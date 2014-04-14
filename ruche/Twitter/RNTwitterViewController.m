//
//  RNTwitterViewController.m
//  ruche
//
//  Created by Eddy RICHARD on 10/03/2014.
//  Copyright (c) 2014 Eddy RICHARD. All rights reserved.
//

#import "RNTwitterViewController.h"
#import "UIScrollView+SpiralPullToRefresh.h"
#import "RNTwitterCell.h"
#import "STTwitter.h"
#import "NSString+HTML.h"
#import "UILabel+Boldify.h"

@interface RNTwitterViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableViewTwitte;
@property (strong, nonatomic) NSMutableArray *twitterFeed;

@property (nonatomic, strong) NSTimer *workTimer;

@end

@implementation RNTwitterViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self tweetFeed];
    
    __typeof (&*self) __weak weakSelf = self;
    
    [self.tableViewTwitte addPullToRefreshWithActionHandler:^ {
        int64_t delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [weakSelf refreshTriggered];
        });
    }];
    
    // Three type of waiting animations available now: Random, Linear and Circular
    self.tableViewTwitte.pullToRefreshController.waitingAnimation = SpiralPullToRefreshWaitAnimationCircular;
}

- (void)tweetFeed {
    STTwitterAPI *twitter = [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:RN_CONSUMER_KEY consumerSecret:RN_CONSUMER_SECRET];
    
    [twitter verifyCredentialsWithSuccessBlock:^(NSString *username) {
        
        [twitter getUserTimelineWithScreenName:RN_SCREEN_NAME successBlock:^(NSArray *statuses) {
            self.twitterFeed = [NSMutableArray arrayWithArray:statuses];
            [self.tableViewTwitte reloadData];
        } errorBlock:^(NSError *error) {
            NSLog(@"%@", error.debugDescription);
        }];
        
    } errorBlock:^(NSError *error) {
        NSLog(@"%@", error.debugDescription);
    }];
}

- (void)refreshTriggered {
    [self statTodoSomething];
}

- (void)statTodoSomething {
    
    [self.workTimer invalidate];
    
    self.workTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(onAllworkDoneTimer) userInfo:nil repeats:NO];
}

- (void)onAllworkDoneTimer {
    [self.workTimer invalidate];
    self.workTimer = nil;
    
    //[self.twitterFeed addObject: [NSNumber numberWithInt: self.twitterFeed.count]];
    
    [self tweetFeed];
    
    [self.tableViewTwitte.pullToRefreshController didFinishRefresh];
    [self.tableViewTwitte reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table View Data Source Mehtods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.twitterFeed.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RN_HEIGHT_CELL_TWITTER;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID =  @"twitterCell" ;
    
    RNTwitterCell *cell = (RNTwitterCell *) [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RNTwitterCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSLog(@"twitterFeed: \n%@", self.twitterFeed);
    
    NSInteger idx = indexPath.row;
    NSDictionary *t = self.twitterFeed[idx];
    
    NSURL *profileImgUrl = [NSURL URLWithString:t[@"user"][@"profile_image_url"]];
    NSData *profileImgData = [NSData dataWithContentsOfURL:profileImgUrl];
    cell.profileImg.image = [UIImage imageWithData:profileImgData];
    
    NSString *name = [t[@"user"][@"name"] stringByDecodingHTMLEntities];
    NSString *screenName = [t[@"user"][@"screen_name"] stringByDecodingHTMLEntities];
    cell.screenNameLabel.text = [NSString stringWithFormat:@"%@ - @%@", name, screenName];
    [cell.screenNameLabel boldSubstring:name];
    
    NSString *tweet = [t[@"text"] stringByDecodingHTMLEntities];
    cell.twitteLabel.text = tweet;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
