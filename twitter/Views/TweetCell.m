//
//  TweetCell.m
//  twitter
//
//  Created by Sj Stroud on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"
#import "Tweet.h"
#import "User.h"
#import "DateTools.h"

@implementation TweetCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setTweet:(Tweet *)tweet{
    //tweet is set -> update all labels
    _tweet = tweet;
    
    self.tweetLabel.text = tweet.text;
    self.displayNameLabel.text = tweet.user.name;
    self.handleLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    self.timeAgoLabel.text = [NSString stringWithFormat:@"%@", tweet.createdAtDate.shortTimeAgoSinceNow];
    
    if (self.tweet.favorited){
        [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    }
    else {
        [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    }
    
    if (self.tweet.retweeted){
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    }
    else {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }
    
    //set bools of highlighted buttons or not
}

- (IBAction)didTapFavorite:(id)sender {
    //set profile pic
    if(self.tweet.favorited){
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
        self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
        
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
        
    }
    else{
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
        self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
        
        // TODO: Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    
}

- (IBAction)didTapRetweet:(id)sender {
    if (self.tweet.retweeted){
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
        self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
        
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];

    }
    else{
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
        self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
 

}


-(void)setUIElements{
    //set profile pic
    self.displayNameLabel.text = self.tweet.user.screenName;
    self.handleLabel.text = self.tweet.user.name;
    self.tweetLabel.text = self.tweet.text;

    //cast to integers first?
    //retweetCountLabel.text = tweet.retweetCount;
    //favoriteCountLabel.text = tweet.favoriteCount;
}
//Favorite, retweet functions

@end
