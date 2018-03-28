//
//  ArtisanApplication.m
//  Artisan
//
//  Created by roger on 14/10/23.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ArtisanApplication.h"
#import "ZenPlayerController.h"

@implementation ArtisanApplication


#pragma mark Remote Control

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)remoteControlReceivedWithEvent: (UIEvent *) receivedEvent
{
    ZenPlayerController *player = [ZenPlayerController sharedInstance];
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        
        switch (receivedEvent.subtype) {
            case UIEventSubtypeRemoteControlTogglePlayPause:
                [player play];
                break;
            case UIEventSubtypeRemoteControlPause:
                [player play];
                break;
            case UIEventSubtypeRemoteControlPlay:
                [player play];
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                [player prev];
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                [player next:YES];
                break;
            default:
                break;
        }
    }
}

@end
