//
//  GameLayer.m
//  DragonFlight
//
//  Created by Jehyeok on 11/29/13.
//  Copyright (c) 2013 com.appcoda. All rights reserved.
//

#import "GameLayer.h"

#import "CCDirector.h"
#import "CCTouchDispatcher.h"
#import "ccDeprecated.h"

@implementation GameLayer
-(id)init {
    self = [super init];
    if (self) {
        // 윈도우 화면 크기 가져옴
        winSize = [[CCDirector sharedDirector] winSize];
        // 배경 초기화
        [self initBackground];
        // 플레이어 초기화
        [self initPlayer];
    }
    return self;
}

-(void)initBackground {
    // 배경에 사용할 1번 이미지 생성 후, 화면에 꽉 차게 이동
    _backgroundImage1 = [CCSprite spriteWithFile:@"background.png"];
    _backgroundImage1.anchorPoint = CGPointZero;
    [self addChild:_backgroundImage1];
    
    // 배경에 사용할 2번 이미지 생성 후, 1번 이미지 위로 이동
    _backgroundImage2 = [CCSprite spriteWithFile:@"background.png"];
    _backgroundImage2.anchorPoint = CGPointZero;
    _backgroundImage2.position = CGPointMake( 0, [_backgroundImage2 boundingBox].size.height);
    [self addChild:_backgroundImage2 z:-1];
}

-(void)initPlayer {
    // 플레이어 생성
    _player = [Player node];
    // 가장 위에 위치 시킴
    [self addChild:_player z:99];
}

- (void)update:(ccTime)dt {
    // 배경화면 움직이는 속도, 현재 위치에 이동할 취리를 ccpADD로 더함
    CGPoint backgroundScrollVel = CGPointMake( 0, -100 );
    // 현재 이미지1의 위치 값 불러옴
    CGPoint currentPos = [_backgroundImage1 position];
    // 1번 이미지가 스크롤 되서 사라지고, 2번 이미지가 1번 이미지의 초기 위치에 오면 최초 위치로 이동
    if (currentPos.y < -winSize.height) {
        [_backgroundImage1 setPosition:CGPointZero];
        currentPos = CGPointMake( 0, [_backgroundImage2 boundingBox].size.height );
        [_backgroundImage2 setPosition:currentPos];
    } else {
        CGPoint multResult = CGPointMake(backgroundScrollVel.x * dt, backgroundScrollVel.y * dt);
        
        _backgroundImage1.position = CGPointMake(multResult.x + _backgroundImage1.position.x, multResult.y + _backgroundImage1.position.y);
    
        _backgroundImage2.position = CGPointMake(multResult.x + _backgroundImage2.position.x, multResult.y + _backgroundImage2.position.y);
    }
}

-(void)onEnter {
    [super onEnter];
    NSLog(@"touch");
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    // 배경 움직임과 충돌을 체크할 때 사용하는 메인 스케쥴
    [self scheduleUpdate];
}

#pragma mark Touch

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    // 바로 전 좌표 값과 비교 위해 저장. UI좌표계를 cocos 좌표계로 변환
    prePoint = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    return YES;
    NSLog(@"touch began");
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    // 움직였을 때 플레이어의 위치 값. UI좌표계를 cocos 좌표계로 변환
    CGPoint location = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    // 플레이어 캐릭터 위치 ( 기존 위치 X값 - 움직인 거리 )
    _player.position = CGPointMake( _player.position.x - (prePoint.x - location.x), _player.position.y );
    // 왼쪽과 오른쪽 경계 체크
    if (_player.position.x < 0) {
        _player.position = CGPointMake( 0, _player.position.y );
    } else if ( _player.position.x > winSize.width ) {
        _player.position = CGPointMake( winSize.width, _player.position.y );
    }
    // 현재 위치를 이전 값으로 초기화
    prePoint = location;
    NSLog(@"touching");
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    
}
@end
