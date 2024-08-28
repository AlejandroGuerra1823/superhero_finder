//
//  PrincipalView.swift
//  superhero_finder
//
//  Created by Alejandro Guerra on 24/08/24.
//

import SwiftUI

struct PrincipalView: View {
    @State var superheroName:String = ""
    @State var wrapper:ApiNetwork.Wrapper? = nil
    var body: some View {
        VStack{
            TextField("", text: $superheroName, prompt: Text("Superman...").font(.title2).bold().foregroundColor(.gray)).font(.title2).bold().foregroundColor(.white).padding(16).border(.purple).padding(8).autocorrectionDisabled().onSubmit {
                print(superheroName)
                Task{
                    do{
                        wrapper = try await ApiNetwork().getHeroesByQuery(query: superheroName)
                    }catch{
                        print("error")
                    }
                    
                }
            }
            
            
            List(wrapper?.results ?? []){ superhero in
                Text(superhero.name)
                
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(.black
        )
    }
}

#Preview {
    PrincipalView()
}
