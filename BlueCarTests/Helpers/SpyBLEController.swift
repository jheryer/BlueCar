import Foundation
@testable import BlueCar

class SpyBLEController: BLEController {
    
    var delegate: BLEControllerDelegate?
    
    var startScanWasCalled: Bool = false
    var startScanCallCount: Int = 0
    var sendMessageToDeviceWasCalled: Bool = false
    var sendMessageCallCount: Int = 0
    var messageList:[String] = [String]()
    
    func startScan() {
        startScanWasCalled = true
        startScanCallCount = startScanCallCount + 1
        self.delegate?.peripheralFound(peripheral:
                                        BLEDevice(id: UUID(uuidString: "F3E2169B-EB75-4DA4-81FD-A9E5C863DA63")!,
                                                         name: "test"))
    }
    
    func sendMessageToDevice(_ message: String) {
        sendMessageCallCount = sendMessageCallCount + 1
        sendMessageToDeviceWasCalled = true
        messageList.append(message)
    }
    
    func reset() {
        startScanCallCount = 0
        sendMessageCallCount = 0
        startScanWasCalled = false
        sendMessageToDeviceWasCalled = false
        messageList = [String]()
    }
}

