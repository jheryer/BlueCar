import SwiftUI
import Combine

protocol BLEInteractor: Injectable {
    func getDevices() -> [BLEDevice]
    func scanForPeripherals() -> ()
    func subject() -> PassthroughSubject<BLEDevice, Never>
    func sendValue(value: ControlValue) -> Void
}

public class JoyStickInteractor: BLEInteractor,BLEControllerDelegate {
    
    var deviceList = [BLEDevice]()
    var deviceSubject = PassthroughSubject<BLEDevice, Never>()
    var bleController: BLEController
    
    private var lastControlValueSent: ControlValue?
    private var lastSectionSent: JoyStickSection = JoyStickSection.UNKNOWN
    
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
        
        let section = JoyStickSection.typeFromValue(value.value)
        
        if let lastValue = lastControlValueSent {
            if lastValue == value || value.name.isEmpty || lastSectionSent == section {
                return false
            }
        }
        lastControlValueSent = value
        lastSectionSent = section
        print(section)
        return true
    }
    
}

enum JoyStickSection {
    case FORWARD, FORWARD_RIGHT, RIGHT, BACK_RIGHT, BACK, BACK_LEFT, LEFT, FORWARD_LEFT, UNKNOWN

    static func typeFromValue(_ value: Int) -> JoyStickSection {
        switch value {
        case 65..<115:
            return .FORWARD
        case 115..<170:
            return .FORWARD_RIGHT
        case 170..<190:
            return .RIGHT
        case 190..<225:
            return .BACK_RIGHT
        case 225..<300:
            return .BACK
        case 300..<350:
            return .BACK_LEFT
        case 10..<65:
            return .FORWARD_LEFT
        case 0...10:
            return .LEFT
        case 350...360:
            return .LEFT
        default:
            return .UNKNOWN
        }
    }
}


/*
 Angle Value:
 motor1(L) | motor2 (R)
 
 // MOVE FORWARD
 if value is between 45 and 135
    motor1 = 255
    motor2 = 255
 
 //TURN RIGHT
 if value is between 135 and 180
    motor1 = 255
    motor2 = 128
 
 // ROTATE RIGHT
 if value is between 135 and 179
    motor1 = 255
    motor2 = 0
 
 //REVRSE TURN RIGHT
 if value is between 180 and 225
    motor1 = 128
    motor2 = -128
 
 // MOVE BACKWARDS
 if value is between 225 and 315
    motor1 = -255
    motor2 = -255
 
 //REVRSE TURN LEFT
 if value is between 315 and 0
    motor1 = -128
    motor2 = 128
 
 // ROTATE LEFT
 if value is between 135 and 179
    motor1 = 0
    motor2 = 255
 
 // TURN LEFT
 if value is between 0 and 45
    motor1 = 128
    motor2 = 255
 */
