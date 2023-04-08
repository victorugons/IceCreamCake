import UIKit

class SearchResultsViewController: UIViewController {
    
    var viewModel: SearchResultsViewModelProtocol
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Buscar"
        return searchController
    }()
    
    private(set) lazy var sortButton: StoreSortButton = {
        let button = StoreSortButton(sortFunction: sortStores)
        return button
    }()

    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(presentFilterModal), for: .touchUpInside)
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
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StoreTableViewCell.self, forCellReuseIdentifier: StoreTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    init(viewModel: SearchResultsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.getFirstSearchResults()
        searchController.searchBar.text = viewModel.searchText
        navigationItem.searchController = searchController
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
            searchResultsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchResultsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchResultsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func sortStores() {
        viewModel.actions.sortStores(with: sortButton.getSortMenuState()) {
            DispatchQueue.main.async { [weak self] in
                self?.searchResultsTableView.reloadData()
            }
        }
    }
    
    @objc
    private func presentFilterModal() {
        viewModel.actions.presentFilterModal(delegate: self)
    }
}

extension SearchResultsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText: String = searchBar.text ?? ""
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).count >= 2 {
            viewModel.getSearchResults(for: searchText) { [weak self] in
                DispatchQueue.main.async {
                    self?.searchResultsTableView.reloadData()
                }
            }
        }
    }
}

extension SearchResultsViewController: FilterDelegate {
    func filter(with state: String) {
        sortButton.performDefaultSort()
        viewModel.actions.filter(with: state) { [weak self] in
            DispatchQueue.main.async {
                self?.searchResultsTableView.reloadData()
            }
        }
    }
    
    func removeFilter() {
        sortButton.performDefaultSort()
        viewModel.actions.removeFilter {
            DispatchQueue.main.async { [weak self] in
                self?.searchResultsTableView.reloadData()
            }
        }
    }
}

