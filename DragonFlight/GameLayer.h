//
//  GameLayer.h
//  DragonFlight
//
//  Created by Jehyeok on 11/29/13.
//  Copyright (c) 2013 com.appcoda. All rights reserved.
//


#import "CCLayer.h"
#import "HUDLayer.h"
#import "CCSprite.h"
#import "Player.h"
#import "Enemy.h"
#import "Bullet.h"
#import "CCDirector.h"
#import "CCTouchDispatcher.h"
#import "ccDeprecated.h"
#import "CCSpriteBatchNode.h"
#import "MenuLayer.h"

#define BULLET_NUM 10
#define MONSTER_NUM 5

@interface GameLayer : CCLayer {
    // 화면 싸이즈 저장 변수
    CGSize winSize;
    // 움직이기 바로 전 플레이어 위치
    CGPoint prePoint;
    CCArray *enemies;
    CCArray *bullets;
    // 마지막 총알 체크
    int lastBullet;
    BOOL isCollision;
    // 점수
    int score;
}
@property (nonatomic, strong) CCSprite *backgroundImage1;
@property (nonatomic, strong) CCSprite *backgroundImage2;
@property (nonatomic, strong) Player *player;
@property (nonatomic, strong) CCSpriteBatchNode *batchNode;
@property (nonatomic, strong) HUDLayer *hudLayer;

@end
