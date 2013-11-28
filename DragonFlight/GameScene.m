//
//  GameScene.m
//  DragonFlight
//
//  Created by Jehyeok on 11/29/13.
//  Copyright (c) 2013 com.appcoda. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene
-(id)init {
    self = [super init];
    if (self) {
        // HUD Layer 추가
        _hudLayer = [HUDLayer node];
        [self addChild:_hudLayer z:1];
        
        // Game Layer 추가
        _gameLayer = [GameLayer node];
        [self addChild:_gameLayer z:0];
    }
    return self;
}
@end
