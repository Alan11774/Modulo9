//
//  ViewController.swift
//  TheSecretParty
//
//  Created by Alan Ulises on 13/12/24.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var admUbicacion: CLLocationManager!
    // Las clases del framework CoreLocation utilizan coordenadas en decimal
    // Parte entera
    var latitud = 19.432601
    var longitud = -19.133204
    var elMapa: MKMapView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        admUbicacion = CLLocationManager()
        admUbicacion.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        admUbicacion.delegate = self
        elMapa = MKMapView()
        elMapa.frame = self.view.bounds
        elMapa.delegate = self
        self.view.addSubview(elMapa)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        admUbicacion.startUpdatingLocation()
        if CLLocationManager.locationServicesEnabled() {
            switch admUbicacion.authorizationStatus {
            case .notDetermined:
                admUbicacion.delegate = self
                admUbicacion.requestAlwaysAuthorization()
                break
            case .restricted, .denied:
                let alert = UIAlertController(title: "Error", message: "Se requiere su permiso para usar la ubicación, Autoriza ahora?", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "SI", style: UIAlertAction.Style.default, handler: { action in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, options: [:],completionHandler:nil)
                    }
                    }))
            alert.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

            break

        default:    // .authorizedWhenInUse, .authorizedAlways
            admUbicacion.startUpdatingLocation()
            break
        }
    }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identificador = "unPin"
            var anotacion = elMapa.dequeueReusableAnnotationView(withIdentifier: identificador) as? MKMarkerAnnotationView
            if anotacion == nil {
                anotacion = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identificador)
            }
        }


    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        // a) si solo necesitaba una ubicación:
        admUbicacion.stopUpdatingLocation()
        guard let origen = locations.first else { return }
        // centramos el mapa en la ubicación obtenida
        var region = MKCoordinateRegion(center:origen.coordinate, latitudinalMeters: 1000, longitudinalMeters:1000)
        elMapa.setRegion(region, animated:true)
        ////// obtenemos las direcciones de las dos ubicaciones
        // print ("usted está en \(ubicacion.coordinate.latitude), \(ubicacion.coordinate.longitude)")
        // obtenemos la dirección que corresponde a una ubicación (reverse geolocation)
        print ("Ud. está en: ")
        geoLocation(origen)
        // ahora encontramos la ubicación de destino:
        print ("Y debe llegar a: ")
        let destino = CLLocation(latitude: latitud, longitude: longitud)
        geoLocation(destino)
        if let region = MKCoordinateRegion(coordinates:[origen.coordinate, destino.coordinate]) {
            elMapa.setRegion(region, animated:true)
        }
    }

    func geoLocation(_ ubicacion: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(ubicacion, completionHandler:{ lugares, error in
            var direccion = ""
            if error != nil {
                print ("no se pudo encontrar la dirección correspondiente a esa coordenada")
            }
            else {
                guard let lugar = lugares?.first else { return }
                let thoroughfare = (lugar.thoroughfare ?? "")
                let subThoroughfare = (lugar.subThoroughfare ?? "")
                let locality = (lugar.locality ?? "")
                let subLocality = (lugar.subLocality ?? "")
                let administrativeArea = (lugar.administrativeArea ?? "")
                let subAdministrativeArea = (lugar.subAdministrativeArea ?? "")
                let postalCode = (lugar.postalCode ?? "")
                let country = (lugar.country ?? "")
                direccion = "Dirección: \(thoroughfare) \(subThoroughfare) \(locality) \(subLocality) \(administrativeArea) \(subAdministrativeArea) \(postalCode) \(country)"
                print (direccion)
            }
            self.colocarPinEn(ubicacion.coordinate, direccion: direccion)
        })

    }
    func colocarPinEn(_ coordenada: CLLocationCoordinate2D, direccion: String){
        let elPin = MKPointAnnotation()
        elPin.coordinate = coordenada
        elPin.title = direccion
        elMapa.addAnnotation(elPin)
        
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        admUbicacion.stopUpdatingLocation()
        print("")
    }

}

