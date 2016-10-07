////
////  GalleryPVC.swift
////  LivoniaAdultGentleCare
////
////  Created by Ovidiu Bortas on 9/27/16.
////  Copyright © 2016 Ovidiu Bortas. All rights reserved.
////
//
//import UIKit
//
//private let displayVCID = "GalleryDisplayVCID"
//
//class GalleryPVC: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
//    
//    var imgNames: [String] = [String]()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setup()
//        
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        //setupPageControl()
//    }
//    
//    func setup() {
//        
//        delegate = self
//        dataSource = self
//        
//        view.backgroundColor = UIColor.clear
//        
//        guard let startVC = viewControllerAtIndex(0) else { return }
//        let viewControllers = [startVC]
//        
//        setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
//        
//        setupPageControl()
//        
//        
//    }
//    
//    func imgTappeded(_ sender: UIButton) {
//        
//        print(sender.tag)
//        
//    }
//    
//    func setupPageControl() {
//        guard let tabBar = (parent?.parent as? TabBarController)?.tabBar else {
//            print("could not grab parent TabBarController")
//            return
//        }
//        
//        let imgHeight: CGFloat = 50.0
//        
//        
//        var imgViews: [UIButton] = [UIButton]()
//        
//        var buttonIndex = 0
//        imgNames.forEach { (name) in
//            
//            let button = UIButton(frame: CGRect.zero)
//            button.setImage(UIImage(named: name), for: .normal)
//            button.imageView?.contentMode = .scaleAspectFill
//            button.tag = buttonIndex
//            
//            button.addTarget(self, action: #selector(imgTappeded(_:)), for: .touchUpInside)
//            
//            button.widthAnchor.constraint(equalToConstant: imgHeight).isActive = true
//            
//            imgViews.append(button)
//            
//            buttonIndex += 1
//        }
//        
//        let stackView = UIStackView(arrangedSubviews: imgViews)
//        stackView.distribution = .fill
//        
//        let imgSpaceing = 1
//        stackView.spacing = CGFloat(imgSpaceing)
//        
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        
//        view.addSubview(stackView)
//        
//        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: (tabBar.frame.height + 10).negated()).isActive = true
//        stackView.heightAnchor.constraint(equalToConstant: imgHeight).isActive = true
//        
//        stackView.widthAnchor.constraint(equalToConstant: CGFloat(((50 + imgSpaceing) * imgViews.count) - imgSpaceing)).isActive = true
//    }
//    
//    func viewControllerAtIndex(_ index: Int) -> UIViewController? {
//        
//        if index == NSNotFound || index < 0 || index >= imgNames.count  { return nil }
//        
//        let vc = storyboard?.instantiateViewController(withIdentifier: displayVCID) as! GalleryDisplayVC
//        
//        vc.vcIndex = index
//        vc.imgName = imgNames[index]
//        
//        return vc
//    }
//    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        
//        let index = (viewController as! GalleryDisplayVC).vcIndex - 1
//        
//        return viewControllerAtIndex(index)
//    }
//    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        
//        let index = (viewController as! GalleryDisplayVC).vcIndex + 1
//        
//        return viewControllerAtIndex(index)
//    }
//    
//    
//}
