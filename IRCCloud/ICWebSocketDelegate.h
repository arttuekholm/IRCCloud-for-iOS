//
//  ICWebSocketDelegate.h
//  IRCCloud
//
//  Created by Adam D on 2/10/12.
//  Copyright (c) 2012 HASHBANG Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../UnittWebSocketClient/WebSocket.h"

@interface ICWebSocketDelegate : NSObject <WebSocketDelegate> {
	WebSocket *webSocket;
}

-(void)open;
-(void)close;

@end
