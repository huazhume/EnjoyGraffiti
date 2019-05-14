
//
//  PTStashFiles.m
//  EnjoyGraffiti
//
//  Created by hua on 2020/5/11.
//  Copyright © 2020 hua. All rights reserved.
//

#import "PTStashFiles.h"

@implementation PTStashFiles

+ (void)stashFilesMethodsOne {
    
    NSString *s1 = @"zhangsan";
    
    NSString *s2 = @"lisi";
    
    NSString *s3 = @"wangwu";
    
    //(1)
    
    NSArray *array1 = [[NSArray alloc] initWithObjects:s1,s2,s3, nil];
    
    NSLog(@"%@",array1); //等价于 array1.descripton
    

    
}

+ (void)oneStashFilesMethods {
    NSString *string = [NSString new];
    

}

+ (void)twoStashFilesMethods {
    NSString *s2 = @"lisi";
    
    NSString *s3 = @"wangwu";
    
}

+ (void)stashFilesMethodsTwo {
    NSString *s2 = @"lisi";
    
    NSString *s3 = @"wangwu";
    
}

+ (void)stashFilesMethodsThree {
    NSString *s1 = @"zhangsan";
    
    NSString *s2 = @"lisi";
    
    NSString *s3 = @"wangwu";
    
    //(1)
    
    NSArray *array1 = [[NSArray alloc] initWithObjects:s1,s2,s3, nil];
    
    NSLog(@"%@",array1); //等价于 array1.descripton
}

+ (void)threeStashFilesMethods {
    NSString *s1 = @"zhangsan";
    
    NSString *s2 = @"lisi";
    
    NSString *s3 = @"wangwu";
    
    //(1)
    
    NSArray *array1 = [[NSArray alloc] initWithObjects:s1,s2,s3, nil];
    
    NSLog(@"%@",array1); //等价于 array1.descripton
}

+ (void)stashFilesMethodsOneTest {
    NSString *s1 = @"zhangsan";
    
    NSString *s2 = @"lisi";
    
    NSString *s3 = @"wangwu";
    
    //(1)
    
    NSArray *array1 = [[NSArray alloc] initWithObjects:s1,s2,s3, nil];
    
    NSLog(@"%@",array1); //等价于 array1.descripton
}

+ (void)oneStashFilesMethodsTest {
    NSString *s1 = @"zhangsan";
    
    NSString *s2 = @"lisi";
    
    NSString *s3 = @"wangwu";
}

+ (void)twoStashFilesMethodsTest {
    NSString *s1 = @"zhangsan";
    
    NSString *s2 = @"lisi";
    
    NSString *s3 = @"wangwu";
}

+ (void)stashFilesMethodsTwoTest {
    NSString *s1 = @"zhangsan";
    
    NSString *s2 = @"lisi";
    
    NSString *s3 = @"wangwu";
}

+ (void)stashFilesMethodsThreeTest {
    NSDictionary *dic = [NSDictionary dictionary];
}

+ (void)threeStashFilesMethodsTest {
    NSSet *set = [NSSet set];
}

@end
