//
//  HomePVC.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 9/25/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

//private let displayVCID = "HomeDisplayVC"

class HomePVC: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
   
   fileprivate let displayVCID = "HomeDisplayVC"
   fileprivate let startIndex = 0
   fileprivate var hasViewAppeared = false
   
   var displayModel = HomeDisplayModel()
   var data = [Int]()
   
   var pageControl: UIPageControl!
   var currentPageIndex: Int!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setup()
   }
   
   // Reset the pageIndex to the begining
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)

         resetPageControllerToBegining()
   }
   
   func setup() {
      delegate = self
      dataSource = self
      
      guard let startVC = viewController(at: startIndex) else { return }
      let viewControllers = [startVC]
      
      setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
      
      setupPageControl(at: startIndex)
   }
   
   func resetPageControllerToBegining() {

      guard let startVC = viewController(at: startIndex) else { return }
      let viewControllers = [startVC]
      
      
      setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)
      
      currentPageIndex = startIndex
      pageControl.currentPage = currentPageIndex
   }
   
   func setupPageControl(at index: Int) {
      pageControl = UIPageControl(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: 20))
      pageControl.isEnabled = false
      view.addSubview(pageControl)
      
      pageControl.currentPage = index
      pageControl.numberOfPages = displayModel.data.count
      
      pageControl.currentPageIndicatorTintColor = UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
      pageControl.pageIndicatorTintColor = UIColor(white: 0.57, alpha: 1.0)
      
   }
   
   func viewController(at index: Int) -> UIViewController? {
      if index == NSNotFound || index < 0 || index >= displayModel.data.count  { return nil }
      
      let vc = storyboard?.instantiateViewController(withIdentifier: displayVCID) as! HomeVC
      vc.data = displayModel.data[index]
      
      return vc
   }
   
   // MARK: - UIPageViewControllerDelegate
   func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
      guard let pendingVC = pendingViewControllers.first as? HomeVC else { return }
      
      currentPageIndex = pendingVC.data.vcIndex
   }
   
   func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
      if completed {
         pageControl.currentPage = currentPageIndex
      }
   }
   
   // MARK: - UIPageViewControllerDataSource
   func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
      let index = (viewController as! HomeVC).data.vcIndex - 1
      
      return self.viewController(at: index)
   }
   
   func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
      let index = (viewController as! HomeVC).data.vcIndex + 1
      
      return self.viewController(at: index)
   }
}
