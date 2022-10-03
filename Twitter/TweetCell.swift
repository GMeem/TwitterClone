//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Gulshan Meem on 9/26/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var liked:Bool = false
    var tweetID:Int = -1
    //var retweeted:Bool = false
    
    @IBAction func LikeTweet(_ sender: Any) {
        let toBeLiked = !liked
        if (toBeLiked){
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetID, success: {
                self.setLike(true)
            }, failure: { (error) in
                print("Like did not succeed: \(error)")
            })
        } else {
            TwitterAPICaller.client?.unFavoriteTweet(tweetID: tweetID, success: {
                self.setLike(false)
            }, failure: { (error) in
                print("Unlike did not succeed: \(error)")
            })
        }
    }
    @IBAction func retweet(_ sender: Any) {
        
        TwitterAPICaller.client?.retweetTweet(tweetID: tweetID, success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print("Retweet did not succeed: \(error)")
            
        })
        
    }
    
    func setRetweeted(_ isRetweeted: Bool){
        if (isRetweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    
    func setLike(_ isLiked:Bool) {
        liked = isLiked
        if (liked){
            likeButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }else{
            likeButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
