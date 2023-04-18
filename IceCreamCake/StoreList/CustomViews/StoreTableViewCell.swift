import UIKit

class StoreTableViewCell: UITableViewCell {
    
    public static let identifier: String = "StoreTableViewCell"
    
    var delegate: StoreTableViewCellDelegate?
    
    private var id: Int64 = 0
    private var storeType: [String] = []
    
    private let standardConstraintValue: CGFloat = 16
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    private lazy var storeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bag.circle.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            categoryLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var leftStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            storeImage,
            labelStackView
        ])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        label.textColor = .black
        label.text = "-"
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
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(toggleFavoriteState), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var rightStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            ratingStackView,
            favoriteButton
        ])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            leftStackView,
            rightStackView
        ])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(contentStackView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(with store: Store) {
        id = Int64(store.id)
        storeType = store.storeType
        nameLabel.text = store.name
        categoryLabel.text = store.category
        ratingLabel.text = store.rating
        if fetchFavoriteStores().map({ $0.id }).contains(id) {
            self.favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        else {
            self.favoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    private func setupConstraints() {
        setupContentStackView()
        setupStoreImageConstraints()
        setupFavoriteButtonConstraints()
        setupStarImageViewConstraints()
    }
    
    private func setupContentStackView() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardConstraintValue),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -standardConstraintValue)
        ])
    }
    private func setupStoreImageConstraints() {
        NSLayoutConstraint.activate([
            storeImage.heightAnchor.constraint(equalToConstant: 40),
            storeImage.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupNameLabelConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupStarImageViewConstraints() {
        NSLayoutConstraint.activate([
            starImageView.heightAnchor.constraint(equalToConstant: 25),
            starImageView.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func setupFavoriteButtonConstraints() {
        NSLayoutConstraint.activate([
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
            favoriteButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc
    private func toggleFavoriteState() {
        if let context = self.context {
            if let storeToRemove = fetchFavoriteStores().first(where: { $0.id == id }){
                context.delete(storeToRemove)
                
                do {
                    try context.save()
                    
                    self.favoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
                    self.delegate?.removeFavorite()
                }
                catch {
                    //TODO: - Show alert
                    print("Error deleting favorite store")
                }
            }
            else {
                let favoriteStore = FavoriteStore(context: context)
                favoriteStore.id = self.id
                favoriteStore.name = self.nameLabel.text
                favoriteStore.category = self.categoryLabel.text
                favoriteStore.rating = self.ratingLabel.text
                favoriteStore.storeType = self.storeType
                
                
                do {
                    try context.save()
                    
                    self.favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
                }
                catch {
                    //TODO: - Show alert
                    print("Error saving favorite store")
                }
            }
        }
        else {
            print("Context is nil")
        }
    }
    
    private func fetchFavoriteStores() -> [FavoriteStore] {
        var favoriteStores: [FavoriteStore] = []
        if let context = self.context {
            do {
                favoriteStores = try context.fetch(FavoriteStore.fetchRequest())
            }
            catch {
                //TODO: - Show alert
                print("Error fetching favorite stores")
            }
        }
        print(favoriteStores.map { $0.id })
        return favoriteStores
    }
}
