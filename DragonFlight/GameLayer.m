//
//  GameLayer.m
//  DragonFlight
//
//  Created by Jehyeok on 11/29/13.
//  Copyright (c) 2013 com.appcoda. All rights reserved.
//

#import "GameLayer.h"

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
        // 적 초기화
        [self initEnemies];
        lastBullet = 0;
        
        [self initBullets];
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

-(void) initEnemies {
    // 적을 배열에 저장
    enemies = [[CCArray alloc] initWithCapacity:MONSTER_NUM];
    // 화면 나눔
    float width = winSize.width / MONSTER_NUM;
    // 적 나타냄
    for ( int i = 0; i < MONSTER_NUM; i++) {
        Enemy *enemy = [Enemy node];
        [self addChild:enemy z:98];
        enemy.position = CGPointMake( i * width + width/2, winSize.height + enemy.boundingBox.size.height/2);
        [enemies addObject:enemy];
    }
}

-(void)initBullets {
    // 총알 갯수만큼 배열 만듦
    bullets = [[CCArray alloc] initWithCapacity:BULLET_NUM];
    // 총알 갯수만큼 초기화
    for (int i = 0; i < BULLET_NUM; i++) {
        // 총알 노드 생성
        Bullet *bullet = [Bullet node];
        // 초기상태는 안보임
        bullet.visible = NO;
        // 배치 노드에 넣음
        [self addChild:bullet z:101];
        [bullets addObject:bullet];
    }
}

-(void)updateBackground:(ccTime)dt {
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
-(void)updateCollision:(ccTime)dt {
    // 플레이어, 적, 총알 충돌 처리
    for (Enemy *enemy in enemies) {
        // 적이 죽은 상태면 패스
        if (!enemy.state) continue;
        
        for (Bullet *bullet in bullets) {
            // 총알이 보이지 않으면 패스
            if (!bullet.visible) continue;
            
            // 총알과 적 충돌 체크
            if (!isCollision && CGRectIntersectsRect(bullet.boundingBox, enemy.boundingBox)) {
                bullet.visible = NO;
                
                if (![enemy attackedWithPoint:[bullet bulletType]]) {
                    
                }
            }
        }
        
        if (!isCollision && CGRectIntersectsRect(enemy.boundingBox, _player.boundingBox)) {
            isCollision = YES;
            if (isCollision) {
                _player.visible = NO;
                // 죽으면 총알 다 삭제
                [self unschedule:@selector(updateBullet:)];
                for (Bullet *bullet in bullets) {
                    bullet.visible = NO;
                    [bullet removeFromParentAndCleanup:YES];
                }
                
                CCCallBlock *allStop = [CCCallBlock actionWithBlock:^{
                    // 터치 이벤트 스탑
                    self.touchEnabled = NO;
                }];
                // 딜레이를 위한 액션
                CCDelayTime *delay = [CCDelayTime actionWithDuration:2.0f];
                // 메뉴로 나가기 위한 액션
                CCCallBlock *block = [CCCallBlock actionWithBlock:^{
                    [[CCDirector sharedDirector] replaceScene:[MenuLayer scene]];
                }];
                // 액션 준비
                CCSequence *seq = [CCSequence actions:allStop, delay, block, nil];
                // 액션 실행
                [self runAction:seq];
            }
        }
    }
}

-(void)updateBullet:(ccTime)dt {
    // 배열에서 총알 하나씩 꺼냄
    Bullet *bullet = (Bullet*)[bullets objectAtIndex:lastBullet];
    // 꺼내서 보이게 설정
    bullet.visible = YES;
    bullet.position = CGPointMake( _player.position.x, _player.position.y + _player.boundingBox.size.height/2);
    // 마지막 총알이 배열의 마지막이면 다시 초기화
    if (++lastBullet == BULLET_NUM) {
        lastBullet = 0;
    }
}

-(void)updateScore:(ccTime)dt {
    [_hudLayer setScoreText:score++];
}

-(void)onEnter {
    [super onEnter];
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    [self schedule:@selector(updateCollision:)];
    [self schedule:@selector(updateBackground:)];
    [self schedule:@selector(updateBullet:) interval:0.15f];
    [self schedule:@selector(updateScore:) interval:0.01f];
}

#pragma mark Touch

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    // 바로 전 좌표 값과 비교 위해 저장. UI좌표계를 cocos 좌표계로 변환
    prePoint = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    return YES;
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
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    
}
@end
