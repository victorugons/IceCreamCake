import UIKit

class SearchResultsViewModel: SearchResultsViewModelProtocol {
    private var stores: [Store]
    var firstSearchText: String
    var searchResults: [Store] = []
    
    init(searchText: String, stores: [Store]) {
        self.firstSearchText = searchText
        self.stores = stores
    }
    
    func getFirstSearchResults() {
        searchResults = stores.filter { $0.name.contains(firstSearchText) }
        print(searchResults)
    }
    
    func getSearchResults(for text: String, completion: @escaping () -> Void) {
        searchResults = stores.filter { $0.name.contains(text) }
        completion()
    }
}
