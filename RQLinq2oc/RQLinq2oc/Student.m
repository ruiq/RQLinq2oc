//
//  Student.m
//  RQLinq2oc
//
//  Created by 李瑞勤 on 13-1-24.
//  Copyright (c) 2013年 ruiq. All rights reserved.
//

#import "Student.h"

@implementation Student

-(NSString *)description
{
    return [NSString stringWithFormat:@"  id: %d - name: %@ - age: %d - sex: %@  ",self.ID,self.name,self.age,self.sex];
}

@end
