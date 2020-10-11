import SwiftUI

struct ControlSlider: View {
    @Binding var value:Double
    
    var body: some View {
        HStack {
            Image(systemName: "minus")
            Slider(value: $value, in: 0...255, step: 1)
                .padding()
                .accentColor(Color.blue)
                .overlay(
                    RoundedRectangle(cornerRadius: 15.0)
                        .stroke(lineWidth: 2)
                        .foregroundColor(Color.blue)
                )
            Image(systemName: "plus")
        }
    }
}

