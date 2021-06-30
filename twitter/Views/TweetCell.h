//
//  TweetCell.h
//  twitter
//
//  Created by Sj Stroud on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *aviView;
@property (weak, nonatomic) IBOutlet UILabel *displayNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *replyIconView;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *retweetIconView;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteIconView;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCountLabel;


@property (nonatomic) Tweet *tweet;

@end

NS_ASSUME_NONNULL_END