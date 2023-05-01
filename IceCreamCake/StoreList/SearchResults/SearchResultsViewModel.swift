import UIKit

class SearchResultsViewModel: SearchResultsViewModelProtocol {
    private let coordinator: StoreListCoordinator
    var actions: StoreListActionsProtocol
    
    var storeList: [Store]
    var searchText: String
    var searchResults: [Store] = []
    
    init(searchText: String, stores: [Store], coordinator: StoreListCoordinator, actions: StoreListActionsProtocol) {
        self.searchText = searchText
        self.storeList = stores
        self.coordinator = coordinator
        self.actions = actions
    }
    
    func getFirstSearchResults() {
        searchResults = storeList.filter { $0.name.range(of: searchText, options: .caseInsensitive) != nil ? true : false }
        actions.storeList = searchResults
    }
    
    func getSearchResults(for text: String, completion: @escaping () -> Void) {
        searchResults = storeList.filter { $0.name.range(of: text, options: .caseInsensitive) != nil ? true : false }
        searchText = text
        actions.storeList = searchResults
        completion()
    }
    
    func goToStoreDetails(with store: Store) {
        coordinator.goToStoreDetails(with: store)
    }
}
