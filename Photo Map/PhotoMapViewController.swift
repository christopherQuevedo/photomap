//
//  PhotoMapViewController.swift
//  Photo Map
//
//  Created by Nicholas Aiwazian on 10/15/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, LocationsViewControllerDelegate, MKMapViewDelegate {

    @IBOutlet weak var photoMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //one degree of latitude is approximately 111 kilometers (69 miles) at all times.
        let tucsonRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(32.2226, -110.9747), MKCoordinateSpanMake(0.05, 0.05))
        photoMapView.setRegion(tucsonRegion, animated: false)

        // Do any additional setup after loading the view.
    }

    @IBAction func onButton(_ sender: Any) {
        let photoLibraryView = UIImagePickerController()
        photoLibraryView.delegate = self
        photoLibraryView.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            photoLibraryView.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            photoLibraryView.sourceType = .photoLibrary
        }
        self.present(photoLibraryView, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        
        dismiss(animated : true){
            self.performSegue(withIdentifier: "tagSegue", sender: nil)
        }
 
        //dismiss(animated: true, completion: nil)
    }
    
    func locationsPickedLocation(controller: LocationsViewController, latitude: NSNumber, longitude: NSNumber) {
        let locationCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        print("Lat: \(latitude), Lng: \(longitude)")
        self.navigationController?.popToViewController(self, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinate
        annotation.title = "Picture!"
        photoMapView.addAnnotation(annotation)
        
    }
    /*
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseID = "myAnnotationView"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
        if (annotationView == nil) {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            annotationView!.canShowCallout = true
            annotationView!.leftCalloutAccessoryView = UIImageView(frame: CGRect(x:0, y:0, width: 50, height:50))
        }
        
        let imageView = annotationView?.leftCalloutAccessoryView as! UIImageView
        imageView.image = UIImage(named: "camera")
        print("here")
        return annotationView
    }
    
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let locationsView = segue.destination as? LocationsViewController
        locationsView?.delegate = self
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
