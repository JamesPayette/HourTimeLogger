//
//  HTLJobEntries.h
//  HourTimeLogger
//
//  Created by Jack Payette on 8/26/14.
//  Copyright (c) 2014 James Payette. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTLJobEntries : NSObject

@property (nonatomic,copy) NSString *eName;
@property (nonatomic,copy) NSString *eRecipient;
@property (nonatomic,copy) NSString *eDate;
@property (nonatomic,retain) NSMutableArray *eJobs;

@end
