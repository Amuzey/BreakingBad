//
//  СharactersCollectionViewController.swift
//  BreakingBad
//
//  Created by Алексей on 11.08.2022.
//

import UIKit

class CharactersCollectionViewController: UICollectionViewController {
    
   private var characters: [Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacter()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let characterVC = segue.destination as? CharacterViewController else { return }
        guard let indexPaths = collectionView.indexPathsForSelectedItems else { return }
        guard let indexPath = indexPaths.first else { return }
        characterVC.character = characters[indexPath.item]
    }
  

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "character",
            for: indexPath
        ) as? CharacterCell else {
            return UICollectionViewCell()
        }
        let character = characters[indexPath.item]
        cell.configure(with: character)
        cell.layer.cornerRadius = 10
        return cell
    }
    private func fetchCharacter() {
        NetworkManager.shared.fetchCharacters(from: charactersUrl) { [weak self] result in
            switch result {
                
            case .success(let data):
                self?.characters = data
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension CharactersCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 2
        let paddingWidth = 10 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widhtPerItem = availableWidth / itemsPerRow
        return CGSize(width: widhtPerItem, height: widhtPerItem + widhtPerItem / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
}

