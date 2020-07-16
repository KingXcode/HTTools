//
//  AudioPlayerManager.m
//  HTToolsDemo
//
//  Created by mypc on 2020/7/17.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import "AudioPlayerManager.h"

AudioPlayerManagerNotification * const AudioPlayerPlayMusicNotification           = @"AudioPlayerPlayMusicNotification";
AudioPlayerManagerNotification * const AudioPlayerPauseMusicNotification          = @"AudioPlayerPauseMusicNotification";
AudioPlayerManagerNotification * const AudioPlayerStopMusicNotification           = @"AudioPlayerStopMusicNotification";
AudioPlayerManagerNotification * const AudioPlayerErrorPlayingMusicNotification   = @"AudioPlayerErrorPlayingMusicNotification";


@interface AudioPlayerManager ()

@property(nonatomic,strong,readonly) AVPlayer *player;
@property (nonatomic,assign) BOOL isPlaying;
@property(nonatomic,strong) id timeObserve;

@end

@implementation AudioPlayerManager



- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _player = [[AVPlayer alloc] init];
        
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord
                                         withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker
                                               error:NULL];

        //播放完毕状态
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endOfPlay:)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:nil];
        //播放失败
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(errorOfPlay:)
                                                     name:AVPlayerItemFailedToPlayToEndTimeNotification
                                                   object:nil];
        //异常中断
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(errorOfPlay:)
                                                     name:AVPlayerItemPlaybackStalledNotification
                                                   object:nil];
        //音频输出改变
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(routeChange:)
                                                     name:AVAudioSessionRouteChangeNotification
                                                   object:[AVAudioSession sharedInstance]];
        //系统中断 （来电话等等之类的）
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleInterruption:)
                                                     name:AVAudioSessionInterruptionNotification
                                                   object:[AVAudioSession sharedInstance]];
  

    }
    return self;
}


/**
 根据音乐url或者本地的音乐名 创建播放器
 */
-(void)playMusicWithMusicName:(NSString *)music error:(NSError **)error
{
    if (_isPlaying) {
        
    }
    
    NSURL *fileUrl;
    if ([AudioPlayerManager ht_IsUrl:music]) {
        fileUrl = [NSURL URLWithString:music];
    }else{
        fileUrl = [[NSBundle mainBundle] URLForResource:music withExtension:@"mp3"];
    }
    if (fileUrl == nil){
        NSString *domain = @"com.yibaotong.nvwa.ErrorDomain";
        NSString *desc = @"Url创建失败";
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : desc};
        *error = [NSError errorWithDomain:domain
                                     code:-1
                                 userInfo:userInfo];
        return;
    }
    

    [self removeAVPlayerItemObserver];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:fileUrl];
    [self addAVPlayerItemObserver:item];
    [self.player replaceCurrentItemWithPlayerItem:item];
}


