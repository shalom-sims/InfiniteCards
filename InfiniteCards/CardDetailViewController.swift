import UIKit

// Detail view controller - like a modal component in React
class CardDetailViewController: UIViewController {
    
    private var card: Card?
    
    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 10
        view.clipsToBounds = false  // Ensure shadow is visible
        return view
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .systemGray2
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    private let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.backgroundColor = .systemGray5
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let classLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.textColor = .systemGray
        return label
    }()
    
    private let levelLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private let ratingContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let statsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let statsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let socialStatsView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = true
        return scroll
    }()
    
    private let contentView = UIView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGestures()
        
        // Configure if card is already set
        if let card = card {
            configureViews(with: card)
        }
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        // Add views
        view.addSubview(containerView)
        containerView.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(closeButton)
        contentView.addSubview(cardImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(classLabel)
        contentView.addSubview(levelLabel)
        contentView.addSubview(ratingContainerView)
        ratingContainerView.addSubview(ratingLabel)
        contentView.addSubview(statsContainerView)
        statsContainerView.addSubview(statsStackView)
        contentView.addSubview(socialStatsView)
        
        // Setup constraints
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        classLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingContainerView.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        statsContainerView.translatesAutoresizingMaskIntoConstraints = false
        statsStackView.translatesAutoresizingMaskIntoConstraints = false
        socialStatsView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set priority for container height to allow it to size based on content
        let containerHeightConstraint = containerView.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.85)
        containerHeightConstraint.priority = .defaultHigh
        
        // Add minimum height to ensure container is visible
        let containerMinHeightConstraint = containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 600)
        containerMinHeightConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            // Container view - centered with max width
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(lessThanOrEqualToConstant: 400),
            containerView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.9),
            containerHeightConstraint,
            containerMinHeightConstraint,
            
            // Scroll view - fill container
            scrollView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            
            // Content view
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Close button
            closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            
            // Card image - making it larger
            cardImageView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 16),
            cardImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cardImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cardImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cardImageView.heightAnchor.constraint(equalTo: cardImageView.widthAnchor, multiplier: 1.2), // Taller aspect ratio
            
            // Name label - adjusted to account for larger image
            nameLabel.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Class label
            classLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            classLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            classLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Level label
            levelLabel.topAnchor.constraint(equalTo: classLabel.bottomAnchor, constant: 8),
            levelLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            levelLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Rating container
            ratingContainerView.topAnchor.constraint(equalTo: levelLabel.bottomAnchor, constant: 16),
            ratingContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            ratingContainerView.widthAnchor.constraint(equalToConstant: 80),
            ratingContainerView.heightAnchor.constraint(equalToConstant: 40),
            
            ratingLabel.centerXAnchor.constraint(equalTo: ratingContainerView.centerXAnchor),
            ratingLabel.centerYAnchor.constraint(equalTo: ratingContainerView.centerYAnchor),
            
            // Stats container
            statsContainerView.topAnchor.constraint(equalTo: ratingContainerView.bottomAnchor, constant: 24),
            statsContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            statsContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            statsStackView.topAnchor.constraint(equalTo: statsContainerView.topAnchor, constant: 16),
            statsStackView.leadingAnchor.constraint(equalTo: statsContainerView.leadingAnchor, constant: 16),
            statsStackView.trailingAnchor.constraint(equalTo: statsContainerView.trailingAnchor, constant: -16),
            statsStackView.bottomAnchor.constraint(equalTo: statsContainerView.bottomAnchor, constant: -16),
            
            // Social stats
            socialStatsView.topAnchor.constraint(equalTo: statsContainerView.bottomAnchor, constant: 16),
            socialStatsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            socialStatsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            socialStatsView.heightAnchor.constraint(equalToConstant: 80),
            socialStatsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupGestures() {
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Configuration
    func configure(with card: Card) {
        self.card = card
        
        // Only configure views if they're loaded
        if isViewLoaded {
            configureViews(with: card)
        }
    }
    
    private func configureViews(with card: Card) {
        nameLabel.text = card.name
        classLabel.text = card.classType
        levelLabel.text = "Level \(card.level)"
        ratingLabel.text = "\(card.overallRating)"
        
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
        
        // Set rating color
        if card.overallRating >= 90 {
            ratingContainerView.backgroundColor = .systemPurple
        } else if card.overallRating >= 80 {
            ratingContainerView.backgroundColor = .systemBlue
        } else if card.overallRating >= 70 {
            ratingContainerView.backgroundColor = .systemGreen
        } else {
            ratingContainerView.backgroundColor = .systemGray
        }
        
        // Setup placeholder image
        setupPlaceholderImage(for: card)
        
        // Setup stats
        setupStats(for: card)
        
        // Setup social stats
        setupSocialStats(for: card)
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
        
        // Create gradient image with larger size
        let imageSize = CGRect(x: 0, y: 0, width: 400, height: 480) // Increased size with 1.2 aspect ratio
        let gradientImage = UIImage.gradientImage(bounds: imageSize, colors: colors)
        cardImageView.image = gradientImage
        
        // Add character initial with larger font
        let initialLabel = UILabel()
        initialLabel.text = String(card.name.prefix(1))
        initialLabel.font = .systemFont(ofSize: 160, weight: .bold) // Increased font size
        initialLabel.textColor = .white
        initialLabel.textAlignment = .center
        cardImageView.addSubview(initialLabel)
        initialLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            initialLabel.centerXAnchor.constraint(equalTo: cardImageView.centerXAnchor),
            initialLabel.centerYAnchor.constraint(equalTo: cardImageView.centerYAnchor)
        ])
    }
    
    private func setupStats(for card: Card) {
        // Clear existing stats
        statsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Create stat rows
        let stats = [
            ("Physical Attack", card.patk),
            ("Physical Defense", card.pdef),
            ("Magic Attack", card.matk),
            ("Magic Defense", card.mdef),
            ("Speed", card.speed),
            ("Critical Hit", card.critHit),
            ("Critical Damage", card.critDmg),
            ("Vitality", card.vitality),
            ("Evasion", card.eva)
        ]
        
        for (statName, statValue) in stats {
            let statView = createStatRow(name: statName, value: statValue, maxValue: 500)
            statsStackView.addArrangedSubview(statView)
        }
    }
    
    private func createStatRow(name: String, value: Int, maxValue: Int) -> UIView {
        let container = UIView()
        
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        nameLabel.textColor = .label
        
        let valueLabel = UILabel()
        valueLabel.text = "\(value)"
        valueLabel.font = .systemFont(ofSize: 14, weight: .bold)
        valueLabel.textAlignment = .right
        
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progress = Float(value) / Float(maxValue)
        progressView.progressTintColor = progressColor(for: Float(value) / Float(maxValue))
        
        container.addSubview(nameLabel)
        container.addSubview(valueLabel)
        container.addSubview(progressView)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.heightAnchor.constraint(equalToConstant: 30),
            
            nameLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 120),
            
            valueLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            valueLabel.widthAnchor.constraint(equalToConstant: 50),
            
            progressView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
            progressView.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: -8),
            progressView.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
        
        return container
    }
    
    private func progressColor(for value: Float) -> UIColor {
        if value > 0.8 { return .systemGreen }
        if value > 0.6 { return .systemBlue }
        if value > 0.4 { return .systemYellow }
        if value > 0.2 { return .systemOrange }
        return .systemRed
    }
    
    private func setupSocialStats(for card: Card) {
        // Clear existing subviews
        socialStatsView.subviews.forEach { $0.removeFromSuperview() }
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        // Likes
        let likesView = createSocialStatView(icon: "heart.fill", value: "\(card.likes)", label: "Likes", color: .systemPink)
        
        // Wins
        let winsView = createSocialStatView(icon: "trophy.fill", value: "\(card.wins)", label: "Wins", color: .systemGreen)
        
        // Losses
        let lossesView = createSocialStatView(icon: "xmark.circle.fill", value: "\(card.losses)", label: "Losses", color: .systemRed)
        
        // Win rate
        let winRate = card.wins + card.losses > 0 ? Int((Double(card.wins) / Double(card.wins + card.losses)) * 100) : 0
        let winRateView = createSocialStatView(icon: "percent", value: "\(winRate)", label: "Win Rate", color: .systemBlue)
        
        stackView.addArrangedSubview(likesView)
        stackView.addArrangedSubview(winsView)
        stackView.addArrangedSubview(lossesView)
        stackView.addArrangedSubview(winRateView)
        
        socialStatsView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: socialStatsView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: socialStatsView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: socialStatsView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: socialStatsView.bottomAnchor, constant: -8)
        ])
    }
    
    private func createSocialStatView(icon: String, value: String, label: String, color: UIColor) -> UIView {
        let container = UIView()
        
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: icon)
        iconImageView.tintColor = color
        iconImageView.contentMode = .scaleAspectFill
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 18, weight: .bold)
        valueLabel.textAlignment = .center
        
        let nameLabel = UILabel()
        nameLabel.text = label
        nameLabel.font = .systemFont(ofSize: 12)
        nameLabel.textColor = .systemGray
        nameLabel.textAlignment = .center
        
        container.addSubview(iconImageView)
        container.addSubview(valueLabel)
        container.addSubview(nameLabel)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: container.topAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            valueLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 4),
            valueLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 2),
            nameLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        return container
    }
    
    // MARK: - Actions
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func backgroundTapped() {
        dismiss(animated: true)
    }
}

// MARK: - UIGestureRecognizerDelegate
extension CardDetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // Only dismiss if tapping outside the container
        return !containerView.frame.contains(touch.location(in: view))
    }
} 