import SwiftUI

struct DeviceRow: View {
    let device: BLEDevice
    
    var body: some View {
        Text("\(device.name) \(device.id)")
    }
}
