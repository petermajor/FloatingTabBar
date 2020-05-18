import UIKit

class HomeMovieCell: UICollectionViewCell {

    static let nib = UINib(nibName: "HomeMovieCell", bundle: Bundle.main)
    static var reuseIdentifier: String = "HomeMovieCell"
    
    @IBOutlet private weak var blurView: UIVisualEffectView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var lengthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        posterImageView.layer.cornerRadius = 12
        blurView.layer.cornerRadius = 12
        blurView.clipsToBounds = true
    }
    
    func bind() {
        posterImageView.image = UIImage(named: "poster_1917")
        titleLabel.text = "1917"
        lengthLabel.text = "126 mins"
    }

}
