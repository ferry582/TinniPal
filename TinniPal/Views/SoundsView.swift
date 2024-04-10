//
//  SoundsView.swift
//  TinniPal
//
//  Created by Ferry Dwianta P on 14/02/24.
//

import SwiftUI

struct SoundsView: View {
    @StateObject private var viewModel = SoundsViewModel()
    
    @State private var isNavigateToConfig = false
    @State private var showTimerPickerPopOver = false
    @State private var showStopAlert = false
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    private let spacing: CGFloat = 8
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                List {
                    ForEach(viewModel.soundsData, id: \.self) { category in
                        Section {
                            LazyVGrid(columns: columns, spacing: spacing) {
                                ForEach(category.sounds, id: \.self) { sound in
                                    let cellWidth = proxy.size.width/4 - spacing * 3
                                    VStack {
                                        Group {
                                            let image = sound.isPlaying ? sound.activeIcon : sound.inactiveIcon
                                            if let _ = UIImage(systemName: image) {
                                                Image(systemName: image)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 24, height: 24)
                                            } else {
                                                Image(image)
                                                    .renderingMode(.template)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 24, height: 24)
                                            }
                                        }
                                        .foregroundStyle(sound.isPlaying ? Color.white : Color("SecondaryText"))
                                        .frame(width: cellWidth, height: cellWidth)
                                        .background(sound.isPlaying ? Color.accentColor : Color("SoundDisableColor"))
                                        .cornerRadius(10)
                                        
                                        Text(sound.title)
                                            .font(.subheadline)
                                    }
                                    .padding(.bottom, 6)
                                    .onTapGesture {
                                        viewModel.soundClicked(categoryId: category.id, soundId: sound.id)
                                    }
                                }
                            }
                        } header: {
                            Text(category.title)
                                .bold()
                        }
                        .listRowBackground(Color.clear)
                        .listSectionSeparator(.hidden)
                    }
                }
                .background(Color(UIColor.secondarySystemBackground))
                .listStyle(.grouped)
                .scrollIndicators(.hidden)
                
                HStack {
                    Button {
                        if viewModel.isAnySoundPlaying {
                            if viewModel.isTimerOn {
                                showStopAlert.toggle()
                            } else {
                                showTimerPickerPopOver.toggle()
                            }
                        }
                    } label: {
                        Image(systemName: viewModel.isTimerOn ? "gauge.with.needle.fill" : "gauge.with.needle")
                            .font(.title)
                            .foregroundStyle(viewModel.isAnySoundPlaying ? Color.accentColor : Color("DisableColor"))
                    }
                    .popover(isPresented: $showTimerPickerPopOver, attachmentAnchor: .point(.topTrailing), arrowEdge: .bottom) {
                        if #available(iOS 16.4, *) {
                            TimerPickerView(didTimeSelected: { time in
                                viewModel.startCountDownTimer(deadline: time)
                            })
                            .frame(height: 250)
                            .presentationCompactAdaptation(.none)
                        } else {
                            TimerPickerView(didTimeSelected: { time in
                                viewModel.startCountDownTimer(deadline: time)
                            })
                            .presentationDetents([.height(250)])
                        }
                    }
                    .alert(isPresented: $showStopAlert) {
                        Alert(title: Text("Stop TImer"), message: Text("Do you want to stop the timer?"), primaryButton: .destructive(Text("Stop"), action: {
                            viewModel.stopCountDownTimer()
                        }), secondaryButton: .cancel(Text("Cancel")))
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("TIMER")
                            .font(.caption2)
                        Text(viewModel.timerCount)
                            .font(.title2)
                    }
                    
                    Spacer()
                    
                    Button {
                        if viewModel.isAnySoundPlaying {
                            viewModel.startStopButtonClicked()
                        }
                    } label: {
                        Image(systemName: viewModel.isSoundsPlayed ? "pause.fill" : "play.fill")
                            .font(.title)
                            .foregroundStyle(viewModel.isAnySoundPlaying ? Color.accentColor : Color("DisableColor"))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 4)
                
            }
            .toolbar {
                if UIDevice.current.userInterfaceIdiom == .phone {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isNavigateToConfig.toggle()
                        } label: {
                            Image(systemName: "gearshape.fill")
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $isNavigateToConfig) {
                ConfigView()
                    .navigationTitle("Configuration")
            }
        }
    }
}

#Preview {
    SoundsView()
}
