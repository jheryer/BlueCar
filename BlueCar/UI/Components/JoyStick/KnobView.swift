import SwiftUI

extension JoyStickControl {
    struct KnobComponentView: View {
        @Binding var isRotating: Bool
        @Binding var angleValue: CGFloat

        var body: some View {
            Circle()
                .fill(Color.lightShadow)
                .overlay(
                    Circle()
                        .stroke(Color.dipCircle1, lineWidth: 30)
                        .blur(radius: 5)
                )
                .frame(width: 60, height: 60)

            Group {
                Circle()
                    .fill(Color.yellow)
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.5), lineWidth: 3)
                            .blur(radius: 4)
                            .offset(x: 2, y: 2)
                            .mask(Circle())
                    )
                    .overlay(
                        Circle()
                            .stroke(Color.black.opacity(0.8), lineWidth: 6)
                            .blur(radius: 4)
                            .offset(x: -2, y: -2)
                            .mask(Circle())
                    )
                    .frame(width: 90, height: 90)

                KnobTopCircles()
            }
                .offset(x: isRotating ? -30 : 0.0)
                .rotationEffect(.degrees(Double(angleValue)))
        }
    }

    struct KnobTopCircles: View {
        var body: some View {
            ZStack {
                KnobView()
                    .offset(x: 30)
                KnobView()
                    .offset(x: -30)
                KnobView()
                    .offset(y: 30)
                KnobView()
                    .offset(y: -30)
            }
        }
    }

    struct KnobView: View {
        var body: some View {
            Circle()
                .fill(Color.clear)
                .overlay(
                    Circle()
                        .stroke(Color.lightShadow, lineWidth: 4)
                        .blur(radius: 4)
                        .offset(x: 2, y: 2)
                        .mask(Circle())
                )
                .overlay(
                    Circle()
                        .stroke(Color.darkShadow, lineWidth: 4)
                        .blur(radius: 4)
                        .offset(x: -2, y: -2)
                        .mask(Circle())
                )
                .frame(width: 8, height: 8)
        }
    }
}
