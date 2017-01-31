//
//  PokemonDetailsVC.swift
//  pokedex
//
//  Created by Anze Vavken on 30/01/2017.
//  Copyright © 2017 VavkenApps. All rights reserved.
//

import UIKit

class PokemonDetailsVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var selectedBioMoves: UISegmentedControl!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenceLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexIDLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var nextEvolutionTexyLbl: UILabel!
    @IBOutlet weak var firstEvolution: UIImageView!
    @IBOutlet weak var secondEvolution: UIImageView!
    
    
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = pokemon.name.capitalized
        pokedexIDLbl.text = "\(pokemon.pokedexID)"
        pokemonImage.image = UIImage(named: "\(pokemon.pokedexID)")
        firstEvolution.image = UIImage(named: "\(pokemon.pokedexID)")
        
        
        
        pokemon.downloadPokemonDetails {
            //whatever we write here will only be called when the network call is complete
            
            self.updateUI()
        }

    }
    
    func updateUI() {
        attackLbl.text = pokemon.attack
        defenceLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        typeLbl.text = pokemon.type
        descriptionLbl.text = pokemon.description
        
        if pokemon.nextEvoID == "" {
            
            nextEvolutionTexyLbl.text = "No evolutions"
            secondEvolution.isHidden = true
        } else {
            secondEvolution.isHidden = false
            secondEvolution.image = UIImage(named: "\(pokemon.nextEvoID)")
            nextEvolutionTexyLbl.text = "Next evolution: \(pokemon.nextEvoName) at level \(pokemon.nextEvolutionLvl)"
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
