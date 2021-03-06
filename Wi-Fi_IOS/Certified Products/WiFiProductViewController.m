//
//  MMViewController.m
//  WFProductsCategories
//
//  Created by Abhyuday Reddy on 09/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WiFiProductViewController.h"
#import "AFJSONRequestOperation.h"
#import "WiFiProductCompaniesViewController.h"
#import "WiFiFilterViewController.h"
#import "WiFiSearchViewController.h"
#import "WiFiProductsHeaderView.h"

@interface WiFiProductViewController(){
    UIActivityIndicatorView * activityView_;
}

@property (nonatomic, retain) UIActivityIndicatorView *activityView_;
@end
@implementation WiFiProductViewController
@synthesize headerView = headerView_;
@synthesize expandedHeadersArray = expandedHeadersArray_;
@synthesize productCategoryTable;
@synthesize activityView_;
@synthesize searchBarField;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void) productCategory:url {
    
    NSString *nurl = [NSString stringWithFormat:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:nurl]];
    // __block NSArray *finalInnerData_ = nil;
    AFJSONRequestOperation *requestOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
       
        jsonArray_ = [[JSON objectForKey:@"categories"] objectForKey:@"category"];
        [productCategoryArray_ removeAllObjects];
        [productCategoryArray_ addObjectsFromArray:jsonArray_];
        
        [productCategoryTable reloadData];
        
    } 

    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        NSLog(@"Error: %@", error);
    }];
    
    NSOperationQueue *queue = [[[NSOperationQueue alloc] init] autorelease];
    [queue addOperation:requestOperation];
    
    
}

