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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
