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
            TextField("", text: $superheroName, prompt: Text("Find your hero").font(.title).bold().foregroundColor(.white)).foregroundColor(.white)
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(.black
        )
    }
}

#Preview {
    PrincipalView()
}
