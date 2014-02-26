//
//  WSMainViewController.m
//  music
//
//  Created by tatsuya fujii on 2013/11/11.
//  Copyright (c) 2013年 Wondershake. All rights reserved.
//

#import "WSMainViewController.h"

@interface WSMainViewController ()

@end

@implementation WSMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if( [ UIApplication sharedApplication ].isStatusBarHidden == NO ) {
        [ UIApplication sharedApplication ].statusBarHidden = YES;
    }
    
    mainScrollView.contentSize = CGSizeMake(320*5, 320*5);
    blurView.renderStatic = YES;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    [self updateMusic];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(checkCurrentPlayTime) userInfo:nil repeats:YES];
    
    musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter
     addObserver: self
     selector:    @selector (updateMusic)
     name:        MPMusicPlayerControllerNowPlayingItemDidChangeNotification
     object:      musicPlayer];
    
    [notificationCenter
     addObserver: self
     selector:    @selector (updateMusic)
     name:        MPMusicPlayerControllerPlaybackStateDidChangeNotification
     object:      musicPlayer];
    
    [musicPlayer beginGeneratingPlaybackNotifications];
    
 
    moodLabel.text = @"Cool";
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}

-(IBAction)showTimeLineView
{
    [self performSegueWithIdentifier:@"showTimeLineView" sender:self];
}

-(void)checkCurrentPlayTime
{
    //NSLog(@"%f %@", musicPlayer.currentPlaybackTime, [[musicPlayer nowPlayingItem] valueForKey:MPMediaItemPropertyPlaybackDuration]);
    //progressView.progress = musicPlayer.currentPlaybackTime / [[[musicPlayer nowPlayingItem] valueForKey:MPMediaItemPropertyPlaybackDuration] floatValue];
    slider.value = musicPlayer.currentPlaybackTime / [[[musicPlayer nowPlayingItem] valueForKey:MPMediaItemPropertyPlaybackDuration] floatValue];
}

-(void)updateMusic
{
    blurView.renderStatic = NO;
    MPMediaItem *playingItem = [musicPlayer nowPlayingItem];
    if (playingItem) {
        NSInteger mediaType = [[playingItem valueForProperty:MPMediaItemPropertyMediaType] integerValue];
        if (mediaType == MPMediaTypeMusic) {
            NSString *songTitle = [playingItem valueForProperty:MPMediaItemPropertyTitle];
            NSString *albumTitle = [playingItem valueForProperty:MPMediaItemPropertyAlbumTitle];
            NSString *artist = [playingItem valueForProperty:MPMediaItemPropertyArtist];
            musicTitleLabel.text = songTitle;
            //albumTitleLabel.text = albumTitle;
            artistNameLabel.text = [NSString stringWithFormat:@"%@ - %@",artist, albumTitle];
            
            MPMediaItemArtwork *artwork = [playingItem valueForProperty:MPMediaItemPropertyArtwork];
            UIImage *artworkImage = [artwork imageWithSize:CGSizeMake(artwork.bounds.size.width, artwork.bounds.size.height)];
            artworkImageView.image = artworkImage;
            blurView.renderStatic = YES;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(WSFlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}


-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    //return [[flameScrollView subviews] objectAtIndex:0];
    return innerView;
}

- (CGRect)zoomRectForScrollView:(UIScrollView *)scrollView_ withScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // The zoom rect is in the content view's coordinates.
    // At a zoom scale of 1.0, it would be the size of the
    // imageScrollView's bounds.
    // As the zoom scale decreases, so more content is visible,
    // the size of the rect grows.
    zoomRect.size.height = innerView.frame.size.height / scale;
    zoomRect.size.width  = innerView.frame.size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}

-(IBAction)zoomButton:(UIButton *)button
{

    
    CGRect zoomRect = [self zoomRectForScrollView:mainScrollView withScale:5.0 withCenter:button.center];
    [mainScrollView zoomToRect:zoomRect animated:YES];
    if (mainScrollView.zoomScale == 1.0) {
        [UIView animateWithDuration:0.5 animations:^(void){
            gridTextImageView.alpha = 1.0;
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^(void){
            gridTextImageView.alpha = 0.0;
        }];
    }
}

@end
