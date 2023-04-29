protocol StoreDetailsViewModelProtocol {
    var store: Store { get }
    var products: [Product] { get }
    
    func fetchProducts(completion: @escaping () -> Void)
}
