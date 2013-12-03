//
//  GameScene.h
//  DragonFlight
//
//  Created by Jehyeok on 11/29/13.
//  Copyright (c) 2013 com.appcoda. All rights reserved.
//

#import "CCScene.h"
#import "GameLayer.h"
#import "HUDLayer.h"

@interface GameScene : CCScene 

@property (nonatomic, strong) GameLayer *gameLayer;
@property (nonatomic, strong) HUDLayer *hudLayer;

@end
