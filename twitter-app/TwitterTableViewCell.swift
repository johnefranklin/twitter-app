//
//  TwitterTableViewCell.swift
//  twitter-app
//
//  Created by John Franklin on 9/28/15.
//  Copyright © 2015 JF. All rights reserved.
//

import UIKit

class TwitterTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var twitterImageView: UIImageView!
    
    @IBOutlet weak var favorite: UIImageView!
    @IBOutlet weak var reply: UIImageView!
    @IBOutlet weak var retweet: UIImageView!
    
    var tweet : Tweet! {
        didSet {
            nameLabel.text = tweet.user!.name
            nicknameLabel.text = "@" + (tweet.user?.screenname)!
            tweetLabel.text = tweet.text
            twitterImageView.setImageWithURL(NSURL(string: (tweet.user?.profileImageUrl)!))
            dateLabel.text = tweet.printableDate
            var image : UIImage
            if tweet.favorited! {
                image = UIImage(named: "favorite_on")!
            } else {
                image = UIImage(named: "favorite")!
            }
            favorite.image = image
            if tweet.retweeted! {
                image = UIImage(named: "retweet_on")!
            } else {
                image = UIImage(named: "retweet")!
            }
            retweet.image = image
            self.layoutSubviews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        twitterImageView.layer.cornerRadius = 3
        twitterImageView.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
