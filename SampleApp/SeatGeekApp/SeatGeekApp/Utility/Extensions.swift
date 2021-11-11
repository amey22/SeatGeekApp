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

extension String
{
   
    func getDateFromString_EEE_dd_MMM_yyyy (timeZone:TimeZone?) -> Date? {
        let df = DateFormatter.format_EEE_dd_MMM_yyyy_hh_mm_a
        if let tz = timeZone
        {
            df.timeZone = tz
        }
        return df.date(from:self)
    }
    func getDateFromString_yyyy_MM_dd_T_HH_mm_ss (timeZone:TimeZone?) -> Date? {
        let df = DateFormatter.format_yyyy_MM_dd_T_HH_mm_ss
        if let tz = timeZone
        {
            df.timeZone = tz
        }
        return df.date(from:self)
    }

}

extension Date
{
    // Convert local time to UTC (or GMT)
    func localToGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    // Convert UTC (or GMT) to local time
    func globalTimeToLocal() -> Date {
        let timezone = NSTimeZone.local
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }

    func getStringFromDate_EEE_dd_MMM_yyyy_hh_mm_ss_a(timeZone:TimeZone?) -> String?
    {
        let df = DateFormatter.format_EEE_dd_MMM_yyyy_hh_mm_a
        if let tz = timeZone
        {
            df.timeZone = tz
        }
        return df.string(from:self)
    }
}

extension DateFormatter
{
    
    public static let format_EEE_dd_MMM_yyyy_hh_mm_a: DateFormatter =
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy hh:mm a"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    
    
    public static let format_yyyy_MM_dd_T_HH_mm_ss: DateFormatter =
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

}
