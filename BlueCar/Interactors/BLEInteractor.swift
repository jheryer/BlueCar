import SwiftUI
import Combine

protocol BLEInteractor: Injectable {
    func getDevices() -> [BLEDevice]
    func scanForPeripherals() -> ()
    func subject() -> PassthroughSubject<BLEDevice, Never>
    func sendMessage(_ message: String) -> Void
}

public class BLE4Interactor: BLEInteractor,BLEControllerDelegate {
    var deviceList = [BLEDevice]()
    var deviceSubject = PassthroughSubject<BLEDevice, Never>()
    
    var bleController: BLEController
    
    func subject() -> PassthroughSubject<BLEDevice, Never> {
        return deviceSubject
    }
    
    init(bleController: BLEController) {
        self.bleController = bleController
        self.bleController.delegate = self
    }
    
    func scanForPeripherals() {
        bleController.startScan()
    }
    
    func getDevices() -> [BLEDevice] {
        return deviceList
    }
    
    func peripheralFound(peripheral: BLEDevice) {
        deviceList.append(peripheral)
        deviceSubject.send(peripheral)
    }
    
    func sendMessage(_ message: String) {
        bleController.sendMessageToDevice(message)
    }
}

