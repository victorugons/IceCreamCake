import UIKit

class StoreListViewController: UIViewController {

    // INCLUIR ORDENAR E FILTRO
    // INCLUIR PESQUISA
    
    private var viewModel: StoreListViewModelProtocol
    
    private lazy var storeTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bannersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 2, left: 16, bottom: 2, right: 16)
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width - 64, height: 200)
        layout.minimumLineSpacing = 32
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var storeListTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(viewModel: StoreListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        addSubviews()
        setupConstraints()
        
        storeListTableView.register(StoreTableViewCell.self, forCellReuseIdentifier: StoreTableViewCell.identifier)
        bannersCollectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        
        storeTypeLabel.text = viewModel.getStoreType()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.printStoreType()
    }
    
    private func addSubviews() {
        view.addSubview(storeTypeLabel)
        view.addSubview(bannersCollectionView)
        view.addSubview(storeListTableView)
    }
    
    private func setupConstraints() {
        setupStoreTypeLabelConstraints()
        setupBannersCollectionViewConstraints()
        setupStoreListTableViewConstraints()
    }

    private func setupStoreTypeLabelConstraints() {
        NSLayoutConstraint.activate([
            storeTypeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            storeTypeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            storeTypeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupBannersCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            bannersCollectionView.topAnchor.constraint(equalTo: storeTypeLabel.bottomAnchor, constant: 16),
            bannersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bannersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bannersCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupStoreListTableViewConstraints() {
        NSLayoutConstraint.activate([
            storeListTableView.topAnchor.constraint(equalTo: bannersCollectionView.bottomAnchor, constant: 16),
            storeListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            storeListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            storeListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}
