//
//  AGSTiledExtendSchema.h
//  AGSTiledMapExtend
//
//  Created by gisxy on 14-3-12.
//  Copyright (c) 2014年 esrixa. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AGSPoint;
@class AGSLOD;
@class AGSSpatialReference;
@class AGSTileInfo;
@class AGSEnvelope;

@interface AGSTiledExtendSchema : NSObject{
    
    AGSSpatialReference* spatialReference;
	AGSEnvelope* fullEnvelope;
	AGSTileInfo* tileInfo;
    NSString* _mapSource;

}

@property (nonatomic,retain,readwrite) AGSSpatialReference* spatialReference;
@property (nonatomic,retain,readwrite) AGSEnvelope* fullEnvelope;
@property (nonatomic,retain,readwrite) AGSTileInfo* tileInfo;

@property (nonatomic,retain) NSString* mapSource;


-(id)initWithMapSource:(NSString*)mapSource;

@end
