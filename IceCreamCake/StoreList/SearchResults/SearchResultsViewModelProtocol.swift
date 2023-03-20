import UIKit

protocol SearchResultsViewModelProtocol: StoreListActionsProtocol {
    var searchText: String { get }
    var searchResults: [Store] { get }
    
    func getFirstSearchResults()
    func getSearchResults(for text: String, completion: @escaping () -> Void)
}
