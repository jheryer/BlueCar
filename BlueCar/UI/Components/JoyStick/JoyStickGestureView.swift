import SwiftUI

extension JoyStickControl {
    struct JoyStickGestureView: View {
        @Binding var isRotating: Bool
        var onChange: (CGPoint) -> Void

        var body: some View {
            Circle()
                .fill(Color.white.opacity(0.001))
                .frame(width: 300, height: 300)
                .gesture(
                    DragGesture(minimumDistance: 0.0)
                        .onChanged({
                            value in
                            self.onChange(value.location)
                        })
                        .onEnded({
                            _ in
                            isRotating = false
                        })
                )
        }
    }
}
