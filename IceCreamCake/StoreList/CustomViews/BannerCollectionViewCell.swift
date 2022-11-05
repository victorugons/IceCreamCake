import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
   
    public static let identifier: String = "BannerCollectionViewCell"
    
    private lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star.filled")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bannerImageView)
        contentView.backgroundColor = .yellow
        setupBannerImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBannerImageView() {
        NSLayoutConstraint.activate([
            bannerImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            bannerImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            bannerImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bannerImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
