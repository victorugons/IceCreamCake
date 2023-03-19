import UIKit

protocol StoreListViewModelProtocol {
    var storeType: StoreType { get }
    var storeList: [Store] { get }
    var sortedStoreList: [Store] { get }
    var banners: [Banner] { get }
    
    func getStoreList(completion: @escaping () -> Void)
    func getBanners(completion: @escaping () -> Void)
    func getStoreType() -> String
    func search(for text: String)
    func sortStores(with state: SortMenuState, completion: @escaping () -> Void)
}
