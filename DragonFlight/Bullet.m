//
//  Bullet.m
//  DragonFlight
//
//  Created by Jehyeok on 12/1/13.
//  Copyright (c) 2013 com.appcoda. All rights reserved.
//

#import "Bullet.h"

#import "CCDirector.h"

@implementation Bullet

-(id)init {
    self = [super initWithFile:@"bullet.png"];
    if (self) {
        _bulletType = damage;
    }
    return self;
}

-(void)updateBullet:(ccTime)dt {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    // 총알 움직임 속도
    CGPoint bulletVel = CGPointMake( 0, 300);
    // 총알의 현재 위치
    CGPoint currentPos = self.position;
    // 화면 밖으로 넘어가면 총알 숨김
    if (currentPos.y > winSize.height) {
        self.visible = NO;
    } else {
        // 총알 움직임
        CGPoint multResult = CGPointMake( bulletVel.x * dt, bulletVel.y * dt );
        self.position = CGPointMake( self.position.x + multResult.x, self.position.y + multResult.y );
    }
}

-(void)onEnter {
    [super onEnter];
    // 스케쥴로 호출
    [self schedule:@selector(updateBullet:) interval:0.05];
}

@end
