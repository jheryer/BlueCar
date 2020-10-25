import SwiftUI

extension Color {
    static let viewBackground = Color.init(red: 42/255, green: 51/255, blue: 200/255)
    static let lightShadow = Color.init(red: 47/255, green: 56/255, blue: 74/255)
    static let darkShadow = Color.init(red: 13/255, green: 16/255, blue: 24/255)
    
    static let dipCircle = LinearGradient(
        gradient: Gradient(
                colors: [lightShadow.opacity(0.3), darkShadow.opacity(0.3)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
    
    static let dipCircle1 = LinearGradient(
        gradient: Gradient(colors: [lightShadow, darkShadow]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
    
}
