//
//  PersonalKeySettingViewController.m
//  HashPass
//
//  Created by HJ on 5/19/16.
//  Copyright © 2016 gknows. All rights reserved.
//

#import "PersonalKeySettingViewController.h"
#import "HashPassSettingManager.h"

@interface PersonalKeySettingViewController ()

@property (weak, nonatomic) IBOutlet UITextField *personalKeyText;
@property (weak, nonatomic) IBOutlet UISwitch *hideSettingSwitch;

@end

@implementation PersonalKeySettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"个人标识设置";
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                      style:UIBarButtonItemStylePlain
                                                     target:self
                                                     action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain
                                                                       target:self
                                                                       action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    self.personalKeyText.text = [HashPassSettingManager sharedManager].personalKey;
    self.hideSettingSwitch.on = [[HashPassSettingManager sharedManager].hideSettingButton boolValue];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.personalKeyText becomeFirstResponder];
}

- (void)cancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)save:(id)sender
{
    NSString *personalKey = self.personalKeyText.text;
    [HashPassSettingManager sharedManager].personalKey = personalKey;
    [HashPassSettingManager sharedManager].hideSettingButton = @(self.hideSettingSwitch.on);
    [self.navigationController popViewControllerAnimated:YES];
}


@end
