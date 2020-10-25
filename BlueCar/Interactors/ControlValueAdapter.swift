
struct ControlValueBLEAdapter {
    static func adapt(value: ControlValue) -> String {
        return "\(value.name):\(value.value)"
    }

    static func adapt(value: ControlAngleValue) -> String {
        // need to push to multiple motors, send list?
        //who knows write tests
        
        return "\(value.name):\(value.value)"
    }
}
