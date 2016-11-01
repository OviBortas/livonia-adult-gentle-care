//
//  GalleryVC.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 9/17/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

class GalleryVC: UIViewController {
    
    private var galleryCVC: GalleryCVC?

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gallaryCollectionViewSegue" {
            galleryCVC = segue.destination as? GalleryCVC
        }
    }
}
