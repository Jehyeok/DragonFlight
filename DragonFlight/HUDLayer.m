//
//  HUDLayer.m
//  DragonFlight
//
//  Created by Jehyeok on 11/29/13.
//  Copyright (c) 2013 com.appcoda. All rights reserved.
//

#import "HUDLayer.h"

@implementation HUDLayer
-(id)init {
    self = [super init];
    if (self) {
        // 레이블 초기화
        scoreLabel = [CCLabelTTF labelWithString:@"0M" fontName:@"Arial" fontSize:20];
        // 위치 초기화
        scoreLabel.position = CGPointMake( 280, 450 );
        [self addChild:scoreLabel];
    }
    return self;
}

-(void)setScoreText:(int)score {
    NSString *scoreString = [NSString stringWithFormat:@"%dM", score];
    [scoreLabel setString:scoreString];
}
@end
