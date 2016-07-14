//
//  MyAnnotation.swift
//  SixthSwiftOfLocation
//
//  Created by apple on 16/7/13.
//  Copyright © 2016年 FZH. All rights reserved.
//

import UIKit
import MapKit
class MyAnnotation: NSObject,MKAnnotation {

	
	var coordinate = CLLocationCoordinate2D();
	var name = String();
	var title:String?;
	var type = NSNumber();
	
	override init() {
		print("ssssss");
		super.init();
	}
	
	func initAnnotationModelWithDict(dict:NSDictionary) -> MyAnnotation {

		dict["coordinate"]!["longitude"]
		self.coordinate = CLLocationCoordinate2DMake(  ((dict["coordinate"]!["longitude"]) as!NSNumber).doubleValue,(dict["coordinate"]!["longitude"] as!NSNumber).doubleValue);
		
		self.title = dict["detail"] as?String;
		
		self.name = (dict["name"] as?String)!;
		
		self.type = dict["type"]!as!NSNumber;
		return self;
		
	}
}
