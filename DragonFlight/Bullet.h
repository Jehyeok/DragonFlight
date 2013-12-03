//
//  Bullet.h
//  DragonFlight
//
//  Created by Jehyeok on 12/1/13.
//  Copyright (c) 2013 com.appcoda. All rights reserved.
//

#import "CCSprite.h"
#import "CCDirector.h"

typedef enum {
    damage = 20
} BulletType;

@interface Bullet : CCSprite

@property (nonatomic, readwrite) BulletType bulletType;

@end

