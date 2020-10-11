import SwiftUI

struct ControlButton: View {
    let title:String
    let value:Double
    @Binding var controlValue: Double
    var body: some View {
        Button(action: {
            controlValue = value
        }) {
            Text(title)
        }.foregroundColor(.blue)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 1)
        )
    }
}
