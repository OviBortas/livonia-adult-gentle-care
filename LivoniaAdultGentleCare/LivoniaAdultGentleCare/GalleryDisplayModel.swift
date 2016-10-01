//
//  GalleryDisplayModel.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 9/27/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import Foundation

struct GalleryDisplayData {
    let title: String
    let imgName: String
    let imgNames: [String]
}

class GalleryDisplayModel {
    
    let data: [GalleryDisplayData] = {
        
        let picNames = ["Island", "img1", "Island"]
        let item1 = GalleryDisplayData(title: "Title 1", imgName: "Pinapples", imgNames: picNames)
        
        let item2 = GalleryDisplayData(title: "Title 2", imgName: "Island", imgNames: picNames)
        let item3 = GalleryDisplayData(title: "Title 3", imgName: "Pinapples", imgNames: picNames)
        let item4 = GalleryDisplayData(title: "Title 4", imgName: "Pinapples", imgNames: picNames)
        let item5 = GalleryDisplayData(title: "Title 5", imgName: "Pinapples", imgNames: picNames)
        let item6 = GalleryDisplayData(title: "None", imgName: "Heart Logo Recovered (Gray)", imgNames: ["None"])

        
        return [item1, item2, item3, item4, item5, item6]
    }()
    
}
