//
//  AGSExtendLayerOperation.h
//  AGSTiledMapExtend
//
//  Created by gisxy on 14-3-12.
//  Copyright (c) 2014年 esrixa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ArcGIS/ArcGIS.h>

@interface AGSExtendLayerOperation : NSOperation{

@private
    id _target;
    SEL _action;
    AGSTileKey* _tile;
    NSString* _mapSource;
    NSString* _mapType;
}

- (id)initWithTile:(AGSTileKey *)tile MapSource:(NSString*)mapSorce MapType:(NSString*)mapType target:(id)target action:(SEL)action;


@property (nonatomic,retain) AGSTileKey *tileKey;
@property (nonatomic,retain) id target;
@property (nonatomic,assign) SEL action;

@property (nonatomic,strong) NSData* imageData;

@property (nonatomic,retain) NSString* mapSource;
@property (nonatomic,retain) NSString* mapType;

@end
