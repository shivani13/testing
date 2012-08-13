//
//  WiFiArticleListCell.h
//  Wi-Fi_IOS
//
//  Created by Pavan Paruchuri on 5/10/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WiFiArticleListCell : UITableViewCell

@property (retain, nonatomic)IBOutlet UILabel *titleLabel;
@property (retain, nonatomic)IBOutlet UILabel *titleSummaryLabel;
@property (retain, nonatomic)IBOutlet UIImageView *tagImageView;

@end
