import UIKit

// Custom cell - similar to a React component
class CardCollectionViewCell: UICollectionViewCell {
    static let identifier = "CardCollectionViewCell"
    
    // UI elements - like declaring state/refs in React
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .systemGray6
        return imageView
    }()
    
    private let imageInitialLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let classLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.textColor = .systemGray
        return label
    }()
    
    private let levelLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    private let ratingView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let winsLossesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        label.textColor = .systemGray2
        return label
    }()
    
    // Initializer - like constructor in React class components
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Setup views - like render method in React
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(cardImageView)
        cardImageView.addSubview(imageInitialLabel)
        containerView.addSubview(nameLabel)
        containerView.addSubview(classLabel)
        containerView.addSubview(levelLabel)
        containerView.addSubview(ratingView)
        containerView.addSubview(winsLossesLabel)
        
        ratingView.addSubview(ratingLabel)
        
        // Auto Layout constraints - like CSS-in-JS or styled-components
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        imageInitialLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        classLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        winsLossesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            // Card image at top
            cardImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            cardImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            cardImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            cardImageView.heightAnchor.constraint(equalTo: cardImageView.widthAnchor, multiplier: 0.7),
            
            imageInitialLabel.centerXAnchor.constraint(equalTo: cardImageView.centerXAnchor),
            imageInitialLabel.centerYAnchor.constraint(equalTo: cardImageView.centerYAnchor),
            
            ratingView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            ratingView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            ratingView.widthAnchor.constraint(equalToConstant: 30),
            ratingView.heightAnchor.constraint(equalToConstant: 30),
            
            ratingLabel.centerXAnchor.constraint(equalTo: ratingView.centerXAnchor),
            ratingLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            classLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            classLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            classLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            levelLabel.topAnchor.constraint(equalTo: classLabel.bottomAnchor, constant: 4),
            levelLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            levelLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            winsLossesLabel.topAnchor.constraint(equalTo: levelLabel.bottomAnchor, constant: 8),
            winsLossesLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            winsLossesLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            winsLossesLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
    }
    
    // Configure cell with data - like props in React
    func configure(with card: Card) {
        nameLabel.text = card.name
        classLabel.text = card.classType
        levelLabel.text = "Level \(card.level)"
        ratingLabel.text = "\(card.overallRating)"
        winsLossesLabel.text = "W: \(card.wins) • L: \(card.losses)"
        
        // Check if dual-class (more than 2 class stats)
        let isDualClass = card.classStats.count > 2
        
        // Set border for dual-class cards
        if isDualClass {
            containerView.layer.borderWidth = 3
            containerView.layer.borderColor = UIColor.systemYellow.cgColor
        } else {
            containerView.layer.borderWidth = 0
            containerView.layer.borderColor = UIColor.clear.cgColor
        }
        
        // Set rating color based on value
        if card.overallRating >= 90 {
            ratingView.backgroundColor = .systemPurple
        } else if card.overallRating >= 80 {
            ratingView.backgroundColor = .systemBlue
        } else if card.overallRating >= 70 {
            ratingView.backgroundColor = .systemGreen
        } else {
            ratingView.backgroundColor = .systemGray
        }
        
        // Setup placeholder image
        setupPlaceholderImage(for: card)
    }
    
    private func setupPlaceholderImage(for card: Card) {
        // Different gradient colors for different classes
        let colors: [UIColor]
        switch card.classType.lowercased() {
        case "warrior":
            colors = [.systemRed, .systemOrange]
        case "mage", "sage", "stormcaster":
            colors = [.systemBlue, .systemPurple]
        case "thief", "assassin", "shadowpriest":
            colors = [.systemGray, .black]
        case "guardian", "vanguard":
            colors = [.systemBrown, .systemGray]
        case "ranger":
            colors = [.systemGreen, .systemYellow]
        default:
            colors = [.systemIndigo, .systemTeal]
        }
        
        // Create gradient image with fixed size
        let imageSize = CGRect(x: 0, y: 0, width: 200, height: 140)
        let gradientImage = UIImage.gradientImage(bounds: imageSize, colors: colors)
        cardImageView.image = gradientImage
        
        // Set initial
        imageInitialLabel.text = String(card.name.prefix(1))
    }
} 