- (void) setTheUrl: newUrl {
    
    NSString *temp = @"http://api.wi-fi.org/v1/products/category/filter/org";
    NSString *urltemp = temp;
    if(newUrl != nil)
        urltemp = [urltemp stringByAppendingString:newUrl];
    [self productCategory:urltemp];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    productCategoryArray_ = [[NSMutableArray alloc]init];
    expandedHeadersArray_ = [[NSMutableArray alloc] init];
    jsonArray_ = [[NSMutableArray alloc] init];
    [self setTheUrl:nil];
    self.title = @"Products";
    [self.navigationItem rightBarButtonItem ];
    
    activityView_ = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    activityView_.frame = CGRectMake(round((self.view.frame.size.width-35)/2),round((self.view.frame.size.height-150)/2),25,25);
    
    [self.view addSubview:activityView_];
    activityView_.hidesWhenStopped = YES;
    [activityView_ startAnimating];
    
    UIBarButtonItem *filterButton = [[[UIBarButtonItem alloc] initWithTitle:@"Filter" 
                                                                      style:UIBarButtonItemStylePlain 
                                                                     target:self 
                                                                     action:@selector(gotoFilter)] autorelease];
    self.navigationItem.rightBarButtonItem = filterButton;
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    for (NSNumber *sec in self.expandedHeadersArray) {
        
        if ([sec isEqualToNumber:[NSNumber numberWithInteger:section]]) {
            
            NSDictionary *dictObject = [productCategoryArray_ objectAtIndex:section];
            NSArray *categoriesArray = [dictObject objectForKey:@"categories"];
            NSMutableArray *finalArray = [[[NSMutableArray alloc] init] autorelease];
            NSMutableArray *idArray = [[[NSMutableArray alloc] init] autorelease];
            
            for (NSDictionary *dict in categoriesArray) {
                [finalArray addObject:[dict objectForKey:@"category"]];
            }
            
            for (NSDictionary *idDict in categoriesArray) {
                [idArray addObject:[[idDict objectForKey:@"category"] objectForKey:@"id"]];
            }
            
            return [finalArray count];
        }
    }
        
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [productCategoryArray_ count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WiFiProductsHeaderView *headerView = [[WiFiProductsHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [headerView.headerTitleLabel setText:[NSString stringWithFormat:@"%@", [[productCategoryArray_ objectAtIndex:section] objectForKey:@"label"]]];
    
    [headerView setSection:section];
    [headerView setDelegate:self];
    [activityView_ stopAnimating];
    return headerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *uniqueIdentifier = @"UITableViewCell";
    UITableViewCell *cell = nil;
    cell = [productCategoryTable dequeueReusableCellWithIdentifier:uniqueIdentifier];
    
    if(!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:uniqueIdentifier] autorelease];
        [[cell textLabel] setFont:[UIFont fontWithName:@"Futura-Medium" size:15]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSDictionary *dictObject = [productCategoryArray_ objectAtIndex:indexPath.section];
    NSArray *categoriesArray = [dictObject objectForKey:@"categories"];
    NSMutableArray *finalArray = [[[NSMutableArray alloc] init] autorelease];
    NSMutableArray *idArray = [[[NSMutableArray alloc] init] autorelease];
    
    for (NSDictionary *dict in categoriesArray) {
        [finalArray addObject:[dict objectForKey:@"category"]];
        
    }
    
    for (NSDictionary *idDict in categoriesArray) {
        [idArray addObject:[[idDict objectForKey:@"category"] objectForKey:@"id"]];
    }
    
    cell.textLabel.text = [[finalArray objectAtIndex:indexPath.row] objectForKey:@"label"];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath { 
    
    NSDictionary *dictObject = [productCategoryArray_ objectAtIndex:indexPath.section];
    NSArray *categoriesArray = [dictObject objectForKey:@"categories"];
    NSMutableArray *finalArray = [[[NSMutableArray alloc] init] autorelease];
    NSMutableArray *idArray = [[[NSMutableArray alloc] init] autorelease];
    for (NSDictionary *dict in categoriesArray) {
        [finalArray addObject:[dict objectForKey:@"category"]];
        
    }
    
    for (NSDictionary *idDict in categoriesArray) {
        [idArray addObject:[[idDict objectForKey:@"category"] objectForKey:@"id"]];
    }
    
    WiFiProductCompaniesViewController *viewCon = [[[WiFiProductCompaniesViewController alloc] initWithNibName:@"WiFiProductCompaniesViewController" bundle:nil] autorelease];
    [viewCon setFinalId : [idArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:viewCon animated:YES];
  
}

- (void) gotoFilter {
    
    WiFiFilterViewController *filterView = [[[WiFiFilterViewController alloc] initWithNibName:@"WiFiFilterViewController" 
                                                                                       bundle:nil] autorelease];
    [filterView setDelegate:self];
    [filterView setDelegate:self];
    
    [self.navigationController pushViewController:filterView animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    WiFiSearchViewController *searchViewController= [[WiFiSearchViewController alloc] initWithKeyword:searchBar.text 
                                                                                           searchType:@"products"];
    
    self.navigationItem.backBarButtonItem =[[[UIBarButtonItem alloc] initWithTitle:@"Products" 
                                                                             style:UIBarButtonItemStyleBordered 
                                                                            target:nil 
                                                                            action:nil] autorelease];
    
    searchViewController.title=@"Search";
    [self.navigationController pushViewController:searchViewController animated:YES];
    [searchViewController release];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if ([searchText length] == 0) {
        [self performSelector:@selector(hideKeyboardWithSearchBar:) withObject:searchBar afterDelay:0];
    }
}

- (void)hideKeyboardWithSearchBar:(UISearchBar *)searchBar
{   
    [searchBar resignFirstResponder];   
}

#pragma mark - HeaderViewDelegate Methods
- (void)updateTableViewWithData: (NSNumber *)section {
    
    BOOL isExist = NO;
    for (NSNumber *sec in self.expandedHeadersArray) {
        
        if ([sec isEqualToNumber:section]) {
            
            [self.expandedHeadersArray removeObject:sec];
            isExist = YES;
            break;
        }
    }
    
    if (!isExist)
        [self.expandedHeadersArray addObject:section];
    
    [self.productCategoryTable reloadData];
}

#pragma mark - Filter Delegate Method
- (void)updateURLInFirstView:(NSString *)urlString {
    
    [self setTheUrl:urlString]; 
}


@end
