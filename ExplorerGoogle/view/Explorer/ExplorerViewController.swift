//
//  ExplorerViewController.swift
//  ExplorerGoogle
//
//  Created by Weslley on 02/10/19.
//  Copyright © 2019 URPay. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces


struct MyPlace {
    var name: String
    var lat: Double
    var long: Double
}

let kMapStyle = "[" +
"  {" +
"    \"featureType\": \"poi.business\"," +
"    \"elementType\": \"all\"," +
"    \"stylers\": [" +
"      {" +
"        \"visibility\": \"off\"" +
"      }" +
"    ]" +
"  }," +
"  {" +
"    \"featureType\": \"transit\"," +
"    \"elementType\": \"labels.icon\"," +
"    \"stylers\": [" +
"      {" +
"        \"visibility\": \"off\"" +
"      }" +
"    ]" +
"  }" +
"]"

class ExplorerViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate, UITextFieldDelegate, CAAnimationDelegate  {
    
    private var components : ExplorerComponents!
    private var contentScreen : ExplorerScreen!
    private var stepComponents: StepComponents!
    
    var currentLocationMarker = GMSMarker()
    var locationManager = CLLocationManager()
    
    
    private var infoWindow = PreviewMapsView ()
    fileprivate var locationMarker: GMSMarker? = GMSMarker ()
    
    var chosenPlace: MyPlace?

    
    let customMarkerWidth: Int = 50
    let customMarkerHeight: Int = 70
    
    let previewDemoData = [(title: "The Polar Junction", img: #imageLiteral(resourceName: "restaurant1"), price: 10), (title: "The Nifty Lounge", img: #imageLiteral(resourceName: "restaurant2"), price: 8), (title: "The Lunar Petal", img: #imageLiteral(resourceName: "restaurant3"), price: 12)]
    
   var iphoneX = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpContentView()
        
        components.myMapView.delegate = self
               
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
               
        
        stepComponents.seachTextField.delegate = self
        stepComponents.seachTextField.alpha = 1
        stepComponents.seachTextField.isHidden = false
//        stepComponents.seachTextField.addTarget(self, action: #selector(seachInRequest), for: .editingChanged)
        stepComponents.seachTextField.endEditing(true)
//        setupTextField(textField: stepComponents.seachTextField)
        
//        restaurantPreviewView = PreviewMapsView(frame: CGRect(x: 500, y: 0, width: 250, height: 160))
        
        components.btnMyLocation.addTarget(self, action: #selector(btnMyLocationAction), for: .touchUpInside)
     

        verifyModeDark()
        
        initGoogleMaps()
          self.navigationController?.isNavigationBarHidden = true
        
       
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    //Função para baixar o teclado quando o DARK MODE for ativado
       override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
           verifyModeDark()
       }
    //MARK: textfield
     func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
         let autoCompleteController = GMSAutocompleteViewController()
         autoCompleteController.delegate = self
        
        autoCompleteController.view.backgroundColor = .blue

         let filter = GMSAutocompleteFilter()
         autoCompleteController.autocompleteFilter = filter
   
        
         self.locationManager.startUpdatingLocation()
         self.present(autoCompleteController, animated: true, completion: nil)
         return false
     }
    
    
    // MARK: GOOGLE AUTO COMPLETE DELEGATE
       func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
           let lat = place.coordinate.latitude
           let long = place.coordinate.longitude
           
           showPartyMarkers(lat: lat, long: long)
           
           let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 17.0)
           components.myMapView.camera = camera
           stepComponents.seachTextField.text = place.formattedAddress
           chosenPlace = MyPlace(name: place.formattedAddress!, lat: lat, long: long)
           let marker=GMSMarker()
           marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
           marker.title = "\(place.name)"
           marker.snippet = "\(place.formattedAddress!)"
//        marker.map = components.myMapView
           
