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
    
    struct SuperheroCompleted:Codable{
        let id:String
        let name:String
        let image:ImageSuperHero
        let powerstats: Powerstats
        let biography: Biography
    }
    
    struct Powerstats:Codable{
        let intelligence:String
        let strength:String
        let speed:String
        let durability:String
        let power:String
        let combat:String
    }
    
    struct Biography:Codable{
        let alignment: String
        let publisher: String
        let aliases:[String]
        let fullName:String
        
        enum CodingKeys:String, CodingKey{
            case fullName = "full-name"
            case alignment = "alignment"
            case aliases = "aliases"
            case publisher = "publisher"
        }
    }
    
    func getHeroById(id:String) async throws -> SuperheroCompleted{
        let url = URL(string: "https://superheroapi.com/api/ece6f1fac2c8d57820f57ab49897eef1/\(id)")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let superhero = try JSONDecoder().decode(SuperheroCompleted.self, from: data)
        
        return superhero
    }
}
