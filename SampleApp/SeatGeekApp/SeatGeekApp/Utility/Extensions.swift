//
//  Extensions.swift
//  SeatGeekApp
//
//  Created by amay on 10/11/21.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView{
    
    func setCasheImage(imageURL:String?,id:String){
        
        var urlImage : URL?
        var res:ImageResource?
        
        if let imageUrl = imageURL , imageUrl != ""
        {
            urlImage = URL(string:imageUrl)
        
              let components =  imageUrl.components(separatedBy: "/")
             
              if let last = components.last
              {
                let cacheName =  NSString(string: last).deletingPathExtension + id
                res  = ImageResource.init(downloadURL: urlImage!, cacheKey: cacheName)
              }
              else
              {
                res  = ImageResource.init(downloadURL: urlImage!, cacheKey: id)
            }
            
        }
        else{
            urlImage = URL(string: "")
        }
        
        
        self.kf.setImage(with: res, placeholder:  UIImage(named: "contactPlaceholder"), options: [.transition(.fade(1))], completionHandler: { result in

        })

    }
}

