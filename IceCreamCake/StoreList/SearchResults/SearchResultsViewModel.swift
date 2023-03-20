import UIKit

class SearchResultsViewModel: SearchResultsViewModelProtocol {
    private var stores: [Store]
    var searchText: String
    var searchResults: [Store] = []
    
    init(searchText: String, stores: [Store]) {
        self.searchText = searchText
        self.stores = stores
    }
    
    func getFirstSearchResults() {
        searchResults = stores.filter { $0.name.range(of: searchText, options: .caseInsensitive) != nil ? true : false }
    }
    
    func getSearchResults(for text: String, completion: @escaping () -> Void) {
        searchResults = stores.filter { $0.name.range(of: text, options: .caseInsensitive) != nil ? true : false }
        searchText = text
        completion()
    }
    
    func sortStores(with state: SortMenuState, completion: @escaping () -> Void) {
        switch state {
        case .defaultOrder:
            searchResults = stores.filter { $0.name.range(of: searchText, options: .caseInsensitive) != nil ? true : false }
        case .alphabeticalOrder:
            searchResults = searchResults.sorted { $0.name.lowercased() < $1.name.lowercased() }
        case .inverseAlphabeticalOrder:
            searchResults = searchResults.sorted { $0.name.lowercased() > $1.name.lowercased() }
        case .ratingOrder:
            searchResults = searchResults.sorted { Double($0.rating) ?? 1 > Double($1.rating) ?? 0 }
        }
        completion()
    }
}
