//
//  SearchViewController.m
//  Wi-Fi_IOS
//
//  Created by Pavan Paruchuri on 5/14/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import "WiFiSearchViewController.h"
#import "WiFiArticleListCell.h"
#import "WiFiArticleListModel.h"
#import "WiFiArticleDetailViewController.h"
#import "AFJSONRequestOperation.h"
#import "WiFiProductDetailViewController.h"
#import "WiFiJSONDataModel.h"

@interface WiFiSearchViewController () {
    
    WiFiArticleListModel *articleListModel;
    BOOL isNavigate;
}

@end

@implementation WiFiSearchViewController

@synthesize activityIndicator;
@synthesize searchSegmentedControl;
@synthesize searchTableView;
@synthesize statusText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithKeyword:(NSString *)searchKeyword searchType:(NSString *)type {
    
    keyword = searchKeyword;
    searchType = type;
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isNavigate = YES;
    
    nameArray = [[NSMutableArray alloc] init];
    companyArray = [[NSMutableArray alloc] init];
    idArray = [[NSMutableArray alloc] init];
    modelArray = [[NSMutableArray alloc] init];
    categoryArray = [[NSMutableArray alloc] init];
    dateArray = [[NSMutableArray alloc] init];
    certificationUrl = [[NSMutableArray alloc] init];
    
    [activityIndicator startAnimating];
    
    if ([searchType isEqualToString:@"articles"]) {
        
        articleListModel= [[WiFiArticleListModel alloc] initWithArticleListUrl:[NSString stringWithFormat:@"%@%@",@"http://mobile.wi-fidev2.org/atom/feed/search/?keyword=",keyword]];
        
        [articleListModel startUrlConnection];
        articleListModel.delegate=self;
        
        [searchSegmentedControl setSelectedSegmentIndex:1];
    }
    else if([searchType isEqualToString:@"products"]) {
        
        NSString *url = [[NSString alloc] init];
        url = @"http://api.wi-fi.org/v1/products/?keyword=";
        url = [url stringByAppendingString:keyword];
        [self searchProducts:url];
       
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    articleListModel.delegate=nil;
}

- (IBAction)searchSegmentedControlValueChanged:(id)sender {
    
    if ([searchSegmentedControl selectedSegmentIndex]==0) {
        searchType =@"products";
        //[self searchProducts:url];
    }
    else {
        searchType = @"articles";
    }
    [searchTableView reloadData];
}

- (void)viewDidUnload
{

    [self setSearchSegmentedControl:nil];
    [self setSearchTableView:nil];
    [self setActivityIndicator:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([searchType isEqualToString:@"articles"]) {
        return 71;
    }else {
        return 50;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([searchType isEqualToString:@"articles"]) {
        return articleListModel.articleTitles.count-1;
    }
    else {
        
        return [nameArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([searchType isEqualToString:@"articles"]) {
        WiFiArticleListCell *cell = nil;
        
        if(cell == nil)
            cell = [[[NSBundle mainBundle] loadNibNamed:@"WiFiArticleListCell" owner:self options:nil] objectAtIndex:0];
        
        cell.titleLabel.text=[articleListModel.articleTitles objectAtIndex:indexPath.row];
        cell.titleSummaryLabel.text=[articleListModel.articleSummaries objectAtIndex:indexPath.row];
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[articleListModel.articleImageUrl objectAtIndex:indexPath.row]]];
        cell.tagImageView.image=[[[UIImage alloc] initWithData:imageData] autorelease];
        [imageData release];
        return cell;
    }
    else {
        
        NSString *uniqueIdentifier = @"UITableViewCell";
        UITableViewCell *cell = nil;
        
        
        cell = [searchTableView dequeueReusableCellWithIdentifier:uniqueIdentifier];
        
        
        if(!cell)
        {
            
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:uniqueIdentifier] autorelease];
            [[cell textLabel] setNumberOfLines:0];
            [[cell textLabel] setFont:[UIFont fontWithName:@"Futura-Medium" size:15]];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        [activityIndicator stopAnimating];
        NSString *searchData = [[NSString alloc] init];
            searchData = @"";
            searchData = [searchData stringByAppendingString:[companyArray objectAtIndex:indexPath.row]];
            searchData = [searchData stringByAppendingString:@" -- "];
            searchData = [searchData stringByAppendingString:[nameArray objectAtIndex:indexPath.row]];
            cell.textLabel.text = searchData;
        
        return cell;
        
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([searchType isEqualToString:@"articles"]) {
        WiFiArticleDetailViewController *articleDetailViewController=[[WiFiArticleDetailViewController alloc] 
                                                                      initWithArticleContent:[articleListModel.articleContent objectAtIndex:indexPath.row] 
                                                                      articleTitle:[articleListModel.articleTitles objectAtIndex:indexPath.row] 
                                                                      articleUrl:[articleListModel.articleLinks objectAtIndex:indexPath.row] 
                                                                      articleImageUrl:[articleListModel.articleImageUrl objectAtIndex:indexPath.row]];
        
        self.navigationItem.backBarButtonItem =[[[UIBarButtonItem alloc] initWithTitle:@"Back" 
                                                                                 style:UIBarButtonItemStyleBordered 
                                                                                target:nil 
                                                                                action:nil] autorelease];
        
        [self.navigationController pushViewController:articleDetailViewController animated:YES];
        
        [articleDetailViewController release];
    }
    else {
    
        WiFiJSONDataModel *data = [[WiFiJSONDataModel alloc] init];
        
        data.certificationId = [idArray objectAtIndex:indexPath.row];
        data.company = [companyArray objectAtIndex:indexPath.row];
        data.product = [nameArray objectAtIndex:indexPath.row];
        data.model = [modelArray objectAtIndex:indexPath.row];
        data.category = [categoryArray objectAtIndex:indexPath.row];
        data.certificationUrl = [certificationUrl objectAtIndex:indexPath.row];
        
        if(isNavigate){        
        
            WiFiProductDetailViewController *viewcontroller = [[WiFiProductDetailViewController alloc] initWithNibName:@"WiFiProductDetailViewController" bundle:nil];
            [viewcontroller setFinal: data];
            [self.navigationController pushViewController:viewcontroller animated:YES];
            [viewcontroller release];
            isNavigate = YES;
        }
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) reloadTableView {
    
    [searchTableView reloadData];
    if (articleListModel.articleTitles.count == 1) {
        
        statusText.text = @"No Match Found";
    }
    
    [activityIndicator stopAnimating];
}


- (void) searchProducts: url {
    
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        // __block NSArray *finalInnerData_ = nil;
        AFJSONRequestOperation *requestOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request 
                                                                                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
           NSArray *jsonArray = [[[NSArray alloc] init] autorelease]; 
           jsonArray = [[JSON objectForKey:@"products"] objectForKey:@"product"];
        
        
        for (NSDictionary *dict in jsonArray) {
            
            [nameArray addObject:[dict objectForKey:@"name"]];
            [companyArray addObject:[dict objectForKey:@"company"]];
            [idArray addObject:[dict objectForKey:@"id"]];
           
            NSMutableArray *tempModel = [[[NSMutableArray alloc] init] autorelease];
            [tempModel addObject:[dict objectForKey:@"alternate_identifiers"]];
            
            NSMutableArray *temp = [[[NSMutableArray alloc] init] autorelease];
            [temp addObject:[tempModel objectAtIndex:0]]; 
            
            NSDictionary *tempDict = [[[NSDictionary alloc] init] autorelease];
            tempDict = [[temp objectAtIndex:0] objectAtIndex:0] ;
            
            [modelArray addObject:[tempDict objectForKey:@"value"]];
            
            NSMutableArray *tempCat = [[NSMutableArray alloc] init];
            [tempCat addObject:[[dict objectForKey:@"category_set"] objectForKey:@"category"]];
            
            NSMutableArray *temp2 = [[NSMutableArray alloc] init];
            [temp2 addObject:[[tempCat objectAtIndex:0] objectAtIndex:0] ];
            
            NSDictionary *temp3 = [[NSDictionary alloc] init];
            temp3 = [temp2 objectAtIndex:0];
            
            [categoryArray addObject:[temp3 objectForKey:@"label"]];
            [certificationUrl addObject:[[[dict objectForKey:@"link"] objectAtIndex:1] objectForKey:@"href"]];
            
            }
           
        if ([nameArray count] == 0 && [companyArray count] == 0) {
            
            statusText.text = @"No Match Found";
            [activityIndicator stopAnimating];
             
        }
        
        [searchTableView reloadData];
        
        } 
        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"Error: %@", error);
        }];
        
        NSOperationQueue *queue = [[[NSOperationQueue alloc] init] autorelease];
        [queue addOperation:requestOperation];
    
                
}

- (void)dealloc {
    
    [searchSegmentedControl release];
    [searchTableView release];
    [activityIndicator release];
    [super dealloc];
}

@end
