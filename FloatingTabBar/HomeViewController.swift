import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var backgroundGradient: BackgroundGradientView!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var searchBar: UIVisualEffectView!
    
    private weak var homeMovieViewController: HomeMovieViewController!
    private weak var homeCategoryViewController: HomeCategoryViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        
        searchBar.layer.cornerRadius = 12
        searchBar.clipsToBounds = true
        
        //backgroundGradient.direction = .topLeftToBottomRight
        backgroundGradient.direction = .custom(165)
        backgroundGradient.colors = [UIColor(named: "background_gradient_start")!, UIColor(named: "background_gradient_end")!]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedHomeMovieViewController" {
            homeMovieViewController = (segue.destination as! HomeMovieViewController)
        } else if segue.identifier == "EmbedHomeCategoryViewController" {
            homeCategoryViewController = (segue.destination as! HomeCategoryViewController)
        }
    }
}

