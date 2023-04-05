import UIKit

extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.state == viewModel.categories[indexPath.row] {
            viewModel.state = nil
            delegate?.removeFilter()
            dismiss(animated: true)
        }
        else {
            viewModel.state = viewModel.categories[indexPath.row]
            delegate?.filter(with: viewModel.categories[indexPath.row])
            dismiss(animated: true)
        }
    }
}

extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .white
        
        var configuration = cell.defaultContentConfiguration()
        
        configuration.text = viewModel.categories[indexPath.row]
        configuration.textProperties.alignment = .center
        configuration.textProperties.color = .black
        
        if let filterState = viewModel.state {
            if(filterState == configuration.text) {
                configuration.textProperties.color = .red
                cell.backgroundColor = #colorLiteral(red: 0.9965899587, green: 0.4590346813, blue: 0.4174408019, alpha: 0.6493675595)
                cell.layer.borderColor = CGColor(red: 1.0, green: 0, blue: 0, alpha: 1.0)
                cell.layer.borderWidth = 1
                cell.layer.cornerRadius = 8
            }
        }
        
        cell.contentConfiguration = configuration
        
        return cell
    }
}
