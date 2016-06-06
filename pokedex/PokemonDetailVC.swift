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
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var currentEvolutionImg: UIImageView!
    @IBOutlet weak var nextEvolutionImg: UIImageView!
    @IBOutlet weak var evolutionLabel: UILabel!
    
    
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        pokemonNameLabel.text = pokemon.name
        mainImg.image = img
        currentEvolutionImg.image = img
        
     
        pokemon.downloadPokemonDetails { () -> () in
            // this run after download completes
            self.updateUI()
        }
    }
    
    func updateUI() {
        descriptionLabel.text = pokemon.descript
        typeLabel.text = pokemon.type
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        defenseLabel.text = pokemon.defense
        pokemonIDLabel.text = "\(pokemon.pokedexId)"
        if pokemon.nextEvolutionId == "" {
            evolutionLabel.text = "No Evolutions"
            nextEvolutionImg.hidden = true
        } else {
            nextEvolutionImg.hidden = false
            nextEvolutionImg.image = UIImage(named: "\(pokemon.nextEvolutionId)")
            var str = "Next Evolution: \(pokemon.nextEvolutionText)"
            if pokemon.nextEvolutionLevel != "" {
                str += " - Level: \(pokemon.nextEvolutionLevel)"
            }
        }
        attackLabel.text = pokemon.attack
        
        
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
