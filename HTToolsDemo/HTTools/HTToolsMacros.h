//
//  HTToolsMacros.h
//  HTToolsDemo
//
//  Created by mypc on 2020/7/17.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#ifndef HTToolsMacros_h
#define HTToolsMacros_h

#define HT_TICK   NSDate *startTime = [NSDate date]
#define HT_TOCK   NSLog(@"运行时间: %f", -[startTime timeIntervalSinceNow])


#ifdef DEBUG
#define LogFileName [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String]
#define Log(FORMAT, ...) fprintf(stderr,"\n%s:%d\n%s\n========================================\n",LogFileName, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif





//获取 APP 名称
#define APP_NAME    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
//获取 程序版本号
#define APP_VERSION [UIDevice currentDevice].appVersion
//获取 APP build 版本
#define APP_BUILD   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]


#define IOS8Later  @available(iOS 8.0 , *)
#define IOS9Later  @available(iOS 9.0 , *)
#define IOS10Later @available(iOS 10.0, *)
#define IOS11Later @available(iOS 11.0, *)
#define IOS12Later @available(iOS 12.0, *)
#define IOS13Later @available(iOS 13.0, *)



#endif /* HTToolsMacros_h */
