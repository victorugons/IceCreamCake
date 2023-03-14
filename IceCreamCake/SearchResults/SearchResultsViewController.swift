import UIKit

class SearchResultsViewController: UIViewController {
    
    var viewModel: SearchResultsViewModelProtocol
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    private lazy var sortButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.up.arrow.down"), for: .normal)
        button.tintColor = .darkGray
//        button.addTarget(self, action: #selector(showFavorites), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
        button.tintColor = .darkGray
//        button.addTarget(self, action: #selector(showFavorites), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var actionsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sortButton, filterButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var searchResultsTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StoreTableViewCell.self, forCellReuseIdentifier: StoreTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    init(viewModel: SearchResultsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        navigationItem.searchController = searchController
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.getFirstSearchResults()
        searchController.searchBar.text = viewModel.firstSearchText
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(actionsStackView)
        view.addSubview(searchResultsTableView)
    }
    
    private func setupConstraints() {
        setupSortButtonConstraints()
        setupFilterButtonConstraints()
        setupActionsStackViewConstraints()
        setupSearchResultsTableViewConstraints()
    }
    
    private func setupSortButtonConstraints() {
        NSLayoutConstraint.activate([
            sortButton.heightAnchor.constraint(equalToConstant: 25),
            sortButton.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func setupFilterButtonConstraints() {
        NSLayoutConstraint.activate([
            filterButton.heightAnchor.constraint(equalToConstant: 25),
            filterButton.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func setupActionsStackViewConstraints() {
        NSLayoutConstraint.activate([
            actionsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            actionsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupSearchResultsTableViewConstraints() {
        NSLayoutConstraint.activate([
            searchResultsTableView.topAnchor.constraint(equalTo: actionsStackView.bottomAnchor, constant: 16),
            searchResultsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchResultsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchResultsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SearchResultsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText: String = searchBar.text ?? ""
        if searchText != "" {
            viewModel.getSearchResults(for: searchText) { [weak self] in
                DispatchQueue.main.async {
                    self?.searchResultsTableView.reloadData()
                }
            }
        }
    }
}

