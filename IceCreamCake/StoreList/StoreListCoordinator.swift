import UIKit

final class StoreListCoordinator: Coordinator {
    var childCoordinators: [BaseCoordinator] = []
    
    var rootViewController = UINavigationController()
    
    var type: StoreType
    
    init(of type: StoreType) {
        self.type = type
    }
    
    func start() {
        let service = StoreListService()
        let actions = StoreListActionsViewModel(coordinator: self)
        
        switch self.type {
        case .salgados:
            let salgadosViewModel = StoreListViewModel(storeType: .salgados, service: service, coordinator: self, actions: actions)
            let salgadosViewController = StoreListViewController(viewModel: salgadosViewModel)
            rootViewController.setViewControllers([salgadosViewController], animated: true)
            
        case .doces:
            let docesViewModel = StoreListViewModel(storeType: .doces, service: service, coordinator: self, actions: actions)
            let docesViewController = StoreListViewController(viewModel: docesViewModel)
            rootViewController.setViewControllers([docesViewController], animated: true)
            
        case .bebidas:
            let bebidasViewModel = StoreListViewModel(storeType: .bebidas, service: service, coordinator: self, actions: actions)
            let bebidasViewController = StoreListViewController(viewModel: bebidasViewModel)
            rootViewController.setViewControllers([bebidasViewController], animated: true)
        }
    }
    
    func goToSearchResults(for text: String, with stores: [Store]) {
        let actions = StoreListActionsViewModel(coordinator: self)
        let searchResultsViewModel = SearchResultsViewModel(searchText: text, stores: stores, coordinator: self, actions: actions)
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
    
    func goToFavorites(with favoriteStores: [FavoriteStore]) {
        let favoritesViewModel = FavoriteStoresViewModel(favoriteStores: favoriteStores, coordinator: self)
        let favoritesViewController = FavoriteStoresViewController(viewModel: favoritesViewModel)
        
        rootViewController.pushViewController(favoritesViewController, animated: true)
    }
    
    func goToStoreDetails(with store: Store) {
        let storeDetailsService = StoreDetailsService()
        let storeDetailsViewModel = StoreDetailsViewModel(store: store, service: storeDetailsService)
        let storeDetailsViewController = StoreDetailsViewController(viewModel: storeDetailsViewModel)
        
        rootViewController.pushViewController(storeDetailsViewController, animated: true)
    }
}
