class DependencyManager {
    private let container: DIContainer
    
    init() {
        self.container = DIContainer(interactors: .init(bleInteractor: JoyStickInteractor(bleController: StubBLEController())))
        addDependencies()
    }
    
    private func addDependencies() {
        let resolver = Resolver.shared
        resolver.add(container)
    }
}
