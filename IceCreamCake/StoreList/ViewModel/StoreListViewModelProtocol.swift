import UIKit

protocol StoreListViewModelProtocol: StoreListActionsProtocol {
    var storeType: StoreType { get }
    var storeList: [Store] { get }
    var sortedStoreList: [Store] { get }
    var filteredStoreList: [Store] { get }
    var banners: [Banner] { get }
    var filterState: String? { get }
    
    func getStoreList(completion: @escaping () -> Void)
    func getBanners(completion: @escaping () -> Void)
    func getStoreType() -> String
    func search(for text: String)
    func presentFilterModal(delegate: FilterDelegate)
    func filter(with state: String, completion: @escaping () -> Void)
    func removeFilter(completion: @escaping () -> Void)
}
