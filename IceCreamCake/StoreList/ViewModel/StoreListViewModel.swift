import UIKit

class StoreListViewModel: StoreListViewModelProtocol {
    private let service: StoreListServiceProtocol
    private let coordinator: StoreListCoordinator
    
    var storeType: StoreType
    var storeList: [Store] = []
    var sortedStoreList: [Store] = []
    var favoritesList: [FavoriteStore] = []
    var banners: [Banner] = []
    
    func getStoreList(completion: @escaping () -> Void) {
        service.fetchStores { [weak self] result in
            switch result {
            case .success(let storeList):
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
    
    init(storeType: StoreType, service: StoreListService, coordinator: StoreListCoordinator) {
        self.service = service
        self.storeType = storeType
        self.coordinator = coordinator
    }
    
    private func filterStoresByType(with storeList: [Store]) {
        self.storeList = storeList.filter { $0.storeType.contains("\(storeType)")}
    }
    
    func printStoreType() {
        print(storeType)
    }
    
    func getStoreType() -> String {
        return storeType.name
    }
    
    func search(for text: String) {
        if text.trimmingCharacters(in: .whitespacesAndNewlines).count >= 2 {
            coordinator.goToSearchResults(for: text, with: storeList)
        }
    }
    
    func sortStores(with state: SortMenuState, completion: @escaping () -> Void) {
        switch state {
        case .defaultOrder:
            break
        case .alphabeticalOrder:
            sortedStoreList = storeList.sorted { $0.name.lowercased() < $1.name.lowercased() }
        case .inverseAlphabeticalOrder:
            sortedStoreList = storeList.sorted { $0.name.lowercased() > $1.name.lowercased() }
        case .ratingOrder:
            sortedStoreList = storeList.sorted { Double($0.rating) ?? 1 > Double($1.rating) ?? 0 }
        }
        completion() 
    }
    
    func presentFilterModal() {
        coordinator.presentFilterModal()
    }
}

