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
            let salgadosViewModel = StoreListViewModel(service: StoreListService(), storeType: .salgados)
            let salgadosViewController = StoreListViewController(viewModel: salgadosViewModel)
            rootViewController.setViewControllers([salgadosViewController], animated: true)
            
        case .doces:
            let docesViewModel = StoreListViewModel(service: StoreListService(), storeType: .doces)
            let docesViewController = StoreListViewController(viewModel: docesViewModel)
            rootViewController.setViewControllers([docesViewController], animated: true)
            
        case .bebidas:
            let bebidasViewModel = StoreListViewModel(service: StoreListService(), storeType: .bebidas)
            let bebidasViewController = StoreListViewController(viewModel: bebidasViewModel)
            rootViewController.setViewControllers([bebidasViewController], animated: true)
        }
    }
}
