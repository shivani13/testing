//
//  WiFiAboutWiFiViewController.m
//  Wi-Fi_IOS
//
//  Created by Pavan Paruchuri on 5/8/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import "WiFiAboutWiFiViewController.h"
#import "SBJson.h"
#import "WiFiArticleListViewController.h"
#import "WiFiSearchViewController.h"
#import "NSString+HTML.h"
@interface WiFiAboutWiFiViewController ()
@end

@implementation WiFiAboutWiFiViewController
@synthesize aboutWiFiTableView;
@synthesize aboutWifiSearchBar;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    response= [[NSMutableData alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:
                                    [NSURL URLWithString:@"http://mobile.wi-fidev2.org/atom/feed/"]cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    
    NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    if(connection){
        
        //NSLog(@"Connection Successfull");
        
    }
    else {
        
        NSLog(@"Connection Not Successfull");
    }
    
    [connection release];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return articleList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    WiFiAboutWifiCell *cell = nil;
    
    if(cell == nil)
        cell = [[[WiFiAboutWifiCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                         reuseIdentifier:identifier] autorelease];
    
    NSString *titledecoded = [[articleList objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    cell.titleLabel.text=[titledecoded stringByDecodingHTMLEntities];
    cell.tagImageView.image = [UIImage imageNamed:@"articlefocus60_4"];
    cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *articleUrl = [NSString stringWithFormat:[[[articleList objectAtIndex:indexPath.row] 
                                    objectForKey:@"link"] objectForKey:@"href"]];
    
    NSString *articleListTitle = [NSString stringWithFormat:[[articleList objectAtIndex:indexPath.row] 
                                    objectForKey:@"title"]];
    
    articleListTitle = [articleListTitle stringByDecodingHTMLEntities];
    
    WiFiArticleListViewController *articleListViewController = [[WiFiArticleListViewController alloc] initWithArticleListUrl:articleUrl articleListTitle:articleListTitle ];
    
    self.navigationItem.backBarButtonItem =[[[UIBarButtonItem alloc] initWithTitle:@"Back" 
                                                                             style:UIBarButtonItemStyleBordered 
                                                                            target:nil action:nil] autorelease];
    
    [self.navigationController pushViewController:articleListViewController animated:YES];
    
    [articleListViewController release];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [response appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *finalResponse = [[NSString alloc]initWithData:response 
                                                   encoding:NSUTF8StringEncoding];
    
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    NSDictionary *result = [parser objectWithString:finalResponse];
    
    articleList=[[NSArray alloc]init];
    articleList=[[[result objectForKey:@"feeds"] objectForKey:@"feed"] objectForKey:@"feed"];
    self.title=[[[result objectForKey:@"feeds"] objectForKey:@"feed"] objectForKey:@"title"];
    self.tabBarItem.title=@"about Wi-Fi";
    
    [parser release];
    [finalResponse release];
    [self.aboutWiFiTableView reloadData];
    
    
}

- (void)viewDidUnload {
    
    [self setAboutWiFiTableView:nil];
    [self setAboutWifiSearchBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    WiFiSearchViewController *searchViewController = [[WiFiSearchViewController alloc] initWithKeyword:searchBar.text 
                                                                                           searchType:@"articles"];
    
    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" 
                                                                              style:UIBarButtonItemStyleBordered 
                                                                             target:nil action:nil] autorelease];
    
    searchViewController.title = @"Search";
    [self.navigationController pushViewController:searchViewController animated:YES];
    
    [searchViewController release];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if ([searchText length] == 0) {
        
        [self performSelector:@selector(hideKeyboardWithSearchBar:) withObject:searchBar afterDelay:0];
    }
}

- (void)hideKeyboardWithSearchBar:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];   
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    
    [aboutWiFiTableView release];
    [aboutWifiSearchBar release];
    [super dealloc];
    
}

@end
