//
//  TabBarController.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 9/20/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate, ShadowHideable {
    var isShadowLineHidden: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hideShadowLine()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController.isKind(of: UINavigationController.self) {
            (viewController as! UINavigationController).popToRootViewController(animated: false)
        }
    }
    
}

class NavigationBar: UINavigationBar, ShadowHideable, UIBarPositioningDelegate {
    var isShadowLineHidden: Bool = false
    fileprivate let navBarHeight: CGFloat = 44.0
    
    let gradient: CAGradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let font = UIFont(name: "AvenirNextCondensed-Regular", size: 24)!
        titleTextAttributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.white]
        items?.first?.leftBarButtonItem?.tintColor = UIColor.white
        
        tintColor = UIColor.white
        
        // Adjust the navigation title
        //setTitleVerticalPositionAdjustment(-20.0, for: .default)
        backIndicatorImage = UIImage(named: "back_detail")?.withRenderingMode(.alwaysOriginal).withAlignmentRectInsets(UIEdgeInsets(top: -20.0, left: 20.0, bottom: 0.0, right: 0.0))
        backIndicatorTransitionMaskImage = UIImage(named: "back_detail")?.withRenderingMode(.alwaysOriginal).withAlignmentRectInsets(UIEdgeInsets(top: -20.0, left: 20.0, bottom: 0.0, right: 0.0))
        
        print(backIndicatorImage?.images)
        
    }
    
    
//    override func sizeThatFits(_ size: CGSize) -> CGSize {
//        super.sizeThatFits(size)
//        return CGSize(width: self.superview!.frame.size.width, height: navBarHeight)
//    }
    
    var set = false
    
    override func layoutSubviews() {
        super.layoutSubviews()

        layer.sublayers?.forEach({ view in
            view.backgroundColor = UIColor.clear.cgColor
        })
        
        hideShadowLine()
        
        gradient.colors = [UIColor(red: 0.0, green: 0.48, blue: 1, alpha: 1.0).cgColor, UIColor(netHex: 0x6ecdf2).cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = bounds
        
        let statusBarHeight: CGFloat = 20.0
        if gradient.frame.size.height < navBarHeight + statusBarHeight {
            gradient.frame.size.height = navBarHeight + statusBarHeight // set to 64 due to navigationController setting navBar under statusBar
            gradient.frame.origin.y = statusBarHeight.negated()   // set to -20 to compencate for status bar, clips under if not -20
        }
        
        layer.insertSublayer(gradient, at: 0)
    }
}
