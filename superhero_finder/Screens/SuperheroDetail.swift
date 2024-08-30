//
//  SuperheroDetail.swift
//  superhero_finder
//
//  Created by Alejandro Guerra on 29/08/24.
//

import SwiftUI
import SDWebImageSwiftUI
import Charts

struct SuperheroDetail: View {
    let id:String
    
    @State var superhero:ApiNetwork.SuperheroCompleted? = nil
    @State var loading:Bool = true
    var body: some View {
        VStack{
            if loading{
                ProgressView().tint(.white)
            }else if let superhero = superhero{
                WebImage(url: URL(string: superhero.image.url)).resizable().scaledToFill().frame(height: 200).clipped().cornerRadius(16).padding(20)
                Text(superhero.name).bold().font(.title).foregroundColor(.white)
                ForEach(superhero.biography.aliases.prefix(4), id: \.self){ alias in
                    Text(alias).foregroundColor(.white).italic()
                }
                
                SuperheroStats(stats: superhero.powerstats)
                
                
            }
            
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity).background(.black).onAppear{
            Task{
                do{
                     superhero = try await ApiNetwork().getHeroById(id: id)
                } catch{
                    print("errorsillo")
                    superhero = nil
                }
                loading = false
            }
        }
    }
}


struct SuperheroStats:View {
    let stats:ApiNetwork.Powerstats
    
    var body: some View {
        VStack{
            Chart{
                SectorMark(angle: .value("Count", Int(stats.combat) ?? 0),
                           innerRadius: .ratio(0.6),
                           angularInset: 3
                ).cornerRadius(5).foregroundStyle(by: .value("Category", "Combat"))
                
                
                SectorMark(angle: .value("Count", Int(stats.durability) ?? 0),
                           innerRadius: .ratio(0.6),
                           angularInset: 3
                ).cornerRadius(5).foregroundStyle(by: .value("Category", "Durabilidad"))
                
                SectorMark(angle: .value("Count", Int(stats.intelligence) ?? 0),
                           innerRadius: .ratio(0.6),
                           angularInset: 3
                ).cornerRadius(5).foregroundStyle(by: .value("Category", "Inteligencia"))
                
                SectorMark(angle: .value("Count", Int(stats.power) ?? 0),
                           innerRadius: .ratio(0.6),
                           angularInset: 3
                ).cornerRadius(5).foregroundStyle(by: .value("Category", "Poder"))
                
                SectorMark(angle: .value("Count", Int(stats.speed) ?? 0),
                           innerRadius: .ratio(0.6),
                           angularInset: 3
                ).cornerRadius(5).foregroundStyle(by: .value("Category", "Velocidad"))
                
                SectorMark(angle: .value("Count", Int(stats.strength) ?? 0),
                           innerRadius: .ratio(0.6),
                           angularInset: 3
                ).cornerRadius(5).foregroundStyle(by: .value("Category", "Finura"))
            }
            
        }.padding(25).frame(maxWidth: .infinity, maxHeight: 350).background(.white).cornerRadius(16).padding(24)
    }
}
#Preview {
    SuperheroDetail(id:"1")
}
