import UIKit

class HomeCategoryCell: UICollectionViewCell {

    static let nib = UINib(nibName: "HomeCategoryCell", bundle: Bundle.main)
    static var reuseIdentifier: String = "HomeCategoryCell"

    @IBOutlet private weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bind(name: String, isSelected: Bool) {
        nameLabel.text = name
        nameLabel.textColor = UIColor(named: isSelected ? "primary_text_color" : "secondary_text_color")
    }
}
