//
//  Enemy.h
//  DragonFlight
//
//  Created by Jehyeok on 11/30/13.
//  Copyright (c) 2013 com.appcoda. All rights reserved.
//

#import "CCSprite.h"
#import "CCDirector.h"

#define ENEMY_ENERGY 100

typedef enum {
    dead = 0,
    alive = 1
} State;

@interface Enemy : CCSprite

// 적 상태 (dead or alive)
@property (nonatomic) State state;
// 에너지
@property (nonatomic) NSInteger energy;

-(void)reset;
-(NSInteger)attackedWithPoint:(NSInteger)point;

@end

