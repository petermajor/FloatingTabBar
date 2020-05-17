import UIKit

class HomeViewController: UIViewController {

    @IBOutlet private weak var backgroundGradient: BackgroundGradientView!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var searchBar: UIVisualEffectView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        
        searchBar.layer.cornerRadius = 12
        searchBar.clipsToBounds = true
        
        backgroundGradient.direction = .custom(165)
        backgroundGradient.colors = [UIColor(named: "background_gradient_start")!, UIColor(named: "background_gradient_end")!]
    }
}

