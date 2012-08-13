//
//  WiFiAboutWifiCell.m
//  Wi-Fi_IOS
//
//  Created by Pavan Paruchuri on 5/10/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import "WiFiAboutWifiCell.h"

@implementation WiFiAboutWifiCell

@synthesize titleLabel;
@synthesize tagImageView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Initialization code
    
        titleLabel =[[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textAlignment = UITextAlignmentLeft;
        tagImageView =[[UIImageView alloc] init];
        [self.contentView addSubview:titleLabel];
        [self.contentView addSubview:tagImageView];
        
    }
    return self;
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    CGRect frame;
    frame= CGRectMake(boundsX+10, 2, 10, 40);
    tagImageView.frame = frame;
    frame= CGRectMake(boundsX+30 ,10, 300, 25);
    titleLabel.frame = frame;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
    [super setSelected:selected animated:animated];

}

@end
