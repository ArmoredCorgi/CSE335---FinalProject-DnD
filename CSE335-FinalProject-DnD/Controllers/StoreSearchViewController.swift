//
//  Copyright © 2019 Nicholas Jorgensen. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class StoreSearchViewController: UIViewController, UISearchBarDelegate {

    // MARK: IBOutlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Gaming Stores"
        self.searchBar.delegate = self
    }
    
    // MARK: Variables
    
    lazy var geocoder = CLGeocoder()
    let regionRadius : CLLocationDistance = 1000
    
    // MARK: Actions
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        //Activity Indicator:
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.center = self.mapView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        //Hide keyboard:
        searchBar.resignFirstResponder()
        
        //Create search request:
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text! + " Hobby Store"
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response, error) in
            
            //Remove activity indicator:
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil {
                print("Unable to complete search (\(String(describing: error)))")
            }
            else {
                //Remove annotations:
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
                for result in (response?.mapItems)! {
                    let placemark = result.placemark
                    let title = result.name!
                    let lat = placemark.coordinate.latitude
                    let long = placemark.coordinate.longitude
                    
                    let annotation = MKPointAnnotation()
                    annotation.title = title
                    annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    self.mapView.addAnnotation(annotation)
                }
                
                //Get response coordinates:
                let lat = response?.boundingRegion.center.latitude
                let long = response?.boundingRegion.center.longitude
                
                //Zoom into annotations:
                self.centerMap(onLocation: CLLocation(latitude: lat!, longitude: long!))
            }
        }
    }
    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl!) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.mapView.mapType = .standard
        case 1:
            self.mapView.mapType = .satellite
        default:
            print("Error: exceeded segmented control index!")
        }
    }
    
    // MARK: Private methods
    
    func centerMap(onLocation: CLLocation) {
        let coordRegion = MKCoordinateRegion(center: onLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordRegion, animated: true)
    }

}
