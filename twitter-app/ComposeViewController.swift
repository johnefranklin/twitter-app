//
//  ComposeViewController.swift
//  twitter-app
//
//  Created by John Franklin on 9/28/15.
//  Copyright © 2015 JF. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var composeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    
    @IBOutlet weak var tweetTextView: UITextView!
    
    @IBAction func onTweet(sender: UIBarButtonItem) {
        let tweetText = tweetTextView.text
        if tweetText.isEmpty {
            print ("no empty string tweets")
        } else {
            var params : Dictionary<String,String> = [:]
            params["status"] = tweetText
            TwitterClient.sharedInstance.tweetWithParams(params) { (error) -> () in
                if (error != nil) {
                    print("error in tweet")
                    print(error)
                }
            }
            tweetTextView.text = ""
            view.reloadInputViews()
        }
        
    }
    
    
    @IBAction func onCancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let color = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        
        tweetTextView.layer.borderColor = color.CGColor;
        tweetTextView.layer.borderWidth = 1.0;
        tweetTextView.layer.cornerRadius = 5.0;

        composeImageView.setImageWithURL(NSURL(string: (User.currentUser?.profileImageUrl)!))
        nameLabel.text = User.currentUser?.name
        screennameLabel.text = "@" + (User.currentUser?.screenname)!
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
