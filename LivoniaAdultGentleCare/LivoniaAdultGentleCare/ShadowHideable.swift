//
//  ShadowHideable.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 9/24/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

// create protocol that is class only
protocol ShadowHideable: class {
    var isShadowLineHidden: Bool { get set }
}

extension ShadowHideable where Self: UITabBarController {
    
    func hideShadowLine() {
        if isShadowLineHidden == false {
            for view in tabBar.subviews {
                if "\(type(of: view))" == "_UIBarBackground" {
                    for subview in view.subviews {
                        if subview.isKind(of: UIImageView.self) {
                            subview.isHidden = true
                            isShadowLineHidden = true
                        }
                    }
                }
            }
        }
    }
}

extension ShadowHideable where Self: UINavigationBar {
    
        func hideShadowLine() {
    
            if isShadowLineHidden == false {
                for view in subviews {
                    if "\(type(of: view))" == "_UIBarBackground" {
                        for subview in view.subviews {
                            if subview.isKind(of: UIImageView.self) {
                                subview.isHidden = true
                                isShadowLineHidden = true
                            }
                        }
                    }
                }
            }
        }
    
    
//    func hideShadowLine() {
//        
//        if isShadowLineHidden == false {
//            for view in subviews where view.isType(of: "_UIBarBackground") {
//                for subview in view.subviews where subview.isKind(of: UIImageView.self) {
//                    subview.isHidden = true
//                    isShadowLineHidden = true
//                }
//            }
//        }
//    }

}





extension NSObject {
    
    func isType(of type: String) -> Bool {
        return "\(type(of: self))" == type ? true : false
    }
}
