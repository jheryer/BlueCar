import XCTest
@testable import BlueCar

class BLEInteractorTests: XCTestCase {

    var subject: BLEInteractor?
    var bleControllerSpy: SpyBLEController?
    
    override func setUpWithError() throws {
        bleControllerSpy = SpyBLEController()
        subject = JoyStickInteractor(bleController: bleControllerSpy!)
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
        subject?.sendValue(value: ControlValue(name: "test", value: 10))
        XCTAssertTrue(bleControllerSpy!.sendMessageToDeviceWasCalled)
        XCTAssertTrue(bleControllerSpy!.sendMessageCallCount == 2)
        XCTAssertEqual(bleControllerSpy!.messageList.count, 2)
    }
    
    func test_given_ble_interactor_when_sendValue_section_BLEController_sendMessageToDevice_invoked_once() throws {
        subject?.sendValue(value: ControlValue(name: "test", value: 45))
        subject?.sendValue(value: ControlValue(name: "test", value: 130))
        subject?.sendValue(value: ControlValue(name: "test", value: 120))
        XCTAssertTrue(bleControllerSpy!.sendMessageToDeviceWasCalled)
        XCTAssertTrue(bleControllerSpy!.sendMessageCallCount == 1)
        XCTAssertEqual(bleControllerSpy!.messageList.count, 1)
    }
    
    func test_given_ble_interactor_when_sendValue_section_BLEController_sendMessageToDevice_invoked_twice() throws {
        subject?.sendValue(value: ControlValue(name: "test", value: 45))
        subject?.sendValue(value: ControlValue(name: "test", value: 130))
        subject?.sendValue(value: ControlValue(name: "test", value: 135))
        XCTAssertTrue(bleControllerSpy!.sendMessageToDeviceWasCalled)
        XCTAssertTrue(bleControllerSpy!.sendMessageCallCount == 2)
        XCTAssertEqual(bleControllerSpy!.messageList.count, 2)
    }
    
    func test_JoyStickSection() throws {
        for value in 65..<115 {
            XCTAssertEqual(JoyStickSection.typeFromValue(value), .FORWARD)
        }
        for value in 115..<170 {
            XCTAssertEqual(JoyStickSection.typeFromValue(value), .FORWARD_RIGHT)
        }
        for value in 170..<190 {
            XCTAssertEqual(JoyStickSection.typeFromValue(value), .RIGHT)
        }
        for value in 190..<225 {
            XCTAssertEqual(JoyStickSection.typeFromValue(value), .BACK_RIGHT)
        }
        for value in 225..<300 {
            XCTAssertEqual(JoyStickSection.typeFromValue(value), .BACK)
        }
        for value in 300..<350 {
            XCTAssertEqual(JoyStickSection.typeFromValue(value), .BACK_LEFT)
        }
        for value in 350...360 {
            XCTAssertEqual(JoyStickSection.typeFromValue(value), .LEFT)
        }
        for value in 0..<10 {
            XCTAssertEqual(JoyStickSection.typeFromValue(value), .LEFT)
        }
        for value in 10..<65 {
            XCTAssertEqual(JoyStickSection.typeFromValue(value), .FORWARD_LEFT)
        }
    }
}
