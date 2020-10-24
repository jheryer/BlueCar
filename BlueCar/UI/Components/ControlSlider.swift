import SwiftUI

struct ControlSlider: View {
    @Binding var value:Double
    
    var body: some View {
        HStack {
            Image(systemName: "minus")
            Slider(value: $value, in: 0...255, step: 16)
                .padding()
                .accentColor(Color.blue)
                .overlay(
                    RoundedRectangle(cornerRadius: 8.0)
                        .stroke(lineWidth: 1)
                        .foregroundColor(Color.blue)
                )
            Image(systemName: "plus")
        }
    }
}

