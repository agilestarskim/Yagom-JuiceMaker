//
//  StockViewController.swift
//  JuiceMaker
//
//  Created by Minsup, Serena on 2023/05/15.
//

import UIKit

class StockViewController: UIViewController {
    
    private let juiceMaker: JuiceMaker
    
    @IBOutlet weak private var viewControllerTitle: UILabel!
    @IBOutlet weak private var strawberryStockLabel: UILabel!
    @IBOutlet weak private var bananaStockLabel: UILabel!
    @IBOutlet weak private var pineappleStockLabel: UILabel!
    @IBOutlet weak private var kiwiStockLabel: UILabel!
    @IBOutlet weak private var mangoStockLabel: UILabel!
    
    @IBOutlet weak private var strawberryStepper: UIStepper!
    @IBOutlet weak private var bananaStepper: UIStepper!
    @IBOutlet weak private var pineappleStepper: UIStepper!
    @IBOutlet weak private var kiwiStepper: UIStepper!
    @IBOutlet weak private var mangoStepper: UIStepper!
    
    init?(juiceMaker: JuiceMaker, coder:NSCoder) {
        self.juiceMaker = juiceMaker
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitle()
        configureLabel()
        configureStepper()
        configureStepperTag()
    }
    
    private func configureTitle() {
        self.viewControllerTitle.text = Navigation.title
    }
    
    private func configureLabel() {
        self.strawberryStockLabel.text = juiceMaker.getStock(fruit: .strawberry).toString
        self.bananaStockLabel.text = juiceMaker.getStock(fruit: .banana).toString
        self.pineappleStockLabel.text = juiceMaker.getStock(fruit: .pineapple).toString
        self.kiwiStockLabel.text = juiceMaker.getStock(fruit: .kiwi).toString
        self.mangoStockLabel.text = juiceMaker.getStock(fruit: .mango).toString
    }
    
    private func configureStepper() {
        self.strawberryStepper.value = juiceMaker.getStock(fruit: .strawberry).toDouble
        self.bananaStepper.value = juiceMaker.getStock(fruit: .banana).toDouble
        self.pineappleStepper.value = juiceMaker.getStock(fruit: .pineapple).toDouble
        self.kiwiStepper.value = juiceMaker.getStock(fruit: .kiwi).toDouble
        self.mangoStepper.value = juiceMaker.getStock(fruit: .mango).toDouble
    }
    
    private func configureStepperTag() {
        self.strawberryStepper.tag = FruitTag.strawberry
        self.bananaStepper.tag = FruitTag.banana
        self.pineappleStepper.tag = FruitTag.pineapple
        self.kiwiStepper.tag = FruitTag.kiwi
        self.mangoStepper.tag = FruitTag.mango
    }
    
    @IBAction private func tapCloseButton() {
        self.updateStock()
        self.dismiss(animated: true)
    }
    
    @IBAction private func tapStockEditButton(_ sender: UIStepper) {
        switch sender.tag {
        case FruitTag.strawberry:
            self.strawberryStockLabel.text = sender.value.toString
        case FruitTag.banana:
            self.bananaStockLabel.text = sender.value.toString
        case FruitTag.pineapple:
            self.pineappleStockLabel.text = sender.value.toString
        case FruitTag.kiwi:
            self.kiwiStockLabel.text = sender.value.toString
        case FruitTag.mango:
            self.mangoStockLabel.text = sender.value.toString
        default:
            return
        }
    }
    
    private func updateStock() {
        let newStock: [Fruit: Int] = [
            .strawberry: self.strawberryStockLabel.text.toInt ?? 0,
            .banana: self.bananaStockLabel.text.toInt ?? 0,
            .pineapple: self.pineappleStockLabel.text.toInt ?? 0,
            .kiwi: self.kiwiStockLabel.text.toInt ?? 0,
            .mango: self.mangoStockLabel.text.toInt ?? 0
        ]
        juiceMaker.updateStock(to: newStock)
    }
}

extension StockViewController {
    enum Navigation {
        static let title = "재고추가"
    }
    enum FruitTag {
        static let strawberry = 0
        static let banana = 1
        static let pineapple = 2
        static let kiwi = 3
        static let mango = 4
    }
}
