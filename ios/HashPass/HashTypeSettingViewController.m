//
//  HashTypeSettingViewController.m
//  HashPass
//
//  Created by HJ on 5/19/16.
//  Copyright © 2016 gknows. All rights reserved.
//

#import "HashTypeSettingViewController.h"
#import "HashPassSettingManager.h"

@interface HashTypeSettingViewController ()

@property (nonatomic, strong) NSArray *hashTypes;
@property (nonatomic, strong) NSIndexPath *lastSelectIndexPath;
@property (nonatomic, strong) NSString *currentHashType;

@end

@implementation HashTypeSettingViewController

#define HP_HASH_TYPE_SETTING NSLocalizedString(@"HP_HASH_TYPE_SETTING", @"hash type setting title")
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = HP_HASH_TYPE_SETTING; // @"哈希类型设置";
    self.hashTypes = [[HashPassSettingManager sharedManager] allSupportHashType];
    self.currentHashType = [HashPassSettingManager sharedManager].hashType;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.hashTypes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"HashTypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString *hashType = self.hashTypes[indexPath.row];
    cell.textLabel.text = hashType;
    if ([hashType isEqualToString:self.currentHashType]) {
        self.lastSelectIndexPath = indexPath;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] != [self.lastSelectIndexPath row])
    {
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:self.lastSelectIndexPath];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        self.lastSelectIndexPath = indexPath;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Private
- (void)setLastSelectIndexPath:(NSIndexPath *)lastSelectIndexPath
{
    _lastSelectIndexPath = lastSelectIndexPath;
    [HashPassSettingManager sharedManager].hashType = self.hashTypes[lastSelectIndexPath.row];
}

@end
