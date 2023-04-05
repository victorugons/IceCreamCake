import UIKit

class FilterViewModel: FilterViewModelProtocol {
    
    var categories: [String]
    var state: String?
    
    init(categories: [String], state: String?) {
        self.categories = categories
        self.state = state
    }
}
