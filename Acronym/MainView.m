//
//  MainView.m
//  Acronym
//
//  Created by Bhavin Patel on 3/3/16.
//  Copyright © 2016 Bhavin Patel. All rights reserved.
//

#import "MainView.h"
#import "customTableViewCell.h"

@import UIKit;

@interface MainView ()

@end

@implementation MainView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.seachBar.delegate=self;
    _ConParAPIObj=[[ConParAPI alloc]init];
    _ConParAPIObj.delegate=self;
    _hud= [[MBProgressHUD alloc]init];
}

-(void)reloadTable{
    [_mainTable reloadData];
    [_hud hide:true];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (![_ConParAPIObj.Message  isEqual: @""]) {
    UIAlertView *alertBox = [[UIAlertView alloc]initWithTitle:@"Alert" message:_ConParAPIObj.Message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertBox show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{

    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.mode = MBProgressHUDModeAnnularDeterminate;
    _hud.labelText = @"Loading";
    _ConParAPIObj.list=nil;
    [_mainTable reloadData];
    [_ConParAPIObj getAcronym:searchBar.text];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_ConParAPIObj.list count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_ConParAPIObj Switch:indexPath];
    [self.mainTable reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [_ConParAPIObj DisplayCheck:section];
}

-  (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
customTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    
    if (indexPath.row==0)
    cell.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    else
    cell.contentView.backgroundColor = [UIColor lightGrayColor];
    NSMutableDictionary *restore=[_ConParAPIObj getdata:indexPath];
    cell.title.text=restore[@"Acr"];
    cell.freq.text= restore[@"Frequency"];
    cell.since.text=restore[@"time"];
    
    return cell;
}
    
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
