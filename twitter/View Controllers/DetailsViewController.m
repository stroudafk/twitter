//
//  DetailsViewController.m
//  twitter
//
//  Created by Sj Stroud on 7/1/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "APIManager.h"
#import "DateTools.h"


@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *aviView;
@property (weak, nonatomic) IBOutlet UILabel *displayNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;



@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *aviURL = [NSURL URLWithString:self.tweet.user.profilePicture];
    [self.aviView setImageWithURL:aviURL];
    
    self.displayNameLabel.text = self.tweet.user.name;
    self.handleLabel.text = self.tweet.user.screenName;
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.tweetLabel.text = self.tweet.text;
    
    self.timestampLabel.text = [NSString stringWithFormat:@"%@", self.tweet.createdAtDate];
    
    // Do any additional setup after loading the view.
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
