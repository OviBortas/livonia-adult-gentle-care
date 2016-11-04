//
//  ContactVC.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 9/17/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit
import MapKit

class ContactVC: UIViewController, CLLocationManagerDelegate {
   
   @IBOutlet var textViews: [UITextView]!
   @IBOutlet var textLabels: [UILabel]!
   @IBOutlet var socialIcons: [UIImageView]!
   @IBOutlet weak var mapView: MKMapView!
   @IBOutlet weak var lagcButton: UIButton!
   @IBOutlet weak var mapLocationSegment: UISegmentedControl!
   
   
   var corLocationManager = CLLocationManager()
   
   var lagcLocation: CLLocation?
   
   var userLocation: CLLocation {
      return CLLocation(latitude: (corLocationManager.location?.coordinate.latitude)!, longitude: (corLocationManager.location?.coordinate.longitude)!)
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      setupUI()
      askForMapPermission()
   }
   
   
   func setupUI() {
      fixLayoutForSmallerScreen()
      
      socialIcons.forEach { icon in
         icon.layer.cornerRadius = 4
         icon.clipsToBounds = true
      }
      
      lagcButton.layer.cornerRadius = 5.0
      mapLocationSegment.layer.cornerRadius = 5.0
      
      let font = UIFont(name: "AvenirNext-Regular", size: 15.0)
      mapLocationSegment.setTitleTextAttributes([NSFontAttributeName: font!], for: UIControlState())
   }
   
   func askForMapPermission() {
      corLocationManager.delegate = self
      
      // location service not yet confirmed or not allowed
      if CLLocationManager.authorizationStatus() == .notDetermined  {
         print("notDetermined")
         // check to see if plist description is set
         if let _ = Bundle.main.object(forInfoDictionaryKey: "NSLocationWhenInUseUsageDescription") {
            corLocationManager.requestWhenInUseAuthorization()
         }
         else {
            print("Did not specify description")
         }
      }
      else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
         lagcButton.isHidden = true
         showLocation(for: Location(rawValue: mapLocationSegment.selectedSegmentIndex)!)
         print("authorizedWhenInUse")
      }
      else {
         handleLagcButtonTapped(lagcButton)
         print("else")
      }
      
      setLAGCLocation()
      
      switch CLLocationManager.authorizationStatus() {
      case .notDetermined:
         break
      case .denied:
         mapLocationSegment.isHidden = true
         lagcButton.isHidden = false
      case .authorizedWhenInUse:
         lagcButton.isHidden = true
         mapLocationSegment.isHidden = false
         mapView.showsUserLocation = true
      default:
         break
      }

   }
   
   func setLAGCLocation() {
      let lagcAddress = Address().completeAddress()
      
      self.geocodeAddressString(address: lagcAddress) { (geocodeInfo, placemark, error) in
         
         if let geocodeInfo = geocodeInfo {
            let lat = geocodeInfo["latitude"]!
            let long = geocodeInfo["longitude"]!
            
            let location = CLLocation(latitude: Double(lat)!, longitude: Double(long)!)
            self.showLagcWithAnotation(location)
            self.lagcLocation = location
         }
         else {
            print(error!)
            self.lagcLocation = nil
         }
      }
   }
   
   // MARK: - Map display methods
   func showLagcWithAnotation(_ location: CLLocation) {
      
      //create pin and coord
      let annotation = MKPointAnnotation()
      annotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
      annotation.title = "Livonia Adult Gentle Care"
      
      // makeing sure to not add the same anotioation again
      if mapView.annotations.count >= 2 {
         displayLocation(location, withSpan: MKCoordinateSpanMake(0.05, 0.05))
         return
      }
      
      mapView.addAnnotation(annotation)
      mapView.showAnnotations(mapView.annotations, animated: false)
      mapView.selectAnnotation(mapView.annotations[0], animated: true)
      
      displayLocation(location, withSpan: MKCoordinateSpanMake(0.05, 0.05))
   }
   
   func displayLocation(_ location: CLLocation, withSpan span: MKCoordinateSpan) {
      // create region to display
      let region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude),  span)
      
      // set mapview region to display
      mapView.setRegion(region, animated: true)
   }
   
   
   @IBAction func handleLagcButtonTapped(_ sender: UIButton) {
      showLocation(for: .lagc)
   }
   
   @IBAction func handleMapLocationSegmentTapped(_ sender: UISegmentedControl) {
      showLocation(for: Location(rawValue: sender.selectedSegmentIndex)!)
   }
   
   // MARK: - Social
   
   struct SocialScheme {
      
      var profileId:String
      var appURLScheme:String
      var webURLScheme:String
   }
   
   @IBAction func facebookTap(_ sender: UITapGestureRecognizer) {
      let facebookScheme = SocialScheme(profileId: "560867137439418", appURLScheme: "fb://profile/", webURLScheme: "https://facebook.com/")
      openApp(forScheme: facebookScheme)
   }
   
   @IBAction func linkedInTap(_ sender: UITapGestureRecognizer) {
      let linkedInScheme = SocialScheme(profileId: "", appURLScheme: "linkedin://company/", webURLScheme: "https://www.linkedin.com")
      openApp(forScheme: linkedInScheme)
      
   }
   @IBAction func twitterTap(_ sender: UITapGestureRecognizer) {
      let twitterScheme = SocialScheme(profileId: "", appURLScheme: "twitter://user?screen_name=", webURLScheme: "https://twitter.com/")
      openApp(forScheme: twitterScheme)
   }
   
   func openApp(forScheme scheme:SocialScheme) {
      
      if let appURL = URL(string: scheme.appURLScheme + scheme.profileId) {
         let isInstalled = UIApplication.shared.canOpenURL(appURL)
         
         if isInstalled {
            UIApplication.shared.openURL(appURL)
         }
         else {
            
            if let webURL = URL(string: scheme.webURLScheme + scheme.profileId) {
               UIApplication.shared.openURL(webURL)
            }
            else {
               print("Web URL is not valid")
            }
         }
      }
      else {
         print("App URL is not valid")
      }
   }
   
   // MARK: - CLLocationManagerDelegate
   // Changes which item to display at the botton based on the permission given
   func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
      print("Did change")
      switch status {
      case .notDetermined:
         break
      case .denied:
         mapLocationSegment.isHidden = true
         lagcButton.isHidden = false
      case .authorizedWhenInUse:
         lagcButton.isHidden = true
         mapLocationSegment.isHidden = false
         mapView.showsUserLocation = true
      default:
         break
      }
   }

   /*
    Adjust constraint to be closer to the leading margin for smaller screens else the
    objects on screen will be too close to the leading edge.
    */
   func fixLayoutForSmallerScreen() {
      // Is iPhone 5 or lower
      if UIScreen.main.bounds.width <= 320.0 {
         for constraint in view.constraints where constraint.identifier == "PhoneLeadingAnchor" {
            constraint.constant = 20.0
         }
      }
   }
}

