RQLinq2oc
=========

Preview
===

linq(like c#) to objective-c .

make an array first:
```ObjectiveC

NSArray *myArray = [NSArray arrayWithLength:10 andObject:^id(NSInteger currentIndex, NSInteger length) {
        Student *s=[Student new];
        s.name=[NSString stringWithFormat:@"s%d",currentIndex];
        s.age=arc4random()%5+18;
        s.sex=[sexs objectAtIndex:arc4random()%2];
        s.ID=arc4random()%1000+1000;
        return s;
    }];
    
    
    
result:
(
    "  id: 1919 - name: s0 - age: 20 - sex: f  ",
    "  id: 1122 - name: s1 - age: 21 - sex: m  ",
    "  id: 1439 - name: s2 - age: 18 - sex: f  ",
    "  id: 1697 - name: s3 - age: 21 - sex: m  ",
    "  id: 1817 - name: s4 - age: 20 - sex: f  ",
    "  id: 1499 - name: s5 - age: 19 - sex: m  ",
    "  id: 1757 - name: s6 - age: 20 - sex: f  ",
    "  id: 1848 - name: s7 - age: 19 - sex: m  ",
    "  id: 1857 - name: s8 - age: 20 - sex: m  ",
    "  id: 1912 - name: s9 - age: 22 - sex: f  "
)
```


get student's name list like this :
```ObjectiveC
  NSArray *nameList=[myArray select:^id(Student* target) {
        return target.name;
    }];
    
result:

(
    s0,
    s1,
    s2,
    s3,
    s4,
    s5,
    s6,
    s7,
    s8,
    s9
)


```

get students where age > 20:
```ObjectiveC
NSArray *studentList=[myArray where:^BOOL(Student* target) {
        return target.age>20;
    }];
    
result:
(
    "  id: 1122 - name: s1 - age: 21 - sex: m  ",
    "  id: 1697 - name: s3 - age: 21 - sex: m  ",
    "  id: 1912 - name: s9 - age: 22 - sex: f  "
)

    
    
```
get students where age >= 20 and group by sex:
```ObjectiveC
NSDictionary *studentDic=[myArray where:^BOOL(Student* target) {
                           return target.age>=20;
                    }] groupBy:^id(Student* obj) {
                        return obj.sex;
    }];
    
result:
{
    f =     (
        "  id: 1919 - name: s0 - age: 20 - sex: f  ",
        "  id: 1817 - name: s4 - age: 20 - sex: f  ",
        "  id: 1757 - name: s6 - age: 20 - sex: f  ",
        "  id: 1912 - name: s9 - age: 22 - sex: f  "
    );
    m =     (
        "  id: 1122 - name: s1 - age: 21 - sex: m  ",
        "  id: 1697 - name: s3 - age: 21 - sex: m  ",
        "  id: 1857 - name: s8 - age: 20 - sex: m  "
    );
}

```


