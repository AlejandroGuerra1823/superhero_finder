//
//  ApiNetwork.swift
//  superhero_finder
//
//  Created by Alejandro Guerra on 26/08/24.
//

import Foundation


class ApiNetwork{
    
    struct Wrapper{
        let response:String
        let results:[Superhero]
    }
    
    struct Superhero{
        let id:String
        let name:String
    }
    
    func getHeroesByQuery(query:String){
        
    }
    
}