-(void)addAVPlayerItemObserver:(AVPlayerItem *)item
{
    //媒体加载状态
    [item addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    //数据缓冲状态
    [item addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    //开始缓冲
    [item addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    //结束缓冲
    [item addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)removeAVPlayerItemObserver
{
    if (self.player.currentItem) {
        [self.player.currentItem cancelPendingSeeks];
        [self.player.currentItem.asset cancelLoading];
        
        [self.player.currentItem removeObserver:self forKeyPath:@"status"];
        [self.player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        [self.player.currentItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
        [self.player.currentItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    }
}


//监听AVPlayerItem status 状态
-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (!self.player || object != self.player.currentItem) { return; }
    
    AVPlayerItem * item = object;

    if ([keyPath isEqualToString:@"status"])
    {//媒体加载状态
        switch ([[change valueForKey:@"new"] integerValue]) {
            case AVPlayerItemStatusUnknown:
                [[NSNotificationCenter defaultCenter] postNotificationName:AudioPlayerErrorPlayingMusicNotification
                                                                    object:[AudioPlayerManager sharedManager]];
                break;
            case AVPlayerItemStatusReadyToPlay:
                // 只有观察到status变为这种状态,才会真正的播放.
                [self playMusic];
                break;
            case AVPlayerItemStatusFailed:
                // mini设备不插耳机或者某些耳机会导致准备失败.
                [[NSNotificationCenter defaultCenter] postNotificationName:AudioPlayerErrorPlayingMusicNotification
                                                                    object:[AudioPlayerManager sharedManager]];
                break;
        }
    }
    else if ([keyPath isEqualToString:@"loadedTimeRanges"])
    {//数据缓冲状态
        NSArray * array = item.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue]; //本次缓冲的时间范围
        
        //缓冲总长度
        NSTimeInterval totalBuffer = CMTimeGetSeconds(timeRange.start) + CMTimeGetSeconds(timeRange.duration);
        
        CMTime duration11     = self.player.currentItem.duration;
        double totalDuration = CMTimeGetSeconds(duration11);
        //缓冲进度
        double percent = (double)totalBuffer / totalDuration;
        
        if (self.didBufferingHandler) {
            self.didBufferingHandler(item, totalBuffer, percent);
        }

    }
    else if ([keyPath isEqualToString:@"playbackBufferEmpty"])
    {
        //开始缓冲
        if (self.didStartBufferHandler) {
            self.didStartBufferHandler(item);
        }
        if (item.isPlaybackBufferEmpty) {
            //缓冲区为空
        }
    }
    else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"])
    {
        //isPlaybackLikelyToKeepUp == NO 则说明调用了播放 但是没有缓冲好
        //isPlaybackLikelyToKeepUp == YES 说明缓冲好了
        if (item.isPlaybackLikelyToKeepUp) {
            //结束缓冲
            if (self.didEndbufferHandler) {
                self.didEndbufferHandler(item);
            }
        }
    }
}




//播放或者暂停
-(BOOL)playOrPauseMusic
{
    if (_isPlaying) {
        //如果是播放状态 则暂停播放
        return [self pauseMusic];
    }else{
        //否则继续播放
        return [self playMusic];
    }
}


//开始播放
-(BOOL)playMusic
{
    if (self.player.currentItem == nil) {
        self.isPlaying = NO;
        return self.isPlaying;
    }
    

    //启动定时器
    [self starObserver];
    //然后开始播放
    [self.player play];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.didStartPlayHandler) {
            self.didStartPlayHandler(self.player.currentItem);
        }
        
        //发送通知 开始播放了
        [[NSNotificationCenter defaultCenter] postNotificationName:AudioPlayerPlayMusicNotification
                                                            object:[AudioPlayerManager sharedManager]];
    });

    
    self.isPlaying = YES;
    
    return self.isPlaying;
}

//暂停播放
-(BOOL)pauseMusic
{

    
    [self stopObserver];
    [self.player pause];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //调用代理
        
        if (self.didPausePlayHandler) {
            self.didPausePlayHandler(self.player.currentItem);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:AudioPlayerPauseMusicNotification
                                                            object:[AudioPlayerManager sharedManager]];
    });

    self.isPlaying = NO;
    return self.isPlaying;
}

//停止播放
-(BOOL)stopMusic
{
    [self stopObserver];
    [self.player pause];
    [self removeAVPlayerItemObserver];
    [self.player replaceCurrentItemWithPlayerItem:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //调用代理
        if (self.didEndPlayHandler) {
            self.didEndPlayHandler(self.player.currentItem);
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:AudioPlayerStopMusicNotification
                                                            object:[AudioPlayerManager sharedManager]];
    });

    self.isPlaying = NO;
    return self.isPlaying;
}


#pragma -mark- 通知
// 播放结束后的方法,由代理具体实现行为.
-(void)endOfPlay:(NSNotification *)sender
{
    AVPlayerItem *item = sender.object;
    if ([item isKindOfClass:[AVPlayerItem class]] && self.player.currentItem != item) {
        return;
    }
    
    [self stopMusic];
}

//播放失败 或 中断
-(void)errorOfPlay:(NSNotification *)sender
{
    [self stopMusic];
}

//音频中断服务
- (void)handleInterruption:(NSNotification *)notification
{
    NSDictionary * info = notification.userInfo;
    AVAudioSessionInterruptionType type = [info[AVAudioSessionInterruptionTypeKey] unsignedIntegerValue];
    //中断开始和中断结束
    if (type == AVAudioSessionInterruptionTypeBegan) {
        //当被电话等中断的时候，调用这个方法，停止播放
        [self pauseMusic];
    } else {
        /**
         *  中断结束，userinfo中会有一个InterruptionOption属性，
         *  该属性如果为resume，则可以继续播放功能
         */
        AVAudioSessionInterruptionOptions option = [info[AVAudioSessionInterruptionOptionKey] unsignedIntegerValue];
        if (option == AVAudioSessionInterruptionOptionShouldResume) {
            [self playMusic];
        }
    }
}

