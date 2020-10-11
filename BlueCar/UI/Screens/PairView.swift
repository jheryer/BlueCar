import SwiftUI
import Combine

struct PairView: View {
    @Binding var showPairView: Bool
    @Binding var selectedDevice: BLEDevice
    @ObservedObject var viewModel:ViewModel = PairView.ViewModel()
    
    func close() {
        self.showPairView = false
    }
    
    var body: some View {
        NavigationView {
            listView.navigationBarItems(trailing: Button("Close") {close()}).onAppear {
                self.viewModel.fetchDevices()
            }
        }
    }
    
    @ViewBuilder
    var listView: some View {
        if(viewModel.deviceList.isEmpty) {
            emptyListview
        } else {
            deviceListView
        }
    }
    
    var emptyListview: some View {
        Text("No Devices Found...")
    }
    
    var deviceListView: some View {
        List(viewModel.deviceList) { device in
            DeviceRow(device: device).onTapGesture {
                selectedDevice = device
                close()
            }
        }
    }
}

extension PairView {
    class ViewModel: ObservableObject {
        @Published private(set) var deviceList: [BLEDevice] = []
        @Inject var container: DIContainer
        
        var subject: PassthroughSubject<BLEDevice, Never>?
        var pipe: AnyCancellable?
        
        func loadDevices() {
            deviceList = container.interactors.bleInteractor.getDevices()
        }
        func fetchDevices() {
            container.interactors.bleInteractor.scanForPeripherals()
            subject = container.interactors.bleInteractor.subject()
            pipe = subject?.sink(receiveValue: deviceFound) ?? nil
        }
        
        func deviceFound(device: BLEDevice) {
            DispatchQueue.main.async {
                self.deviceList.append(device)
            }
        }
    }
}
