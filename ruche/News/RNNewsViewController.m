//
//  RNNewsViewController.m
//  ruche
//
//  Created by Eddy RICHARD on 15/03/2014.
//  Copyright (c) 2014 Eddy RICHARD. All rights reserved.
//

#import "RNNewsViewController.h"
#import "RNDetailNewsViewController.h"
#import "RNNewsCell.h"

@interface RNNewsViewController () {
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *link;
    NSMutableString *guid;
    NSMutableString *pubDate;
    NSMutableString *description;
    NSString *element;
}

@end

@implementation RNNewsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    feeds = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:RN_FEED_NEWS_REALEASE];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return feeds.count;
}

/*- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RN_HEIGHT_CELL_EVENT;
}*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*static NSString *simpleTableIdentifier = @"cellNews";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.detailTextLabel.text = [self formatDateString:[[feeds objectAtIndex:indexPath.row] objectForKey:@"pubDate"]];
    
    return cell;*/
    
    
    
    static NSString *simpleTableIdentifier = @"NewsCell";
    
    RNNewsCell *cell = (RNNewsCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RNNewsCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.textLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.detailTextLabel.text = [self formatDateString:[[feeds objectAtIndex:indexPath.row] objectForKey:@"pubDate"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tbView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDetailNews" sender:self];
}

- (NSDate *)rssToDate:(NSString *)strDate
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"EEE',' dd MMM yyyy HH:mm:ss z "];
    NSLocale *locale = [[NSLocale alloc ] initWithLocaleIdentifier:@"en_US" ];
    [df setLocale:locale];
    
    return [df dateFromString:strDate];
}

- (NSString *)formatDateString:(NSString *)date
{
    NSString *dateRSS = date;
    NSDate *_date = [self rssToDate:dateRSS];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"'Publié le 'dd/MM/yyyy' '"];
    NSString *formattedDateString = [df stringFromDate:_date];
    
    return formattedDateString;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

# pragma mark - Parser Delegate.

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    element = elementName;
    
    if ([element isEqualToString:@"item"]) {
        item = [[NSMutableDictionary alloc] init];
        title = [[NSMutableString alloc] init];
        link = [[NSMutableString alloc] init];
        guid = [[NSMutableString alloc] init];
        pubDate = [[NSMutableString alloc] init];
        description = [[NSMutableString alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
        [item setObject:guid forKey:@"guid"];
        [item setObject:pubDate forKey:@"pubDate"];
        [item setObject:description forKey:@"description"];
        
        [feeds addObject:[item copy]];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    } else if ([element isEqualToString:@"link"]) {
        [link appendString:string];
    } else if ([element isEqualToString:@"pubDate"]) {
        [pubDate appendString:string];
    } else if ([element isEqualToString:@"description"]) {
        [description appendString:string];
    } else if ([element isEqualToString:@"guid"]) {
        [guid appendString:string];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    [self.tableView reloadData];
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetailNews"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *titreNews = [feeds[indexPath.row] objectForKey:@"title"];
        NSString *descriptionNews = [feeds[indexPath.row] objectForKey:@"description"];
        NSString *dateNsws = [self formatDateString:[[feeds objectAtIndex:indexPath.row] objectForKey:@"pubDate"]];
        NSString *urlNews = [feeds[indexPath.row] objectForKey:@"guid"];
        [[segue destinationViewController] setStringTitle:titreNews];
        [[segue destinationViewController] setDateString:dateNsws];
        [[segue destinationViewController] setStringDescription:descriptionNews];
        [[segue destinationViewController] setStringUrl:urlNews];
    }
}

# pragma mark - Go to Home.
 
- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated: YES completion: NULL];
}

@end

