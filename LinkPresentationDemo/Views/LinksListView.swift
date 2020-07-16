//
//  LinksListView.swift
//  LinkPresentationDemo
//
//  Created by Gabriel Theodoropoulos.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import SwiftUI

struct LinksListView: View {
    @EnvironmentObject var linksList: LinksModel
    @State private var showInputLinkView = false
    @State private var linkToShare: Link?
    
    var body: some View {
        NavigationView {
            VStack {
                List(linksList.links, rowContent: { link in
                    Button(action: {
                        
                        self.linkToShare = link
                        
                    }) {
                        LinkView(metadata: link.metadata)
                            .disabled(true)
                    }
                        .padding(.vertical, 20)
                })
                
                
                if linkToShare != nil {
                    ShareLinkView(metadata: linkToShare!.metadata, completion: {
                        self.linkToShare = nil
                    })
                        .frame(width: 0, height: 0)
                }
                
            }
            .navigationBarTitle("Links")
            .navigationBarItems( trailing:
                Button(action: {
                    self.showInputLinkView = true
                }) {
                    Image(systemName: "plus.circle")
                        .font(.title)
                }
                .sheet(isPresented: self.$showInputLinkView) {
                    InputLinkView()
                        .environmentObject(self.linksList)
                }
            )
        }
    }
}

struct LinksListView_Previews: PreviewProvider {
    static var previews: some View {
        LinksListView().environmentObject(LinksModel())
    }
}
