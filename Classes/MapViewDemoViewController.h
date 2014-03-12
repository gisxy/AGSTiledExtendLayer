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

#import <UIKit/UIKit.h>
#import <ArcGIS/ArcGIS.h>

//Set up constant for predefined where clause for search
#define kLayerDefinitionFormat @"STATE_NAME = '%@'"


@interface MapViewDemoViewController : UIViewController <AGSMapViewLayerDelegate> {
	
	//container for map layers
	AGSMapView *_mapView;
	
	//this map has a dynamic layer, need a view to act as a container for it
	AGSDynamicMapServiceLayer * _dynamicLayer;
}

//map view is an outlet so we can associate it with UIView
//in IB
@property (nonatomic, strong) IBOutlet AGSMapView *mapView;
@property (nonatomic, strong) IBOutlet UISegmentedControl *switchMapControl;

- (IBAction)controlChanged:(id)sender;

@end

