import SwiftUI
// implementation based off of the video from Kazi Nabi
// https://www.youtube.com/watch?v=tJKAKnyy_68

struct JoyStickControl: View {
    @ObservedObject var viewModel:ViewModel
    @State var isRotating = false
    @State var angleValue: CGFloat = 0.0
   
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.viewBackground)
                .edgesIgnoringSafeArea(.all)
            JoyStickBackgroundView()
            KnobComponentView(isRotating: $viewModel.isRotating, angleValue: $viewModel.angleValue)

            IndicatorView(isRotating: $viewModel.isRotating, angleValue: $viewModel.angleValue)

            JoyStickGestureView(isRotating: $viewModel.isRotating, onChange: {
                location in
                self.viewModel.moveKnob(location: location)
            })

            Text("\(String.init(format: "%.0f", viewModel.angleValue))")
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .offset(y: 300)
        }
    }
}

extension JoyStickControl {
    class ViewModel: ObservableObject {
        @Inject var container: DIContainer
        var name:String
        @Published var angleValue: CGFloat = 0.0
        @Published var isRotating: Bool = false
        
        init(name: String) {
            self.name = name
        }
        
        func moveKnob(location: CGPoint) {
            changeLocation(location: location)
            let controlValue = ControlValue(name: name, value: Int(angleValue))
            container.interactors.bleInteractor.sendValue(value: controlValue)
        }

        private func changeLocation(location: CGPoint) {

            let loc1 = CGPoint(x: location.x - 150, y: location.y - 150)
            let loc2 = CGPoint(x: 0 - 150, y: location.y - 150)

            let vector1 = CGVector(dx: loc1.x, dy: loc1.y)
            let vector2 = CGVector(dx: loc2.x, dy: loc2.y)
            let angleV1V2 = atan2(vector2.dy, vector2.dx) - atan2(vector1.dy, vector1.dx)

            var degree = angleV1V2 * CGFloat(180.0 / .pi)

            if degree < 0 {
                degree += 360.0
            }

            isRotating = true
            angleValue = 360 - degree
        }
    }
}

struct JoyStickControl_Previews: PreviewProvider {
    static var previews: some View {
        JoyStickControl(viewModel: JoyStickControl.ViewModel(name: "angleControl"))
    }
}
