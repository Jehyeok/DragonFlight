//
//  Enemy.m
//  DragonFlight
//
//  Created by Jehyeok on 11/30/13.
//  Copyright (c) 2013 com.appcoda. All rights reserved.
//

#import "Enemy.h"

@implementation Enemy

-(id)init {
    self = [super initWithFile:@"stone.png"];
    if (self) {
        // 적의 기본 에너지 100
        _state = alive;
        _energy = ENEMY_ENERGY;
    }
    return self;
}

-(NSInteger)attackedWithPoint:(NSInteger)point {
    _energy -= point;
    // 0미만이면 죽음, 아니면 반환
    if (_energy <=0 ) {
        [self destroy];
    }
    return _energy;
}

-(void)destroy {
    _state = dead;
    self.visible = NO;
}

-(void)reset {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    // 적의 위치를 화면 상단으로
    self.position = CGPointMake( self.position.x, winSize.height + self.boundingBox.size.height/2 );
    [self setVisible:YES];
    _energy = ENEMY_ENERGY;
    _state = alive;
}

// 일정 시간마다 적을 아래로 움직임
-(void)update:(ccTime)dt {
    // 적의 움직임 속도
    CGPoint enemyScrollVel = CGPointMake( 0, -250);
    // 현재 적 위치
    CGPoint enemyPos = [self position];
    // 화면 아래로 벗어나는지 체크
    if (enemyPos.y + self.boundingBox.size.height / 2 <= 0) {
        // 벗어나면 리셋
        [self reset];
    } else {
        // 위치값 아래로 이동
        CGPoint multResult = CGPointMake( enemyScrollVel.x * dt, enemyScrollVel.y * dt );
        enemyPos = CGPointMake( enemyPos.x + multResult.x, enemyPos.y + multResult.y );
        [self setPosition:enemyPos];
    }
}

-(void)onEnter {
    [super onEnter];
    // 스케쥴러 호출
    [self scheduleUpdate];
}
@end
