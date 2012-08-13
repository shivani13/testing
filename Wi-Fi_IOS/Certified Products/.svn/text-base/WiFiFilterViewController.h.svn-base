//
//  MMFilter.h
//  Wi-Fi_IOS
//
//  Created by Abhyuday Reddy on 14/05/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WiFiDetailFilterViewController.h"


@protocol FilterDelegate;

@interface WiFiFilterViewController : UIViewController<UITableViewDelegate,UITableViewDataSource, WiFiDetailFilterDelegate>
{
        NSMutableArray *tableFields_;
        NSMutableArray *subTexts_;
    NSMutableArray *idValue_;
    NSMutableArray *urlArray_;
    id<FilterDelegate> delegate_;
}
@property (nonatomic, retain) IBOutlet UIButton *doneFilter;
@property (retain, nonatomic) IBOutlet UITableView *filterTableView;
@property (nonatomic, assign) id<FilterDelegate> delegate;
- (IBAction) doneFilterMethod:(id)sender;
- (void)getFilterDataMethod;

@end
@protocol FilterDelegate <NSObject>

- (void)updateURLInFirstView: (NSString *)urlString;

@end