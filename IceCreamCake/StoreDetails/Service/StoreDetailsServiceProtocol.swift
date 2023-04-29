protocol StoreDetailsServiceProtocol {
    func fetchStoreProducts(completion: @escaping (Result<[Product], Error>) -> Void)
}
