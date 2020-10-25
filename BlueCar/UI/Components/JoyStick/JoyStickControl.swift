import SwiftUI

struct JoyStickControl: View {

    @State var isRotating = false
    @State var angleValue: CGFloat = 0.0
    
    @ObservedObject var viewModel:ViewModel = JoyStickControl.ViewModel()

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
                self.viewModel.changeLocation(location: location)
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
        @Published var angleValue: CGFloat = 0.0
        @Published var isRotating: Bool = false

        func changeLocation(location: CGPoint) {

            let loc1 = CGPoint(x: location.x - 150, y: location.y - 150)
            let loc2 = CGPoint(x: 0 - 150, y: location.y - 150)

            let vector1 = CGVector(dx: loc1.x, dy: loc1.y)
            let vector2 = CGVector(dx: loc2.x, dy: loc2.y)
            let angleV1V2 = atan2(vector2.dy, vector2.dx) - atan2(vector1.dy, vector1.dx)

            var degree = angleV1V2 * CGFloat(180.0 / .pi)

            if degree < 0 { degree += 360.0 }

            isRotating = true
            angleValue = 360 - degree
        }
    }
}

struct JoyStickControl_Previews: PreviewProvider {
    static var previews: some View {
        JoyStickControl()
    }
}
