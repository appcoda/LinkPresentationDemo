//
//  LinksModel.swift
//  LinkPresentationDemo
//
//  Created by Gabriel Theodoropoulos.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import Foundation
import LinkPresentation

class LinksModel: ObservableObject {
    
    @Published var links = [Link]()
    
    
    init() {
        loadLinks()
    }
    
    
    func createLink(with metadata: LPLinkMetadata) {
        let link = Link()
        link.id = Int(Date.timeIntervalSinceReferenceDate)
        link.metadata = metadata
        links.append(link)
        saveLinks()
    }
    
    
    fileprivate func saveLinks() {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: links, requiringSecureCoding: true)
            guard let docDirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
            try data.write(to: docDirURL.appendingPathComponent("links"))
            print(docDirURL.appendingPathComponent("links"))
        } catch {
            print(error.localizedDescription)
        }
    }
        
    
    fileprivate func loadLinks() {
        guard let docDirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let linksURL = docDirURL.appendingPathComponent("links")

        if FileManager.default.fileExists(atPath: linksURL.path) {
            do {
                let data = try Data(contentsOf: linksURL)
                guard let unarchived = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Link] else { return }
                links = unarchived
            } catch {
                print(error.localizedDescription)
            }
        }
    }
        
    
    class func fetchMetadata(for link: String, completion: @escaping (Result<LPLinkMetadata, Error>) -> Void) {
        guard let url = URL(string: link) else { return }
        
        let metadataProvider = LPMetadataProvider()
        metadataProvider.startFetchingMetadata(for: url) { (metadata, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let metadata = metadata {
                completion(.success(metadata))
            }
        }
    }
    
}
