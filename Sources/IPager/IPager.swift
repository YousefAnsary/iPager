//
//  IPagerCell.swift
//
//  Created by Youssef El-Ansary on 16/10/2021.
//

import UIKit

public class IPager: UIView {
    
    // MARK: - Variables
    @IBInspectable
    public var dotSize: CGSize = CGSize(width: 8, height: 8)
    @IBInspectable
    public var selectedDotSize: CGSize = CGSize(width: 14, height: 14)
    @IBInspectable
    public var spacing: CGFloat = 8
    @IBInspectable
    public var circularDot: Bool = true
    @IBInspectable
    public var tint: UIColor = .gray
    @IBInspectable
    public var selectedTint: UIColor = .blue
    @IBInspectable
    public var isPageSelectionEnabled = false
    //
    public var didSelectedPageAt: ((Int) -> Void)?
    public var numberOfPages: Int = 3 {
        didSet {
            self.updateCVWidth()
            self.collectionView.reloadData()
        }
    }
    public var currentPage: Int = 0 {
        didSet {
            self.updateSelectedPage()
        }
    }
    private var _currentPage = 0
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = spacing
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.register(
            IPagerCell.self,
            forCellWithReuseIdentifier: String(describing: IPagerCell.self)
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    private var cvWidthConstraint: NSLayoutConstraint!
    private var collectionWidth: CGFloat {
        min(contentWidth, frame.width)
    }
    private var contentWidth: CGFloat {
        let totalCellWidth = dotSize.width * CGFloat(numberOfPages - 1) + selectedDotSize.width
        let totalSpacingWidth = spacing * CGFloat(numberOfPages - 1)
        let contentWidth = totalCellWidth + totalSpacingWidth
        return contentWidth
    }
    
    // MARK: - Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupViews()
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        self.addSubview(collectionView)
        self.backgroundColor = .clear
        cvWidthConstraint = collectionView.widthAnchor.constraint(
            equalToConstant: contentWidth
        )
        self.updateCVWidth()
        NSLayoutConstraint.activate([
            collectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            collectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            collectionView.heightAnchor.constraint(equalTo: self.heightAnchor),
            cvWidthConstraint
        ])
    }
    
    private func updateCVWidth() {
        /*
         * Postponing calculation in case of zero frame caused by UIView.init()
         * to avoid calculating wrong width (will be zero)
         */
        let latencyTime = frame == .zero ? 0.3 : 0
        DispatchQueue.main.asyncAfter(deadline: .now() + latencyTime) {
            self.cvWidthConstraint.constant = self.collectionWidth
        }
    }
    
    private func updateSelectedPage() {
        guard currentPage != _currentPage else { return }
        let validRange = 0...numberOfPages - 1
        guard validRange.contains(currentPage) else { // Reset to last valid
            currentPage = _currentPage
            return
        }
        collectionView.performBatchUpdates {
            self.collectionView.reloadItems(
                at: [IndexPath(row: currentPage, section: 0),
                     IndexPath(row: _currentPage, section: 0)]
            )
        }
        scrollToSelectedPage()
        _currentPage = currentPage
    }
    
    /// Scrolls to next/prev page of the selected one if available
    private func scrollToSelectedPage() {
        let isScrollingForward = currentPage > _currentPage
        let firstIndex = 0
        let lastIndex = numberOfPages - 1
        let nextPage = currentPage + 1
        let prevPage = currentPage - 1
        let scrollDestination = isScrollingForward ? min(nextPage, lastIndex) : max(prevPage, firstIndex)
        self.collectionView.scrollToItem(
            at: IndexPath(item: scrollDestination, section: 0),
            at: .centeredHorizontally,
            animated: true
        )
    }
}

// MARK: - UICollectionView
extension IPager: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return numberOfPages
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: IPagerCell.self),
            for: indexPath
        ) as! IPagerCell
        cell.view.layer.cornerRadius = circularDot ? cell.frame.height / 2 : 0
        cell.view.backgroundColor = indexPath.row == currentPage ? selectedTint : tint
        return cell
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return indexPath.row == currentPage ? selectedDotSize : dotSize
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard isPageSelectionEnabled else { return }
        self.currentPage = indexPath.row
        self.didSelectedPageAt?(self.currentPage)
    }
}
