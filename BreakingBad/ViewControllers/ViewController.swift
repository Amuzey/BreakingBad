//
//  ViewController.swift
//  BreakingBad
//
//  Created by Алексей on 08.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let newsUrl = "https://www.breakingbadapi.com/api/characters"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: newsUrl) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "Not error description")
                return
            }
            do {
                let info = try JSONDecoder().decode([Characters].self, from: data)
                print(info)
            } catch let error {
                print(error)
            }
        }.resume()
        
    }
}


