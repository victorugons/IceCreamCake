import UIKit

extension StoreListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.sortButton.getSortMenuState() == .defaultOrder {
            viewModel.actions.filterState == nil ? viewModel.goToStoreDetails(with: viewModel.storeList[indexPath.row]) : viewModel.goToStoreDetails(with: viewModel.actions.filteredStoreList[indexPath.row])
        }
        else {
            viewModel.goToStoreDetails(with: viewModel.actions.sortedStoreList[indexPath.row])
        }
    }
}

extension StoreListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.actions.filterState == nil ? viewModel.actions.storeList.count : viewModel.actions.filteredStoreList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoreTableViewCell.identifier, for: indexPath) as? StoreTableViewCell else { return UITableViewCell() }
        if self.sortButton.getSortMenuState() == .defaultOrder {
            viewModel.actions.filterState == nil ? cell.setupCell(with: viewModel.storeList[indexPath.row]) : cell.setupCell(with: viewModel.actions.filteredStoreList[indexPath.row])
        }
        else {
            cell.setupCell(with: viewModel.actions.sortedStoreList[indexPath.row])
        }
        return cell
    }
}


