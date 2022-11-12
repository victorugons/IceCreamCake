import UIKit

class StoreListViewModel: StoreListViewModelProtocol {
    private let service: StoreListServiceProtocol
    
    var storeType: StoreType
    var storeList: [Store] = []
    var banners: [Banner] = []
    
    func getStoreList(completion: @escaping () -> Void) {
        service.fetchStores { [weak self] result in
            switch result {
            case .success(let storeList):
                self?.filterStoresByType(with: storeList)
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getBanners(completion: @escaping () -> Void) {
        service.fetchBanners { [weak self] result in
            switch result {
            case .success(let banners):
                self?.banners = banners.filter { $0.storeType == self?.storeType.rawValue }
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    init(service: StoreListService, storeType: StoreType) {
        self.service = service
        self.storeType = storeType
    }
    
    private func filterStoresByType(with storeList: [Store]) {
        self.storeList = storeList.filter { $0.storeType.contains("\(storeType)")}
    }
    
    func printStoreType() {
        print(storeType)
    }
    
    func getStoreType() -> String {
        return storeType.name
    }
}

