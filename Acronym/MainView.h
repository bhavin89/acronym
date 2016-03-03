//
//  MainView.h
//  Acronym
//
//  Created by Bhavin Patel on 3/3/16.
//  Copyright © 2016 Bhavin Patel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConParAPI.h"
#import "MBProgressHUD.h"

@interface MainView : UIViewController<UISearchBarDelegate,DataFetch,UITableViewDataSource , UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *seachBar;
@property (strong, nonatomic) ConParAPI *ConParAPIObj;
@property (weak, nonatomic) IBOutlet UITableView *mainTable;
@property (strong, nonatomic) MBProgressHUD *hud;
@end
