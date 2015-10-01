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
    @IBOutlet weak var tweetStatus: UILabel!
    
    @IBAction func onTweet(sender: UIBarButtonItem) {
        let tweetText = tweetTextView.text
        if tweetText.isEmpty {
            self.tweetStatus.textColor = UIColor.redColor()
            tweetStatus.text = "no empty tweets please"
        } else {
            self.tweetStatus.text = ""
            var params : Dictionary<String,String> = [:]
            params["status"] = tweetText
            TwitterClient.sharedInstance.tweetWithParams(params, completion: { (tweet, error) -> () in
                if tweet != nil {
                    // success
                    self.tweetStatus.textColor = UIColor.greenColor()
                    self.tweetStatus.text = "success"
                } else {
                    // error
                    print("error in tweet")
                    print(error)
                    self.tweetStatus.textColor = UIColor.redColor()
                    self.tweetStatus.text = error?.localizedDescription
                }
            })
            
            //view.reloadInputViews()
        }
        
    }
    
    
    @IBAction func onCancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.25, green:0.60, blue:1.00, alpha:1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
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
