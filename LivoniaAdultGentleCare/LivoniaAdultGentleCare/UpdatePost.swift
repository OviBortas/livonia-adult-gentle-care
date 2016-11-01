//
//  UpdatePost.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 10/10/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import Foundation

struct DictKeys {
   
   static let authorPhotoURL   = "authorPhotoURL"
   static let author           = "author"
   static let publishTime      = "publishTime"
   static let articleTitle     = "articleTitle"
   static let articleImageURL  = "articleImageURL"
   static let articleURL       = "articleURL"
   static let body             = "body"
   static let index            = "index"
   static let didView          = "didView"
}

class UpdatePost {
   
   fileprivate static let userDefaults: UserDefaults = UserDefaults.standard
   fileprivate static let updatePostKey = "updatePostKey"
   fileprivate static let previous = UpdatePost.userDefaults.object(forKey: UpdatePost.updatePostKey)
   
   let author: String?
   let publishTime: String?
   let title: String?
   let body: String?
   let timeAgo: String?
   let index: Int?
   var didView: Bool = false
   
   init(author: String?, publishTime: String?, title: String?, body: String?, index: Int?) {
      self.author = author
      self.publishTime = publishTime
      self.title = title
      self.body = body
      self.index = index
      
      self.timeAgo = DateFormatter().timeAgo(from: publishTime!)
      
      // Checks the UserDefaults if it contains an object with the same time stamp
      // and if it does it used that objects didview value
      if let savedPosts = UpdatePost.previous as? [[String: Any?]] {
         savedPosts.forEach { obj in
            if let pubTime = obj[DictKeys.publishTime] as? String, pubTime == self.publishTime {
               self.didView = obj[DictKeys.didView] as! Bool
            }
         }
      }
   }
   
   func toDictionary() -> [String: Any?] {
      let dict: [String: Any?] = [DictKeys.publishTime: publishTime, DictKeys.didView: didView]
      return dict
   }
}
