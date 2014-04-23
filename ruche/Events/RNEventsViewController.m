//
//  RNEventsViewController.m
//  ruche
//
//  Created by Eddy RICHARD on 14/03/2014.
//  Copyright (c) 2014 Eddy RICHARD. All rights reserved.
//

#import "RNEventsViewController.h"
#import "RNEventCell.h"

@interface RNEventsViewController () {
    NSXMLParser *parser;
    NSMutableArray *event;
    NSMutableDictionary *entry;
    NSMutableString *title;
    NSMutableString *endTime;
    NSMutableString *startTime;
    NSMutableString *content;
    NSMutableString *valueString;
    NSString *element;
}

@end

@implementation RNEventsViewController

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

    event = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:RN_GOOGLE_AGENDA_EVENT_REALEASE_XML];
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
    return event.count;
}

/*- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RN_HEIGHT_CELL_EVENT;
}*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;*/
    
    /*UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey:@"title"];
    return cell;*/
    
    //NSLog(@"event :: %@", event);
    
    static NSString *simpleTableIdentifier = @"EventCell";
    
    RNEventCell *cell = (RNEventCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RNEventCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.textLabel.text = [[event objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.detailTextLabel.text = [self dateFromISO8601String:[[event objectAtIndex:indexPath.row] objectForKey:@"startTime"] andTimeZone:RN_TIMEZONE andLocale:RN_LOLALE];
    
    return cell;
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

# pragma mark - Parser Delegate.

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"entry"]) {
        entry = [[NSMutableDictionary alloc] init];
        title = [[NSMutableString alloc] init];
        content = [[NSMutableString alloc] init];
    } else if ([element isEqualToString:@"gd:when"]) {
        entry = [[NSMutableDictionary alloc] initWithDictionary:attributeDict];
        startTime = [[NSMutableString alloc] init];
        endTime = [[NSMutableString alloc] init];
    } /*else if ([element isEqualToString:@"gd:where"]) {
        entry = [[NSMutableDictionary alloc] initWithDictionary:attributeDict];
        valueString = [[NSMutableString alloc] init];
    }*/
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"entry"]) {
        [entry setObject:title forKey:@"title"];
        [entry setObject:content forKey:@"content"];
        //[event addObject:entry];
    } else if ([elementName isEqualToString:@"gd:when"]) {
        [event addObject:entry];
    } /*else if ([elementName isEqualToString:@"gd:where"]) {
        [event addObject:entry];
    }*/
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    } else if ([element isEqualToString:@"content"]) {
        [content appendString:string];
    } else if ([element isEqualToString:@"gd:when"]) {
        [endTime appendString:string];
        [startTime appendString:string];
    } /*else if ([element isEqualToString:@"gd:where"]) {
        [valueString appendString:string];
    }*/
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    [self.tableView reloadData];
}

/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *string = [feeds[indexPath.row] objectForKey: @"link"];
        [[segue destinationViewController] setUrl:string];
        
    }
}*/

# pragma mark - Go to Home.

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated: YES completion: NULL];
}

# pragma mark - Convert ISO 8601 date format in national date format

- (NSString *)dateFromISO8601String:(NSString *)dateString andTimeZone:(NSTimeZone *)timezone andLocale:(NSLocale *)locale
{
    NSString *s = dateString;
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZ"];
    NSDate *d = [f dateFromString:s];
    
    [f setLocale:locale];
    [f setTimeZone:timezone];
    [f setDateStyle:NSDateFormatterFullStyle];
    [f setTimeStyle:NSDateFormatterShortStyle];
    NSString *date = [f stringFromDate:d];
    NSString *output = [NSString stringWithFormat:@"Le %@", date];
    
    return output;
}

@end
