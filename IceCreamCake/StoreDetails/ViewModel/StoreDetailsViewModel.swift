class StoreDetailsViewModel: StoreDetailsViewModelProtocol {
    let store: Store
    var products: [Product] = []
    let service: StoreDetailsServiceProtocol
    
    init(store: Store, service: StoreDetailsServiceProtocol) {
        self.store = store
        self.service = service
    }
    
    func fetchProducts(completion: @escaping () -> Void) {
        service.fetchStoreProducts { [weak self] result in
            switch result {
            case .success(let products):
                self?.products = products
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func countProductsOfType(type: String) {
        
    }
}
