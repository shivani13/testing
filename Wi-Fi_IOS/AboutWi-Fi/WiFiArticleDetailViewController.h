//
//  ArticleDetailViewController.h
//  Wi-Fi_IOS
//
//  Created by Pavan Paruchuri on 5/9/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageUI/MFMailComposeViewController.h"

@interface WiFiArticleDetailViewController : UIViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property (retain, nonatomic) IBOutlet UIWebView *articleDetailsWebView;
@property (assign, nonatomic) NSString *articleContent;
@property (assign, nonatomic) NSString *articleTitle;
@property (assign, nonatomic) NSString *articleUrl;
@property (assign, nonatomic) NSString *articleImageUrl;
@property (retain, nonatomic) IBOutlet UILabel *articleTitleLabel;
@property (strong, nonatomic) UIActionSheet *shareActionSheet;
@property (retain, nonatomic) IBOutlet UIButton *favoriteArticleButton;
@property (assign, nonatomic) BOOL isFavorite;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (IBAction)favoriteButtonClicked:(id)sender;
- (id)initWithArticleContent:(NSString *)content articleTitle:(NSString *)title articleUrl:(NSString *)url articleImageUrl:(NSString *)imageUrl;
- (void)shareOnMail:(NSString *)title url:(NSString *)url;
- (BOOL)isFavoriteArticle;
- (void)removeFavorite;
- (void)saveFavorite;
- (IBAction)showActionSheet:(id)sender;

@end
