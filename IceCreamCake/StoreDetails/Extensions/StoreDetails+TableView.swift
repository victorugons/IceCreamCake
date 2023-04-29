import UIKit

extension StoreDetailsViewController: UITableViewDelegate {
    
}

extension StoreDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.store.storeType.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if viewModel.store.storeType[section] == StoreType.salgados.rawValue {
            return "🍗" + StoreType.salgados.name
        }
        else if viewModel.store.storeType[section] == StoreType.doces.rawValue {
            return "🧁" + StoreType.doces.name
        }
        else if viewModel.store.storeType[section] == StoreType.bebidas.rawValue {
            return "🥤" + StoreType.bebidas.name
        }
        return viewModel.store.storeType[section].capitalized
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.store.storeType[section] == StoreType.salgados.rawValue {
            return viewModel.products.filter({ $0.productType == StoreType.salgados.rawValue }).count
        }
        else if viewModel.store.storeType[section] == StoreType.doces.rawValue {
            return viewModel.products.filter({ $0.productType == StoreType.doces.rawValue }).count
        }
        else if viewModel.store.storeType[section] == StoreType.bebidas.rawValue {
            return viewModel.products.filter({ $0.productType == StoreType.bebidas.rawValue }).count
        }
        return viewModel.products.filter({ $0.productType == viewModel.store.storeType[section] }).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as? ProductTableViewCell else { return UITableViewCell() }
        if viewModel.store.storeType[indexPath.section] == StoreType.salgados.rawValue {
            cell.setupCell(with: viewModel.products.filter({ $0.productType == StoreType.salgados.rawValue })[indexPath.row])
        }
        else if viewModel.store.storeType[indexPath.section] == StoreType.doces.rawValue {
            cell.setupCell(with: viewModel.products.filter({ $0.productType == StoreType.doces.rawValue })[indexPath.row])
        }
        else if viewModel.store.storeType[indexPath.section] == StoreType.bebidas.rawValue {
            cell.setupCell(with: viewModel.products.filter({ $0.productType == StoreType.bebidas.rawValue })[indexPath.row])
        }
        else {
            cell.setupCell(with: viewModel.products.filter({ $0.productType == viewModel.store.storeType[indexPath.section] })[indexPath.row])
        }
        return cell
    }
}
