//
//  PostManager.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 10/10/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import Foundation
import FBSDKShareKit

class PostManager: NSObject, NSCacheDelegate {
   
   static let sharedInstance = PostManager()
   
   fileprivate let fetchAmount = 30
   fileprivate var isFetching = false
   fileprivate let author = "Livonia Adult Gentle Care"
   
   var interestPosts: [InterestPost]?
   var updatePosts: [UpdatePost]?
   
   
   func setupCache() {
      // Setup the URLCache
      let urlCache = URLCache(memoryCapacity: 20 * 1024 * 1024, diskCapacity: 50 * 1024 * 1024, diskPath: nil)
      URLCache.shared = urlCache
   }
   
   
   func fetchFBPosts() {
      
      if isFetching == false {
         isFetching = true
         
         let path = "LivoniaAdultGentleCare"
         let parameters = ["fields": "posts.limit(\(fetchAmount)){description, message, link, picture, full_picture, created_time, name}",
            "access_token": "1235112659861857|e013e2a956977fde3b6a99a1f50c8d6d"]
         
         _ = FBSDKGraphRequest(graphPath: path, parameters: parameters)
            .start { (connection, result, error) in
               
               if error != nil {
                  print(error!)
                  self.isFetching = false
                  return
               }
               
               self.parse(fetchedPosts: result as? [String: AnyObject])
               self.isFetching = false
         }
      }
   }
   
   func parse(fetchedPosts postJSON: [String: AnyObject]?) {
      
      // Check if postJSON exists and grab the data
      if let posts = postJSON?["posts"] as? [String: AnyObject], let data = posts["data"] as? [[String: AnyObject]] {
      
         
         var newInterestPosts = [InterestPost]()
         var newUpdatePosts = [UpdatePost]()
         
         // Initalize post objects with its relevant data
         for dataKey in data {
            
            let articleBody = dataKey["description"] as? String
            let message = dataKey["message"] as? String
            let articleLink = dataKey["link"] as? String
            let pictureURLSmall = dataKey["picture"] as? String
            let pictureURL = dataKey["full_picture"] as? String
            let postDate = dataKey["created_time"] as? String
            let articleTitle = dataKey["name"] as? String
            
            // If the message contains the #
            if message != nil && message!.contains("#articleofinterest") {
               
               print(articleBody)
               
               // Create the needed URL objects
               let picURL = URL(string: pictureURL ?? "")
               let picURLSmall = URL(string: pictureURLSmall ?? "")
               let articleLinkURL = URL(string: articleLink ?? "")
               
               // Init the object and add it to the array
               let post = InterestPost(authorPhotoURL: nil, author: author, publishTime: postDate, articleTitle: articleTitle, articleImageURL: picURL, articleImageURLSmall: picURLSmall, articleURL: articleLinkURL, body: articleBody, index: 0)
               
               newInterestPosts.append(post)
            }
            else {
               if message == nil || (message?.isEmpty)! { continue }
               
               let newline = CharacterSet.newlines
               let seperatedMessage = message?.components(separatedBy: newline)
               
               if (seperatedMessage?.count)! < 3 {
                  let post = UpdatePost(author: author, publishTime: postDate, title: "No title", body: message, index: 0)
                  
                  newUpdatePosts.append(post)
                  
                  continue
               }
               
               let messageTitle = seperatedMessage?.first
               let newMessageBody = seperatedMessage?.last
               
               let post = UpdatePost(author: author, publishTime: postDate, title: messageTitle, body: newMessageBody, index: 0)
               
               newUpdatePosts.append(post)
            }
         }
         
         interestPosts = newInterestPosts
         updatePosts = newUpdatePosts
      }
   }
}




extension String {
   var toNSString: NSString {
      return NSString(string: self)
   }
}

//    fileprivate var urlCache: URLCache
//    let interestPostCache: NSCache<NSString, InterestPost> = NSCache()
//    let updatePostCache: NSCache<NSString, UpdatePost> = NSCache()

//    override init() {
//
//        // Setup URL Cache
//        let memoryCapacity = 50 * 1024 * 1024 // 50MB
//        let diskCapacity = 75 * 1024 * 1024   // 75MB
//        let path = "fbFetchedData"
//        urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: path)
//        URLCache.shared = urlCache
//
//
//        // Setup Post cache
//        interestPostCache.countLimit = 12
//        interestPostCache.name = "interestPostCache"
//
//        updatePostCache.countLimit = 12
//        updatePostCache.name = "updatePostCache"
//
//
//        super.init()
//
//        updatePostCache.delegate = self
//    }



//    func cache(object: AnyObject) {
//
//        if object.isKind(of: UpdatePost.self) {
//            print("Update")
//
//        }
//        else if object.isKind(of: InterestPost.self) {
//            print("Interest")
//        }
//        else {
//            print("Unknown class \(#function) \(#line)")
//        }
//    }

//    func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
//        print((obj as? UpdatePost)?.author)
//    }
