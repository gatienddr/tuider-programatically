//
//  ProfilViewController.swift
//  tuider-programatically
//
//  Created by Gatien DIDRY on 27/11/2022.
//

import UIKit

final class ProfilViewController: UIViewController {

    // MARK: Private Properties

    let imageView = UIImageView(image: UIImage(named: "domingo"))
    let imageViewArea = UIView()
    let widthImageViewArea = UIScreen.main.bounds.width / 2

    let cardView = UIView()

    let completeProfileView = UIView()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    // MARK: Private method
    private func setUpView() {

        self.imageViewArea.translatesAutoresizingMaskIntoConstraints = false
        self.imageViewArea.backgroundColor = .red
        self.imageViewArea.layer.cornerRadius = self.widthImageViewArea / 2
        self.imageViewArea.clipsToBounds = true

        self.imageView.contentMode = .scaleAspectFit
        self.imageView.translatesAutoresizingMaskIntoConstraints = false

        let cardView = UIView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = .systemGroupedBackground
        cardView.layer.cornerRadius = 30
        cardView.clipsToBounds = true

        self.completeProfileView.backgroundColor = .red
        self.completeProfileView.translatesAutoresizingMaskIntoConstraints = false
        self.completeProfileView.layer.cornerRadius = 10

        // area under pic
        let backgroundImageColor = UIImageView(image: UIImage(named: "background_text"))
        self.completeProfileView.clipsToBounds = true
        backgroundImageColor.translatesAutoresizingMaskIntoConstraints = false
        self.completeProfileView.addSubview(backgroundImageColor)

        // Label under pic
        let completeProfileLabel = UILabel()
        completeProfileLabel.translatesAutoresizingMaskIntoConstraints = false
        completeProfileLabel.text = "Completed at 56 %"
        completeProfileLabel.textColor = .white

        completeProfileView.addSubview(completeProfileLabel)

        // circle around pic

        let xPosCircle = UIScreen.main.bounds.width / 2
        let yPosCircle: Double = 100

        let circlePath = UIBezierPath(
            arcCenter: CGPoint(
                x: xPosCircle,
                y: yPosCircle
            ),
            radius: 100,
            startAngle: 0,
            endAngle: 10,
            clockwise: true
        )

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath

        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 3.0

        cardView.layer.addSublayer(shapeLayer)

        view.addSubview(cardView)
        cardView.addSubview(self.imageViewArea)
        cardView.addSubview(self.completeProfileView)

        self.imageViewArea.addSubview(self.imageView)

        NSLayoutConstraint.activate([
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),

            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            imageViewArea.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            imageViewArea.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 50),
            imageViewArea.heightAnchor.constraint(equalToConstant: self.widthImageViewArea ),
            imageViewArea.widthAnchor.constraint(equalToConstant: self.widthImageViewArea),

            imageView.heightAnchor.constraint(equalToConstant: self.widthImageViewArea),
            imageView.widthAnchor.constraint(equalToConstant: self.widthImageViewArea),

            self.completeProfileView.centerXAnchor.constraint(equalTo: self.imageViewArea.centerXAnchor),
            self.completeProfileView.topAnchor.constraint(equalTo: self.imageViewArea.bottomAnchor, constant: -30),
            completeProfileView.widthAnchor.constraint(equalToConstant: self.widthImageViewArea),
            completeProfileView.heightAnchor.constraint(equalToConstant: 30),

            completeProfileLabel.centerXAnchor.constraint(equalTo: completeProfileView.centerXAnchor),
            completeProfileLabel.centerYAnchor.constraint(equalTo: completeProfileView.centerYAnchor),

            backgroundImageColor.centerXAnchor.constraint(equalTo: self.completeProfileView.centerXAnchor),
            backgroundImageColor.centerYAnchor.constraint(equalTo: self.completeProfileView.centerYAnchor),

        ])
    }

}
