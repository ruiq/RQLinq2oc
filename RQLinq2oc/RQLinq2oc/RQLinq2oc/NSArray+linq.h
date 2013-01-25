//
//  NSArray+linq.h
//  OC_LINQ_DEMO
//
//  Created by 李瑞勤 on 13-1-22.
//  Copyright (c) 2013年 ruiq. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL(^whereBlock)(id target);
typedef BOOL(^findBlock)(id target);
typedef id(^selectBlock)(id target);
typedef id(^groupByBlock)(id obj);
typedef id(^arrayCreatorBlock)(NSInteger currentIndex,NSInteger length);

@interface NSArray (linq)
+(NSArray*)arrayWithLength:(NSInteger)arrayLength andObject:(arrayCreatorBlock)createBlock;
-(NSArray*)where:(whereBlock)whereBlock;
-(NSArray*)select:(selectBlock)selectBlock;
-(id)find:(findBlock)findBlock;
-(NSDictionary*)groupBy:(groupByBlock)groupBlock;
@end
