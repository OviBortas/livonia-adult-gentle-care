//
//  HomePVC.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 9/25/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

private let displayVCID = "HomeDisplayVC"

class HomePVC: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var displayModel = HomeDisplayModel()
    
    
    var data: [Int] = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setup()
    }
    
    func setup() {
        
        delegate = self
        dataSource = self

        guard let startVC = viewControllerAtIndex(0) else { return }
        let viewControllers = [startVC]
        
        setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
    }
    
    func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        
        if index == NSNotFound || index < 0 || index >= displayModel.data.count  { return nil }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: displayVCID) as! HomeVC
        vc.data = displayModel.data[index]

        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let index = (viewController as! HomeVC).data.vcIndex - 1
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let index = (viewController as! HomeVC).data.vcIndex + 1
        
        return viewControllerAtIndex(index)
    }


}
