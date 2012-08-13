//
//  MMProductListViewController.m
//  WFProductsCategories
//
//  Created by Abhyuday Reddy on 09/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMProductListViewController.h"
#import "MMProductCompanies.h"
#import "SearchViewController.h"

@implementation MMProductListViewController
@synthesize productList = productList_;
@synthesize idList = idList_;
@synthesize searchProList;
@synthesize productListTable;

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
    self.title = @"Product List";
   // NSLog(@"%@",idList_);
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [productList_ count];
    
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
    NSDictionary *productList = [productList_ objectAtIndex:indexPath.row];
    cell.textLabel.text = [productList objectForKey:@"label"];
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *idValue = [idList_ objectAtIndex:indexPath.row];
    //NSLog(@"id value is : %@", idValue);
    MMProductCompanies *viewCon = [[[MMProductCompanies alloc] initWithNibName:@"MMProductCompanies" bundle:nil] autorelease];
    [viewCon setFinalId : idValue];
    [self.navigationController pushViewController:viewCon animated:YES];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"Search Button pressed %@",searchBar.text);
    [searchBar resignFirstResponder];
    SearchViewController *searchViewController= [[SearchViewController alloc] initWithKeyword:searchBar.text searchType:@"Products"];
    self.navigationItem.backBarButtonItem =[[[UIBarButtonItem alloc] initWithTitle:@"Product List" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
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
