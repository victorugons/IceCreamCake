import UIKit

protocol StoreListViewModelProtocol {
    func getStoreList(of type: StoreType)
    func printStoreType()
    func getStoreType() -> String
}
