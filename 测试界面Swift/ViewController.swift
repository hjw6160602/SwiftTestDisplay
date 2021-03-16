//
//  ViewController.swift
//  测试界面Swift
//
//  Created by SaiDiCaprio on 2021/3/16.
//


import UIKit
import RxSwift
import RxCocoa

fileprivate let reuseCellId = "kFaceFavorCollectionCellReuseCellId"

class ViewController: UIViewController {

    var items = [1,2,3,4,5,6,7,8,9,10]
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        let dataSource = BehaviorSubject(value: items)
        
        dataSource.bind(to: collectionView.rx.items(cellIdentifier: reuseCellId, cellType: FaceFavorCollectionCell.self)) {
            [weak self] (row, element, cell) in
            if let num = self?.items[row] {
                cell.textLabel.text = "\(num)"
            }
            cell.backgroundColor = .random
        }.disposed(by: disposeBag)
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var itemL = (kScreenWidth - 32 - 24) * 0.25
        if itemL < 79 { itemL = 79 }
        
        layout.itemSize = CGSize(width: itemL, height: itemL)
        
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        let height = kScreenHeight - kNavigationBarH - kBottomMargin
        let rect = CGRect(x: 0, y: kNavigationBarH, width: kScreenWidth, height: height)
        let cv = UICollectionView(frame: rect, collectionViewLayout: layout)
        cv.register(FaceFavorCollectionCell.self, forCellWithReuseIdentifier: reuseCellId)
        cv.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        cv.delegate = self
//        cv.dataSource = self
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressMoving(longPress:)))
        cv.addGestureRecognizer(longPress)
        cv.backgroundColor = .white
        return cv
    }()
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseCellId, for: indexPath) as! FaceFavorCollectionCell
        let num = items[indexPath.row]
        cell.textLabel.text = "\(num)"
        cell.backgroundColor = .random
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
    @objc func longPressMoving(longPress: UILongPressGestureRecognizer) {
        // 获取长按点
        let point = longPress.location(in: collectionView)
        switch longPress.state {
        case .began:
            // 根据长按点，获取对应cell的IndexPath
            guard let indexPath = collectionView.indexPathForItem(at: point) else {
                return
            }
            print(indexPath)
            collectionView.beginInteractiveMovementForItem(at: indexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(point)
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
        
    }
    
    
    // 设置第一个不可参与移动
    func collectionView(_ collectionView: UICollectionView,
                        targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath,
                        toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
        if proposedIndexPath.item == 0 {
            return originalIndexPath
        }
        if originalIndexPath.item == 0 {
            return originalIndexPath
        }
        return proposedIndexPath
    }
    
    // 设置是否可以移动
    func collectionView(_ collectionView: UICollectionView,
                        canFocusItemAt indexPath: IndexPath) -> Bool {
        guard indexPath.row > 0 else {
            return false
        }
        return true
    }
    
    // 移动后交换数据
    func collectionView(_ collectionView: UICollectionView,
                        moveItemAt sourceIndexPath: IndexPath,
                        to destinationIndexPath: IndexPath) {
        let moveData = self.items.remove(at: sourceIndexPath.row)
        self.items.insert(moveData, at: destinationIndexPath.row)
    }
}


class FaceFavorCollectionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var textLabel: UILabel = {
        let lb = UILabel()
        lb.frame = self.bounds
        lb.textAlignment = .center
        addSubview(lb)
        return lb
    }()
}
