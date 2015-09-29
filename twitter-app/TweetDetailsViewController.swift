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
    
    @IBAction func onHome(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onReply(sender: UIBarButtonItem) {
        
    }
    
    
    @IBAction func onReplyImageTouched(sender: AnyObject) {
        print("reply called")
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
            
        } else {
            print ("tweet is nil")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
