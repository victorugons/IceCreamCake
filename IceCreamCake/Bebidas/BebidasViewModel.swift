import UIKit

class BebidasViewModel: StoreListViewModelProtocol {
    
    let storeType: StoreType = .bebidas
    
    func printStoreType() {
        print(storeType)
    }
    
    func getStoreList(of type: StoreType) {
    }
    
    func getStoreType() -> String {
        return storeType.name
    }
}

