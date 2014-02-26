//
//  WSMainViewController.h
//  music
//
//  Created by tatsuya fujii on 2013/11/11.
//  Copyright (c) 2013年 Wondershake. All rights reserved.
//

#import "WSFlipsideViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AMBlurView.h"
#import "DRNRealTimeBlurView.h"
@interface WSMainViewController : UIViewController <UIScrollViewDelegate>
{
    IBOutlet UIImageView *artworkImageView;
    IBOutlet DRNRealTimeBlurView *blurView;
    
    IBOutlet UILabel *musicTitleLabel;
    IBOutlet UILabel *albumTitleLabel;
    IBOutlet UILabel *artistNameLabel;
    IBOutlet UILabel *moodLabel;
    
    NSTimer *timer;
    MPMusicPlayerController *musicPlayer;
    IBOutlet UIProgressView *progressView;
    IBOutlet UISlider *slider;
    
    IBOutlet UIScrollView *mainScrollView;
    IBOutlet UIView *innerView;
    
    IBOutlet UIImageView *gridImageView;
    IBOutlet UIImageView *gridTextImageView;
}
-(IBAction)zoomButton:(UIButton *)button;
@end
