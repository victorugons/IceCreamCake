import UIKit

class StoreListViewModel: StoreListViewModelProtocol {
    private let service: StoreListServiceProtocol
    private let coordinator: StoreListCoordinator
    var actions: StoreListActionsProtocol
    
    var storeType: StoreType
    var fullStoreList: [Store] = []
    var storeList: [Store] = []
    var favoritesList: [FavoriteStore] = []
    var banners: [Banner] = []
    
    func getStoreList(completion: @escaping () -> Void) {
        service.fetchStores { [weak self] result in
            switch result {
            case .success(let storeList):
                self?.fullStoreList = storeList
                self?.filterStoresByType(with: storeList)
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getBanners(completion: @escaping () -> Void) {
        service.fetchBanners { [weak self] result in
            switch result {
            case .success(let banners):
                self?.banners = banners.filter { $0.storeType == self?.storeType.rawValue }
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    init(storeType: StoreType, service: StoreListService, coordinator: StoreListCoordinator, actions: StoreListActionsProtocol) {
        self.service = service
        self.storeType = storeType
        self.coordinator = coordinator
        self.actions = actions
    }
    
    private func filterStoresByType(with storeList: [Store]) {
        self.storeList = storeList.filter { $0.storeType.contains("\(storeType)")}
        actions.storeList = self.storeList
    }
    
    func printStoreType() {
        print(storeType)
    }
    
    func getStoreType() -> String {
        return storeType.name
    }
    
    func search(for text: String) {
        if text.trimmingCharacters(in: .whitespacesAndNewlines).count >= 2 {
            coordinator.goToSearchResults(for: text, with: fullStoreList)
        }
    }
    
    func goToFavorites() {
        var favoriteStores: [FavoriteStore]
        
        do {
            try favoriteStores = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext.fetch(FavoriteStore.fetchRequest()) ?? []
            coordinator.goToFavorites(with: favoriteStores)
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
