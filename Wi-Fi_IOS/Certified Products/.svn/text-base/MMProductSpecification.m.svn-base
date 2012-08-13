//
//  MMProductSpecification.m
//  WFProductsCategories
//
//  Created by Abhyuday Reddy on 10/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMProductSpecification.h"
#import "AFJSONRequestOperation.h"
#import "MMJSONData.h"
#import "MMProductDetail.h"
#import "SearchViewController.h"

@implementation MMProductSpecification
@synthesize specificationTable;
@synthesize comSpec = comSpec_;
@synthesize searchProSpec;

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
    self.title = @"Specification";
    //NSLog(@"url is : %@",comSpec_);
    jsonSpecification = [[NSMutableArray alloc] init];
    productSpecification_ = [[NSMutableArray alloc] init];
    [self specification];
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

- (void) specification{
   // NSString *url = [NSString stringWithFormat:comSpec_];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:comSpec_]];
    // __block NSArray *finalInnerData_ = nil;
    AFJSONRequestOperation *requestOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"URL %@",comSpec_);
        jsonSpecification = [[JSON objectForKey:@"products"] objectForKey:@"product"];
       // NSLog(@"json array : %@",jsonSpecification);
        [productSpecification_ addObjectsFromArray:jsonSpecification];
       // NSLog(@"prod : %@",productSpecification_);
        [specificationTable reloadData];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Error: %@", error);
    }];
    
    NSOperationQueue *queue = [[[NSOperationQueue alloc] init] autorelease];
    [queue addOperation:requestOperation];
    
    //NSLog(@"category : %@",productCategoryArray_);
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"count : %d", [productSpecification_ count]);
    return [productSpecification_ count];
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *uniqueIdentifier = @"UITableViewCell";
    UITableViewCell *cell = nil;
    
    
    cell = [tableView dequeueReusableCellWithIdentifier:uniqueIdentifier];
    
    //    MMJSONData *data = [productCategoryArray_ objectAtIndex:[indexPath row]];
    
    if(!cell)
    {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:uniqueIdentifier] autorelease];
        //        [[cell textLabel] setTextColor:[UIColor blackColor]];
        //        [[cell textLabel] setNumberOfLines:0];
        //        [[cell textLabel] setLineBreakMode:UILineBreakModeWordWrap];
        [[cell textLabel] setFont:[UIFont fontWithName:@"Futura-Medium" size:15]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSDictionary *spec = [productSpecification_ objectAtIndex:indexPath.row];
    //NSLog(@"specification : %@",spec);
    cell.textLabel.text = [spec objectForKey:@"name"];
    //cell.textLabel.text = comSpec_;
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSString *idValue = [idList_ objectAtIndex:indexPath.row];
//    //NSLog(@"id value is : %@", idValue);
//    MMProductCompanies *viewCon = [[MMProductCompanies alloc] initWithNibName:@"MMProductCompanies" bundle:nil];
//    [viewCon setFinalId : idValue];
//    [self.navigationController pushViewController:viewCon animated:YES];
//    
    NSDictionary *spec = [productSpecification_ objectAtIndex:indexPath.row];
    //NSLog(@"data : %@",spec);
    NSMutableArray *model = [spec objectForKey:@"alternate_identifiers"];
    
    //NSLog(@"model : %@",model);
    NSDictionary *dict = [model objectAtIndex:0];
    NSMutableArray *links = [spec objectForKey:@"link"];
    // NSLog(@"links : %@",[links objectAtIndex:1]);
    NSDictionary *linkDict = [links objectAtIndex:1];

    NSString *linkHref;
    linkHref = [linkDict objectForKey:@"href"];
    MMJSONData *data = [[[MMJSONData alloc] init] autorelease];
    
    data.certificationId = [spec objectForKey:@"id"];
    data.company = [spec objectForKey:@"company"];
    data.product = [spec objectForKey:@"name"];
    data.model = [dict objectForKey:@"value"];
    data.certificationUrl = linkHref;
    NSArray *temp = [[spec objectForKey:@"category_set"] objectForKey:@"category"] ;
    NSString *category = [[temp objectAtIndex:0] objectForKey:@"label"];
    //NSLog(@"cert : %@ and %@", data.certificationId, category);
    data.category = category;
    
    MMProductDetail *viewCont = [[[MMProductDetail alloc] initWithFinalData:data] autorelease];
    [self. navigationController pushViewController:viewCont animated:YES];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"Search Button pressed %@",searchBar.text);
    [searchBar resignFirstResponder];
    SearchViewController *searchViewController= [[SearchViewController alloc] initWithKeyword:searchBar.text searchType:@"products"];
    self.navigationItem.backBarButtonItem =[[[UIBarButtonItem alloc] initWithTitle:@"Specification" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
    searchViewController.title=@"Search";
    //[searchViewController setObjects:];
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



@end
