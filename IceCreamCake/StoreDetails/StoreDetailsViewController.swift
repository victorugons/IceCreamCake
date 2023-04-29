import UIKit

class StoreDetailsViewController: UIViewController {
    
    let viewModel: StoreDetailsViewModelProtocol
    
    private lazy var storeBannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var storeBannerImageShadowView: UIView = {
        let view = UIView()
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var storeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bag.circle.fill")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var storeImageShadowView: UIView = {
        let view = UIView()
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var storeNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = #colorLiteral(red: 1, green: 0.8632914424, blue: 0, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            starImageView,
            ratingLabel
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var storeInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            storeNameLabel,
            ratingStackView
        ])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var productsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(viewModel: StoreDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        storeNameLabel.text = viewModel.store.name
        ratingLabel.text = viewModel.store.rating
        viewModel.fetchProducts {
            DispatchQueue.main.async { [weak self] in
                self?.productsTableView.reloadData()
            }
        }
    }
    
    private func addSubviews() {
        storeBannerImageShadowView.addSubview(storeBannerImageView)
        storeImageShadowView.addSubview(storeImageView)
        view.addSubview(storeBannerImageShadowView)
        view.addSubview(storeImageShadowView)
        view.addSubview(storeInfoStackView)
        view.addSubview(productsTableView)
    }
    
    private func setupConstraints() {
        setupStoreBannerImageViewConstraints()
        setupStoreBannerImageShadowViewConstraints()
        setupStoreImageViewConstraints()
        setupStoreImageShadowViewConstraints()
        setupStoreInfoStackViewConstraints()
        setupStarImageViewConstraints()
        setupProductsTableViewConstraints()
    }
    
    private func setupStoreBannerImageViewConstraints() {
        NSLayoutConstraint.activate([
            storeBannerImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            storeBannerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            storeBannerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            storeBannerImageView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    private func setupStoreBannerImageShadowViewConstraints() {
        NSLayoutConstraint.activate([
            storeBannerImageShadowView.centerYAnchor.constraint(equalTo: storeBannerImageView.centerYAnchor),
            storeBannerImageShadowView.centerXAnchor.constraint(equalTo: storeBannerImageView.centerXAnchor),
            storeBannerImageShadowView.heightAnchor.constraint(equalTo: storeBannerImageView.heightAnchor),
            storeBannerImageShadowView.widthAnchor.constraint(equalTo: storeBannerImageView.widthAnchor)
        ])
    }
    
    private func setupStoreImageViewConstraints() {
        NSLayoutConstraint.activate([
            storeImageView.centerYAnchor.constraint(equalTo: storeBannerImageView.centerYAnchor),
            storeImageView.leadingAnchor.constraint(equalTo: storeBannerImageView.leadingAnchor, constant: 24),
            storeImageView.heightAnchor.constraint(equalToConstant: 80),
            storeImageView.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setupStoreImageShadowViewConstraints() {
        NSLayoutConstraint.activate([
            storeImageShadowView.centerYAnchor.constraint(equalTo: storeImageView.centerYAnchor),
            storeImageShadowView.centerXAnchor.constraint(equalTo: storeImageView.centerXAnchor),
            storeImageShadowView.heightAnchor.constraint(equalTo: storeImageView.heightAnchor),
            storeImageShadowView.widthAnchor.constraint(equalTo: storeImageView.widthAnchor)
        ])
    }
    
    private func setupStoreInfoStackViewConstraints() {
        NSLayoutConstraint.activate([
            storeInfoStackView.centerYAnchor.constraint(equalTo: storeImageView.centerYAnchor),
            storeInfoStackView.leadingAnchor.constraint(equalTo: storeImageView.trailingAnchor, constant: 16),
            storeInfoStackView.trailingAnchor.constraint(equalTo: storeBannerImageView.trailingAnchor, constant: -24)
        ])
    }
    
    private func setupStarImageViewConstraints() {
        NSLayoutConstraint.activate([
            starImageView.heightAnchor.constraint(equalToConstant: 30),
            starImageView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupProductsTableViewConstraints() {
        NSLayoutConstraint.activate([
            productsTableView.topAnchor.constraint(equalTo: storeBannerImageView.bottomAnchor, constant: 20),
            productsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            productsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            productsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
    }
}
