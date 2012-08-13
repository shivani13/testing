//
//  SearchViewController.h
//  Wi-Fi_IOS
//
//  Created by Pavan Paruchuri on 5/14/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "WiFiArticleListModel.h"
@interface WiFiSearchViewController : UIViewController<ArticleListDelegate>{
    
    NSString *keyword;
    NSString *searchType;
    NSMutableData *response;
    NSMutableArray *nameArray;
    NSMutableArray *companyArray;
    NSMutableArray *idArray;
    NSMutableArray *dateArray;
    NSMutableArray *modelArray;
    NSMutableArray *categoryArray;
    NSMutableArray *certificationUrl;
}

@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (retain, nonatomic) IBOutlet UISegmentedControl *searchSegmentedControl;
@property (retain, nonatomic) IBOutlet UITableView *searchTableView;
@property (retain, nonatomic) IBOutlet UILabel *statusText;

- (IBAction)searchSegmentedControlValueChanged:(id)sender;

- (id)initWithKeyword:(NSString *)searchKeyword searchType:(NSString *)type;


@end
