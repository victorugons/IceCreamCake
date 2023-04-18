protocol FavoriteStoresViewModelProtocol {
    var favoriteStores: [FavoriteStore] { get }
    
    func updateFavorites()
}
