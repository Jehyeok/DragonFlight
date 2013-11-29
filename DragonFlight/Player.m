//
//  Player.m
//  DragonFlight
//
//  Created by Jehyeok on 11/29/13.
//  Copyright (c) 2013 com.appcoda. All rights reserved.
//

#import "Player.h"

#import "CCDirector.h"

@implementation Player
-(id)init {
    // 플레이어 몸통 스프라이트 생성
    self = [super initWithFile:@"player_body.png"];
    if (self) {
        // 윈도우 크기 값
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        // 화면의 가운데 아래측 위치 시킴
        self.position = CGPointMake( winSize.width/2 , 75 );
        
        // 왼쪽 날개 만듦
        _leftWing = [CCSprite spriteWithFile:@"player_wing.png"];
        // 중간 정도로 위치 시킴
        _leftWing.position = CGPointMake( winSize.width/2, 50 );
        // 몸통아래에 위치 하도록 z-order 변경
        [self addChild:_leftWing z:-1];
        
        // 오른쪽 날개 만듦
        _rightWing = [CCSprite spriteWithFile:@"player_wing.png"];
        // 날개 회전 시킴
        [_rightWing setFlipX:YES];
        _rightWing.position = CGPointMake( winSize.width/2 , 50 );
        // 몸통 아래 위치하도록 z-order 변경
        [self addChild:_rightWing z:-1];
    }
    return self;
}
@end
