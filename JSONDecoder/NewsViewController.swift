//
//  NewsViewController.swift
//  JSONDecoder
//
//  Created by Brandon Rodriguez Molina on 24/05/21.
//

import UIKit

// Estructuras para acceder a los valores del JSON
struct Noticias: Codable {
    var articles: [Noticia]
}
struct Noticia: Codable {
    var title: String
    var description: String?
}

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var noticias = [Noticia]()
    
    @IBOutlet weak var tablaNoticias: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://newsapi.org/v2/top-headlines?apiKey=a6b08412bf55474c9d4e7f992e2646f0&country=mx"
        if let url = URL(string: urlString) {
            if let datos = try? Data(contentsOf: url) {
                parsear(json: datos)
            }
        }
    }
    
    func parsear(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPeticiones = try? decoder.decode(Noticias.self, from: json) {
            noticias = jsonPeticiones.articles
            tablaNoticias.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaNoticias.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        celda.textLabel?.text = noticias[indexPath.row].title
        celda.detailTextLabel?.text = noticias[indexPath.row].description
        
        return celda
    }

}
