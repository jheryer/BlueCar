import SwiftUI

struct DIContainer: Injectable {
    let interactors: Interactors
}

extension DIContainer {
    struct Interactors {
        let bleInteractor: BLEInteractor
        
        init(bleInteractor: BLEInteractor) {
            self.bleInteractor = bleInteractor
        }
    }
}
