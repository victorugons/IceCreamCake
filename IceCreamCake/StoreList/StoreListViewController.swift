import UIKit

class StoreListViewController: UIViewController {
    
    var viewModel: StoreListViewModelProtocol
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    private lazy var storeTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.text = viewModel.getStoreType()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var favoritesToggleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(showFavorites), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var sortButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.up.arrow.down"), for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(showFavorites), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(showFavorites), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var actionsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [favoritesToggleButton, sortButton, filterButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [storeTypeLabel, actionsStackView])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var bannersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 2, left: 32, bottom: 2, right: 32)
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width - 96, height: 120)
        layout.minimumLineSpacing = 64
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var bannersPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.backgroundStyle = .prominent
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private lazy var storeListTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StoreTableViewCell.self, forCellReuseIdentifier: StoreTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - Init
    init(viewModel: StoreListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.searchController = searchController
        addSubviews()
        setupConstraints()
        customizeViews()
        viewModel.getStoreList { [weak self] in
            DispatchQueue.main.async {
                self?.storeListTableView.reloadData()
            }
        }
        viewModel.getBanners { [weak self] in
            DispatchQueue.main.async {
                self?.bannersCollectionView.reloadData()
            }
            self?.bannersPageControl.numberOfPages = self?.viewModel.banners.count ?? 1
        }
    }
    
    func shouldChangePageControlCurrentPage(to value: Int) {
        bannersPageControl.currentPage = value
    }
    
    private func addSubviews() {
        view.addSubview(headerStackView)
        view.addSubview(bannersCollectionView)
        view.addSubview(bannersPageControl)
        view.addSubview(storeListTableView)
    }
    
    private func setupConstraints() {
        setupFavoritesToggleButtonConstraints()
        setupSortButtonConstraints()
        setupFilterButtonConstraints()
        setupHeaderStackViewConstraints()
        setupBannersCollectionViewConstraints()
        setupStoreListTableViewConstraints()
        setupBannersPageControlConstraints()
    }
    
    private func setupFavoritesToggleButtonConstraints() {
        NSLayoutConstraint.activate([
            favoritesToggleButton.heightAnchor.constraint(equalToConstant: 25),
            favoritesToggleButton.widthAnchor.constraint(equalToConstant: 25)
        ])
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
    
    
    private func setupHeaderStackViewConstraints() {
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupBannersCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            bannersCollectionView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 16),
            bannersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bannersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bannersCollectionView.heightAnchor.constraint(equalToConstant: 124)
        ])
    }
    
    private func setupBannersPageControlConstraints() {
        NSLayoutConstraint.activate([
            bannersPageControl.topAnchor.constraint(equalTo: bannersCollectionView.bottomAnchor, constant: 8),
            bannersPageControl.centerXAnchor.constraint(equalTo: bannersCollectionView.centerXAnchor)
        ])
    }
    
    private func setupStoreListTableViewConstraints() {
        NSLayoutConstraint.activate([
            storeListTableView.topAnchor.constraint(equalTo: bannersPageControl.bottomAnchor, constant: 16),
            storeListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            storeListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            storeListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func customizeViews() {
        switch viewModel.storeType {
        case .salgados:
            storeTypeLabel.textColor = #colorLiteral(red: 1, green: 0.8225428462, blue: 0, alpha: 1)
            bannersPageControl.currentPageIndicatorTintColor = #colorLiteral(red: 1, green: 0.8225428462, blue: 0, alpha: 1)
        case .doces:
            storeTypeLabel.textColor = #colorLiteral(red: 0.2247380912, green: 0.6563640237, blue: 0.9539867043, alpha: 1)
            bannersPageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.2247380912, green: 0.6563640237, blue: 0.9539867043, alpha: 1)
        case .bebidas:
            storeTypeLabel.textColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 0.9508226407)
            bannersPageControl.currentPageIndicatorTintColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        }
    }
    
    @objc private func showFavorites() {
        print("Teste Favoritos")
    }
}

extension StoreListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText: String = searchBar.text ?? ""
        viewModel.search(for: searchText)
    }
}
