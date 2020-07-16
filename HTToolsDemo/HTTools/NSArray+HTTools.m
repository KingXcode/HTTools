//
//  NSArray+HTTools.m
//  HTToolsDemo
//
//  Created by mypc on 2020/7/17.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import "NSArray+HTTools.h"

@implementation NSArray (HTTools)


//反序数组
-(NSArray *)ht_reverse
{
    NSArray *reversArray = [[self reverseObjectEnumerator] allObjects];
    return reversArray;
}

//去除重复的元素
-(NSArray *)ht_removeRepeatRows
{
    NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < [self count]; i++){
        if ([categoryArray containsObject:[self objectAtIndex:i]] == NO){
            [categoryArray addObject:[self objectAtIndex:i]];
        }
    }
    return categoryArray;
}

//去除重复的元素
-(NSArray *)ht_removeRepeatRowsWithKeypath:(NSString *)keypath
{
    NSMutableSet *seenObjects = [NSMutableSet set];
    NSPredicate * predicate = [NSPredicate predicateWithBlock: ^BOOL(id obj, NSDictionary *bind) {
        id property = [obj valueForKeyPath:keypath];//元素属性
        BOOL seen = [seenObjects containsObject:property];
        if (!seen) {
            [seenObjects addObject:property];
        }
        return !seen;
    }];
    
    NSMutableArray *categoryArray = [NSMutableArray arrayWithArray:[self filteredArrayUsingPredicate:predicate]];
    return categoryArray;
}


/**
 将模型数组中的模型 根据keypath 获取到值与text对比 ，如果相同 则将该元素移除掉
 
 @param keypath 模型数据路径 对应的值也必须是string 否则也会返回原数组
 @param text 模型数据路径的数据 必须是string 否则返回原数组
 @return 移除包含text的模型数组
 */
-(NSMutableArray *)ht_removeItemsWithKeypath:(NSString *)keypath ByContains:(NSString *)text
{
    if (![text isKindOfClass:[NSString class]]) {
        return [NSMutableArray arrayWithArray:self];
    }
    NSMutableArray *newArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i<self.count; i++) {
        id  obj = self[i];
        id property = [obj valueForKeyPath:keypath];//元素属性
        if (![property isKindOfClass:[NSString class]])
        {
            return [NSMutableArray arrayWithArray:self];
        }
        NSString *modelString = [NSString stringWithFormat:@"%@",property];
        if (![modelString isEqualToString:text]) {
            [newArray addObject:obj];
        }
    }
    return newArray;
}



@end
