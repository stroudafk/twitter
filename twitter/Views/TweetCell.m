//
//  TweetCell.m
//  twitter
//
//  Created by Sj Stroud on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"

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
    //set bools of highlighted buttons or not
}

//Favorite, retweet functions



//-(void)favoriteTweet{
//    //change the favorite image to highlighted
//
//}
//-(void)undoFavoriteTweet{
//
//}
//-(void)retweetTweet{
//
//}
//-(void)underRetweetTweet{
//
//}

@end
