//
//  HTLJob.h
//  HourTimeLogger
//
//  Created by Jack Payette on 8/26/14.
//  Copyright (c) 2014 James Payette. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTLJob : NSObject

@property (nonatomic,copy) NSString *jobName;
@property (nonatomic,copy) NSString *description;
@property (nonatomic,copy) NSString *hours;

@end
