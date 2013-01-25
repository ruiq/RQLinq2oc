//
//  RQViewController.m
//  RQLinq2oc
//
//  Created by 李瑞勤 on 13-1-24.
//  Copyright (c) 2013年 ruiq. All rights reserved.
//

#import "RQViewController.h"
#import "Student.h"
#import "NSArray+linq.h"

@interface RQViewController ()
@property(nonatomic) NSArray *data;
@end

@implementation RQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self reset:nil];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    CGSize screenSize=[[UIScreen mainScreen] applicationFrame].size;
    CGRect txtViewFrame=self.txtView.frame;
    txtViewFrame.size.height=screenSize.height-100;
    self.txtView.frame=txtViewFrame;

}

-(IBAction)reset:(id)sender
{
    int count=30;
    NSArray *sexs=[NSArray arrayWithObjects:@"f",@"m", nil];
    self.data=[NSArray arrayWithLength:count andObject:^id(NSInteger currentIndex, NSInteger length) {
        Student *s=[Student new];
        s.name=[NSString stringWithFormat:@"s%d",currentIndex];
        s.age=arc4random()%5+18;
        s.sex=[sexs objectAtIndex:arc4random()%2];
        s.ID=arc4random()%1000+1000;
        return s;
    }];
    self.txtView.text=self.data.description;
}

-(IBAction)selectData:(id)sender
{
    self.txtView.text=[[self.data
                        where:^BOOL(Student* target) {
                            return target.age>20;
    }]
                       select:^id(Student* target) {
                           return target.name;
    }].description;
}
-(IBAction)whereData:(id)sender
{
    self.txtView.text=[self.data where:^BOOL(Student* target) {
        return target.age>20;
    }].description;
}
-(IBAction)groupBy:(id)sender
{
    self.txtView.text=[[self.data where:^BOOL(Student* target) {
                           return target.age>=20;
                    }] groupBy:^id(Student* obj) {
                        return obj.sex;
    }].description;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setTxtView:nil];
    [super viewDidUnload];
}
@end
