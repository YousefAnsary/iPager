//
//  IPagerCell.swift
//
//  Created by Youssef El-Ansary on 16/10/2021.
//

import UIKit

class IPagerCell: UICollectionViewCell {
    
    lazy var view: UIView = {
        let view = UIView(frame: self.frame)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(view)
        self.backgroundColor = .clear
        NSLayoutConstraint.activate([
            view.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            view.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            view.heightAnchor.constraint(equalTo: self.heightAnchor),
            view.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
