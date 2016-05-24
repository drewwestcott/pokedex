//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Drew Westcott on 18/05/2016.
//  Copyright © 2016 Drew Westcott. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var pokemonNameLabel: UILabel!
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonNameLabel.text = pokemon.name
    }
    
}
