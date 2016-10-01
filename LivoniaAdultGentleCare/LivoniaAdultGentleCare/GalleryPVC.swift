//
//  GalleryPVC.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 9/27/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

private let displayVCID = "GalleryDisplayVCID"

class GalleryPVC: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var imgNames: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupPageControl()
    }
    
    func setup() {
        
        delegate = self
        dataSource = self
        
        view.backgroundColor = UIColor.clear
        
        guard let startVC = viewControllerAtIndex(0) else { return }
        let viewControllers = [startVC]
        
        setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
        
        setupPageControl()
        
        
    }
    
    func setupPageControl() {
        guard let tabBar = (parent?.parent as? TabBarController)?.tabBar else {
            print("could not grab parent TabBarController")
            return
        }
    
        let pView = UIView()
        
        pView.backgroundColor = UIColor.red
        
        pView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(pView)
        

        
        pView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -tabBar.frame.height).isActive = true
        pView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        pView.backgroundColor = UIColor.green
    
        
        print(view.frame)
    }
    
    func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        
        if index == NSNotFound || index < 0 || index >= imgNames.count  { return nil }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: displayVCID) as! GalleryDisplayVC
        
        vc.vcIndex = index
        vc.imgName = imgNames[index]
        
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let index = (viewController as! GalleryDisplayVC).vcIndex - 1
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let index = (viewController as! GalleryDisplayVC).vcIndex + 1
        
        return viewControllerAtIndex(index)
    }
    
    
}
