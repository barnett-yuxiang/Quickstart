//
//  SnapKitDemoView.swift
//  Quickstart
//
//  Created by AI Assistant
//

import SwiftUI
import UIKit
import SnapKit

// MARK: - UIKit View 使用 SnapKit
class SnapKitDemoViewController: UIViewController {

    // UI 元素
    private let titleLabel = UILabel()
    private let redBox = UIView()
    private let blueBox = UIView()
    private let button = UIButton(type: .system)
    private let stackContainer = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        view.backgroundColor = .systemBackground

        // 标题标签
        titleLabel.text = "SnapKit 基础用法演示"
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .label

        // 红色方块
        redBox.backgroundColor = .systemRed
        redBox.layer.cornerRadius = 12

        // 蓝色方块
        blueBox.backgroundColor = .systemBlue
        blueBox.layer.cornerRadius = 12

        // 按钮
        button.setTitle("点击我!", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        // 容器视图
        stackContainer.backgroundColor = .systemGray6
        stackContainer.layer.cornerRadius = 16

        // 添加到视图层次
        view.addSubview(titleLabel)
        view.addSubview(stackContainer)
        stackContainer.addSubview(redBox)
        stackContainer.addSubview(blueBox)
        view.addSubview(button)
    }

    private func setupConstraints() {
        // 🔥 SnapKit 基础用法演示

        // 1. 标题标签 - 顶部居中
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        // 2. 容器视图 - 居中，固定大小
        stackContainer.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(280)
            make.height.equalTo(200)
        }

        // 3. 红色方块 - 左上角
        redBox.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(80)
        }

        // 4. 蓝色方块 - 右下角
        blueBox.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(80)
        }

        // 5. 按钮 - 底部居中
        button.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-40)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }

    @objc private func buttonTapped() {
        // 🎯 动画演示 SnapKit 更新约束
        UIView.animate(withDuration: 0.5, animations: {
            // 随机改变红色方块的位置
            let randomOffset = Int.random(in: 20...100)
            self.redBox.snp.updateConstraints { make in
                make.top.leading.equalToSuperview().inset(randomOffset)
            }
            self.view.layoutIfNeeded()
        })

        // 按钮反馈
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

// MARK: - SwiftUI Wrapper
struct SnapKitDemoView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> SnapKitDemoViewController {
        return SnapKitDemoViewController()
    }

    func updateUIViewController(_ uiViewController: SnapKitDemoViewController, context: Context) {
        // 这里可以处理 SwiftUI 数据变化
    }
}

// MARK: - Preview
#Preview {
    SnapKitDemoView()
}