           self.dismiss(animated: true, completion: nil) // dismiss after place selected
       }
       
     @objc func backUpHome() {
         tabBarController?.tabBar.isHidden = true
         let transition = CATransition.init()
         transition.duration = 0.5
         transition.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.default)
         transition.type = CATransitionType.push
         transition.subtype = CATransitionSubtype.fromBottom
         transition.delegate = self
         view.window!.layer.add(transition, forKey: kCATransition)
         
         self.navigationController?.popToRootViewController(animated: false)
     }
     
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("ERROR AUTO COMPLETE \(error)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func initGoogleMaps() {
        let camera = GMSCameraPosition.camera(withLatitude: 28.7041, longitude: 77.1025, zoom: 17.0)
        components.myMapView.camera = camera
        components.myMapView.delegate = self
        
        
        do {
          // Set the map style by passing a valid JSON string.
            components.myMapView.mapStyle = try GMSMapStyle(jsonString: kMapStyle)
        } catch {
          NSLog("One or more of the map styles failed to load. \(error)")
        }

//        components.myMapView.isExclusiveTouch = true
    }
    
    // MARK: CLLocation Manager Delegate
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while getting location \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.delegate = nil
        locationManager.stopUpdatingLocation()
        let location = locations.last
        let lat = (location?.coordinate.latitude)!
        let long = (location?.coordinate.longitude)!
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 17.0)
        
        components.myMapView.animate(to: camera)
        
        showPartyMarkers(lat: lat, long: long)
    }
    
    // MARK: GOOGLE MAP DELEGATE
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return false }
        let img = customMarkerView.img!
        
        let colorSelected = #colorLiteral(red: 0.2431372549, green: 0.7098039216, blue: 0.3254901961, alpha: 1)
        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: img, borderColor: colorSelected, tag: customMarkerView.tag)
        
        marker.iconView = customMarker
 
     
        
        return false
    }

    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return nil }

        let data = previewDemoData[customMarkerView.tag]

        
        stepComponents.setData(title: data.title, img: data.img, price: data.price)
               
        //aparecer o card com as infos
        itensAparecer()
        
        //subir logo da google
        let mapInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 100.0, right: 300.0)
        mapView.padding = mapInsets
        
        return stepComponents
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
        let tag = customMarkerView.tag

        restaurantTapped(tag: tag)
    }
    
    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
        let img = customMarkerView.img!
        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: img, borderColor: UIColor.darkGray, tag: customMarkerView.tag)
        marker.iconView = customMarker
        
        
    }
    
    func showPartyMarkers(lat: Double, long: Double) {
        components.myMapView.clear()
        for i in 0..<3 {
            let randNum=Double(arc4random_uniform(30))/10000
            let marker=GMSMarker()
            let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: previewDemoData[i].img, borderColor: UIColor.darkGray, tag: i)
            marker.iconView=customMarker
            let randInt = arc4random_uniform(4)
            if randInt == 0 {
                marker.position = CLLocationCoordinate2D(latitude: lat+randNum, longitude: long-randNum)
            } else if randInt == 1 {
                marker.position = CLLocationCoordinate2D(latitude: lat-randNum, longitude: long+randNum)
            } else if randInt == 2 {
                marker.position = CLLocationCoordinate2D(latitude: lat-randNum, longitude: long-randNum)
            } else {
                marker.position = CLLocationCoordinate2D(latitude: lat+randNum, longitude: long+randNum)
            }
            marker.map = components.myMapView
        }
    }

    
    func itensAparecer(){
        
        stepComponents.cardzin.isHidden = false
        stepComponents.imageUser.isHidden = false
        stepComponents.user.isHidden = false
        stepComponents.priceLabel.isHidden = false
        
        
    }
    
    @objc func btnMyLocationAction() {
        let location: CLLocation? = components.myMapView.myLocation
        if location != nil {
            components.myMapView.animate(toLocation: (location?.coordinate)!)
        }
    }
    
    @objc func restaurantTapped(tag: Int) {
        let v = DetailsViewController()
        v.passedData = previewDemoData[tag]
        
//        v.containerView.isHidden = true
        self.navigationController?.pushViewController(v, animated: true)
    }
    
    private func setUpContentView() {
        stepComponents = StepComponents()
        components = ExplorerComponents()
        contentScreen = ExplorerScreen(stepComponents: stepComponents, components: components, frame: view.frame)
        view.addSubview(contentScreen)
        contentScreen.translatesAutoresizingMaskIntoConstraints = false
        
        var initialConstraints = [NSLayoutConstraint]()
        initialConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|",
                                                             options: NSLayoutConstraint.FormatOptions(),
                                                             metrics: nil,
                                                             views: ["v0" : contentScreen])
        
        initialConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v0]-0-|",
                                                             options: NSLayoutConstraint.FormatOptions(),
                                                             metrics: nil,
                                                             views: ["v0" : contentScreen])
        
        
        
        NSLayoutConstraint.activate(initialConstraints)
        
    }

  
    
    func verifyModeDark(){
        
        if self.traitCollection.userInterfaceStyle == .dark {
            do {
                // Set the map style by passing the URL of the local file.
                if let styleURL = Bundle.main.url(forResource: "mapsDark", withExtension: "json") {
                   components.myMapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                } else {
                  NSLog("Unable to find style.json")
                }
              } catch {
                NSLog("One or more of the map styles failed to load. \(error)")
              }
        } else {
          
           do {
                         // Set the map style by passing the URL of the local file.
                         if let styleURL = Bundle.main.url(forResource: "mapsLight", withExtension: "json") {
                            components.myMapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                         } else {
                           NSLog("Unable to find style.json")
                         }
                       } catch {
                         NSLog("One or more of the map styles failed to load. \(error)")
                       }
           
           
           }
        
    }
}


