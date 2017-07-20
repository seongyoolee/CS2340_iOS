//
//  ItemDetailViewController.swift
//  CS2340_Project
//
//  Created by Seon Gyoo Lee on 7/9/17.
//  Copyright © 2017 slee3056. All rights reserved.
//  Credit to GT iOS Club for providing help with MapView/CoreData/Pin Attribute
//

import UIKit
import CoreData
import MapKit

class ItemDetailViewController: UIViewController, MKMapViewDelegate, UIGestureRecognizerDelegate {
    
    var beforeViewController:ItemListViewController!
    var pin:Pin?
    var isNewName:Bool = false

    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lostFoundTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = pin?.pinName
        lostFoundTextField.text = pin?.lostOrFound
        
        if isNewName {
            promptLabel.text = "Enter a new name:"
        } else {
            promptLabel.text = "Edit name:"
        }
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress))
        recognizer.minimumPressDuration = 0.5
        recognizer.delaysTouchesBegan = true
        recognizer.delegate = self
        mapView.addGestureRecognizer(recognizer)
        
        if let pin = pin {
            self.centerMapViewOn(pin: pin)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Pin> = Pin.fetchRequest()
        
        do {
            let pins = try managedContext.fetch(fetchRequest)
            
            for pin in pins {
                mapView.addAnnotation(pin)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDone(_ sender: Any) {
        if isNewName && pin == nil {
            let myAlert = UIAlertController(title:"Alert", message:"You have not placed a pin yet", preferredStyle: UIAlertControllerStyle.alert);
            let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default){ action in
                self.dismiss(animated: true, completion:nil);
            }
            myAlert.addAction(okAction);
            self.present(myAlert, animated:true, completion:nil);
        }
        else if pin != nil {
            pin?.pinName = nameTextField.text
            pin?.lostOrFound = lostFoundTextField.text
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext

            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save: \(error.localizedDescription)")
            }
            beforeViewController.loadPins()
            beforeViewController.tableView.reloadData()
            self.navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func onCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView!.rightCalloutAccessoryView = btn
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let pin = view.annotation as! Pin
        let placeName = pin.pinName
        let placeInfo = pin.lostOrFound
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    
    // MARK: - Helper
    
    func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {

        if gestureReconizer.state != UIGestureRecognizerState.ended {
            return
        }

        if self.pin != nil {
            mapView.removeAnnotation(pin!)
        } else {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            self.pin = Pin(context: managedContext)
        }
        
        let location = gestureReconizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        

        pin?.pinLat = coordinate.latitude
        pin?.pinLong = coordinate.longitude
        
        mapView.addAnnotation(pin!)
        centerMapViewOn(pin: pin!)
    }
    
    func centerMapViewOn(pin:Pin) {
        let center = CLLocationCoordinate2D(latitude: pin.pinLat, longitude: pin.pinLong)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50))
        mapView.setRegion(region, animated: true)
    }


    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
