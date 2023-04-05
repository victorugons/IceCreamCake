import UIKit

extension StoreListViewController: UITableViewDelegate {
    
}

extension StoreListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filterState == nil ? viewModel.storeList.count : viewModel.filteredStoreList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoreTableViewCell.identifier, for: indexPath) as? StoreTableViewCell else { return UITableViewCell() }
        if self.sortButton.getSortMenuState() == .defaultOrder {
            viewModel.filterState == nil ? cell.setupCell(with: viewModel.storeList[indexPath.row]) : cell.setupCell(with: viewModel.filteredStoreList[indexPath.row])
        }
        else {
            cell.setupCell(with: viewModel.sortedStoreList[indexPath.row])
        }
        return cell
    }
}


