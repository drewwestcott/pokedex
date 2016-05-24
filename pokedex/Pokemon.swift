//
//  Pokemon.swift
//  pokedex
//
//  Created by Drew Westcott on 15/05/2016.
//  Copyright © 2016 Drew Westcott. All rights reserved.
//

import Foundation

class Pokemon: NSObject {
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int! {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
}