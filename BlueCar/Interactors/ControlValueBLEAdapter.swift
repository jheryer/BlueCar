
struct ControlValueBLEAdapter {
    static func adapt(value: ControlValue) -> String {
        return "\(value.name):\(value.value)"
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
