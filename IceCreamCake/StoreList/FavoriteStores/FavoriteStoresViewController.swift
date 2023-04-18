import UIKit

class FavoriteStoresViewController: UIViewController {
    
    let viewModel: FavoriteStoresViewModelProtocol
    
    private lazy var favoritesTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StoreTableViewCell.self, forCellReuseIdentifier: StoreTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(viewModel: FavoriteStoresViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Meus favoritos"
        view.backgroundColor = .white
        view.addSubview(favoritesTableView)
        setupFavoritesTableViewConstraints()
    }
    
    private func setupFavoritesTableViewConstraints() {
        NSLayoutConstraint.activate([
            favoritesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoritesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            favoritesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            favoritesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

extension FavoriteStoresViewController: StoreTableViewCellDelegate {
    func removeFavorite() {
        viewModel.updateFavorites()
        
        DispatchQueue.main.async { [weak self] in
            self?.favoritesTableView.reloadData()
        }
    }
}
