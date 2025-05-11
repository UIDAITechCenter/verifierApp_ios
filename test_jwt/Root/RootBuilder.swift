
import UIKit

protocol RootBuilderProtocol {
    static func buildRootModule() -> RootViewController
}

struct RootBuilder: RootBuilderProtocol {
    static func buildRootModule() -> RootViewController {
        let router = RootRouter()
        let viewModel = RootViewModel(router: router)
        let viewController = RootViewController(viewModel: viewModel)

        router.viewController = viewController

        return viewController
    }
}
