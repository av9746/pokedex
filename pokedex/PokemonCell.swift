//
//  PokemonCell.swift
//  pokedex
//
//  Created by Anze Vavken on 29/01/2017.
//  Copyright © 2017 VavkenApps. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ pokemon: Pokemon) {
        self.pokemon = pokemon
        pokemonNameLabel.text = self.pokemon.name.capitalized
        pokemonImage.image = UIImage(named: "\(self.pokemon.pokedexID)")
    }
    
    
}
