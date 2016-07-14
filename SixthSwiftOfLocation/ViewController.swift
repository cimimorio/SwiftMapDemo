//
//  ViewController.swift
//  SixthSwiftOfLocation
//
//  Created by 冯志浩 on 16/6/22.
//  Copyright © 2016年 FZH. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class ViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

    let locationLabel = UILabel()
    var locationButton = UIButton()
    let locationManager:CLLocationManager = CLLocationManager()
    let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
    let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height
	var mapView = MKMapView();
	var theSpan = MKCoordinateSpan();
	var theRegion = MKCoordinateRegion();
	
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBackgroundImageView()
        self.setupLabelAndButton()
    }
    //创建背景图
    func setupBackgroundImageView(){
        let bgImageView = UIImageView(image: UIImage(named: "bg"))
        bgImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        self.view.addSubview(bgImageView)
    }
    
    //创建label和button mapView
    func setupLabelAndButton() {
		
		
		
		//1.mapView
		mapView = MKMapView.init(frame: UIScreen.mainScreen().bounds);
		mapView.showsUserLocation = true;
		mapView.delegate = self;
		self.view.addSubview(mapView);
		
        //2.label
        locationLabel.frame = CGRectMake(20, 64, SCREEN_WIDTH - 40, 50)
        locationLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(locationLabel)
        
        //3.button
        locationButton = UIButton.init(type: .Custom)
        locationButton.frame = CGRectMake(20, SCREEN_HEIGHT * 0.7, SCREEN_WIDTH - 40, 50);
        locationButton.addTarget(self, action: #selector(ViewController.myLocationButtonDidTouch), forControlEvents: .TouchUpInside)
        locationButton.setTitle("find my location", forState: .Normal)
        locationButton.backgroundColor = UIColor.blackColor()
        self.view.addSubview(locationButton)
		
		
		
		
    }
    //按钮的点击方法
    func myLocationButtonDidTouch() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
		
        //判断是否允许
        if (CLLocationManager.locationServicesEnabled())
        {
            //允许使用定位服务的话，开启定位服务更新
            locationManager.startUpdatingLocation()
			theSpan.latitudeDelta=0.05;
			theSpan.longitudeDelta=0.05;
			//		theRegion.center= [[locationManager location] coordinate];
			theRegion.center = (locationManager.location?.coordinate)!;
			theRegion.span=theSpan;
			mapView.setRegion(theRegion, animated: true);
			loadData((locationManager.location?.coordinate)!);
            print("定位开始")
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        locationLabel.text = "Error while updating location " + error.localizedDescription
    }
	
	func loadData(coordinate:CLLocationCoordinate2D){
		let filePath = NSBundle.mainBundle().pathForResource("PinData", ofType: "plist");
		let arr = NSArray.init(contentsOfFile: filePath!);
		let dic = arr?.firstObject?.mutableCopy();
		let tempDic = NSMutableDictionary.init(object: coordinate.latitude, forKey: "latitude");
//		tempDic.setValue(coordinate.longitude, forKeyPath: "longitude");
		
		tempDic.setObject(coordinate.longitude, forKey: "longitude");
		
		
		
		dic!.setObject(tempDic, forKey: "coordinate");
		print(dic, tempDic);
		let anno = MyAnnotation().initAnnotationModelWithDict(dic! as! NSDictionary);
		print(anno);
		mapView.addAnnotation(anno);
		
	}
//mapViewDelegate

	
	
	func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {

		print("aaaaa\(annotation)");
		let	annoView = CustomAnnotationView.init(annotation: annotation, reuseIdentifier: "otherAnnotationView");
		annoView.image = UIImage.init(named: "user") ;
		annoView.label.text = "ME";
		return annoView;
		
	}
	
	
	func mapView(mapView: MKMapView, didAddAnnotationViews views: [MKAnnotationView]) {
//		let visibleRect = mapView.visibleMapRect as!CGRect;
//		for annoView in views {
//			let endFrame = annoView.frame;
//			var startFrame = endFrame;
//			startFrame.origin.y = visibleRect.origin.y - startFrame.size.height;
//			annoView.frame = startFrame;
//			UIView.beginAnimations("drop", context: nil)
////			[UIView beginAnimations:"drop" context:NULL];
////			[UIView setAnimationDuration:1];
//			UIView.setAnimationDuration(1);
//			UIView.commitAnimations();
////			view.frame = endFrame;
////			[UIView commitAnimations];
//
//		}
	}
	
   func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //地理反编码
        CLGeocoder().reverseGeocodeLocation(manager.location!,completionHandler: { (placemarks, error) ->Void in
            if(error != nil){
                self.locationLabel.text = "Reverse geocoder failed with error" + error!.localizedDescription
                return
            }
            if placemarks!.count > 0{
                let pm = placemarks![0]
                self.displayLocationInfo(pm)
                
            }else{
                self.locationLabel.text = "Problem with the data received from geocoder"
            }
        })
    }
    //解析位置
    func displayLocationInfo(placemark: CLPlacemark?) {
        
        if let containsPlacemark = placemark {
            locationManager.stopUpdatingLocation()
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
            let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
            
            self.locationLabel.text = locality! +  postalCode! +  administrativeArea! +  country!
        }

    }
    

}

