//
//  CharacterCell.swift
//  BreakingBad
//
//  Created by Алексей on 11.08.2022.
//

import UIKit

class CharacterCell: UICollectionViewCell {
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    
    func configure(with character: Character) {
        
        nameLabel.text = character.name
        
        NetworkManager.shared.fetchImage(from: character.img) { [weak self] result in
            switch result {
                
            case .success(let imageData):
                self?.photoImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
