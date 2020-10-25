import XCTest
@testable import BlueCar


class BLEInteractorTests: XCTestCase {

    var subject: BLEInteractor?
    var bleControllerSpy: SpyBLEController?
    
    override func setUpWithError() throws {
        bleControllerSpy = SpyBLEController()
        subject = BLE4Interactor(bleController: bleControllerSpy!)
    }

    override func tearDownWithError() throws {
        
    }

    func test_given_ble_interactor_when_sendValue_called_then_BLEController_sendMessageToDevice_invoked() throws {
        subject?.sendValue(value: ControlValue(name: "test", value: 1))
        XCTAssertTrue(bleControllerSpy!.sendMessageToDeviceWasCalled)
        XCTAssertEqual(bleControllerSpy!.messageList.count, 1)
    }
    
    func test_given_ble_interactor_when_sendValue_same_value_called_then_BLEController_sendMessageToDevice_invoked_once() throws {
        subject?.sendValue(value: ControlValue(name: "test", value: 1))
        subject?.sendValue(value: ControlValue(name: "test", value: 1))
        XCTAssertTrue(bleControllerSpy!.sendMessageToDeviceWasCalled)
        XCTAssertTrue(bleControllerSpy!.sendMessageCallCount == 1)
        XCTAssertEqual(bleControllerSpy!.messageList.count, 1)
    }
    
    func test_given_ble_interactor_when_sendValue_diff_value_called_then_BLEController_sendMessageToDevice_invoked_once() throws {
        subject?.sendValue(value: ControlValue(name: "test", value: 1))
        subject?.sendValue(value: ControlValue(name: "test", value: 2))
        XCTAssertTrue(bleControllerSpy!.sendMessageToDeviceWasCalled)
        XCTAssertTrue(bleControllerSpy!.sendMessageCallCount == 2)
        XCTAssertEqual(bleControllerSpy!.messageList.count, 2)
    }
}
