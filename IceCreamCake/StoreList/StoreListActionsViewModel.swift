import UIKit

class StoreListActionsViewModel: StoreListActionsProtocol {
    var coordinator: StoreListCoordinator
    var storeList: [Store] = []
    var sortedStoreList: [Store] = []
    var filteredStoreList: [Store] = []
    var filterState: String?
    
    init(coordinator: StoreListCoordinator) {
        self.coordinator = coordinator
    }
    
    func sortStores(with state: SortMenuState, completion: @escaping () -> Void) {
        switch state {
        case .defaultOrder:
            break
        case .alphabeticalOrder:
            sortedStoreList = filterState == nil ? storeList.sorted { $0.name.lowercased() < $1.name.lowercased() } : filteredStoreList.sorted { $0.name.lowercased() < $1.name.lowercased() }
        case .inverseAlphabeticalOrder:
            sortedStoreList = filterState == nil ? storeList.sorted { $0.name.lowercased() > $1.name.lowercased() } : filteredStoreList.sorted { $0.name.lowercased() > $1.name.lowercased() }
        case .ratingOrder:
            sortedStoreList = filterState == nil ? storeList.sorted { Double($0.rating) ?? 1 > Double($1.rating) ?? 0 } : filteredStoreList.sorted { Double($0.rating) ?? 1 > Double($1.rating) ?? 0 }
        }
        completion() 
    }
    
    func presentFilterModal(delegate: FilterDelegate) {
        let categories = storeList.map { $0.category }
        coordinator.presentFilterModal(with: categories.unique(), delegate: delegate, state: filterState)
    }
    
    func filter(with state: String, completion: @escaping () -> Void) {
        filterState = state
        filteredStoreList = storeList.filter { $0.category == state }
        completion()
    }
    
    func removeFilter(completion: @escaping () -> Void) {
        filterState = nil
        completion()
    }
    
    
}
