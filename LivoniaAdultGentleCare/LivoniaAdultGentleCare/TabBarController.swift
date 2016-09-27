//
//  TabBarController.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 9/20/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, ShadowHideable {
    var isShadowLineHidden: Bool = false
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hideShadowLine()
    }
}

class NavigationBar: UINavigationBar, ShadowHideable, UIBarPositioningDelegate {
    var isShadowLineHidden: Bool = false
    
    let gradient: CAGradientLayer = CAGradientLayer()
    
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
        
        if gradient.frame.size.height < 64 {
            gradient.frame.size.height = 64.0 // set to 64 due to navigationController setting navBar under statusBar
            gradient.frame.origin.y = -20.0   // set to -20 to compencate for status bar, clips under if not -20
        }
        
        layer.insertSublayer(gradient, at: 0)
    
    }
}
