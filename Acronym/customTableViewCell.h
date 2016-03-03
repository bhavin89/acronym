//
//  customTableViewCell.h
//  Acronym
//
//  Created by Bhavin Patel on 3/3/16.
//  Copyright © 2016 Bhavin Patel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *freq;
@property (weak, nonatomic) IBOutlet UILabel *since;

@end
