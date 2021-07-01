//
//  ComposeViewController.m
//  twitter
//
//  Created by Sj Stroud on 6/30/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "Tweet.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ComposeViewController
- (IBAction)cancelTweet:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)sendTweet:(id)sender {
    NSString *tweetContents = [self.textView text];
    [[APIManager shared] postStatusWithText:tweetContents completion:^(Tweet *tweet, NSError *error) {
        if (error) {
            NSLog(@"😫😫😫 Error sending tweet: %@", error.localizedDescription);
        } else {
            NSLog(@"😎😎😎 Successfully sent tweet.");
        }
    }];
    
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.textView becomeFirstResponder];
    // Do any additional setup after loading the view.
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
