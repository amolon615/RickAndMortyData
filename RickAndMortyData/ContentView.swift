//
//  test.swift
//  BucketList
//
//  Created by Artem on 03/12/2022.
//

import SwiftUI
//import Combine

struct ContentView: View {
    // The characters array that will store the fetched data
    @State var characters: [Character] = []

    var body: some View {
        // Use a List to display the characters
        VStack{
            List(characters) { character in
                HStack{
                    AsyncImage(url: URL(string: character.image), scale: 3) {
                        image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                        
                    }
                    .frame(height: 50)
//                        .resizable()
//                        .frame(width: 50, height: 50)

                    Text(character.name)
                }
                }
            .onAppear(perform: loadData)
        }
      
    }


    // The loadData method that fetches and decodes the JSON data from the API
    func loadData() {
        // Use the URLSession API to fetch the JSON data from the API
        URLSession.shared.dataTask(with: URL(string: "https://rickandmortyapi.com/api/character")!) { (data, response, error) in
            // Ensure that we have data and no error
            guard let data = data, error == nil else { return }

            // Decode the JSON data into the root JSON object
            let json = try! JSONDecoder().decode(RootJSON.self, from: data)

            // Set the characters array to the results from the JSON object
            DispatchQueue.main.async {
                self.characters = json.results
                print(characters)
            }
        }.resume()
    }
}


struct DetailedView: View {
    @State var characters: [Character] = []
    
    var body: some View {
        List(characters) { character in
        Text(character.location.name)
                   }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



