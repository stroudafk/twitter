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
- (IBAction)didTapFavorite:(id)sender {
    //set ui elements
//    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    // TODO: Update the local tweet model
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    [self.favoriteButton setImage:[UIImage imageNamed:@"favorite-icon-red"] forState:UIControlStateNormal];
    

    
    // TODO: Update cell UI
    if(self.tweet.favorited == YES){
        [self.favoriteButton setImage:[UIImage imageNamed:@"favorite-icon-red"] forState:UIControlStateNormal];
    }
    else{
        [self.favoriteButton setImage:[UIImage imageNamed:@"favorite-icon.png"] forState:UIControlStateNormal];

    }
    
    //call refreshData() ?
    // TODO: Send a POST request to the POST favorites/create endpoint
    
}
-(void)setUIElements{
    //set profile pic
    //displayNameLabel.text = self.tweet.user.screenName;
    //handleLabel.text = self.tweet.user.name;
    //tweetLable.text = self.tweet.text;
    
    //cast to integers first?
    //retweetCountLabel.text = tweet.retweetCount;
    //favoriteCountLabel.text = tweet.favoriteCount;
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
