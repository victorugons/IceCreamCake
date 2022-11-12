import UIKit
import Kingfisher

class BannerCollectionViewCell: UICollectionViewCell {
   
    public static let identifier: String = "BannerCollectionViewCell"
    
    private lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bannerImageView)
        setupBannerImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(with banner: Banner) {
        bannerImageView.kf.setImage(with: URL(string: banner.url))
    }
    
    private func setupBannerImageView() {
        NSLayoutConstraint.activate([
            bannerImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            bannerImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            bannerImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bannerImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
