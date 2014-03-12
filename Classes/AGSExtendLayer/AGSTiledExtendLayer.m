//
//  AGSTiledExtendLayer.m
//  AGSTiledMapExtend
//
//  Created by gisxy on 14-3-12.
//  Copyright (c) 2014年 esrixa. All rights reserved.
//

#import "AGSTiledExtendLayer.h"
#import "AGSTiledExtendSchema.h"
#import "AGSExtendLayerOperation.h"

@implementation AGSTiledExtendLayer

@synthesize mapSource=_mapSource;
@synthesize mapType=_mapType;

-(AGSSpatialReference *)spatialReference{
	return _fullEnvelope.spatialReference;
}

-(AGSEnvelope *)fullEnvelope{
	return _fullEnvelope;
}

-(AGSEnvelope *)initialEnvelope{
	//Assuming our initial extent is the same as the full extent
	return _fullEnvelope;
}

-(AGSTileInfo*) tileInfo{
	return _tileInfo;
}

-(id)initWithAGSTiledExtendMapSchema:(NSString*)mapSource MapType:(NSString*)mapType
{
    self.mapSource=mapSource;
    self.mapType=mapType;
    
    if (self=[super init])
    {
        AGSTiledExtendSchema * shema = [[AGSTiledExtendSchema alloc] initWithMapSource:mapSource];
        _tileInfo = shema.tileInfo;
                //NSLog([NSString stringWithFormat:@"l=%d",[_tileInfo.lods count]]);
        _fullEnvelope = shema.fullEnvelope;
        
    }
        
        [super layerDidLoad];
	
	return self;
	
}
- (void)didFinishOperation:(AGSExtendLayerOperation*)op {
	//... pass the tile's data to the super class
    [super setTileData: op.imageData  forKey:op.tileKey];
}

#pragma AGSTiledLayer (ForSubclassEyesOnly)
- (void)requestTileForKey:(AGSTileKey *)key{
    //Create an operation to fetch tile from local cache
	AGSExtendLayerOperation *operation =
	[[AGSExtendLayerOperation alloc] initWithTile:key
                                       MapSource:self.mapSource
                                         MapType:self.mapType
                                          target:self
                                          action:@selector(didFinishOperation:)];
	//Add the operation to the queue for execution
    [[AGSRequestOperation sharedOperationQueue] addOperation:operation];
    
    //[super.operationQueue addOperation:operation];
	NSLog(@"%@",[NSString stringWithFormat:@"x=%d y=%d z=%d",key.row,key.column,key.level]);
    
}

- (void)cancelRequestForKey:(AGSTileKey *)key{
    //Find the OfflineTileOperation object for this key and cancel it
    for(NSOperation* op in [AGSRequestOperation sharedOperationQueue].operations){
        if( [op isKindOfClass:[AGSExtendLayerOperation class]]){
            AGSExtendLayerOperation* offOp = (AGSExtendLayerOperation*)op;
            if([offOp.tileKey isEqualToTileKey:key]){
                [offOp cancel];
            }
        }
    }
}

@end