//音频输出改变触发事件
- (void)routeChange:(NSNotification *)notification
{
    NSDictionary *dic = notification.userInfo;
    
    int changeReason= [dic[AVAudioSessionRouteChangeReasonKey] intValue];
    
    //等于AVAudioSessionRouteChangeReasonOldDeviceUnavailable表示旧输出不可用
    if (changeReason == AVAudioSessionRouteChangeReasonOldDeviceUnavailable)
    {
        AVAudioSessionRouteDescription *routeDescription = dic[AVAudioSessionRouteChangePreviousRouteKey];
        AVAudioSessionPortDescription  *portDescription  = [routeDescription.outputs firstObject];
        //原设备为耳机则暂停 AVAudioSessionPortBluetoothA2DP
        if ([portDescription.portType isEqualToString:AVAudioSessionPortHeadphones] ||
            [portDescription.portType isEqualToString:AVAudioSessionPortBluetoothA2DP])
        {
            UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
            AVAudioSession * session = [AVAudioSession sharedInstance];
            [session setPreferredIOBufferDuration:audioRouteOverride error:nil];
            //如果视频正在播放，会自动暂停，这里用来设置按钮图标
            [self pauseMusic];
        }
    }else if (changeReason == AVAudioSessionRouteChangeReasonRouteConfigurationChange) {
        //路线改变
        
    }
}


//启动进度更新
-(void)starObserver
{
    [self stopObserver];
    
    __weak typeof(self) __self = self;
    self.timeObserve = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 2.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        if (__self.didGetTimeProgress) {
            __self.didGetTimeProgress([__self valueToString:[__self getCurTime]], [__self valueToString:[__self getTotleTime]], [__self getProgress]);
        }
    }];
}

//关闭进度更新
-(void)stopObserver
{
    if (self.timeObserve) {
        [self.player removeTimeObserver:self.timeObserve];
        self.timeObserve = nil;
    }
}




// 跳转方法
-(void)seekToTimeWithValue:(double)value
{
    if (self.player.currentItem == nil) {
        return ;
    }
    
    // 先暂停
    [self pauseMusic];
    
    // 跳转
    [self.player seekToTime:CMTimeMake(value * [self getTotleTime], 1) completionHandler:^(BOOL finished) {
        if (finished == YES) {
            [self playMusic];
        }
    }];
}



// 获取当前的播放时间
-(NSInteger)getCurTime
{
    if (self.player.currentItem) {
        // 用value/scale,就是AVPlayer计算时间的算法. 它就是这么规定的.
        return (NSInteger)(self.player.currentTime.value / self.player.currentTime.timescale);
    }
    return 0;
}


// 获取总时长
-(NSInteger)getTotleTime
{
    CMTime totleTime = [self.player.currentItem duration];
    
    if (totleTime.timescale == 0)
    {
        return 1;
    }
    else
    {
        return (NSInteger)(totleTime.value /totleTime.timescale);
    }
}


// 获取当前播放进度
-(double)getProgress
{
    return (double)[self getCurTime] / (double)[self getTotleTime];
}

// 将整数秒转换为 00:00 格式的字符串
-(NSString *)valueToString:(NSInteger)value
{
    return [NSString stringWithFormat:@"%@:%@",@(value/60),@(value%60)];
}












/**
 判断是不是url
 */
+ (BOOL)ht_IsUrl:(NSString *)urlStr
{
    if ([self ht_isNullString:urlStr]) {
        return NO;
    }
    NSString *pattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:urlStr options:0 range:NSMakeRange(0, urlStr.length)];
    return results.count > 0;
}


/**
 判断是不是空字符串
 */
+ (BOOL)ht_isNullString:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}



static AudioPlayerManager *_manager = nil;

+(instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager == nil) {
            _manager = [[super allocWithZone:NULL]init];
        }
    });
    return _manager;
}

// 防止外部调用alloc 或者 new
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [AudioPlayerManager sharedManager];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return [AudioPlayerManager sharedManager];
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    return [AudioPlayerManager sharedManager];
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self stopObserver];
}





#pragma -mark- AVAudioPlayerDelegate

// 当一个声音播放完毕后调用。如果由于中断而停止播放器，则不调用此方法


// 如果在解码时发生错误，它将报告给委托



#pragma -mark- AVAudioSession - Notification
//线路变更 主要是插拔耳机

//系统中断 可能是电话 可能是其它app截断了

//媒体服务终止通知



@end

