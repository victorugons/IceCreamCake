import UIKit

class FavoriteStoresViewModel: FavoriteStoresViewModelProtocol {
    var favoriteStores: [FavoriteStore]
    
    init(favoriteStores: [FavoriteStore]) {
        self.favoriteStores = favoriteStores
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
}
