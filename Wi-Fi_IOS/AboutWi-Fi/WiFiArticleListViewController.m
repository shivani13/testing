//
//  ArticleListViewController.m
//  Wi-Fi_IOS
//
//  Created by Pavan Paruchuri on 5/9/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import "WiFiArticleListViewController.h"
#import "WiFiArticleDetailViewController.h"
#import "WiFiArticleListCell.h"
#import "WiFiArticleListModel.h"
#import "NSString+HTML.h"
#import "UIImageView+AFNetworking.h"

@interface WiFiArticleListViewController () {
 
    WiFiArticleListModel *articleListModel;

}
@end

@implementation WiFiArticleListViewController

@synthesize articleListSearchBar;
@synthesize activityView = activityView_;
@synthesize articleListUrl;
@synthesize articleListTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithArticleListUrl:(NSString *)url articleListTitle:(NSString *)title {
    
    articleListUrl=url;
    self.title=title;
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [activityView_ startAnimating];
    articleListModel = [[WiFiArticleListModel alloc] initWithArticleListUrl:articleListUrl];
    articleListModel.delegate = self;
    [articleListModel startUrlConnection];
    [articleListTableView reloadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillDisappear:(BOOL)animated {
    
    articleListModel.delegate=nil;
}

- (void)viewDidUnload {
    
    [self setArticleListTableView:nil];
    [self setArticleListSearchBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    
    WiFiSearchViewController *searchViewController= [[WiFiSearchViewController alloc] initWithKeyword:searchBar.text 
                                                                                           searchType:@"articles"];
    
    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" 
                                                                              style:UIBarButtonItemStyleBordered 
                                                                             target:nil action:nil] autorelease];
    
    searchViewController.title=@"Search";
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 71;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return articleListModel.articleTitles.count-1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WiFiArticleListCell *cell = nil;
    
    if(cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WiFiArticleListCell" owner:self options:nil] objectAtIndex:0];
        cell.titleLabel.text=[articleListModel.articleTitles objectAtIndex:indexPath.row];
        cell.titleSummaryLabel.text=[articleListModel.articleSummaries objectAtIndex:indexPath.row];
        [cell.tagImageView setImageWithURL:[NSURL URLWithString:[articleListModel.articleImageUrl 
                                                                 objectAtIndex:indexPath.row]]];
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WiFiArticleDetailViewController *articleDetailViewController = [[WiFiArticleDetailViewController alloc] 
                                                                  initWithArticleContent:[articleListModel.articleContent objectAtIndex:indexPath.row]    
                                                                  articleTitle:[articleListModel.articleTitles objectAtIndex:indexPath.row] 
                                                                  articleUrl:[articleListModel.articleLinks objectAtIndex:indexPath.row] 
                                                                  articleImageUrl:[articleListModel.articleImageUrl objectAtIndex:indexPath.row]];
    
    
    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" 
                                                                             style:UIBarButtonItemStyleBordered 
                                                                            target:nil 
                                                                            action:nil] 
                                            autorelease];
    
    [self.navigationController pushViewController:articleDetailViewController animated:YES];
    [articleDetailViewController release];
}

- (void) reloadTableView {
    
    [articleListTableView reloadData];
    [activityView_ stopAnimating];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    
    [articleListTableView release];
    [articleListSearchBar release];
    [super dealloc];
}
@end
