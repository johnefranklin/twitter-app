//
//  ReplyViewController.swift
//  twitter-app
//
//  Created by John Franklin on 9/30/15.
//  Copyright © 2015 JF. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController {
    
    var tweet : Tweet?
    
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var replyStatus: UILabel!
    @IBOutlet weak var replyTextView: UITextView!
    @IBOutlet weak var originalTweet: UILabel!
    @IBOutlet weak var tweeterScreenName: UILabel!
    @IBOutlet weak var tweeterName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.25, green:0.60, blue:1.00, alpha:1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        let color = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        replyTextView.layer.borderColor = color.CGColor;
        replyTextView.layer.borderWidth = 1.0;
        replyTextView.layer.cornerRadius = 5.0;
        tweetImageView.setImageWithURL(NSURL(string: (tweet?.user?.profileImageUrl)!))
        originalTweet.text = tweet?.text
        tweeterScreenName.text = "@" + (tweet?.user?.screenname)!
        tweeterName.text = tweet?.user?.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBack(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onSend(sender: UIBarButtonItem) {
        let tweetText = replyTextView.text
        if tweetText.isEmpty {
            self.replyStatus.textColor = UIColor.redColor()
            replyStatus.text = "no empty replies please"
        } else {
            self.replyStatus.text = ""
            var params : Dictionary<String,String> = [:]
            params["status"] = tweeterScreenName.text! + " " + tweetText
            params["in_reply_to_status_id"] = tweet?.idStr
            TwitterClient.sharedInstance.tweetWithParams(params, completion: { (tweet, error) -> () in
                if tweet != nil {
                    // success
                    self.replyStatus.textColor = UIColor.greenColor()
                    self.replyStatus.text = "success"
                } else {
                    // error
                    print("error in tweeting reply")
                    print(error)
                    self.replyStatus.textColor = UIColor.redColor()
                    self.replyStatus.text = error?.localizedDescription
                }
            })
            
            //view.reloadInputViews()
        }

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
