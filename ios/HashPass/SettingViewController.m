//
//  SettingViewController.m
//  HashPass
//
//  Created by HJ on 5/19/16.
//  Copyright © 2016 gknows. All rights reserved.
//

#import "SettingViewController.h"
#import "HashPassSettingManager.h"

@interface SettingViewController ()

@property (weak, nonatomic) IBOutlet UILabel *personalKeyLabel;
@property (weak, nonatomic) IBOutlet UILabel *hashTypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *hashTimesLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLengthLabel;

@property (weak, nonatomic) IBOutlet UISlider *hashTimesSlider;
@property (weak, nonatomic) IBOutlet UISlider *passwordLengthSlider;

@property (weak, nonatomic) IBOutlet UISwitch *caseMixedSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *sendToClipboardSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *sendNotificationSwitch;

@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 8.0)];
    self.navigationItem.title = @"设置";
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onSendNotificationSettingChangedNotification:)
                                                 name:HPSendNotificationChangedNotification
                                               object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateSettings];
}

- (void)updateSettings
{
    HashPassSettingManager *setting = [HashPassSettingManager sharedManager];
    self.personalKeyLabel.text = setting.personalKey;
    self.hashTypeLabel.text = setting.hashType;
    
    int hashTimes = [setting.hashTimes intValue];
    self.hashTimesLabel.text = [NSString stringWithFormat:@"%d",hashTimes];
    self.hashTimesSlider.value = hashTimes;
    
    int passwordLength = [setting.passwordLength intValue];
    self.passwordLengthLabel.text = [NSString stringWithFormat:@"%d",passwordLength];
    self.passwordLengthSlider.value = passwordLength;
    
    self.caseMixedSwitch.on = [setting.caseMixed boolValue];
    self.sendToClipboardSwitch.on = [setting.sendToClipboard boolValue];
    self.sendNotificationSwitch.on = [setting.sendNotification boolValue];
}


- (IBAction)hashTimesSlide:(UISlider *)sender
{
    int value = [[NSNumber numberWithFloat:sender.value] intValue];
    self.hashTimesLabel.text = [NSString stringWithFormat:@"%d", value];
}

- (IBAction)hashTimesDone:(UISlider *)sender
{
    int value = [[NSNumber numberWithFloat:sender.value] intValue];
    self.hashTimesLabel.text = [NSString stringWithFormat:@"%d", value];
    [[HashPassSettingManager sharedManager] setHashTimes:@(value)];
}

- (IBAction)passwordLengthSlide:(UISlider *)sender
{
    int value = [[NSNumber numberWithFloat:sender.value] intValue];
    self.passwordLengthLabel.text = [NSString stringWithFormat:@"%d", value];
}

- (IBAction)passwordLengthDone:(UISlider *)sender
{
    int value = [[NSNumber numberWithFloat:sender.value] intValue];
    self.passwordLengthLabel.text = [NSString stringWithFormat:@"%d", value];
    [[HashPassSettingManager sharedManager] setPasswordLength:@(value)];
}

- (IBAction)caseMixedValueChanged:(UISwitch *)sender
{
    [[HashPassSettingManager sharedManager] setCaseMixed:@(sender.on)];
}

- (IBAction)sendToClipboardValueChanged:(UISwitch *)sender
{
    [[HashPassSettingManager sharedManager] setSendToClipboard:@(sender.on)];
}

- (IBAction)sendNotificationValueChanged:(UISwitch *)sender
{
    [[HashPassSettingManager sharedManager] setSendNotification:@(sender.on)];
    if (sender.on) {
        UIUserNotificationType types = UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.section == 5) && (indexPath.row == 1))
    {
        NSLog(@"test");
#warning 增加调整到评分
    }
}

#pragma mark - HPSendNotificationChangedNotification
- (void)onSendNotificationSettingChangedNotification:(NSNotification *)notification
{
    self.sendNotificationSwitch.on = [[HashPassSettingManager sharedManager].sendNotification boolValue];
}

@end
