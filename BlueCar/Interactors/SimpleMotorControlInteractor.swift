import SwiftUI
import Combine


public class SimpleMotorControlInteractor: BLEInteractor,BLEControllerDelegate {
    
    var deviceList = [BLEDevice]()
    var deviceSubject = PassthroughSubject<BLEDevice, Never>()
    var bleController: BLEController
    
    private var lastControlValueSent: ControlValue?
    
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
    
    func sendValue(value: ControlValue) {
        if(isValid(value)) {
            let bleCommand = ControlValueBLEAdapter.adapt(value: value)
            bleController.sendMessageToDevice(bleCommand)
        }        
    }
    
    private func isValid(_ value: ControlValue) -> Bool {
        if let lastValue = lastControlValueSent {
            if lastValue == value || value.name.isEmpty {
                return false
            }
        }
        lastControlValueSent = value
        return true
    }
    
}

