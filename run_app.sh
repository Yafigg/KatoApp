#!/bin/bash

echo "🚀 Menjalankan Kato App..."
echo "📱 Flutter Mobile App untuk Supply Chain Digital"

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter tidak ditemukan. Silakan install Flutter terlebih dahulu."
    exit 1
fi

# Check Flutter version
echo "📋 Flutter version:"
flutter --version

echo ""
echo "🔧 Getting dependencies..."
flutter pub get

echo ""
echo "📱 Running app..."
echo "💡 Tips: Gunakan 'r' untuk hot reload, 'R' untuk hot restart, 'q' untuk quit"

# Run the app
flutter run

