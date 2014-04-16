//
//  RNTwitterViewController.m
//  ruche
//
//  Created by Eddy RICHARD on 10/03/2014.
//  Copyright (c) 2014 Eddy RICHARD. All rights reserved.
//

#import "RNTwitterViewController.h"
#import "STTwitter.h"
#import "RNTwitterCell.h"

@interface RNTwitterViewController ()

@property (nonatomic, strong) NSMutableArray *jsonFeedTweeter;
@property (nonatomic, strong) IBOutlet UITableView *tableViewTwitte;

@end

@implementation RNTwitterViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self tweetFeed];
}

- (void)tweetFeed
{
    STTwitterAPI *twitter = [STTwitterAPI twitterAPIWithOAuthConsumerName:RN_CONSUMER_NAME
                                                              consumerKey:RN_OAUTH_CONSUMER_KEY
                                                           consumerSecret:RN_OAUTH_CONSUMER_SECRET_KEY
                                                               oauthToken:RN_OUATH_TOKEN
                                                         oauthTokenSecret:RN_OUATH_TOKEN_SECRET];
    
    [twitter verifyCredentialsWithSuccessBlock:^(NSString *username) {
        
        [twitter getHomeTimelineSinceID:nil
                                  count:20
                           successBlock:^(NSArray *statuses) {
                               self.jsonFeedTweeter = [NSMutableArray arrayWithArray:statuses];
                               [self.tableViewTwitte reloadData];
                           } errorBlock:^(NSError *error) {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Erreur :" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                               [alertView show];
                           }];
        
    } errorBlock:^(NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Erreur" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source Mehtods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.jsonFeedTweeter count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RN_HEIGHT_CELL_TWITTER;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"twitterCell";
    
    RNTwitterCell *cell = (RNTwitterCell *) [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RNTwitterCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *status = [self.jsonFeedTweeter objectAtIndex:indexPath.row];
    
    NSString *text = [status valueForKey:@"text"];
    NSString *screenName = [status valueForKeyPath:@"user.screen_name"];
    NSString *name = [status valueForKeyPath:@"user.name"];
    NSString *profileImgStr = [status valueForKeyPath:@"user.profile_image_url"];
    NSURL *imageUrl = [NSURL URLWithString:profileImgStr];
    
    NSData *profileImgData = [NSData dataWithContentsOfURL:imageUrl];
    cell.profileImg.image = [UIImage imageWithData:profileImgData];
    
    cell.twitteLabel.text = text;
    cell.screenNameLabel.text = [NSString stringWithFormat:@"%@ @%@", name, screenName];;
    
    return cell;
}

@end
