//
//  ConParAPI.h
//  Acronym
//
//  Created by Bhavin Patel on 3/3/16.
//  Copyright © 2016 Bhavin Patel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <UIKit/UIKit.h>

@protocol DataFetch <NSObject>
-(void)reloadTable;
@end

@interface ConParAPI : NSObject

@property (nonatomic,weak) id<DataFetch> delegate;
@property (nonatomic,weak) NSString *Message;
@property (nonatomic,strong) NSMutableArray *list;

-(void)getAcronym:(NSString *)Acr;
-(NSMutableDictionary *)getdata:(NSIndexPath *)Section;
-(void)Switch:(NSIndexPath *)indexPath;
-(NSInteger)DisplayCheck:(NSInteger)section;
-(NSMutableArray *)calSub:(NSMutableArray *)subMain and: (int *)i;
-(void)returnToReloadtable: (NSString *)message;

@end



