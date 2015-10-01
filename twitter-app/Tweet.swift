//
//  Tweet.swift
//  twitter-app
//
//  Created by John Franklin on 9/26/15.
//  Copyright © 2015 JF. All rights reserved.
//

import UIKit

extension NSDate {
    func yearsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Year, fromDate: date, toDate: self, options: []).year
    }
    func monthsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Month, fromDate: date, toDate: self, options: []).month
    }
    func weeksFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.WeekOfYear, fromDate: date, toDate: self, options: []).weekOfYear
    }
    func daysFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Day, fromDate: date, toDate: self, options: []).day
    }
    func hoursFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Hour, fromDate: date, toDate: self, options: []).hour
    }
    func minutesFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Minute, fromDate: date, toDate: self, options: []).minute
    }
    func secondsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Second, fromDate: date, toDate: self, options: []).second
    }
    func offsetFrom(date:NSDate) -> String {
        if yearsFrom(date)   > 0 { return "\(yearsFrom(date))y"   }
        if monthsFrom(date)  > 0 { return "\(monthsFrom(date))M"  }
        if weeksFrom(date)   > 0 { return "\(weeksFrom(date))w"   }
        if daysFrom(date)    > 0 { return "\(daysFrom(date))d"    }
        if hoursFrom(date)   > 0 { return "\(hoursFrom(date))h"   }
        if minutesFrom(date) > 0 { return "\(minutesFrom(date))m" }
        if secondsFrom(date) > 0 { return "\(secondsFrom(date))s" }
        return ""
    }
}

class Tweet: NSObject {
    
    var user : User?
    var text : String?
    var createdAtString : String?
    var createdAt : NSDate?
    var printableDate : String?
    var retweetCount : Int?
    var favoritesCount : Int?
    var idStr :String?
    var retweeted : Bool?
    var favorited : Bool?

    init(dictionary : NSDictionary) {
        user = User(dictionary: (dictionary["user"] as? NSDictionary)!)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        let formatter = NSDateFormatter()
        formatter.timeZone = NSTimeZone()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        //formatter.dateFormat = "mm/dd/yy HH:mm:ss"
        createdAt = formatter.dateFromString(createdAtString!)
        
        retweetCount = dictionary["retweet_count"] as? Int
        favoritesCount = dictionary["favorite_count"] as? Int
        idStr = dictionary["id_str"] as? String
        retweeted = dictionary["retweeted"] as? Bool
        favorited = dictionary["favorited"] as? Bool
        
//        let dateFormatter = NSDateFormatter()
//        //To prevent displaying either date or time, set the desired style to NoStyle.
//        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle //Set time style
//        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle //Set date style
//        dateFormatter.timeZone = NSTimeZone()
//        //let localDate = dateFormatter.stringFromDate(date)
//        
//        let usDateFormat = NSDateFormatter.dateFormatFromTemplate("MMddyyyy HH:mm:ss", options: 0, locale: NSLocale(localeIdentifier: "en-US"))
//        let printDateFormatter = NSDateFormatter()
//        printDateFormatter.dateFormat = usDateFormat
//        printableDate = printDateFormatter.stringFromDate(createdAt!)
//        print(printableDate)
        
        let date1 = NSDate()
        
        printableDate = date1.offsetFrom(createdAt!)
    }
    
    class func tweetsWithArray(array : [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in array {
            tweets.append(Tweet(dictionary : dictionary))
        }
        return tweets
    }
}

