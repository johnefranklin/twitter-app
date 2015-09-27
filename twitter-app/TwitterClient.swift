//
//  TwitterClient.swift
//  twitter-app
//
//  Created by John Franklin on 9/25/15.
//  Copyright © 2015 JF. All rights reserved.
//

import UIKit

let twitterConsumerKey = "koUDKRqYXN01phhPqDGsnkr4X"
let twitterConsumerSecret = "gbVeQHs1JLkbXzVjozHn33HipwidHq6YsMhHSLGzkFZB2Pfemi"
let twitterBaseURL = NSURL(string : "https://api.twitter.com")


class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var loginCompletion : ((user : User?, error : NSError?) -> ())?

    class var sharedInstance : TwitterClient {
        
        struct Static {
            static let instance = TwitterClient(baseURL : twitterBaseURL, consumerKey : twitterConsumerKey, consumerSecret : twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    func loginWithCompletion(completion : (user : User?, error : NSError?) -> ()) {
        
        loginCompletion = completion
        
        // fetch request token and redirect to twitter auth page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken : BDBOAuth1Credential!) -> Void in
        print("Success getting request token")
        let authURL = NSURL(string : "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
        UIApplication.sharedApplication().openURL(authURL!)
        }) { (error : NSError!) -> Void in
            print("error")
            self.loginCompletion?(user : nil, error : error)
        }
    }
    
    func openURL (url : NSURL) {
        TwitterClient.sharedInstance.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken : BDBOAuth1Credential!) -> Void in
            print("Got access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation : AFHTTPRequestOperation!, response : AnyObject!) -> Void in
                //print ("user : \(response)")
                let user = User(dictionary: response as! NSDictionary)
                print ("user : \(user.name)")
                print("screenname : \(user.screenname)")
                self.loginCompletion?(user : user, error : nil)
                User.currentUser = user
                }, failure: { (operation : AFHTTPRequestOperation!, error : NSError!) -> Void in
                    print ("error getting user info")
                    self.loginCompletion?(user : nil, error : error)
            })
            
            TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation : AFHTTPRequestOperation!, response : AnyObject!) -> Void in
                //print ("timeline : \(response)")
                let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                for tweet in tweets {
                    print("text: \(tweet.text), created At: \(tweet.createdAt)")
                }
                }, failure: { (operation : AFHTTPRequestOperation!, error : NSError!) -> Void in
                    print("error getting timeline")
            })
            
            }) { (error : NSError!) -> Void in
                print("error getting access token")
                self.loginCompletion?(user : nil, error : error)
                
        }

    }

}
