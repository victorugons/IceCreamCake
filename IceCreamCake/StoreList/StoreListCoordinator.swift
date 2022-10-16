import UIKit

final class StoreListCoordinator: Coordinator {
    var childCoordinators: [BaseCoordinator] = []
    
    var rootViewController = UINavigationController()
    
    var type: StoreType
    
    init(of type: StoreType) {
        self.type = type
    }
    
    func start() {
        switch self.type {
        case .salgados:
            let salgadosViewModel = SalgadosViewModel()
            let salgadosViewController = StoreListViewController(viewModel: salgadosViewModel)
            rootViewController.setViewControllers([salgadosViewController], animated: true)
            
        case .doces:
            let docesViewModel = DocesViewModel()
            let docesViewController = StoreListViewController(viewModel: docesViewModel)
            rootViewController.setViewControllers([docesViewController], animated: true)
            
        case .bebidas:
            let bebidasViewModel = BebidasViewModel()
            let bebidasViewController = StoreListViewController(viewModel: bebidasViewModel)
            rootViewController.setViewControllers([bebidasViewController], animated: true)
        }
    }
}
