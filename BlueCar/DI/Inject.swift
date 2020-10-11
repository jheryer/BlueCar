
protocol Injectable {}

@propertyWrapper
struct Inject<T: Injectable> {
    let wrappedValue: T
    init() {
        wrappedValue = Resolver.shared.resolve()
    }
}

class Resolver {
    public var factories: [ObjectIdentifier: Injectable] = [:]
    static let shared = Resolver()
    private init() {}
    
    func add<T: Injectable>(_ injectable: T) {
        let key = ObjectIdentifier(T.self)
        factories[key] = injectable
    }
    
    func resolve<T: Injectable>() -> T {
        let key = ObjectIdentifier(T.self)
        
        guard let injectable = factories[key] as? T else {
            fatalError("\(key) has not been added as an injectable object")
        }
        
        return injectable
    }
}
