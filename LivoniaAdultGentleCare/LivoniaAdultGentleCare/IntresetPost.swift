//
//  IntresetPost.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 10/10/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

struct DictKeys {
   
   static let authorPhotoURL   = "authorPhotoURL"
   static let author           = "author"
   static let publishTime      = "publishTime"
   static let articleTitle     = "articleTitle"
   static let articleImageURL  = "articleImageURL"
   static let articleURL       = "articleURL"
   static let body             = "body"
   static let index            = "index"
}

class InterestPost {
   
   let authorPhotoURL: URL?
   let author: String?
   let publishTime: String?
   let articleTitle: String?
   let articleImageURL: URL?
   let articleImageURLSmall: URL?
   let articleURL: URL?
   let body: String?
   
   let index: Int?
   let timeAgo: String?
   
   var authorPhoto: UIImage? = UIImage(named: "Icon-60@3x")
   var articlePhoto: UIImage?
   
   init(authorPhotoURL: URL?, author: String?, publishTime: String?, articleTitle: String?, articleImageURL: URL?, articleImageURLSmall: URL?, articleURL: URL?, body: String?, index: Int?) {
      
      self.authorPhotoURL = authorPhotoURL
      self.author = author
      self.publishTime = publishTime
      self.articleTitle = articleTitle
      self.articleImageURL = articleImageURL
      self.articleImageURLSmall = articleImageURLSmall
      self.articleURL = articleURL
      self.body = body
      self.index = index
      
      self.timeAgo = DateFormatter().timeAgo(from: publishTime!)
      
      downloadImage(from: self.articleImageURL)
   }
   
   func downloadImage(from url: URL?) {
      guard let url = url else { return }
      
      URLSession.shared.dataTask(with: url) { (data, response, error) in
         guard let data = data, error == nil else { return }
         
         DispatchQueue.main.async {
            self.articlePhoto = UIImage(data: data)
         }
         }.resume()
   }
   
   func toDictionary() -> [String: Any] {
      let dict: [String: Any] = [DictKeys.authorPhotoURL:     authorPhotoURL,
                                 DictKeys.author:             author,
                                 DictKeys.publishTime:        publishTime,
                                 DictKeys.articleTitle:       articleTitle,
                                 DictKeys.articleImageURL:    articleImageURL,
                                 DictKeys.articleURL:         articleURL,
                                 DictKeys.body:               body,
                                 DictKeys.index:              index]
      return dict
   }
}
