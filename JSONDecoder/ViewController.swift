//
//  ViewController.swift
//  JSONDecoder
//
//  Created by Brandon Rodriguez Molina on 24/05/21.
//

import UIKit

// Estructuras para acceder a los valores del JSON
struct Peticion: Decodable {
    var title: String
    var body: String
}
struct Peticiones: Decodable {
    var results: [Peticion]
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var peticiones = [Peticion]()
    
    @IBOutlet weak var tablaJson: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://hackingwithswift.com/samples/petitions-1.json"
        if let url = URL(string: urlString) {
            if let datos = try? Data(contentsOf: url) {
                parsear(json: datos)
            }
        }
    }
    
    func parsear(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPeticiones = try? decoder.decode(Peticiones.self, from: json) {
            peticiones = jsonPeticiones.results
            tablaJson.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peticiones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaJson.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        celda.textLabel?.text = peticiones[indexPath.row].title
        celda.detailTextLabel?.text = peticiones[indexPath.row].body
        
        return celda
    }


}

