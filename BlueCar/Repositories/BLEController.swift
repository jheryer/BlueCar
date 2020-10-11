import CoreBluetooth

private let BLE_Service_CBUUID = CBUUID(string:"0xFFE0")
private let BLE_FIRST_Characteristic_CBUUID = CBUUID(string:"0xFFE1")

protocol BLEControllerDelegate {
    func peripheralFound(peripheral: BLEDevice) -> Void
}

protocol BLEController {
    func startScan() -> Void
    func sendMessageToDevice(_ message: String) -> Void
    var delegate: BLEControllerDelegate? {get set}
}

class SimpleBLEController: NSObject, BLEController, CBCentralManagerDelegate, CBPeripheralDelegate {
    var centralManager: CBCentralManager?
    var peripherialMonitor: CBPeripheral?
    var peripheral: CBPeripheral?
    var writeCharacteristic: CBCharacteristic?
    var delegate: BLEControllerDelegate?
    
    private var writeType: CBCharacteristicWriteType = .withoutResponse
    
    var isReady:Bool {
        get {
            return centralManager?.state == .poweredOn &&
            peripheral != nil &&
                writeCharacteristic != nil
        }
    }
    
    override init() {
        super.init()
    }
    
    func startScan() {
        let centralQueue = DispatchQueue(label: "com.madcoder.bluecar")
        centralManager = CBCentralManager(delegate: self, queue: centralQueue)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("Central state upate...")
        if central.state != .poweredOn {
            print("Central is not powered on")
        } else {
            print("Central scanning for", BLE_Service_CBUUID)
            centralManager?.scanForPeripherals(withServices: [BLE_Service_CBUUID], options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print(peripheral.name!)
        print(peripheral.identifier)
        decodePeripheralState(peripheralState: peripheral.state)
        self.peripheral = peripheral
        self.peripheral?.delegate = self
        centralManager?.stopScan()
        centralManager?.connect(self.peripheral!)
        delegate?.peripheralFound(peripheral: BLEDevice(id: peripheral.identifier, name: peripheral.name!))
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        if peripheral == self.peripheral! {
            print("Connected to DSD Periphial")
            peripheral.discoverServices([BLE_Service_CBUUID])
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            for service in services {
                print(service.uuid)
                if service.uuid == BLE_Service_CBUUID {
                    print("Service Found, discoveringCharacteristics")
                    self.peripheral?.discoverCharacteristics([BLE_FIRST_Characteristic_CBUUID], for: service)
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        for characteristic in service.characteristics! {
            if characteristic.uuid == BLE_FIRST_Characteristic_CBUUID {
                print("Characteristic found: \(characteristic.uuid)")
                writeCharacteristic = characteristic
                writeType = characteristic.properties.contains(.write) ? .withResponse : .withoutResponse
                print("Characteristic is ready.")
            }
        }
    }
    
    func disconnect() {
        if let per = self.peripheral {
            centralManager?.cancelPeripheralConnection(per)
        }
    }
    
    func readRSSI() {
        guard isReady else {return}
        self.peripheral!.readRSSI()
    }
    
    func sendMessageToDevice(_ message: String) {
            guard isReady else { return }
            
            if let data = message.data(using: String.Encoding.utf8) {
                peripheral!.writeValue(data, for: writeCharacteristic!, type: writeType)
                print("SENT [ \(message) ]")
            }
        }
        
//        func sendBytesToDevice(_ bytes: [UInt8]) {
//            guard isReady else { return }
//            let data = Data(bytes: UnsafePointer<UInt8>(bytes), count: bytes.count)
//            peripheral!.writeValue(data, for: writeCharacteristic!, type: writeType)
//        }
        
        func sendDataToDevice(_ data: Data) {
            guard isReady else { return }
            peripheral!.writeValue(data, for: writeCharacteristic!, type: writeType)
        }
    
    private func decodePeripheralState(peripheralState: CBPeripheralState) {
            switch peripheralState {
                case .disconnected:
                    print("Peripheral state: disconnected")
                case .connected:
                    print("Peripheral state: connected")
                case .connecting:
                    print("Peripheral state: connecting")
                case .disconnecting:
                    print("Peripheral state: disconnecting")
            @unknown default:
                print("Peripheral state: Unknown")
            }
    }
}
