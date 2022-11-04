import UIKit

class StoreTableViewCell: UITableViewCell {
    
    public static let identifier: String = "StoreTableViewCell"
    
    private let standardConstraintValue: CGFloat = 16
    
    private lazy var storeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bag.circle.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "TESTEEEEEEEEEEEEEEEEEEEEEEEE"
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "TESTANDOOOOOOOOOOOOOOOOOOOOO"
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
        label.text = "4.5"
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
    
    private lazy var favoriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart")
        imageView.tintColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var rightStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            ratingStackView,
            favoriteImageView
       ])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
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
        contentView.addSubview(contentStackView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        setupContentStackView()
        setupStoreImageConstraints()
        setupFavoriteImageView()
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
    
    private func setupFavoriteImageView() {
        NSLayoutConstraint.activate([
            favoriteImageView.heightAnchor.constraint(equalToConstant: 30),
            favoriteImageView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}
