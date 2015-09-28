//
//  TwitterTableViewCell.swift
//  twitter-app
//
//  Created by John Franklin on 9/28/15.
//  Copyright © 2015 JF. All rights reserved.
//

import UIKit

class TwitterTableViewCell: UITableViewCell {

    
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var twitterImageView: UIImageView!
    
    var tweet : Tweet! {
        didSet {
            nameLabel.text = tweet.user!.name
            nicknameLabel.text = "@" + (tweet.user?.screenname)!
            tweetLabel.text = tweet.text
            twitterImageView.setImageWithURL(NSURL(string: (tweet.user?.profileImageUrl)!))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        twitterImageView.layer.cornerRadius = 3
        twitterImageView.clipsToBounds = true
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        nicknameLabel.preferredMaxLayoutWidth = nicknameLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        nicknameLabel.preferredMaxLayoutWidth = nicknameLabel.frame.size.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
