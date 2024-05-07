//
//  ContentView.swift
//  SwiftKmpPersistence
//
//  Created by Miguel Aragüés on 7/5/24.
//

import SwiftUI
import shared

struct ContentView: View {
    
    var database : AppDatabase = DatabaseKt.getRoomDatabase(builder: DatabaseKt.getDatabaseBuilder())
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Click to insert") {
                var movieToInsert: MovieEntity = MovieEntity(id: 0, title: "Superman", content: "Action")
                
                Task {
                    var count: Int = try await database.getDao().count().intValue
                    print("Count pre insert \(count)")
                    
                    try await database.getDao().insert(item: movieToInsert)
                    
                    var count2: Int = try await database.getDao().count().intValue
                    print("Count pre insert \(count2)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
