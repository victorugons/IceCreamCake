import UIKit

class DocesViewModel: StoreListViewModelProtocol {
    let storeType: StoreType = .doces
    
    func getStoreList(of type: StoreType) {
    }
    func printStoreType() {
        print(storeType)
    }
    
    func getStoreType() -> String {
        return storeType.name
    }
}
