//
//  SearchBar.swift
//  ChessReader
//
//  Created by Axel Söderberg on 2021-02-23.
//

import Foundation
import SwiftUI

struct CustomSearchBar: UIViewControllerRepresentable {
    
    
    
    func makeCoordinator() -> Coordinator {
        return CustomSearchBar.Coordinator(parent: self)
    }
    
    var view: ReadGameView
    
    var largeTitle: Bool
    var title: String
    var placeHolder: String
    
    var onSearch: (String)->()
    var onCancel: ()->()
    
    init(view: ReadGameView,onSearch: @escaping (String)->(), onCancel: @escaping ()->()) {
        self.title = title
        self.largeTitle = largeTitle!
        self.placeHolder = placeHolder!
        self.view = view
        self.onSearch = onSearch
        self.onCancel = onCancel
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        
        let childView = UIHostingController(rootView: view)
        
        let controller = UINavigationController(rootViewController: childView)
        
        controller.navigationBar.topItem?.title = title
        controller.navigationBar.prefersLargeTitles = largeTitle
        
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = placeHolder
        
        searchController.searchBar.delegate = context.coordinator
        
        searchController.obscuresBackgroundDuringPresentation = false
        
        controller.navigationBar.topItem?.hidesSearchBarWhenScrolling = false
        controller.navigationBar.topItem?.searchController = searchController
        
        return controller
        
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        uiViewController.navigationBar.topItem?.title = title
        uiViewController.navigationBar.topItem?.searchController?.searchBar.placeholder = placeHolder
        uiViewController.navigationBar.preferensLargeTitles = largeTitle
    }
    
    
    class Coordinator: NSObject,UISearchBarDelegate{
        
        var parent: CustomSearchBar
        
        init(parent: CustomSearchBar) {
            self.parent = parent
        }
        
        func searchBar(_searchBar: UISearchBar, textDidChange searchText: String){
            
            self.parent.onSearch(searchText)
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         
            self.parent.onCancel()
            
            
            
        }
    }
}

