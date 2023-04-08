import UIKit

protocol SearchResultsViewModelProtocol {
    var actions: StoreListActionsProtocol { get }
    var storeList: [Store] { get }
    var searchText: String { get }
    var searchResults: [Store] { get }
    
    func getFirstSearchResults()
    func getSearchResults(for text: String, completion: @escaping () -> Void)
}
