protocol StoreListActionsProtocol {
    var storeList: [Store] { get set }
    var sortedStoreList: [Store] { get }
    var filteredStoreList: [Store] { get }
    var filterState: String? { get }
    
    func sortStores(with state: SortMenuState, completion: @escaping () -> Void)
    func presentFilterModal(delegate: FilterDelegate)
    func filter(with state: String, completion: @escaping () -> Void)
    func removeFilter(completion: @escaping () -> Void)
}
