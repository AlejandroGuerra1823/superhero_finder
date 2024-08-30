//
//  PrincipalView.swift
//  superhero_finder
//
//  Created by Alejandro Guerra on 24/08/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct PrincipalView: View {
    @State var superheroName:String = ""
    @State var wrapper:ApiNetwork.Wrapper? = nil
    @State var loading: Bool = false
    var body: some View {
        VStack{
            TextField("", text: $superheroName, prompt: Text("Superman...").font(.title2).bold().foregroundColor(.gray)).font(.title2).bold().foregroundColor(.white).padding(16).border(.purple).padding(8).autocorrectionDisabled().onSubmit {
                loading = true
                print(superheroName)
                Task{
                    do{
                        wrapper = try await ApiNetwork().getHeroesByQuery(query: superheroName)
                    }catch{
                        print("error")
                    }
                    loading = false
                }
            }
            if loading {
                ProgressView().tint(.white)
            }
            
            NavigationStack{
                List(wrapper?.results ?? []){ superhero in
                    ZStack{
                        SuperheroItem(superhero: superhero)
                        NavigationLink(destination: SuperheroDetail(id: superhero.id)){EmptyView().opacity(0)}
                    }.listRowBackground(Color.black)
                }.listStyle(.plain)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(.black
        )
    }
}

struct SuperheroItem:View {
    
    let superhero:ApiNetwork.Superhero
    
    var body: some View {
        ZStack{
            WebImage(url: URL(string: superhero.image.url)).resizable().indicator(.activity).scaledToFill().frame(height: 200)
            VStack{
                Spacer()
                Text("\(superhero.name)").foregroundColor(.white).font(.title).bold().padding().frame(maxWidth: .infinity).background(.red.opacity(0.5))
            }
        }.frame(height: 200).cornerRadius(32)
    }
}


#Preview {
    PrincipalView()
}
