//
//  GameLayer.h
//  DragonFlight
//
//  Created by Jehyeok on 11/29/13.
//  Copyright (c) 2013 com.appcoda. All rights reserved.
//

#import "CCLayer.h"
#import "CCSprite.h"
#import "Player.h"

@interface GameLayer : CCLayer {
    // 화면 싸이즈 저장 변수
    CGSize winSize;
}
@property (nonatomic, strong) CCSprite *backgroundImage1;
@property (nonatomic, strong) CCSprite *backgroundImage2;
@property (nonatomic, strong) Player *player;
@end
