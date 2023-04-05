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
            let salgadosViewModel = StoreListViewModel(storeType: .salgados, service: StoreListService(), coordinator: self)
            let salgadosViewController = StoreListViewController(viewModel: salgadosViewModel)
            rootViewController.setViewControllers([salgadosViewController], animated: true)
            
        case .doces:
            let docesViewModel = StoreListViewModel(storeType: .doces, service: StoreListService(), coordinator: self)
            let docesViewController = StoreListViewController(viewModel: docesViewModel)
            rootViewController.setViewControllers([docesViewController], animated: true)
            
        case .bebidas:
            let bebidasViewModel = StoreListViewModel(storeType: .bebidas, service: StoreListService(), coordinator: self)
            let bebidasViewController = StoreListViewController(viewModel: bebidasViewModel)
            rootViewController.setViewControllers([bebidasViewController], animated: true)
        }
    }
    
    func goToSearchResults(for text: String, with stores: [Store]) {
        let searchResultsViewModel = SearchResultsViewModel(searchText: text, stores: stores)
        let searchResultsViewController = SearchResultsViewController(viewModel: searchResultsViewModel)
        
        rootViewController.pushViewController(searchResultsViewController, animated: true)
    }
    
    func presentFilterModal(with categories: [String], delegate: FilterDelegate, state: String?) {
        let filterViewModel = FilterViewModel(categories: categories, state: state)
        let filterViewController = FilterViewController(viewModel: filterViewModel)
        filterViewController.delegate = delegate
        let navigationController = UINavigationController(rootViewController: filterViewController)
        if let sheet = navigationController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        
        rootViewController.present(navigationController, animated: true)
    }
}
