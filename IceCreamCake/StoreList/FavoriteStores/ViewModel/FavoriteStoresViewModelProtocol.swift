protocol FavoriteStoresViewModelProtocol {
    var favoriteStores: [FavoriteStore] { get }
    
    func updateFavorites()
    func goToStoreDetails(with store: Store)
}
