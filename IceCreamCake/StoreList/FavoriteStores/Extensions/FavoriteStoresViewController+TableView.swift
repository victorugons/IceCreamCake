import UIKit

extension FavoriteStoresViewController: UITableViewDelegate {
    
}

extension FavoriteStoresViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.favoriteStores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoreTableViewCell.identifier, for: indexPath) as? StoreTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        
        let favoriteStore = viewModel.favoriteStores[indexPath.row]
        if let favoriteStoreName = favoriteStore.name, let favoriteStoreCategory = favoriteStore.category, let favoriteStoreRating = favoriteStore.rating {
            let store = Store(id: Int(favoriteStore.id), name: favoriteStoreName, storeType: favoriteStore.storeType ?? [], category: favoriteStoreCategory, rating: favoriteStoreRating)
            cell.setupCell(with: store)
        }
        
        return cell
    }
}
