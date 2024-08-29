//
//  ApiNetwork.swift
//  superhero_finder
//
//  Created by Alejandro Guerra on 26/08/24.
//

import Foundation


class ApiNetwork{
    
    struct Wrapper:Codable{
        let response:String
        let results:[Superhero]
    }
    
    struct Superhero:Codable, Identifiable{
        let id:String
        let name:String
        let image:ImageSuperHero
    }
    
    struct ImageSuperHero:Codable{
        let url:String
    }
    
    func getHeroesByQuery(query:String) async throws -> Wrapper{
        let url = URL(string:"https://superheroapi.com/api/ece6f1fac2c8d57820f57ab49897eef1/search/\(query)")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let wrapper = try JSONDecoder().decode(Wrapper.self, from: data)
        
        return wrapper
    }
    
}
