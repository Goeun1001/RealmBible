//
//  CheckListToUI.swift
//  BibleCheckList
//
//  Created by jge on 2020/08/24.
//  Copyright © 2020 eunjin. All rights reserved.
//

import SwiftUI

struct CheckListToUI: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = BooksViewController
    
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> UIViewControllerType {
        let storyboard = UIStoryboard(name: "ReadALL", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "BooksViewController")
        return controller as! BooksViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    //    typealias UIViewControllerType = UINavigationController
    //
    //    @available(iOS 13.0, *)
    //    func makeUIViewController(context: Context) -> UINavigationController {
    //        let viewController = BooksViewController()
    //        let navigationController = UINavigationController(rootViewController: viewController)
    //        return navigationController
    //    }
    //
    //    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    //
    //    }
    
}
