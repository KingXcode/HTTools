//
//  AudioPlayerManager.h
//  HTToolsDemo
//
//  Created by mypc on 2020/7/17.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString AudioPlayerManagerNotification NS_EXTENSIBLE_STRING_ENUM;
extern AudioPlayerManagerNotification * const AudioPlayerPlayMusicNotification;//播放音乐
extern AudioPlayerManagerNotification * const AudioPlayerPauseMusicNotification;//暂停播放音乐
extern AudioPlayerManagerNotification * const AudioPlayerStopMusicNotification;//停止播放音乐
extern AudioPlayerManagerNotification * const AudioPlayerErrorPlayingMusicNotification;//播放出错



@interface AudioPlayerManager : NSObject

+(instancetype)sharedManager;

//根据音乐url或者本地的音乐名-创建播放器 需要调用playOrStopMusic才会播放
-(void)playMusicWithMusicName:(NSString *)music error:(NSError **)error;

/*
    以下方法的返回值表示播放状态
 */
//开始或暂停
-(BOOL)playOrPauseMusic;
//开始播放
-(BOOL)playMusic;
//暂停播放
-(BOOL)pauseMusic;
//停止
-(BOOL)stopMusic;

/************************************************************************************/

// 跳转方法
-(void)seekToTimeWithValue:(double)value;
// 获取当前的播放时间
-(NSInteger)getCurTime;
// 获取总时长
-(NSInteger)getTotleTime;
// 获取当前播放进度
-(double)getProgress;
// 将整数秒转换为 00:00 格式的字符串
-(NSString *)valueToString:(NSInteger)value;


//播放进度
@property (nonatomic, copy) void(^didGetTimeProgress)(NSString *currentTime, NSString *totleTime, double progress);

//开始播放
@property (nonatomic, copy) void(^didStartPlayHandler)(AVPlayerItem *item);
//暂停播放
@property (nonatomic, copy) void(^didPausePlayHandler)(AVPlayerItem *item);
//结束播放
@property (nonatomic, copy) void(^didEndPlayHandler)(AVPlayerItem *item);

//开始缓冲
@property (nonatomic, copy) void(^didStartBufferHandler)(AVPlayerItem *item);
//缓冲中--缓冲进度
@property (nonatomic, copy) void(^didBufferingHandler)(AVPlayerItem *item, NSTimeInterval totalBuffer, double progress);
//结束缓冲
@property (nonatomic, copy) void(^didEndbufferHandler)(AVPlayerItem *item);

@end

NS_ASSUME_NONNULL_END
