//
//  AGSTiledExtendLayer.h
//  AGSTiledMapExtend
//
//  Created by gisxy on 14-3-12.
//  Copyright (c) 2014年 esrixa. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <ArcGIS/ArcGIS.h>

@interface AGSTiledExtendLayer : AGSTiledLayer{
    AGSTileInfo* _tileInfo;
	AGSEnvelope* _fullEnvelope;
	NSString* _mapSource;
    NSString* _mapType;
}

-(id)initWithAGSTiledExtendMapSchema:(NSString*)mapSource MapType:(NSString*)mapType;

@property (nonatomic,retain) NSString* mapSource;
@property (nonatomic,retain) NSString* mapType;

@end
