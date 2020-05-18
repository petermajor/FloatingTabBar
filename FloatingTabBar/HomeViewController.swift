import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource {
    @IBOutlet private weak var backgroundGradient: BackgroundGradientView!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var searchBar: UIVisualEffectView!
    @IBOutlet private weak var movieCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        
        searchBar.layer.cornerRadius = 12
        searchBar.clipsToBounds = true
        
        //backgroundGradient.direction = .topLeftToBottomRight
        backgroundGradient.direction = .custom(165)
        backgroundGradient.colors = [UIColor(named: "background_gradient_start")!, UIColor(named: "background_gradient_end")!]
        
        movieCollectionView.dataSource = self
        movieCollectionView.register(HomeMovieCell.nib, forCellWithReuseIdentifier: HomeMovieCell.reuseIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMovieCell.reuseIdentifier, for: indexPath) as! HomeMovieCell
        cell.bind()
        return cell
    }
}

