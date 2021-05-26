//
//  CovidViewController.swift
//  JSONDecoder
//
//  Created by Brandon Rodriguez Molina on 25/05/21.
//

import UIKit

// Estructuras para acceder a los valores del JSON

struct Country: Codable {
    var country: String?
    var cases: Int?
}

class CovidViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var paises = [Country]()
    @IBOutlet weak var tablaCovid: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://corona.lmao.ninja/v3/covid-19/countries"
        if let url = URL(string: urlString) {
            if let datos = try? Data(contentsOf: url) {
                parsear(arreglo: datos)
            }
        }
    }
    
    func parsear(arreglo: Data) {
        let decoder = JSONDecoder()
        if let decodificado = try? decoder.decode([Country].self, from: arreglo) {
            paises = decodificado
            tablaCovid.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaCovid.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        celda.textLabel?.text = paises[indexPath.row].country!
        celda.detailTextLabel?.text = "\(paises[indexPath.row].cases!)"
        return celda
    }

    

}
