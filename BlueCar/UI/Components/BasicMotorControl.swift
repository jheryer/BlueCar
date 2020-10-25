
import SwiftUI

let MAX_VALUE = 255.0
let MIN_VALUE = 0.0

struct BasicMotorControl: View {
    @ObservedObject var viewModel:ViewModel
    @State var controlValue = 0.0
    
    var body: some View {
        VStack(spacing: 16) {
            Text(viewModel.name)
            ControlSlider(value: $viewModel.controlValue)
            HStack(spacing: 64) {
                ControlButton(title: "Off",value: MIN_VALUE, controlValue: $viewModel.controlValue)
                ControlButton(title: "On",value: MAX_VALUE, controlValue: $viewModel.controlValue)
            }
        }
    }
}

extension BasicMotorControl {
    class ViewModel: ObservableObject {
        @Inject var container: DIContainer
        var name:String
        var lastValue: Double = MIN_VALUE
        @Published var controlValue = MIN_VALUE {
            didSet {
                container.interactors.bleInteractor.sendValue(value: ControlValue(name: name, value: Int(controlValue)))
            }
        }
     
        init(name: String) {
            self.name = name
        }
    }
}

struct BasicControl_Previews: PreviewProvider {
    static var previews: some View {
        BasicMotorControl(viewModel: BasicMotorControl.ViewModel(name: "test"))
    }
}
