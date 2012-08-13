//
//  MMProductCompanies.m
//  WFProductsCategories
//
//  Created by Abhyuday Reddy on 10/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WiFiProductCompaniesViewController.h"
#import "AFJSONRequestOperation.h"
#import "WiFiSearchViewController.h"
#import "WiFiProductDetailViewController.h"
#import "WiFiProductsHeaderView.h"
#import "WiFiJSONDataModel.h"

@implementation WiFiProductCompaniesViewController

@synthesize finalId = finalId_;
@synthesize productCompanyListTable;
@synthesize searchProdComp;
@synthesize headerView = headerView_;
@synthesize expandedHeadersArray = expandedHeadersArray_;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Companies";
    
    productCompanyArray_ = [[NSMutableArray alloc] init];
    jsonCompnayArray = [[NSMutableArray alloc] init ];
    
    NSString *idUrl = @"http://mobile.wi-fi.org/v1/certifiers/category/";
    
    idUrl = [idUrl stringByAppendingString:finalId_];
    
    [self productCompany:idUrl];
    //NSLog(@"url is : %@",idUrl);
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) productCompany: (NSString *) url {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    // __block NSArray *finalInnerData_ = nil;
    AFJSONRequestOperation *requestOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        jsonCompnayArray = [[JSON objectForKey:@"companies"] objectForKey:@"company"];
        
        [productCompanyArray_ addObjectsFromArray:jsonCompnayArray];
        
        [productCompanyListTable reloadData];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Error: %@", error);
    }];
    
    NSOperationQueue *queue = [[[NSOperationQueue alloc] init] autorelease];
    [queue addOperation:requestOperation];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [productCompanyArray_ count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    WiFiProductsHeaderView *headerView = [[WiFiProductsHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [headerView.headerTitleLabel setText:[NSString stringWithFormat:@"%@", 
                                          [[productCompanyArray_ objectAtIndex:section] 
                                           objectForKey:@"name"]]];
    [headerView setSection:section];
    [headerView setDelegate:self];
    
    return headerView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([expandedHeader integerValue] == section) {
        return productSpecification_.count;
    }
    return 0;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *uniqueIdentifier = @"UITableViewCell";
    UITableViewCell *cell = nil;
    
    
    cell = [productCompanyListTable dequeueReusableCellWithIdentifier:uniqueIdentifier];
    
    
    if(!cell)
    {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:uniqueIdentifier] autorelease];
        [[cell textLabel] setFont:[UIFont fontWithName:@"Futura-Medium" size:15]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    NSDictionary *spec = [productSpecification_ objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [spec objectForKey:@"name"];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSDictionary *spec = [productSpecification_ objectAtIndex:indexPath.row];
    NSMutableArray *model = [spec objectForKey:@"alternate_identifiers"];
    
    NSDictionary *dict = [model objectAtIndex:0];
    NSMutableArray *links = [spec objectForKey:@"link"];
    NSDictionary *linkDict = [links objectAtIndex:1];
    NSString *linkHref;
    
    linkHref = [linkDict objectForKey:@"href"];
    WiFiJSONDataModel *data = [[[WiFiJSONDataModel alloc] init] autorelease];
    
    data.certificationId = [spec objectForKey:@"id"];
    data.company = [spec objectForKey:@"company"];
    data.product = [spec objectForKey:@"name"];
    data.model = [dict objectForKey:@"value"];
    data.certificationUrl = linkHref;
    
    NSArray *temp = [[spec objectForKey:@"category_set"] objectForKey:@"category"] ;
    NSString *category = [[temp objectAtIndex:0] objectForKey:@"label"];
    
    data.category = category;
    
    WiFiProductDetailViewController *viewCont = [[[WiFiProductDetailViewController alloc] initWithFinalData:data] autorelease];
    [self. navigationController pushViewController:viewCont animated:YES];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
    WiFiSearchViewController *searchViewController= [[WiFiSearchViewController alloc] initWithKeyword:searchBar.text 
                                                                                           searchType:@"products"];
    self.navigationItem.backBarButtonItem =[[[UIBarButtonItem alloc] initWithTitle:@"Companies" 
                                                                             style:UIBarButtonItemStyleBordered 
                                                                            target:nil 
                                                                            action:nil] autorelease];
    
    searchViewController.title=@"Search";
    
    [self.navigationController pushViewController:searchViewController animated:YES];
    [searchViewController release];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if ([searchText length] == 0) {
        [self performSelector:@selector(hideKeyboardWithSearchBar:) withObject:searchBar afterDelay:0];
    }
}

- (void)hideKeyboardWithSearchBar:(UISearchBar *)searchBar
{   
    [searchBar resignFirstResponder];   
}

- (void)updateTableViewWithData: (NSNumber *)section{
    expandedHeader = section;
    
    NSDictionary *newObj = [productCompanyArray_ objectAtIndex:[section intValue]];
    NSArray *companyArray = [newObj objectForKey:@"link"];
    NSString *urlLink = [[companyArray objectAtIndex:0] objectForKey:@"href"];
    
    [self getCompanyProducts:urlLink];
    
}

- (void)getCompanyProducts:(NSString *)url{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    jsonSpecification = [[NSMutableArray alloc] init];
    productSpecification_ = [[NSMutableArray alloc] init];
    // __block NSArray *finalInnerData_ = nil;
    AFJSONRequestOperation *requestOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        jsonSpecification = [[JSON objectForKey:@"products"] objectForKey:@"product"];
        
        [productSpecification_ addObjectsFromArray:jsonSpecification];
        
        [self.productCompanyListTable reloadData];
    } 
    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        NSLog(@"Error: %@", error);
    }];
    
    NSOperationQueue *queue = [[[NSOperationQueue alloc] init] autorelease];
    [queue addOperation:requestOperation];
    
}

-(void) dealloc{
    [finalId_ release];
    [expandedHeadersArray_ release];
    [super dealloc];
}



@end