// MARK: - Map Helpers
extension ContactVC {
   
   fileprivate enum Location: Int {
      case lagc, me, both
   }
   
   fileprivate func showLocation(for locationItem: Location) {
      switch locationItem {
      case .lagc:
         if let lagcLocation = lagcLocation {
            showLagcWithAnotation(lagcLocation)
         }
      case .me:
         displayLocation(userLocation, withSpan: MKCoordinateSpanMake(0.05, 0.05))
      case .both:
         mapView.showAnnotations(mapView.annotations, animated: true)
      }
   }
   
   typealias LMGeocodeCompletionHandler = ((_ gecodeInfo: [String: String]?, _ placemark: CLPlacemark?, _ error: String?) -> Void)?
   
   fileprivate func geocodeAddressString(address: String, onGeocodingCompletionHandler: LMGeocodeCompletionHandler) {
      
      let geocoder = CLGeocoder()
      
      geocoder.geocodeAddressString(address) { (placemarks: [CLPlacemark]?, error: Error?) in
         
         if error != nil {
            onGeocodingCompletionHandler!(nil,nil,error!.localizedDescription)
         }
         else {
            
            guard let placemark = placemarks?.first else {
               onGeocodingCompletionHandler!(nil, nil, "invalid address: \(address)")
               return
            }
            
            // Parse the address
            let streetNumber = placemark.thoroughfare ?? ""
            let locality = placemark.locality ?? ""
            let postalCode = placemark.postalCode ?? ""
            let subLocality = placemark.subLocality ?? ""
            let administrativeArea = placemark.administrativeArea ?? ""
            let country = placemark.country ?? ""
            let longitude = placemark.location!.coordinate.longitude.description
            let latitude = placemark.location!.coordinate.latitude.description
            
            // Create a dictionary out of the address
            let addressDict = ["streetNumber": streetNumber,
                               "locality": locality,
                               "postalCode": postalCode,
                               "subLocality": subLocality,
                               "administrativeArea": administrativeArea,
                               "country": country,
                               "longitude": longitude,
                               "latitude": latitude]
            
            onGeocodingCompletionHandler!(addressDict, placemark, nil)
         }
      }
   }
   
   fileprivate struct Address {
      var street: String = "29043 Dardanella St."
      var city: String = "Livonia"
      var state: String = "MI"
      var zip: String = "48152"
      
      fileprivate func completeAddress() -> String {
         return "\(street) \(city), \(state) \(zip)"
      }
      
      fileprivate func mapViewAddress() -> String {
         return "\(street)\n\(city), \(state) \(zip)"
      }
   }
}

