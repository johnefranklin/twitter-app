//
//  Tweet.swift
//  twitter-app
//
//  Created by John Franklin on 9/26/15.
//  Copyright © 2015 JF. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var user : User?
    var text : String?
    var createdAtString : String?
    var createdAt : NSDate?
    var printableDate : String?

    init(dictionary : NSDictionary) {
        user = User(dictionary: (dictionary["user"] as? NSDictionary)!)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        let formatter = NSDateFormatter()
        formatter.timeZone = NSTimeZone()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        //formatter.dateFormat = "mm/dd/yy HH:mm:ss"
        createdAt = formatter.dateFromString(createdAtString!)
        
        let dateFormatter = NSDateFormatter()
        //To prevent displaying either date or time, set the desired style to NoStyle.
        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle //Set time style
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle //Set date style
        dateFormatter.timeZone = NSTimeZone()
        //let localDate = dateFormatter.stringFromDate(date)
        
        let usDateFormat = NSDateFormatter.dateFormatFromTemplate("MMddyyyy HH:mm:ss", options: 0, locale: NSLocale(localeIdentifier: "en-US"))
        let printDateFormatter = NSDateFormatter()
        printDateFormatter.dateFormat = usDateFormat
        printableDate = printDateFormatter.stringFromDate(createdAt!)
        print(printableDate)
        //usDateFormat now contains an optional string "MM/dd/yyyy".
    }
    
    class func tweetsWithArray(array : [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in array {
            tweets.append(Tweet(dictionary : dictionary))
        }
        return tweets
    }
}
