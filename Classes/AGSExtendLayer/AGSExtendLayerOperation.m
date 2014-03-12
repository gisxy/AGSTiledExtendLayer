//
//  AGSExtendLayerOperation.m
//  AGSTiledMapExtend
//
//  Created by gisxy on 14-3-12.
//  Copyright (c) 2014年 esrixa. All rights reserved.
//

#import "AGSExtendLayerOperation.h"

int tn(int n)//计算2的n次方
{
	int num = 1;
	int i = 0;
	for (i=0; i<n; i++) {
		num = num *2;
	}
	return num;
}

@implementation AGSExtendLayerOperation

@synthesize tileKey=_tileKey;
@synthesize target=_target;
@synthesize action=_action;
@synthesize imageData=_imageData;
@synthesize mapSource=_mapSource;
@synthesize mapType=_mapType;

- (id)initWithTile:(AGSTileKey *)tile MapSource:(NSString*)mapSorce MapType:(NSString*)mapType target:(id)target action:(SEL)action; {
	
	if (self = [super init]) {
		self.target = target;
		self.action = action;
		self.tileKey = tile;
        self.mapSource=mapSorce;
        self.mapType=mapType;
		
	}
	return self;
}

//使用宏方式解决在ARC项目中使用performSelector的警告信息
//warning:performSelector may cause a leak because its selector is unknown
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//#pragma clang diagnostic pop
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

-(void)main {
	//Fetch the tile for the requested Level, Row, Column
	@try {
		      
        NSString *s=@"Galileo";
        s=[s substringWithRange:NSMakeRange(0,((3 * self.tileKey.column + self.tileKey.row) % 8))];
        NSString *baseUrl =@"";
        
        if ([self.mapType isEqualToString:@"Vector"] && [self.mapSource isEqualToString:@"Google"])
        {
            baseUrl = [NSString stringWithFormat:@"http://mt%d.google.com/vt/lyrs=m@158000000&hl=zh-CN&gl=cn&x=%d&y=%d&z=%d&s=%@",(self.tileKey.column)%4,self.tileKey.column,self.tileKey.row,self.tileKey.level,s];
        }
        else if ([self.mapType isEqualToString:@"Image"] && [self.mapSource isEqualToString:@"Google"])
        {
            baseUrl = [NSString stringWithFormat:@"http://mt%d.google.com/vt/lyrs=s&hl=en&gl=en&x=%d&y=%d&z=%d&s=%@",(self.tileKey.column)%4,self.tileKey.column,self.tileKey.row,self.tileKey.level,s];
        }
        else if ([self.mapType isEqualToString:@"Vector"] && [self.mapSource isEqualToString:@"Baidu"])
        {
            baseUrl = [NSString stringWithFormat:@"http://emap%d.mapabc.com/mapabc/maptile?v=w2.61&&x=%d&y=%d&z=%d",(self.tileKey.column)%4,self.tileKey.column,self.tileKey.row,self.tileKey.level];
        }
        else if ([self.mapType isEqualToString:@"Image"] && [self.mapSource isEqualToString:@"Baidu"])
        {
            baseUrl = [NSString stringWithFormat:@"http://webst04.is.autonavi.com/appmaptile?lang=zh_cn&size=1&scale=1&style=6&x=%d&y=%d&z=%d",self.tileKey.column,self.tileKey.row,self.tileKey.level];
        }
        else{
            baseUrl = [NSString stringWithFormat:@"http://emap%d.mapabc.com/mapabc/maptile?v=w2.61&&x=%d&y=%d&z=%d",(self.tileKey.column)%4,self.tileKey.column,self.tileKey.row,self.tileKey.level];
        }
		
        if (self.tileKey.row >=tn(self.tileKey.level)) {
			NSLog(@"11");
			return;
		}
		NSURL* aURL = [NSURL URLWithString:baseUrl];
		NSData* data = [[NSData alloc] initWithContentsOfURL:aURL];
        
		self.imageData = data;
		NSLog(@"baseURL:%@",baseUrl);
		
	}
	@catch (NSException *exception) {
		NSLog(@"main: Caught Exception %@: %@", [exception name], [exception reason]);
	}
	@finally {
		//Invoke the layer's action method
		if(!self.isCancelled)
            [self.target performSelector:self.action withObject:self];
	}
}
#pragma clang diagnostic pop

@end
