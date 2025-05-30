import UIKit

// Main view controller - like a container component in React
class CardsListViewController: UIViewController {
    
    // Data source - like state in React
    private var cards: [Card] = []
    
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
        title = "Infinite Cards"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemGroupedBackground
        
        // Add collection view to view hierarchy
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set constraints - like flex styles in React Native
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
        
        return CGSize(width: itemWidth, height: itemWidth * 1.3)
    }
    
    // Handle selection - like onPress in React Native
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let card = cards[indexPath.item]
        print("Selected card: \(card.name)")
        // TODO: Show card detail popup
    }
} 