//
//  Employee+CoreDataProperties.h
//  WQCoreData
//
//  Created by 王巧 on 16/4/13.
//  Copyright © 2016年 wangqiao. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Employee.h"

NS_ASSUME_NONNULL_BEGIN

@interface Employee (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *height;
@property (nullable, nonatomic, retain) NSDate *birthday;

@end

NS_ASSUME_NONNULL_END
