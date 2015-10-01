//
//  TweetsViewController.swift
//  twitter-app
//
//  Created by John Franklin on 9/27/15.
//  Copyright © 2015 JF. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var tweets : [Tweet]!
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onSignOut(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.25, green:0.60, blue:1.00, alpha:1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        //load tweets
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()            
        }
    }
    
    func refresh(sender : AnyObject) {
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            print("number of tweets: \(tweets!.count)")
            return (tweets?.count)!
        } else {
            return 0;
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TwitterTableViewCell", forIndexPath: indexPath) as! TwitterTableViewCell
        cell.tweet = tweets[indexPath.row] as Tweet
        let tappedReply : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tappedReply:")
        tappedReply.numberOfTapsRequired = 1
        cell.reply.addGestureRecognizer(tappedReply)
        let tappedRetweet : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tappedRetweet:")
        tappedRetweet.numberOfTapsRequired = 1
        cell.retweet.addGestureRecognizer(tappedRetweet)
        let tappedFavorite : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tappedFavorite:")
        tappedFavorite.numberOfTapsRequired = 1
        cell.favorite.addGestureRecognizer(tappedFavorite)
        return cell
    }
    
    func tappedReply(sender : UITapGestureRecognizer) {
        print("reply tapped")
        let tapLocation = sender.locationInView(self.tableView)
        if let tapIndexPath = tableView.indexPathForRowAtPoint(tapLocation) {
            if let tappedCell = tableView.cellForRowAtIndexPath(tapIndexPath) as? TwitterTableViewCell {
                performSegueWithIdentifier("CellToReply", sender: tappedCell)
            }
        }
    }
    
    func tappedRetweet(sender : UITapGestureRecognizer) {
        print("retweet tapped")
        let tapLocation = sender.locationInView(self.tableView)
        if let tapIndexPath = tableView.indexPathForRowAtPoint(tapLocation) {
            if let tappedCell = tableView.cellForRowAtIndexPath(tapIndexPath) as? TwitterTableViewCell {
                let selectedTweet = tappedCell.tweet
                TwitterClient.sharedInstance.retweetWithParams(nil, id: (selectedTweet?.idStr)!) { (tweet, error) -> () in
                    if tweet != nil {
                        print("retweet success")
                        let image = UIImage(named: "retweet_on")
                        tappedCell.retweet.image = image
                        //tappedCell.reloadInputViews()
                    } else {
                        print("retweet failed")
                        print(error)
                    }
                }

            }
        }
    }
    
    func tappedFavorite(sender : UITapGestureRecognizer) {
        print("favorite tapped")
        let tapLocation = sender.locationInView(self.tableView)
        if let tapIndexPath = tableView.indexPathForRowAtPoint(tapLocation) {
            if let tappedCell = tableView.cellForRowAtIndexPath(tapIndexPath) as? TwitterTableViewCell {
                let selectedTweet = tappedCell.tweet
                var params : Dictionary<String,String> = [:]
                params["id"] = selectedTweet?.idStr
                TwitterClient.sharedInstance.favoriteWithParams(params) { (tweet, error) -> () in
                    if tweet != nil {
                        print("favoriting tweet success")
                        let image = UIImage(named: "favorite_on")
                        tappedCell.favorite.image = image
                        //tappedCell.reloadInputViews()
                    } else {
                        print("favoriting tweet failed")
                        print(error)
                    }
                }
            }
        }
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

        let s = sender is UITableViewCell ? true : false
        if s {
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPathForCell(cell)
            let tweet = self.tweets[indexPath!.row]
            let detailsNavController = segue.destinationViewController as! UINavigationController
            if let detailsViewController = detailsNavController.topViewController as? TweetDetailsViewController {
                detailsViewController.tweet = tweet
            } else {
                let replyViewController = detailsNavController.topViewController as? ReplyViewController
                replyViewController?.tweet = tweet
            }
        }
    }
}
