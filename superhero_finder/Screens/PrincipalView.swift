//
//  PrincipalView.swift
//  superhero_finder
//
//  Created by Alejandro Guerra on 24/08/24.
//

import SwiftUI

struct PrincipalView: View {
    @State var superheroName:String = ""
    
    var body: some View {
        VStack{
            TextField("", text: $superheroName, prompt: Text("Superman...").font(.title2).bold().foregroundColor(.gray)).font(.title2).bold().foregroundColor(.white).padding(16).border(.purple).padding(8).autocorrectionDisabled().onSubmit {
                print(superheroName)
                ApiNetwork().getHeroesByQuery(query: superheroName)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(.black
        )
    }
}

#Preview {
    PrincipalView()
}
