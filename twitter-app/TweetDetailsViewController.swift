//
//  TweetDetailsViewController.swift
//  twitter-app
//
//  Created by John Franklin on 9/28/15.
//  Copyright © 2015 JF. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {
    
    var tweet : Tweet?

    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoritesCountLabel: UILabel!
    @IBOutlet weak var replyImageView: UIImageView!
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    @IBAction func onReplyImageTouched(sender: UITapGestureRecognizer) {
        print("reply image touched")
        performSegueWithIdentifier("ReplySegue", sender: sender)
    }
    
    @IBAction func onRetweetImageTouched(sender: UITapGestureRecognizer) {
        print("retweet image touched")
        TwitterClient.sharedInstance.retweetWithParams(nil, id: (tweet?.idStr)!) { (tweet, error) -> () in
            if tweet != nil {
                print("retweet success")
                let image = UIImage(named: "retweet_on")
                self.retweetImageView.image = image
                self.reloadInputViews()
            } else {
                print("retweet failed")
                print(error)
            }
        }
    }
    @IBAction func onFavoriteImageTouched(sender: AnyObject) {
        print("favorite image touched")
        var params : Dictionary<String,String> = [:]
        params["id"] = tweet?.idStr
        TwitterClient.sharedInstance.favoriteWithParams(params) { (tweet, error) -> () in
            if tweet != nil {
                print("favoriting tweet success")
                let image = UIImage(named: "favorite_on")
                self.favoriteImageView.image = image
                self.reloadInputViews()
            } else {
                print("favoriting tweet failed")
                print(error)
            }
        }

    }
    @IBAction func onHome(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onReply(sender: UIBarButtonItem) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.25, green:0.60, blue:1.00, alpha:1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        
        if let t = tweet {
            self.userImageView.setImageWithURL(NSURL(string : (t.user?.profileImageUrl)!))
            self.nameLabel.text = t.user?.name
            self.screennameLabel.text = "@" + (t.user?.screenname)!
            self.tweetTextLabel.text = t.text
            self.dateLabel.text = t.createdAtString
            self.retweetCountLabel.text = String(t.retweetCount as Int!)
            self.favoritesCountLabel.text = String(t.favoritesCount as Int!)
            var image : UIImage
            if t.favorited! {
                image = UIImage(named: "favorite_on")!
            } else {
                image = UIImage(named: "favorite")!
            }
            favoriteImageView.image = image
            var image1 : UIImage
            if t.retweeted! {
                image1 = UIImage(named: "retweet_on")!
            } else {
                image1 = UIImage(named: "retweet")!
            }
            retweetImageView.image = image1
                        
        } else {
            print ("tweet is nil")
        }
        
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let nvc = segue.destinationViewController as! UINavigationController
        let vc = nvc.topViewController as! ReplyViewController
        vc.tweet = self.tweet
        
    }
    

}
