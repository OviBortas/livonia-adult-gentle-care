//
//  GalleryModel.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 9/24/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

struct GalleryData {
    let image: UIImage
    let title: String
}

class GalleryModel {
    
    let data: [GalleryData] = {
        
        let d1 = GalleryData(image: UIImage(named: "Pinapples")!, title: "First")
        let d2 = GalleryData(image: UIImage(named: "img1")!, title: "Second")
        let d3 = GalleryData(image: UIImage(named: "Pinapples")!, title: "Third")
        let d4 = GalleryData(image: UIImage(named: "Pinapples")!, title: "Fourth")
        let d5 = GalleryData(image: UIImage(named: "Pinapples")!, title: "Fifth")
        let d6 = GalleryData(image: UIImage(named: "Pinapples")!, title: "Sixth")
        let d7 = GalleryData(image: UIImage(named: "Heart Logo Recovered (Gray)")!, title: "7th")
        
        return [d1, d2, d3, d4, d5, d6, d7]
    }()
    


}
