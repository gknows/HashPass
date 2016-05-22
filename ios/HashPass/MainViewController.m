//
//  ViewController.m
//  HashPass
//
//  Created by HJ on 5/19/16.
//  Copyright © 2016 gknows. All rights reserved.
//

#import "MainViewController.h"
#import "SettingViewController.h"
#import "HashPassSettingManager.h"
#import "HashPassGenerater.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIView *codeBarView;
@property (weak, nonatomic) IBOutlet UITextField *codeText;

@property (nonatomic, strong) UIButton *settingButton;
@property (nonatomic, strong) UILabel *resultLabel;
@property (nonatomic, strong) NSLayoutConstraint *settingButtonBottomConstraints;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupSubviews];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.codeText becomeFirstResponder];
    
    self.settingButton.hidden = [[HashPassSettingManager sharedManager].hideSettingButton boolValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupSubviews
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationItem.title = @"哈希密码";
    
    self.codeBarView.layer.cornerRadius = 3;
    self.codeBarView.layer.masksToBounds = YES;
    
    _settingButton = [[UIButton alloc] init];
    _settingButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_settingButton setImage:[UIImage imageNamed:@"setting_normal"] forState:UIControlStateNormal];
    [_settingButton setImage:[UIImage imageNamed:@"setting_highlight"] forState:UIControlStateHighlighted];
    [_settingButton addTarget:self
                       action:@selector(settingAction:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_settingButton];
    
    _resultLabel = [[UILabel alloc] init];
    _resultLabel.backgroundColor = [UIColor clearColor];
    _resultLabel.translatesAutoresizingMaskIntoConstraints = NO;
    if (![[HashPassSettingManager sharedManager].alreadySet boolValue]) {
        _resultLabel.font = [UIFont systemFontOfSize:14.0];
        _resultLabel.text = @"还没有进行偏好设置？点这里->";
        _resultLabel.textAlignment = NSTextAlignmentRight;
        [HashPassSettingManager sharedManager].alreadySet = @(YES);
    }
    [self.view addSubview:_resultLabel];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_resultLabel]-10-[_settingButton(32)]-20-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_resultLabel,_settingButton)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_resultLabel
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_settingButton
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    [_settingButton addConstraint:[NSLayoutConstraint constraintWithItem:_settingButton
                                                               attribute:NSLayoutAttributeHeight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:_settingButton
                                                               attribute:NSLayoutAttributeWidth
                                                              multiplier:1.0
                                                                constant:0.0]];
    self.settingButtonBottomConstraints = [NSLayoutConstraint constraintWithItem:_settingButton
                                                                       attribute:NSLayoutAttributeBottom
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeBottom
                                                                      multiplier:1.0
                                                                        constant:-20];
    [self.view addConstraint:self.settingButtonBottomConstraints];
}

#pragma mark - Action
- (IBAction)textEditingChanged:(UITextField *)sender
{
    HashPassSettingManager *setting = [HashPassSettingManager sharedManager];
    if ([setting.hideSettingButton boolValue]) {
        NSString *personalKey = [HashPassSettingManager sharedManager].personalKey;
        if ([sender.text isEqualToString:personalKey]) {
            self.settingButton.hidden = NO;
        }else{
            self.settingButton.hidden = YES;
        }
    }
}


- (IBAction)doneEditAction:(UITextField *)sender
{
    self.resultLabel.font = [UIFont systemFontOfSize:17.0];
    self.resultLabel.textAlignment = NSTextAlignmentLeft;
    NSString *text = sender.text;
    NSString *result = [HashPassGenerater generatePassword:text];
    self.resultLabel.text = result;
    if ([[HashPassSettingManager sharedManager].sendToClipboard boolValue]) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = result;
    }
    if ([[HashPassSettingManager sharedManager].sendNotification boolValue]) {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.alertBody = result;
        localNotification.alertAction = @"";
        localNotification.soundName = @"";
        [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
    }
}

- (void)settingAction:(UIButton *)sender
{
    self.resultLabel.text = @"";
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    SettingViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"SettingView"];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UIKeyBoard Notification
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardRect.size.height;
    [UIView animateWithDuration:0.3f
                     animations:^{
                         [self.settingButtonBottomConstraints setConstant:-keyboardHeight-5];
                         [self.view layoutIfNeeded];
                     }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3f
                     animations:^{
                         [self.settingButtonBottomConstraints setConstant:-20];
                         [self.view layoutIfNeeded];
                     }];
}


@end
