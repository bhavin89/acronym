//
//  ConParAPI.m
//  Acronym
//
//  Created by Bhavin Patel on 3/3/16.
//  Copyright © 2016 Bhavin Patel. All rights reserved.
//

#import "ConParAPI.h"

@implementation ConParAPI

-(void)getAcronym:(NSString *)Acr{
   
    _Message=@"";
  
    _list=[[NSMutableArray alloc]init];
       
    AFHTTPRequestOperationManager *Operationmanager = [AFHTTPRequestOperationManager manager];
    Operationmanager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    [Operationmanager GET:[NSString stringWithFormat: @"http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=%@",Acr] parameters:nil success:^(AFHTTPRequestOperation * operation, id responseObject) {
    
        NSMutableArray *MainData=responseObject;
            if ([MainData count]>0) {
                   for (int i=0;i<[ MainData [0][@"lfs"] count] ; i++) {

                        [_list addObject:@{
                                            @"Acr":[NSString stringWithFormat:@"%@",MainData[0] [@"lfs"] [i] [@"lf"]],
                                            @"Frequency":  [NSString stringWithFormat:@"%@",MainData[0] [@"lfs"] [i][@"freq"]],
                                            @"time":[NSString stringWithFormat:@"%@",MainData[0] [@"lfs"] [i] [@"since"]],
                                            @"list":   [self calSub: MainData[0][@"lfs"][i][@"vars"] and:&i],
                                            @"display":@false
                                            }];
            }
                [self returnToReloadtable:@""];
                
          }else{
              [self returnToReloadtable:@"No result found"];
            }
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        [self returnToReloadtable:@"Error...please check connection"];
    }];
}

-(void)returnToReloadtable: (NSString *)message{
    if (![message  isEqual: @""]) {
        _list=nil;
        _Message=message;
    }
        id<DataFetch> delegate1=self.delegate;
        [delegate1 reloadTable];
}

-(NSMutableArray *)calSub:(NSMutableArray *)subMain and: (int *)i{
    NSMutableArray *SubCollection=[[NSMutableArray alloc]init];
    for (int j=0;j<[subMain count] ; j++) {
        [SubCollection addObject:@{
                                   @"Acr":[NSString stringWithFormat:@"%@",subMain[j][@"lf"]],
                                   @"Frequency":[NSString stringWithFormat:@"%@",subMain[j] [@"freq"]],
                                   @"time":[NSString stringWithFormat:@"%@",subMain[j] [@"since"]]
                                   }];
    }
    return SubCollection;
}

-(NSMutableDictionary *)getdata:(NSIndexPath *)Section{
    if (Section.row==0) {
        return _list[Section.section];
    }else{
        return _list[Section.section][@"list"][Section.row-1];
            }
}

-(void)Switch:(NSIndexPath *)indexPath {
    NSMutableDictionary *temp=[_list[indexPath.section] mutableCopy];
    if ([_list[indexPath.section][@"display"] isEqual:@false]) {
        [temp setObject:@true forKey:@"display"];
    }else{
        [temp setObject:@false forKey:@"display"];
    }
    [_list replaceObjectAtIndex:indexPath.section withObject:temp];
}

-(NSInteger)DisplayCheck:(NSInteger)section;
{
    if ([_list[section][@"display"] isEqual:@true]) {
        return [_list[section][@"list"] count] + 1;
    } else {
        return 1;
    }  
}
@end
