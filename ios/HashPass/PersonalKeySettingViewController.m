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

#define HP_PERSONAL_KEY_SETTING NSLocalizedString(@"HP_PERSONAL_KEY_SETTING", @"personal setting view title")
#define HP_PERSONAL_KEY_SETTING_CANCEL NSLocalizedString(@"HP_PERSONAL_KEY_SETTING_CANCEL", @"personal setting view cancel")
#define HP_PERSONAL_KEY_SETTING_SAVE NSLocalizedString(@"HP_PERSONAL_KEY_SETTING_SAVE", @"personal setting view save")
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = HP_PERSONAL_KEY_SETTING; // @"个人标识设置";
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:HP_PERSONAL_KEY_SETTING_CANCEL // @"取消"
                                                      style:UIBarButtonItemStylePlain
                                                     target:self
                                                     action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:HP_PERSONAL_KEY_SETTING_SAVE // @"保存"
                                                                        style:UIBarButtonItemStylePlain
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
