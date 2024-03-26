import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    let cellReuseIdentifier = "ImageCell"
    var data: Data?
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    lazy var productImage: UIImageView = {
        let image = UIImageView(frame: contentView.bounds)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 2
        return image
    }()
    
    func build(image: UIImage, name: String) {
        productImage.image = image
        nameLabel.text = name
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showSkeleton() {
        // Enable skeleton view for the image
//        productImage.isSkeletonable = true
//        productImage.showAnimatedGradientSkeleton()
    }
    
    func hideSkeleton() {
        // Hide skeleton view for the image
//        productImage.hideSkeleton()
    }
    
    func configViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(productImage)
        
        contentView.bringSubviewToFront(nameLabel)
        
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            productImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            productImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            nameLabel.bottomAnchor.constraint(equalTo: productImage.bottomAnchor, constant: -14),
            nameLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
}

