//
//  CustomAnnotationView.swift
//  SixthSwiftOfLocation
//
//  Created by apple on 16/7/13.
//  Copyright © 2016年 FZH. All rights reserved.
//
/*
- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{

if ([super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
//在大头针旁边加一个label
self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, -15, 50, 20)];
self.label.textColor = [UIColor grayColor];
self.label.textAlignment = NSTextAlignmentCenter;
self.label.font = [UIFont systemFontOfSize:10];
[self addSubview:self.label];


}

return self;
}
*/
import UIKit
import MapKit
class CustomAnnotationView: MKAnnotationView {

	var label = UILabel();
	
	override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
		print(annotation);
		super.init(annotation: annotation, reuseIdentifier: reuseIdentifier);
		
		label = UILabel.init(frame: CGRectMake(0, -15, 50, 20));
		label.textColor = UIColor.grayColor();
		label.textAlignment = NSTextAlignment.Center;
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame);
	}
	
	func setView(annotaion:MKAnnotation!, reuseIdentifier:String!) -> CustomAnnotationView {
		label = UILabel.init(frame: CGRectMake(0, -15, 50, 20));
		label.textColor = UIColor.grayColor();
		label.textAlignment = NSTextAlignment.Center;
//		label.font = UIFont.systemFontSize();
		return self;
	}
	
	
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
