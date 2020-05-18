import UIKit

class HomeMovieViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.register(HomeMovieCell.nib, forCellWithReuseIdentifier: HomeMovieCell.reuseIdentifier)
    }
}

extension HomeMovieViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMovieCell.reuseIdentifier, for: indexPath) as! HomeMovieCell
        cell.bind()
        return cell
    }

}
