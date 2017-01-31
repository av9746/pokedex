//
//  Pokemon.swift
//  pokedex
//
//  Created by Anze Vavken on 29/01/2017.
//  Copyright © 2017 VavkenApps. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionLvl: String!
    private var _nextEvoName: String!
    private var _nextEvoID: String!
    private var _pokemonURL: String!
    
    var nextEvoID: String {
        if _nextEvoID == nil {
            _nextEvoID = ""
        }
        return _nextEvoID
    }
    
    var nextEvoName: String {
        if _nextEvoName == nil {
            _nextEvoName = ""
        }
        return _nextEvoName
    }
    
    var nextEvolutionLvl: String {
        if _nextEvolutionLvl == nil {
            _nextEvolutionLvl = ""
        }
        return _nextEvolutionLvl
    }
    
    var nextEvolutionTxt: String {
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name
    }
    
    var pokedexID: Int {
        if _pokedexID == nil {
            _pokedexID = -3
        }
        return _pokedexID
    }
    
    init(name:String, pokedexID: Int) {
        self._name = name
        self._pokedexID = pokedexID
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexID)/"
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        
        Alamofire.request(_pokemonURL).responseJSON { (response) in
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
                print(self._weight)
                print(self._height)
                print(self._defense)
                print(self._attack)
                
                if let types = dict["types"] as? [Dictionary<String, String>]  , types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        for x in 1..<types.count {
                            
                            if let name = types[x]["name"] {
                                
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                    print(self._type)
                  
                } else {
                    self._type = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0 {
                    
                    if let evolveTo = evolutions[0]["to"] as? String {
                        
                        if evolveTo.range(of: "mega") == nil {
                            self._nextEvoName = evolveTo
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvoID = nextEvoId
                                
                                if let lvlExist = evolutions[0]["level"] {
                                    if let level = lvlExist as? Int {
                                        
                                        self._nextEvolutionLvl = "\(level)"
                                    }
                                    
                                } else {
                                    self._nextEvolutionLvl = ""
                                }
                            }
                        }
                    } else {
                        self._nextEvoName = "ni me"
                        self._nextEvoID = "ni me"
                        self._nextEvolutionLvl = "ni me"
                    }
                    
                }
                
                if let descriptions = dict["descriptions"] as? [Dictionary<String, String>] , descriptions.count > 0 {
                    if let url = descriptions[0]["resource_uri"] {
                        
                        let descrUrl = "\(URL_BASE)\(url)"
                        
                        print(descrUrl)
                        Alamofire.request(descrUrl).responseJSON(completionHandler: { (response) in
                            if let dict2 = response.result.value as? Dictionary<String, AnyObject> {
                                if let description = dict2["description"] as? String {
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    self._description = newDescription
                                }
                            }
                            completed()
                        })
                    }
                } else {
                    
                    self._description = ""
                }
                
            }
          completed()
        }
    }
}
