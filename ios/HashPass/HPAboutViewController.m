//
//  HPAboutViewController.m
//  HashPass
//
//  Created by HJ on 5/19/16.
//  Copyright © 2016 gknows. All rights reserved.
//

#import "HPAboutViewController.h"

@interface HPAboutViewController ()

@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation HPAboutViewController

#define HP_ABOUT NSLocalizedString(@"HP_ABOUT", @"about")
#define HP_ABOUT_VERSION NSLocalizedString(@"HP_ABOUT_VERSION", @"about view version")
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = HP_ABOUT; // @"关于";
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    //self.versionLabel.text = [NSString stringWithFormat:@"哈希密码 %@", version];
    self.versionLabel.text = [NSString stringWithFormat:HP_ABOUT_VERSION, version];
}

@end
