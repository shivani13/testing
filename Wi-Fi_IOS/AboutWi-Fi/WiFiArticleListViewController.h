//
//  ArticleListViewController.h
//  Wi-Fi_IOS
//
//  Created by Pavan Paruchuri on 5/9/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "WiFiSearchViewController.h"
#import "WiFiArticleListModel.h"

@interface WiFiArticleListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, ArticleListDelegate> {
    
        IBOutlet UIActivityIndicatorView * activityView_;
    
}

@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (retain, nonatomic) IBOutlet UISearchBar *articleListSearchBar;

@property (retain, nonatomic) NSString *articleListUrl;
@property (retain, nonatomic) IBOutlet UITableView *articleListTableView;


- (id)initWithArticleListUrl:(NSString *)url articleListTitle:(NSString *)title;

@end
