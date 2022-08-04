//
//  CoinDetails.swift
//  Cryptholic
//
//  Created by Berkay Disli on 4.08.2022.
//

import SwiftUI

struct CoinDetails: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var navVM: NavigationViewModel
    
    var body: some View {
        VStack {
            // Coin Info Header
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Bitcoin")
                        .font(.title3)
                        .foregroundColor(.gray)
                    Image(systemName: "star.circle")
                        .font(.system(size: 20))
                }
                .padding(.top)
                // Price and Buttons
                HStack {
                    Text("USD \(21002.51.formatted())")
                        .font(.system(size: 32))
                        .fontWeight(.medium)
                    Spacer()
                    //Buttons
                    HStack {
                        Button {
                            
                        } label: {
                            IconButton(iconName: "bell")
                        }
                        
                        Button {
                            
                        } label: {
                            IconButton(iconName: "slider.vertical.3")
                        }

                    }

                }
                // Price Change Info
                HStack{
                    Image(systemName: "arrow.down.right")
                    Text("\(2452.11.formatted())")
                    Text("(\(5.58.formatted())%)")
                }
                .fontWeight(.medium)
                .foregroundColor(.red)
                
            }
            .padding(.horizontal)
            
            // Graph
            VStack {
                Color.blue.opacity(0.15)
                    .frame(height: 500)
                    .padding(.top, 8)
                HStack {
                    ForEach(TimezoneRanges.allCases, id:\.self) { item in
                        HStack {
                            Spacer()
                            Text(item.shortTitle)
                                .font(.title3).fontWeight(.medium)
                                .foregroundColor(Color(uiColor: .darkGray))
                                .padding(.top, 4)
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 4)
            
            Divider()
            
            // Add to Fav Button
            Button {
                
            } label: {
                Text("Add to Watchlist")
                    .font(.title3).fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity).frame(height: 66)
                    .background(.black)
                    .cornerRadius(100)
                    .padding([.horizontal, .top])
            }

            
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: {
            navVM.closeTabBar()
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: "chevron.left")
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
        .navigationBarBackButtonHidden()
        
    }
}

struct CoinDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CoinDetails()
                .environmentObject(NavigationViewModel())
        }
    }
}
