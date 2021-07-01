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
    //self.tweet = tweet;
    
    self.tweetLabel.text = tweet.text;
    self.displayNameLabel.text = tweet.user.name;
    self.handleLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    
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
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    
    //refresh data
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    

    // TODO: Send a POST request to the POST favorites/create endpoint
    if(self.tweet.favorited == YES){
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
    self.tweet.retweeted = YES;
    self.tweet.retweetCount += 1;

    [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
 
    NSLog(@"retweet button pressed");
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
