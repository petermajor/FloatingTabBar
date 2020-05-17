import UIKit

class FloatingTabBarController : UITabBarController {
    
    private let tabBarInset: CGFloat = 15
    
    //private var tabBarBackgroundView: UIView!
    
    private var windowBottomSafeAreaInset: CGFloat {
        return view.window?.safeAreaInsets.bottom ?? 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setAdditionalSafeAreaInset()
    }
    
    private func setupTabBar() {
        tabBar.backgroundImage = UIImage() // remove the default background
        tabBar.shadowImage = UIImage()     // remove the line
        tabBar.tintColor = UIColor(named: "tabbar_color_selected")
        tabBar.unselectedItemTintColor = UIColor(named: "tabbar_color_unselected")

        let blurEffect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.layer.cornerRadius = 15
        effectView.clipsToBounds = true
        effectView.translatesAutoresizingMaskIntoConstraints = false
        tabBar.insertSubview(effectView, at: 0)
        
        effectView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor, constant: tabBarInset).isActive = true
        effectView.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor, constant: -tabBarInset).isActive = true
        effectView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: 0).isActive = true
        effectView.bottomAnchor.constraint(equalTo: tabBar.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        setAdditionalSafeAreaInset()
    }
    
    // we want the tabbar to have a bottom inset
    // but we don't need an inset if there's already a nav handle at the bottom, there will already be an inset
    private func setAdditionalSafeAreaInset() {
        if windowBottomSafeAreaInset == 0 {
            if additionalSafeAreaInsets.bottom == 0 {
                additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: tabBarInset, right: 0)
            }
        } else {
            if additionalSafeAreaInsets.bottom != 0 {
                additionalSafeAreaInsets = UIEdgeInsets.zero
            }
        }
    }
}
