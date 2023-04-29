import UIKit

protocol StoreListViewModelProtocol {
    var actions: StoreListActionsProtocol { get }
    var storeType: StoreType { get }
    var storeList: [Store] { get }
    var banners: [Banner] { get }
    
    func getStoreList(completion: @escaping () -> Void)
    func getBanners(completion: @escaping () -> Void)
    func getStoreType() -> String
    func search(for text: String)
    func goToFavorites()
    func goToStoreDetails(with store: Store)
}
