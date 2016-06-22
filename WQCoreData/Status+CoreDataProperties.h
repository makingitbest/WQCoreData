//
//  Status+CoreDataProperties.h
//  WQCoreData
//
//  Created by 王巧 on 16/4/14.
//  Copyright © 2016年 wangqiao. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Status.h"

NS_ASSUME_NONNULL_BEGIN

@interface Status (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *createDate;
@property (nullable, nonatomic, retain) NSString *text;

@end

NS_ASSUME_NONNULL_END
