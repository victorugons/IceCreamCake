import UIKit

class SalgadosViewModel: StoreListViewModelProtocol {
    let storeType: StoreType = .salgados
    
    func getStoreList(of type: StoreType) {
    }
    
    func printStoreType() {
        print(storeType)
    }
    
    func getStoreType() -> String {
        return storeType.name
    }
}
