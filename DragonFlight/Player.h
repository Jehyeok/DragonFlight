//
//  Player.h
//  DragonFlight
//
//  Created by Jehyeok on 11/29/13.
//  Copyright (c) 2013 com.appcoda. All rights reserved.
//

#import "CCSprite.h"
#import "CCDirector.h"
#import "cocos2d.h"

@interface Player : CCSprite {
    BOOL wingDown;
}

@property (nonatomic, strong) CCSprite *leftWing;
@property (nonatomic, strong) CCSprite *rightWing;

@end

