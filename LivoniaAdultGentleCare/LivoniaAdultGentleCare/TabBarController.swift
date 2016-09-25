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

class NavigationBar: UINavigationBar, ShadowHideable {
    var isShadowLineHidden: Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        hideShadowLine()
    }
}
