//
//  ViewController.swift
//  MapOnFly
//
//  Created by Павел Анплеенко on 12/09/16.
//  Copyright © 2016 Pavel Anpleenko. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
	
	//позволяет менять координаты
	var geokoder: CLGeocoder!
	
	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var mapField: MKMapView!
	

	override func viewDidLoad() {
		super.viewDidLoad()
		geokoder = CLGeocoder()
		//указываем какой объект для наблюдения мы добавляем UIControlEvents.EditingChanged
		//и следим если изменения происходят то отправляем в self
		textField.addTarget(self, action: "textFieldChanged", forControlEvents: UIControlEvents.EditingChanged)
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	//метод для изменения
	func textFieldChanged(){
		
		geokoder.geocodeAddressString((textField.text!)) { (placemarks, error) -> Void in
			if error != nil{
				print("MapKit error \(error?.description)")
			}
			
			if placemarks != nil {
				if let placemark = placemarks?.first{
					
					let annotation = MKPointAnnotation()
					annotation.title = "Просмотр места"
					annotation.subtitle = self.textField.text
					annotation.coordinate = (placemark.location?.coordinate)!
					
					self.mapField.showAnnotations([annotation], animated: true)
					//self.mapField.selectedAnnotations(annotation, animated: true)
				}
			}
			
		}
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

