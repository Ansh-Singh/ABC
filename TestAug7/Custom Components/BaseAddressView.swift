//
//  BaseDropDownView.swift
//  Profile
//
//  Created by Milan Katiyar on 24/07/19.
//  Copyright © 2019 learning. All rights reserved.
//
protocol UpdateCountryList: class {
    func updateCountrySelection(countryname: String)
}

public enum PlaceTypeaddress: String {
    case all = ""
    case geocode
    case address
    case establishment
    case regions = "(regions)"
    case cities = "(cities)"
}

import Foundation
import UIKit
import CoreLocation
//import CountryPicker
import GooglePlacesSearchController
protocol BaseAddressDelegate: class {
    
    func UpdateAddressText(view: BaseAddressView,index: Int,text: String)
}

public class BaseAddressView : UIView {
    var geoLabel: PlaceType = .all
    var profileGeoLabel = "0"
    var VC: UIViewController!
    weak var Delegate:BaseAddressDelegate!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var dropDownLbl: UILabel!
    @IBOutlet weak var title_lbl: UILabel!
    let GoogleMapsAPIServerKey = GOOGLE_KEY
    lazy var placesSearchController: GooglePlacesSearchController = {
        let controller = GooglePlacesSearchController(delegate: self, apiKey: GoogleMapsAPIServerKey, placeType: .all, coordinate: kCLLocationCoordinate2DInvalid, radius: 34, strictBounds: true, searchBarPlaceholder: ""
            
        )
        return controller
    }()
    
    

 
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
        
    }
    
    func initializeView() {
        
      //  let controller = GooglePlacesSearchController(delegate: self(), apiKey: GoogleMapsAPIServerKey, placeType: <#T##PlaceType#>, coordinate: <#T##CLLocationCoordinate2D#>, radius: <#T##CLLocationDistance#>, strictBounds: <#T##Bool#>, searchBarPlaceholder: <#T##String#>
        
        
        let podBundle = Bundle(for: BaseAddressView.self)
        let nib = UINib(nibName: "BaseAddressView", bundle: podBundle)
        mainView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        self.addSubview(mainView)
        mainView.frame = bounds
        mainView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
     initializeAddress()
    }
    
    func initializeAddress(){
       
  
       
    }
    
    public func setAddressGeoLavel(PROFILE_ATTRIBUTE_GEO_LEVEL: String, viewController: UIViewController)  {
        profileGeoLabel = PROFILE_ATTRIBUTE_GEO_LEVEL
        if PROFILE_ATTRIBUTE_GEO_LEVEL == "3" {
            geoLabel = .cities
        }
        VC = viewController
        placesSearchController  = {
            let controller = GooglePlacesSearchController(delegate: self, apiKey: GoogleMapsAPIServerKey, placeType: geoLabel, coordinate: kCLLocationCoordinate2DInvalid, radius: 34, strictBounds: true, searchBarPlaceholder: ""
                
            )
            return controller
        }()
        
    
    }
    
    
    @IBAction func showaddressView(_ sender: Any) {
        if profileGeoLabel == "0" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewCon = storyboard.instantiateViewController(withIdentifier :"SelectCountryViewController") as! SelectCountryViewController
            viewCon.textCountry = self.dropDownLbl
            viewCon.DelegateSelect = self
            VC.present(viewCon, animated: true) {
                
            }
            return
            
        }
     VC.present(placesSearchController, animated: true, completion: nil)
    }
}

extension BaseAddressView: GooglePlacesAutocompleteViewControllerDelegate, UpdateCountryList{
    func updateCountrySelection(countryname: String) {
        self.dropDownLbl.text = countryname
        self.Delegate.UpdateAddressText(view: self, index: 0, text:countryname )
    }
    
    public func viewController(didAutocompleteWith place: PlaceDetails) {
        
        if let cntry = place.country {
          print("cntry ==",cntry)
        }
    
        var geocode = ""
        var locality = ""
        var sublocality = ""
        var administrativeArea = ""
        var country = ""
        var name = ""
        /*
        //GMSAutocompleteViewController
        CITY_NAME = ""
        placesSearchController.isActive = false
        
        
      
        if let lat  = place.coordinate?.latitude, let long = place.coordinate?.longitude {
            
            geocode = "\(lat),\(long)"
            print("geocode ==",geocode)
        }
        
        if let nm = place.name {
            name = nm
        }
        
        
        
        
        if let cntry = place.country {
            country = cntry
        }
        if let lc = place.administrativeArea {
            administrativeArea =  ", " + lc
        }
        
        if self.autoLocationType == "start" {
            
            if let lc = place.locality{
                locality = lc
                self.FROM_CITY_NAME = locality
                print("place.locality ==",lc)
                
            }
            else if let lc = place.subLocality {
                locality = lc
                self.FROM_CITY_NAME = locality
                print("place.locality ==",lc)
                
            }
            
            
            
            if locality.contains(find: name) {
                self.startLocTF.text = locality + administrativeArea + ", " + country
                inputText = locality + ", " + country
            }
            else {
                
                self.startLocTF.text = name + ", " + locality + administrativeArea + ", " + country
                inputText = name + ", " + locality + ", " + country
            }
            
            
            self.selectedStartCountry = country
            inputLocGeo = geocode
            
            
        }
        else {
            
            if let lc = place.locality{
                locality = lc
                self.CITY_NAME = locality
                cityName = self.CITY_NAME
                print("place.locality ==",lc)
                
            }
            
            if locality.contains(find: name) {
                self.endLocTF.text = locality  + administrativeArea +  ", " + country
            }
            else {
                
                self.endLocTF.text = name + ", " + locality + administrativeArea + ", " + country
            }
            
            getCityImageUrl()
            inputEndLocGeo = geocode
            self.selectedEndCountry = country
            geoVal = self.endLocTF.text ?? ""
            
        }
        */
        
        if geoLabel == .cities {
            if let lc = place.locality{
                locality = lc
           
                self.dropDownLbl.text = locality
        self.Delegate.UpdateAddressText(view: self, index: 0, text:locality )
                
            }
        }
        VC.dismiss(animated: true) {
            
        }
    }
}
