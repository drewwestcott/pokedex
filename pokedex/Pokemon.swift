//
//  Pokemon.swift
//  pokedex
//
//  Created by Drew Westcott on 15/05/2016.
//  Copyright © 2016 Drew Westcott. All rights reserved.
//

import Alamofire
import Foundation

class Pokemon: NSObject {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionText: String!
    private var _nextEvolutionLevel: String!
    private var _pokemon_url: String!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int! {
        return _pokedexId
    }
    
    var descript: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type : String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense : String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height : String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight : String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack : String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionText : String {
        if _nextEvolutionText == nil {
            _nextEvolutionText = ""
        }
        return _nextEvolutionText
    }
    
    var nextEvolutionLevel : String {
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemon_url = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        
        let url = NSURL(string: _pokemon_url)!
        Alamofire.request(.GET, url).responseJSON { response in
        
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
             
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String,String>] where types.count > 0 {
                    print(types.debugDescription)
                    if let name = types[0]["name"]?.capitalizedString {
                        self._type = name
                    }
                    print(types.count)
                    if types.count > 1 {
                        for index in 1..<types.count {
                            if let nextType = types[index]["name"]?.capitalizedString {
                            self._type = "\(self._type) / \(nextType)"
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String,String>] where descArr.count > 0 {
                    if let url = descArr[0]["resource_uri"] {
                        let descUrl = NSURL(string: "\(URL_BASE)\(url)")!
                        print(descUrl)
                        
                        Alamofire.request(.GET, descUrl).responseJSON { response in
                            
                            let desResult = response.result
                            if let descDict = desResult.value as? Dictionary<String, AnyObject> {
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                    print(self._description)
                                }
                            }
                            completed()
                        }
                    }
                } else {
                    self._description = ""
                }
                
                if let evoArr = dict["evolutions"] as? [Dictionary<String,AnyObject>] where evoArr.count > 0 {
                    
                    if let to = evoArr[0]["to"] as? String {
                        
                        //ignore megas as not completely supported but returned by API
                        if to.rangeOfString("mega") == nil {
                            if let uri = evoArr[0]["resource_uri"] as? String {
                                let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let numberOfEvolution = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                self._nextEvolutionId = numberOfEvolution
                                self._nextEvolutionText = to
                                
                                if let level = evoArr[0]["level"] as? Int {
                                    self._nextEvolutionLevel = "\(level)"
                                }
                                print(self._nextEvolutionId)
                                print("Evo:\(self._nextEvolutionText)")
                                print(self._nextEvolutionLevel)
                            }
                        }
                    }
                }
                
                print(self._height)
                print(self._height)
                print(self._attack)
                print(self._defense)
                print(self._type)
            }
        }
    }
}