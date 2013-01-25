//
//  NSArray+linq.m
//  OC_LINQ_DEMO
//
//  Created by 李瑞勤 on 13-1-22.
//  Copyright (c) 2013年 ruiq. All rights reserved.
//

#import "NSArray+linq.h"
#import <objc/runtime.h>

@implementation NSArray (linq)

+(NSArray *)arrayWithLength:(NSInteger)arrayLength andObject:(arrayCreatorBlock)createBlock{
    NSMutableArray *tmpArray=[NSMutableArray arrayWithCapacity:arrayLength];
    for (int idx=0; idx<arrayLength; idx++) {
        [tmpArray addObject:createBlock(idx,arrayLength)];
    }
    return tmpArray;
}

-(NSArray *)where:(whereBlock)whereBlock
{
    NSMutableArray *tmp=[NSMutableArray arrayWithCapacity:self.count];
    for (NSObject *obj in self) {
        if(whereBlock(obj))
            [tmp addObject:obj];
    }
    return tmp;
}

-(NSArray *)select:(selectBlock)selectBlock
{
    NSMutableArray *tmp=[NSMutableArray arrayWithCapacity:self.count];
    for (NSObject *obj in self) {
            [tmp addObject:selectBlock(obj)];
    }
    return tmp;
}
-(id)find:(findBlock)findBlock
{
    NSArray *whereResult=[self where:^BOOL(id target) {
        return findBlock(target);
    }];
    if (whereResult.count>0)
    {
        return whereResult[0];
    }
    return nil;
}

-(NSDictionary *)groupBy:(groupByBlock)groupBlock
{
    if(self.count==0)
        return nil;
    id propertyValue=groupBlock(self[0]);
    id targetObj=self[0];
    NSString *key=nil;
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([targetObj class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        NSString *tmpKey=[NSString stringWithUTF8String:propName];
        if(propertyValue==[targetObj valueForKey:tmpKey])
        {
            key=tmpKey;
            break;
        }
    }
    free(properties);
    NSMutableSet *keySet=[NSMutableSet setWithCapacity:self.count];
    NSMutableDictionary *groupResult=[NSMutableDictionary dictionaryWithCapacity:keySet.count];
    for (NSObject *obj in self) {
        [keySet addObject:[obj valueForKey:key]];
    }
    for (NSObject<NSCopying> *obj in keySet) {
        NSArray *whereResult=[self where:^BOOL(id target) {
            return [[target valueForKey:key] isEqual:obj];
        }];
        [groupResult setObject:whereResult forKey:obj];
    }
    return groupResult;
}

@end
