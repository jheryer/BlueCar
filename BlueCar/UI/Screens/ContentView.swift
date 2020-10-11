import SwiftUI

struct ContentView: View {
    @State var showPairView = false
    @State var selectedDevice: BLEDevice = BLEDevice(id: UUID(), name: "")
    @ObservedObject var viewModel:ViewModel = ContentView.ViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                ForEach(viewModel.motorList, id: \.self){
                    name in
                    BasicMotorControl(viewModel: BasicMotorControl.ViewModel(name: name)).frame(width: 300, height: 200, alignment: .center)
                }
            }.navigationBarItems(leading:Text(selectedDevice.name) ,trailing: Button("Find Device") {
                self.showPairView.toggle()
            }.sheet(isPresented: $showPairView, content: {
                PairView(showPairView: self.$showPairView, selectedDevice: self.$selectedDevice)
            }))
        }
    }
}

extension ContentView {
    class ViewModel: ObservableObject {
        var motorList = ["motor1", "motor2"]
    }
}
