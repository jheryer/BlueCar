import SwiftUI

extension JoyStickControl {
struct IndicatorView: View {
    @Binding var isRotating: Bool
    @Binding var angleValue: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.darkShadow,
                    style: StrokeStyle(lineWidth: 6, lineCap: .round, dash: [1,40], dashPhase: 20)
                
                )
                .frame(width: 250, height: 250)
               
            
            Circle()
                .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                .stroke(
                    RadialGradient(
                        gradient: Gradient(
                            colors: [Color.yellow, Color.white.opacity(0.001)]),
                            center: .top,
                            startRadius: 0,
                            endRadius: 100
                    ),
                    style: StrokeStyle(lineWidth: 6, lineCap: .round))
                .frame(width: 250, height: 250)
                .opacity(isRotating ? 1.0: 0.0)
                .rotationEffect(.degrees(-90))
                .rotationEffect(isRotating ? .degrees(Double(angleValue)) : .degrees(0))
                .clipShape(
                    Circle()
                        .stroke(
                            style: StrokeStyle(
                                    lineWidth: 6,
                                    lineCap: .round,
                                    dash: [1,40],
                                    dashPhase: 20)))
        }
    }
}
}
