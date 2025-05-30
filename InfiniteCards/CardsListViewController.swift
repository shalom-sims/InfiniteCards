import UIKit

// Main view controller - like a container component in React
class CardsListViewController: UIViewController {
    
    // Data source - like state in React
    private var cards: [Card] = []
    
    // Currency header view
    private let currencyHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private let diamondsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemIndigo.withAlphaComponent(0.1)
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let goldContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow.withAlphaComponent(0.1)
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let diamondsIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "diamond.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemIndigo
        return imageView
    }()
    
    private let goldIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "coins.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    private let diamondsLabel: UILabel = {
        let label = UILabel()
        label.text = "2,600"
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .systemIndigo
        return label
    }()
    
    private let goldLabel: UILabel = {
        let label = UILabel()
        label.text = "250K"
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .systemYellow
        return label
    }()
    
    // Collection view - like a FlatList in React Native
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemGroupedBackground
        collection.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    // Lifecycle method - like componentDidMount in React
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadCards()
    }
    
    private func setupUI() {
        // Remove title and large titles
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = nil
        
        view.backgroundColor = .systemGroupedBackground
        
        // Add currency header
        view.addSubview(currencyHeaderView)
        currencyHeaderView.addSubview(diamondsContainer)
        currencyHeaderView.addSubview(goldContainer)
        
        diamondsContainer.addSubview(diamondsIcon)
        diamondsContainer.addSubview(diamondsLabel)
        goldContainer.addSubview(goldIcon)
        goldContainer.addSubview(goldLabel)
        
        // Add collection view to view hierarchy
        view.addSubview(collectionView)
        
        // Setup constraints
        currencyHeaderView.translatesAutoresizingMaskIntoConstraints = false
        diamondsContainer.translatesAutoresizingMaskIntoConstraints = false
        goldContainer.translatesAutoresizingMaskIntoConstraints = false
        diamondsIcon.translatesAutoresizingMaskIntoConstraints = false
        goldIcon.translatesAutoresizingMaskIntoConstraints = false
        diamondsLabel.translatesAutoresizingMaskIntoConstraints = false
        goldLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Currency header
            currencyHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            currencyHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currencyHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currencyHeaderView.heightAnchor.constraint(equalToConstant: 36),
            
            // Diamonds container
            diamondsContainer.centerYAnchor.constraint(equalTo: currencyHeaderView.centerYAnchor),
            diamondsContainer.trailingAnchor.constraint(equalTo: currencyHeaderView.centerXAnchor, constant: -8),
            diamondsContainer.heightAnchor.constraint(equalToConstant: 28),
            diamondsContainer.widthAnchor.constraint(equalToConstant: 90),
            
            // Gold container
            goldContainer.centerYAnchor.constraint(equalTo: currencyHeaderView.centerYAnchor),
            goldContainer.leadingAnchor.constraint(equalTo: currencyHeaderView.centerXAnchor, constant: 8),
            goldContainer.heightAnchor.constraint(equalToConstant: 28),
            goldContainer.widthAnchor.constraint(equalToConstant: 90),
            
            // Diamonds icon
            diamondsIcon.leadingAnchor.constraint(equalTo: diamondsContainer.leadingAnchor, constant: 8),
            diamondsIcon.centerYAnchor.constraint(equalTo: diamondsContainer.centerYAnchor),
            diamondsIcon.widthAnchor.constraint(equalToConstant: 16),
            diamondsIcon.heightAnchor.constraint(equalToConstant: 16),
            
            // Diamonds label
            diamondsLabel.leadingAnchor.constraint(equalTo: diamondsIcon.trailingAnchor, constant: 8),
            diamondsLabel.centerYAnchor.constraint(equalTo: diamondsContainer.centerYAnchor),
            diamondsLabel.trailingAnchor.constraint(equalTo: diamondsContainer.trailingAnchor, constant: -12),
            
            // Gold icon
            goldIcon.leadingAnchor.constraint(equalTo: goldContainer.leadingAnchor, constant: 8),
            goldIcon.centerYAnchor.constraint(equalTo: goldContainer.centerYAnchor),
            goldIcon.widthAnchor.constraint(equalToConstant: 16),
            goldIcon.heightAnchor.constraint(equalToConstant: 16),
            
            // Gold label
            goldLabel.leadingAnchor.constraint(equalTo: goldIcon.trailingAnchor, constant: 8),
            goldLabel.centerYAnchor.constraint(equalTo: goldContainer.centerYAnchor),
            goldLabel.trailingAnchor.constraint(equalTo: goldContainer.trailingAnchor, constant: -12),
            
            // Collection view - adjusted to be below currency header
            collectionView.topAnchor.constraint(equalTo: currencyHeaderView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // Load cards from JSON - like fetching data in React
    private func loadCards() {
        guard let url = Bundle.main.url(forResource: "cards", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Failed to load cards.json")
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let cardData = try decoder.decode(CardData.self, from: data)
            self.cards = cardData.cards
            
            // Update UI on main thread - like setState in React
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } catch {
            print("Failed to decode cards: \(error)")
        }
    }
}

// MARK: - UICollectionViewDataSource
// Data source methods - like mapping over data in React
extension CardsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as? CardCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let card = cards[indexPath.item]
        cell.configure(with: card)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
// Layout delegate - like responsive design in React
extension CardsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Calculate cell size based on screen width
        let padding: CGFloat = 32 // 16 on each side
        let minimumItemSpacing: CGFloat = 16
        let availableWidth = collectionView.frame.width - padding
        
        // Determine number of columns based on device
        let columns: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 3 : 2
        let itemWidth = (availableWidth - (minimumItemSpacing * (columns - 1))) / columns
        
        // Reduced height since we removed stats
        return CGSize(width: itemWidth, height: itemWidth * 1.3)
    }
    
    // Handle selection - like onPress in React Native
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let card = cards[indexPath.item]
        
        // Create detail view controller
        let detailVC = CardDetailViewController()
        
        // Configure the view controller with card data
        detailVC.configure(with: card)
        
        // Configure modal presentation style
        detailVC.modalPresentationStyle = .overFullScreen
        detailVC.modalTransitionStyle = .crossDissolve
        
        // Present modally
        present(detailVC, animated: true)
    }
} 