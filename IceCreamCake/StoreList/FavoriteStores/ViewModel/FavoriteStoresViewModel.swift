import UIKit

class FavoriteStoresViewModel: FavoriteStoresViewModelProtocol {
    var favoriteStores: [FavoriteStore]
    private let coordinator: StoreListCoordinator
    
    init(favoriteStores: [FavoriteStore], coordinator: StoreListCoordinator) {
        self.favoriteStores = favoriteStores
        self.coordinator = coordinator
    }
    
    func updateFavorites() {
        do {
            try favoriteStores = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext.fetch(FavoriteStore.fetchRequest()) ?? []
        }
        catch {
            //TODO: - Present alert
            print("Error fetching favorite stores")
        }
    }
    
    func goToStoreDetails(with store: Store) {
        coordinator.goToStoreDetails(with: store)
    }
}
