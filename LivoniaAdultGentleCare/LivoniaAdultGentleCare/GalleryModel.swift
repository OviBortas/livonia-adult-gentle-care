//
//  GalleryModel.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 9/24/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

struct GalleryData {
    let title: String
    let displayImg: UIImage
    let imgNames: [String]
}

class GalleryModel {
    
    let data: [GalleryData] = {
        
        // set the names of the pictures associated with the item
        let picNames = ["Island", "img1", "Island"]
        let item1 = GalleryData(title: "First", displayImg: UIImage(named: "Pinapples")!, imgNames: picNames)
        
        
        let item2 = GalleryData(title: "Second", displayImg: UIImage(named: "img1")!, imgNames: picNames)
        let item3 = GalleryData(title: "Third", displayImg: UIImage(named: "Pinapples")!, imgNames: picNames)
        let item4 = GalleryData(title: "Fourth", displayImg: UIImage(named: "Pinapples")!, imgNames: picNames)
        let item5 = GalleryData(title: "Fifth", displayImg: UIImage(named: "Pinapples")!, imgNames: picNames)
        let item6 = GalleryData(title: "Sixth", displayImg: UIImage(named: "Pinapples")!, imgNames: picNames)
        let item7 = GalleryData(title: "None", displayImg: UIImage(named: "Heart Logo Recovered (Gray)")!, imgNames: ["None"])
        
        return [item1, item2, item3, item4, item5, item6, item7]
    }()
    


}
