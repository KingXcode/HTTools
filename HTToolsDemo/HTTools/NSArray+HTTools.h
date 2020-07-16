//
//  NSArray+HTTools.h
//  HTToolsDemo
//
//  Created by mypc on 2020/7/17.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (HTTools)


/**
 反序数组
 @return 反序后的新数组
 */
-(NSArray *)ht_reverse;

/**
 去除重复的元素
 */
-(NSArray *)ht_removeRepeatRows;



/**
 @param keypath 模型数组元素中的一个属性
 @return 过滤之后的新数组
 */
-(NSArray *)ht_removeRepeatRowsWithKeypath:(NSString *)keypath;


/**
 将模型数组中的模型 根据keypath 获取到值与text对比 ，如果相同 则将该元素移除掉
 
 @param keypath 模型数据路径 对应的值也必须是string 否则也会返回原数组
 @param text 模型数据路径的数据 必须是string 否则返回原数组
 @return 移除包含text的模型数组
 */
-(NSMutableArray *)ht_removeItemsWithKeypath:(NSString *)keypath ByContains:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
