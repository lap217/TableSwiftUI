//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Park, Lauren on 4/12/23.
//

import SwiftUI
import MapKit

let data = [
    Item(name: "LBJ Student Center", neighborhood: "San Marcos", desc: "The hub of activity on campus. LBJ Student Center is the perfect place for students to attend classes or club meetings, hangout, and grab a bite to eat. The University Bookstore is also located here.", lat: 29.88957777575879, long: -97.94450469092354, imageName: "stop1"),
    Item(name: "Albert B. Alkek Library", neighborhood: "San Marcos", desc: "The main central library at Texas State. Alkek provides students access to computers, scanners, printers, and study rooms.", lat: 29.88904555758779, long: -97.94308370591796, imageName: "stop2"),
    Item(name: "Harris Dining Hall", neighborhood: "San Marcos", desc: "A great place to stop by before0 or after working out at the recreation center, as it's right next door. Harris Dining Hall has a variety of food to choose from, breakfast included. ", lat: 29.888005015112544, long: -97.95163807632622, imageName: "stop3"),
    Item(name: "Student Recreation Center", neighborhood: "San Marcos", desc: "With amentities like badminton, cardio machines, dance studios, and basketball the Student Recreation Center is a good place for students to get their blood pumping. Equipment can also be checked out here with proof of student i.d.", lat: 29.888878124751166, long: -97.95055097585275, imageName: "stop4"),
    Item(name: "Student Health Center", neighborhood: "San Marcos", desc: "Student's one-stop healthcare clinic on campus. If students are ever feeling sick or in need of a check-up or medication, the Student Health Center will be fastest and most convenient.", lat: 29.890828467104114, long: -97.94616757346425, imageName: "stop5")
   
]

struct Item: Identifiable {
       let id = UUID()
       let name: String
       let neighborhood: String
       let desc: String
       let lat: Double
       let long: Double
       let imageName: String
   }


struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 29.891519526224883, longitude: -97.94611662698637), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    var body: some View {
        NavigationView {
            VStack {
                List(data, id: \.name) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        HStack {
                            Image(item.imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.neighborhood)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                Map(coordinateRegion: $region, annotationItems: data) { item in
                               MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                                   Image(systemName: "mappin.circle.fill")
                                       .foregroundColor(.red)
                                       .font(.title)
                                       .overlay(
                                           Text(item.name)
                                               .font(.subheadline)
                                               .foregroundColor(.black)
                                               .fixedSize(horizontal: true, vertical: false)
                                               .offset(y: 25)
                                       )
                               }
                           }
                           .frame(height: 300)
                           .padding(.bottom, -30)
                
            }
            .listStyle(PlainListStyle())
                    .navigationTitle("Spots on Campus")
        }


    }
}



struct DetailView: View {
    @State private var region: MKCoordinateRegion
          
          init(item: Item) {
              self.item = item
              _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
          }
    
      let item: Item
              
      var body: some View {
          VStack {
              Image(item.imageName)
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(maxWidth: 200)
              Text("Neighborhood: \(item.neighborhood)")
                  .font(.subheadline)
              Text("Description: \(item.desc)")
                  .font(.subheadline)
                  .padding(10)
                  }
                   .navigationTitle(item.name)
                   Spacer()
          
          Map(coordinateRegion: $region, annotationItems: [item]) { item in
                 MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                     Image(systemName: "mappin.circle.fill")
                         .foregroundColor(.red)
                         .font(.title)
                         .overlay(
                             Text(item.name)
                                 .font(.subheadline)
                                 .foregroundColor(.black)
                                 .fixedSize(horizontal: true, vertical: false)
                                 .offset(y: 25)
                         )
                 }
             }
                 .frame(height: 300)
                 .padding(.bottom, -30)
               
       }
    }
  
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
