//
//  ContentView.swift
//  SwiftKmpPersistence
//
//  Created by Miguel Aragüés on 7/5/24.
//

import SwiftUI
import shared

struct ContentView: View {
    
    var database: Database = DatabaseKt.getDatabase()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Click to insert") {
                let movieToInsert: MovieEntity = MovieEntity()
                movieToInsert.title = "Superman"
                
                Task {
                    var count: Int = try await database.movieDao.count().intValue
                    print("Count pre insert \(count)")
                    
                    try await database.movieDao.insert(item: movieToInsert)
                    
                    var count2: Int = try await database.movieDao.count().intValue
                    print("Count pre insert \(count2)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
