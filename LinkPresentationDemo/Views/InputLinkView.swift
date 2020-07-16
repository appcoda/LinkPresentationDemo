//
//  InputLinkView.swift
//  LinkPresentationDemo
//
//  Created by Gabriel Theodoropoulos.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import SwiftUI
import LinkPresentation

struct InputLinkView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var linksList: LinksModel
    @State private var link: String = ""
    @State private var metadata: LPLinkMetadata?
    
    var body: some View {
        VStack {
            // Top buttons.
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark.circle")
                        .font(.title).foregroundColor(.gray)
                }
                
                Spacer()
                
                Button(action: {
                    
                    self.keepLink()
                    
                }) {
                    Image(systemName: "checkmark.circle")
                        .font(.title).foregroundColor(.gray)
                }
            }
            .padding(20)
            
            
            // Text field.
            TextField("Type or paste a link...", text: $link, onEditingChanged: { (changed) in
                
                if self.metadata != nil {
                    self.metadata = nil
                }
                
            }) {
                
                LinksModel.fetchMetadata(for: self.link) { (result) in
                    self.handleLinkFetchResult(result)
                }
                
            }
                .font(.title)
                .multilineTextAlignment(.center)
                .keyboardType(.URL)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding(.horizontal, 8)
                .padding(.top, 20)
            
            
            Spacer()
            
            // Link preview.
            HStack {
                if metadata != nil {
                    
                    LinkView(metadata: metadata)
                        .aspectRatio(contentMode: .fit)
                    
                } else {
                    Text("Link preview will be shown here")
                        .font(.title)
                        .fontWeight(.thin)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.init(white: 0.4))
                }
            }
                .padding(20)
            
            Spacer()
            
        }
    }
    
    
    private func handleLinkFetchResult(_ result: Result<LPLinkMetadata, Error>) {
        DispatchQueue.main.async {
            switch result {
                case .success(let metadata): self.metadata = metadata
                case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    
    private func keepLink() {
        guard let metadata = self.metadata else { return }

        // Create the Link object and save all links metadata to file.
        self.linksList.createLink(with: metadata)

        // Dismiss InputLinkView instance.
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct InputLinkView_Previews: PreviewProvider {
    static var previews: some View {
        InputLinkView()
    }
}
