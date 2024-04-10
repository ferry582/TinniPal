//
//  TimerPickerView.swift
//
//
//  Created by Ferry Dwianta P on 23/02/24.
//

import SwiftUI

struct TimerPickerView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedTime: TimeInterval = 60
    
    var didTimeSelected: ((TimeInterval) -> Void)? = nil
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
                
                Spacer()
                
                Button {
                    didTimeSelected?(selectedTime)
                    dismiss()
                } label: {
                    Text("Done")
                        .bold()
                }
            }
            .padding(.top, 16)
            .padding(.horizontal, 16)
            
            TimeDurationPicker(duration: $selectedTime)
        }
    }
}

struct TimeDurationPicker: UIViewRepresentable {
    typealias UIViewType = UIDatePicker
    
    @Binding var duration: TimeInterval
    
    func makeUIView(context: Context) -> UIDatePicker {
        let timeDurationPicker = UIDatePicker()
        timeDurationPicker.datePickerMode = .countDownTimer
        timeDurationPicker.addTarget(context.coordinator, action: #selector(Coordinator.changed(_:)), for: .valueChanged)
        return timeDurationPicker
    }
    
    func updateUIView(_ uiView: UIDatePicker, context: Context) {
        uiView.countDownDuration = duration
    }
    
    func makeCoordinator() -> TimeDurationPicker.Coordinator {
        Coordinator(duration: $duration)
    }
    
    class Coordinator: NSObject {
        private var duration: Binding<TimeInterval>
        
        init(duration: Binding<TimeInterval>) {
            self.duration = duration
        }
        
        @objc func changed(_ sender: UIDatePicker) {
            self.duration.wrappedValue = sender.countDownDuration
        }
    }
}

