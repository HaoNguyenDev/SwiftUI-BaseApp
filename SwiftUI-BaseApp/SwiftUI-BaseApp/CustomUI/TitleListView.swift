//
//  TitleListView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import SwiftUI

protocol TitleItem {
    var title: String { get }
}

struct TitleListView: View {
    private let kDragDismissThreshold: CGFloat = 100
    private let kMaxOffset: CGFloat = 400
    
    @State private var isShow: Bool = false
    @State private var offset: CGFloat = 400
    @State private var opacity: CGFloat = 0

    let title: String
    let items: [TitleItem]
    var onDismiss: VoidResult?
    var onSelectItem: SingleResult<(Int, TitleItem)>?

    var body: some View {
        VStack(spacing: 16) {
            VStack {
                Text("Swipe down to exit")
                    .set(font: mainFont.regular(12), and: .white)
                VStack(spacing: 16) {
                    Text(title)
                        .set(font: mainFont.bold(24), and: Color(hex: "#333333"))

                    VStack(spacing: 16) {
                        ForEach(items.indices, id: \.self) { idx in
                            Text(items[idx].title)
                                .set(font: mainFont.regular(16), and: Color(hex: "#333333"))
                                .frame(maxWidth: .infinity)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    onSelectItem?((idx, items[idx]))
                                }
                            if idx < items.count - 1 {
                                Divider()
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                }
                .padding(EdgeInsets(top: 40, leading: 32, bottom: 40, trailing: 32))
                .frame(maxWidth: .infinity)
                .background(Color.white, in: .rect(cornerRadius: 40))
            }
            .offset(y: offset)
            .opacity(opacity)
            .gesture(createDismissGesture())
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .setDefaultBackground()
        .animation(.easeOut(duration: 0.2), value: offset)
        .animation(.easeOut(duration: 0.2), value: opacity)
        .onChange(of: isShow) { newValue in
            offset = newValue ? 0 : kMaxOffset
            opacity = newValue ? 1 : 0
            if !newValue {
                onDismiss?()
            }
        }
        .onAppear {
            // Add a slight delay to ensure the view is fully rendered
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isShow = true
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private func createDismissGesture() -> some Gesture {
        DragGesture()
            .onChanged { value in
                let translation = max(0, value.translation.height)
                offset = translation
                opacity = 1 - translation / kMaxOffset
            }
            .onEnded { value in
                isShow = value.translation.height < kDragDismissThreshold
                offset = isShow ? 0 : kMaxOffset
                opacity = isShow ? 1 : 0
            }
    }
}

