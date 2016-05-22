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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"关于";
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    self.versionLabel.text = [NSString stringWithFormat:@"哈希密码 %@", version];
}

@end
