// Copyright 2010 ESRI
//
// All rights reserved under the copyright laws of the United States
// and applicable international laws, treaties, and conventions.
//
// You may freely redistribute and use this sample code, with or
// without modification, provided you include the original copyright
// notice and use restrictions.
//
// See the use restrictions at http://help.arcgis.com/en/sdk/10.0/usageRestrictions.htm
//

#import "MapViewDemoViewController.h"
#import "AGSTiledExtendLayer.h"


@implementation MapViewDemoViewController

@synthesize mapView = _mapView;
@synthesize switchMapControl=_switchMapControl;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// set the delegate for the map view
	self.mapView.layerDelegate = self;
	
	AGSTiledExtendLayer *base_vector=[[AGSTiledExtendLayer alloc]initWithAGSTiledExtendMapSchema:@"Google" MapType:@"Vector"];
	
	//Add it to the map view
	[self.mapView addMapLayer:base_vector withName:@"baselayer"];
    
}
- (IBAction)controlChanged:(id)sender
{
    NSLog(@"index is %d",self.switchMapControl.selectedSegmentIndex);
    

    for(AGSLayer * layer in self.mapView.mapLayers)
    {
        [self.mapView removeMapLayer:layer];
    }
    
    switch(self.switchMapControl.selectedSegmentIndex){
       
        case 0:{
             AGSTiledExtendLayer* GoogleMap_Vector=[[AGSTiledExtendLayer alloc]initWithAGSTiledExtendMapSchema:@"Google" MapType:@"Vector"];
            
            [self.mapView addMapLayer:GoogleMap_Vector withName:@"Google_Vector"];
            break;
        }
        case 1:{
            
             AGSTiledExtendLayer* GoogleMap_Image=[[AGSTiledExtendLayer alloc]initWithAGSTiledExtendMapSchema:@"Google" MapType:@"Image"];
            
            [self.mapView addMapLayer:GoogleMap_Image withName:@"Google_Image"];
            break;
        }
        case 2:{
            
            AGSTiledExtendLayer* AbcMap_Vector=[[AGSTiledExtendLayer alloc]initWithAGSTiledExtendMapSchema:@"Baidu" MapType:@"Vector"];
            
            [self.mapView addMapLayer:AbcMap_Vector withName:@"Abc_Vector"];
            break;
        }
        case 3:{
            
            AGSTiledExtendLayer* AbcMap_Image=[[AGSTiledExtendLayer alloc]initWithAGSTiledExtendMapSchema:@"Baidu" MapType:@"Image"];
            
            [self.mapView addMapLayer:AbcMap_Image withName:@"Abc_Image"];
            break;
        }
            
    }
    

}
    

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    self.mapView = nil;
}


- (void)dealloc {
	
}


#pragma mark AGSMapViewLayerDelegate methods

-(void) mapViewDidLoad:(AGSMapView*)mapView {

	// comment to disable the GPS on start up
	[self.mapView.locationDisplay startDataSource];
    self.mapView.locationDisplay.autoPanMode = AGSLocationDisplayAutoPanModeDefault;
}

@end
