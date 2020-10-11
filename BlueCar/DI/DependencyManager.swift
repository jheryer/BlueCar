class DependencyManager {
    private let container: DIContainer
    
    init() {
        self.container = DIContainer(interactors: .init(bleInteractor: BLE4Interactor(bleController: SimpleBLEController())))
        addDependencies()
    }
    
    private func addDependencies() {
        let resolver = Resolver.shared
        resolver.add(container)
    }
}
