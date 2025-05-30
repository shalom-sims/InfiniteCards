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
    
    private let statsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let winsLossesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
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
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(classLabel)
        containerView.addSubview(levelLabel)
        containerView.addSubview(ratingView)
        containerView.addSubview(statsStackView)
        containerView.addSubview(winsLossesLabel)
        
        ratingView.addSubview(ratingLabel)
        
        // Auto Layout constraints - like CSS-in-JS or styled-components
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        classLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        statsStackView.translatesAutoresizingMaskIntoConstraints = false
        winsLossesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            ratingView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            ratingView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            ratingView.widthAnchor.constraint(equalToConstant: 30),
            ratingView.heightAnchor.constraint(equalToConstant: 30),
            
            ratingLabel.centerXAnchor.constraint(equalTo: ratingView.centerXAnchor),
            ratingLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: ratingView.leadingAnchor, constant: -8),
            
            classLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            classLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            classLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            levelLabel.topAnchor.constraint(equalTo: classLabel.bottomAnchor, constant: 4),
            levelLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            levelLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            statsStackView.topAnchor.constraint(equalTo: levelLabel.bottomAnchor, constant: 12),
            statsStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            statsStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            winsLossesLabel.topAnchor.constraint(equalTo: statsStackView.bottomAnchor, constant: 8),
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
        winsLossesLabel.text = "W: \(card.wins) L: \(card.losses)"
        
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
        
        // Clear previous stats
        statsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Add main stats
        let mainStats = [
            ("ATK", max(card.patk, card.matk)),
            ("DEF", max(card.pdef, card.mdef)),
            ("SPD", card.speed),
            ("VIT", card.vitality)
        ]
        
        for (statName, statValue) in mainStats {
            let statLabel = UILabel()
            statLabel.font = .systemFont(ofSize: 11)
            statLabel.text = "\(statName): \(statValue)"
            statLabel.textAlignment = .center
            statsStackView.addArrangedSubview(statLabel)
        }
    }
} 