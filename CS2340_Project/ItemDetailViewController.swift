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
    var name: String = ""
    var lostOrFound: String = ""
    var isNewName: Bool = false

    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lostFoundTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = name
        lostFoundTextField.text = lostOrFound
        
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
        if isNewName {
            beforeViewController.beforeViewController.arr.append(nameTextField.text!)
            beforeViewController.beforeViewController.arr.append(lostFoundTextField.text!)
        } else {
            let i = beforeViewController.beforeViewController.arr.index(of: name)!
            beforeViewController.beforeViewController.arr[i] = nameTextField.text!
            beforeViewController.beforeViewController.arr2[i] = lostFoundTextField.text!
        }
        
//        if isNewName {
//            beforeViewController.array.append(nameTextField.text!)
//            beforeViewController.array2.append(lostFoundTextField.text!)
//        } else {
//            let i = beforeViewController.array.index(of: name)!
//            beforeViewController.array[i] = nameTextField.text!
//            beforeViewController.array2[i] = lostFoundTextField.text!
//        }
        
//        beforeViewController.dict.updateValue(lostFoundTextField.text!, forKey: nameTextField.text!)
        beforeViewController.tableView.reloadData()
        self.navigationController?.popViewController(animated: true)
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
        let placeInfo = pin.pinDescription
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    
    // MARK: - Helper
    
    func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.ended {
            return
        }
        
        let location = gestureReconizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        let alert = UIAlertController(title: "Add a New Pin", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Pin Name"
        }
        
        alert.addTextField { textField in
            textField.placeholder = "Pin Description"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            let nameTextField = alert.textFields![0]
            let descriptionTextField = alert.textFields![1]
            let name = nameTextField.text ?? "Pin Name"
            let description = descriptionTextField.text ?? "Pin Description"
            
            if let pin = self.savePin(name: name, description: description, location: coordinate) {
                self.mapView.addAnnotation(pin)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func savePin(name: String, description: String, location: CLLocationCoordinate2D) -> Pin? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let pin = Pin(context: managedContext)
        pin.pinName = name
        pin.pinDescription = description
        pin.pinLat = location.latitude
        pin.pinLong = location.longitude
        
        do {
            try managedContext.save()
            return pin
        } catch let error as NSError {
            print("Could not save: \(error.localizedDescription)")
            return nil
        }
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
