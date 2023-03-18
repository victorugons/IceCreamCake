import UIKit

protocol SearchResultsViewModelProtocol {
    var firstSearchText: String { get }
    var searchResults: [Store] { get }
    
    func getFirstSearchResults()
    func getSearchResults(for text: String, completion: @escaping () -> Void)
}
