//
//  MMDetailFilter.h
//  Wi-Fi_IOS
//
//  Created by Abhyuday Reddy on 30/05/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WiFiDetailFilterDelegate;

@interface WiFiDetailFilterViewController : UIViewController{
    NSMutableArray *detailFilterArray_;
    NSMutableArray *idFilterArray_;
    NSMutableArray *statusArray_;
    NSString *tempUrl_;
    
    id<WiFiDetailFilterDelegate> delegate_;
}

@property (nonatomic, retain) IBOutlet UITableView *detailFilterTableView;
@property (nonatomic, retain) IBOutlet UIButton *select;
@property (nonatomic, retain) IBOutlet UIButton *unselect;
@property (nonatomic, retain) NSString *detailFilterUrl;
@property (nonatomic, retain) NSString *titleValue;
@property (nonatomic, retain) NSString *valueID;

@property (nonatomic, assign) id<WiFiDetailFilterDelegate> delegate;

- (IBAction)selectMethod:(id)sender;
- (IBAction)unselectMethod:(id)sender;
- (void)setUrlData;
- (void)setDetailFilterData;
- (void) doneFilter;
- (NSString *) retrieveData;
@end

@protocol WiFiDetailFilterDelegate <NSObject>

- (void)updateURLInFilterView: (NSString *)urlString;

@end
