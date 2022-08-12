//
//  CharacterViewController.swift
//  BreakingBad
//
//  Created by Алексей on 12.08.2022.
//

import UIKit

class CharacterViewController: UIViewController {
    
    @IBOutlet var photoImageView: UIImageView!
  
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var portrayedLabel: UILabel!
    
    var character: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        nameLabel.text = character?.name
        statusLabel.text = character?.status.rawValue
        nicknameLabel.text = character?.nickname
        portrayedLabel.text = character?.portrayed
        
        NetworkManager.shared.fetchImage(from: character?.img) { [weak self] result in
            switch result {
                
            case .success(let data):
                self?.photoImageView.image = UIImage(data: data)
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
}


