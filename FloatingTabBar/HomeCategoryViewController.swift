import UIKit

class HomeCategoryViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    private let names = ["Recently", "Top week", "Popular", "Featured"]
    private var selectedName: String? = "Recently"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = createCompositionalLayout()
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(HomeCategoryCell.nib, forCellWithReuseIdentifier: HomeCategoryCell.reuseIdentifier)
        view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.delegate = self

        dataSource = UICollectionViewDiffableDataSource<Int, String>(collectionView: collectionView, cellProvider: getCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    }
    
    private func reload() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(names, toSection: 0)
        dataSource.apply(snapshot)
    }

    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: createLayoutSection)
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        layout.configuration = configuration
        return layout
    }
    
    private func createLayoutSection(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(10), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(10), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 30, bottom: 0, trailing: 0)

        return section
    }
    
    private func getCell(collectionView: UICollectionView, indexPath: IndexPath, name: String) -> UICollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryCell.reuseIdentifier, for: indexPath) as! HomeCategoryCell
        cell.bind(name: name, isSelected: name == selectedName)
        return cell
    }
    
    private func deselectCurrent() {
        guard let selectedName = selectedName else { return }
        guard let selectedRow = names.firstIndex(of: selectedName) else { return }
        guard let selectedCell = collectionView.cellForItem(at: IndexPath(row: selectedRow, section: 0)) as? HomeCategoryCell else { return }
        selectedCell.bind(name: selectedName, isSelected: false)
        self.selectedName = nil
    }
    
    private func select(at indexPath: IndexPath) {
        let selectedName = names[indexPath.row]
        guard let cell = collectionView.cellForItem(at: indexPath) as? HomeCategoryCell else { return }
        cell.bind(name: selectedName, isSelected: true)
        self.selectedName = selectedName
    }
}

// MARK: - UICollectionViewDelegate
extension HomeCategoryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        deselectCurrent()
        select(at: indexPath)
        return false
    }
}
