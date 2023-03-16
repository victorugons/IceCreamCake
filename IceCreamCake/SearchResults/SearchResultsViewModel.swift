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
        searchResults = stores.filter { $0.name.range(of: firstSearchText, options: .caseInsensitive) != nil ? true : false }
        print(searchResults)
    }
    
    func getSearchResults(for text: String, completion: @escaping () -> Void) {
        searchResults = stores.filter { $0.name.range(of: text, options: .caseInsensitive) != nil ? true : false }
        completion()
    }
}
