import SwiftUI

struct ModernWeatherView: View {
    @State private var viewModel = ModernWeatherViewModel()

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(red: 0.10, green: 0.36, blue: 0.74), Color(red: 0.19, green: 0.69, blue: 0.88)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 18) {
                HStack {
                    Text(viewModel.cityName)
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(.white)
                    Spacer()
                    Button {
                        Task { await viewModel.refresh() }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .font(.title3)
                            .foregroundStyle(.white)
                    }
                }
                .padding(.horizontal)

                VStack(spacing: 8) {
                    Image(systemName: viewModel.iconText)
                        .font(.system(size: 64))
                        .foregroundStyle(.white)
                    Text(viewModel.temperature)
                        .font(.system(size: 52, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                }
                .padding(.vertical)

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.footnote)
                        .foregroundStyle(.white.opacity(0.8))
                        .padding(.horizontal)
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 14) {
                        ForEach(viewModel.forecastCards) { card in
                            VStack(spacing: 10) {
                                Text(card.time)
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.8))
                                Text(card.iconText)
                                    .font(.title3)
                                Text(card.temperature)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 76, height: 120)
                            .padding(10)
                            .background(.white.opacity(0.12))
                            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                        }
                    }
                    .padding(.horizontal)
                }

                if viewModel.isLoading {
                    ProgressView()
                        .tint(.white)
                }

                Spacer()
            }
            .padding(.top, 24)
        }
        .task {
            await viewModel.refresh()
        }
    }
}

#Preview {
    ModernWeatherView()
}
