import UIKit

protocol CharacterViewProtocol {
    var cellImage: UIImage? { get set }
    var cellName: String? { get set }
    func buildCells()
}

class CharacterViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CharacterViewProtocol {
    
    var cellImage: UIImage?
    var cellName: String?
    
    var characterCellData: [CharacterCellData] = []
    let cellReuseIdentifier = "ImageCell"
    
    init(characterCellData: [CharacterCellData]) {
        self.characterCellData = characterCellData
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPurple
        
        configViews()
        
        // Do any additional setup after loading the view.
    }
    
    private lazy var collectionView: UICollectionView = {
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth - 30) / 2
        let layout =  UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isDirectionalLockEnabled = false
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? CustomCollectionViewCell else {
            return CustomCollectionViewCell()
        }
        
//        let currentCharacter = characterCellData[indexPath.item]
        
        DispatchQueue.main.async {
            cell.build(image: self.cellImage ?? UIImage(), name: self.cellName ?? "")
            self.collectionView.reloadData()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characterCellData.count
    }
    
    func buildCells() {
        collectionView.reloadData()
    }
    
    func configViews() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

