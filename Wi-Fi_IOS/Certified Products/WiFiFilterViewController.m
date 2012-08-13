//
//  MMFilter.m
//  Wi-Fi_IOS
//
//  Created by Abhyuday Reddy on 14/05/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import "WiFiFilterViewController.h"
#import "WiFiDetailFilterViewController.h"
#import "AFJSONRequestOperation.h"


@interface WiFiFilterViewController ()


@end

@implementation WiFiFilterViewController
@synthesize doneFilter = doneFilter_;
@synthesize filterTableView;
@synthesize delegate = delegate_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Filter";
    tableFields_ = [[NSMutableArray alloc] init];
    subTexts_ = [[NSMutableArray alloc] init];
    idValue_ = [[NSMutableArray alloc] init];
    urlArray_ = [[NSMutableArray alloc] init];
    [self getFilterDataMethod];
   
}

- (void)viewDidUnload
{
    [self setFilterTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)doneFilterMethod:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return subTexts_.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
     cell.textLabel.text = [tableFields_ objectAtIndex:indexPath.row];
     cell.detailTextLabel.text = [subTexts_ objectAtIndex:indexPath.row];
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WiFiDetailFilterViewController *viewController = [[WiFiDetailFilterViewController alloc] initWithNibName:@"WiFiDetailFilterViewController" bundle:nil];
    [viewController setDelegate:self];
    
    if([[idValue_ objectAtIndex:indexPath.row] isEqualToString:@"org"]){
        [viewController setDetailFilterUrl:[urlArray_ objectAtIndex:indexPath.row]];
        [viewController setTitleValue:[idValue_ objectAtIndex:indexPath.row]];
    
    }
    else if([[idValue_ objectAtIndex:indexPath.row] isEqualToString:@"cert"]){
        [viewController setDetailFilterUrl:[urlArray_ objectAtIndex:indexPath.row]];
        [viewController setTitleValue:[idValue_ objectAtIndex:indexPath.row]];
    }
    else {
        //NSLog(@"idValue : %@, url : %@",[idValue_ objectAtIndex:indexPath.row],[urlArray_ objectAtIndex:indexPath.row]);
    }
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void) getFilterDataMethod{
    
        NSString *url = [NSString stringWithFormat:@"http://mobile.wi-fi.org/v1/products/filter/modify"];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        // __block NSArray *finalInnerData_ = nil;
        AFJSONRequestOperation *requestOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            NSMutableArray *jsonArray = [[JSON objectForKey:@"filters"] objectForKey:@"filter"];
            int i=0;
            
            for (NSDictionary *tempData in jsonArray) {
            
                tempData = [jsonArray objectAtIndex:i];
                [tableFields_ addObject:[tempData objectForKey:@"name"]];
                [subTexts_ addObject:[tempData objectForKey:@"status"]];
                [idValue_ addObject:[tempData objectForKey:@"id"]];
                
                NSMutableArray *tempUrl = [tempData objectForKey:@"link"];
                [urlArray_ addObject:[[tempUrl objectAtIndex:0] objectForKey:@"href"]];
                
                i++;
            }
            
            [filterTableView reloadData];
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"Error: %@", error);
        }];
        
        NSOperationQueue *queue = [[[NSOperationQueue alloc] init] autorelease];
        [queue addOperation:requestOperation];
        
       
}

- (void) dealloc{
    [filterTableView release];
    [super dealloc];
    //[doneFilter_ release];
    [tableFields_ release];
    [subTexts_ release];
}

#pragma mark - DetailFilter Delegate Methods
- (void)updateURLInFilterView: (NSString *)urlString {
    
    [delegate_ updateURLInFirstView:urlString];
    
}

@end
