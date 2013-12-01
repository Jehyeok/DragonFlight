//
//  Player.m
//  DragonFlight
//
//  Created by Jehyeok on 11/29/13.
//  Copyright (c) 2013 com.appcoda. All rights reserved.
//

#import "Player.h"

#import "CCDirector.h"
#import "cocos2d.h"

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
        _leftWing.anchorPoint = CGPointMake( 1.0, 1.0 );
        // 중간 정도로 위치 시킴
        _leftWing.position = CGPointMake( self.boundingBox.size.width/2, 30 );
        // 몸통아래에 위치 하도록 z-order 변경
        [self addChild:_leftWing z:-1];
        
        // 오른쪽 날개 만듦
        _rightWing = [CCSprite spriteWithFile:@"player_wing.png"];
        // 날개 회전 시킴
        [_rightWing setFlipX:YES];
        _rightWing.anchorPoint = CGPointMake( 0.0, 1.0 );
        _rightWing.position = CGPointMake( self.boundingBox.size.width/2, 30 );
        // 몸통 아래 위치하도록 z-order 변경
        [self addChild:_rightWing z:-1];
        
        wingDown = NO;
    }
    return self;
}

-(void)updateWings:(ccTime)dt {
    // 왼쪽 날개 애니메이션
    CCRotateTo *leftWingDown = [CCRotateTo actionWithDuration:0.2 angleX:-30 angleY:60];
    CCRotateTo *leftWingUp = [CCRotateTo actionWithDuration:0.2 angleX:0 angleY:0];
    
    // 오른쪽 날개 애니메이션
    CCRotateTo *rightWingDown = [CCRotateTo actionWithDuration:0.2 angleX:30 angleY:-60];
    CCRotateTo *rightWingUp = [CCRotateTo actionWithDuration:0.2 angleX:0 angleY:0];
    
    if ((wingDown = !wingDown)) {
        [_leftWing runAction:leftWingDown];
        [_rightWing runAction:rightWingDown];
    } else {
        [_leftWing runAction:leftWingUp];
        [_rightWing runAction:rightWingUp];
    }
}

-(void)onEnter {
    [super onEnter];
    [self schedule:@selector(updateWings:) interval:0.2];
}
@end
