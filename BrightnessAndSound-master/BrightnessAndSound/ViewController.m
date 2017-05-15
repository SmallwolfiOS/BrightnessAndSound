//
//  ViewController.m
//  BrightnessAndSound
//
//  Created by Jason on 2017/4/10.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *brightnessSlider;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;
@property (nonatomic,strong)  MPVolumeView *volumeView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat currentLight = [[UIScreen mainScreen] brightness];
    [[UIScreen mainScreen] setBrightness: currentLight];
    
    
    _volumeView = [[MPVolumeView alloc]init];
    
//    _volumeView.showsRouteButton = NO;
//    //默认YES，这里为了突出，故意设置一遍
//    _volumeView.showsVolumeSlider = YES;
    
    [_volumeView sizeToFit];
    [_volumeView setFrame:CGRectMake(-1000, -1000, 10, 10)];
    
//    [self.view addSubview:_volumeView];//*****亲测，这行代码是现实音量指示器的关键所在*****
    [_volumeView userActivity];
}

- (IBAction)changeBrightness:(UISlider *)sender {
    NSLog(@"%.2f",sender.value);
    [[UIScreen mainScreen] setBrightness: sender.value];
}
- (IBAction)changeVolume:(UISlider *)sender {
    /*
    MPMusicPlayerController *mpc = [MPMusicPlayerController applicationMusicPlayer];
    //This property is deprecated -- use MPVolumeView for volume control instead.
    //在7.0以后苹果反对使用此方法，建议用MPVolumeView
    mpc.volume = sender.value;  //0.0~1.0
    */
    
    static UISlider * volumeViewSlider = nil;
    if (volumeViewSlider == nil) {
        
        for (UIView* newView in _volumeView.subviews) {
            if ([newView.class.description isEqualToString:@"MPVolumeSlider"]){
                volumeViewSlider = (UISlider*)newView;
                break;
            }
        }
    }
    NSLog(@"%.2f",volumeViewSlider.value);
    
    volumeViewSlider.value = sender.value;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
