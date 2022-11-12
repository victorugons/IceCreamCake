protocol StoreListServiceProtocol {
    func fetchStores(completion: @escaping (Result<[Store], Error>) -> Void)
    func fetchBanners(completion: @escaping (Result<[Banner], Error>) -> Void)
}
