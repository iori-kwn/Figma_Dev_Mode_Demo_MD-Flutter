#!/bin/bash

# Figma Material 3 Flutter App Setup Script
echo "🚀 Setting up Flutter Material 3 App..."

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    echo "   Visit: https://docs.flutter.dev/get-started/install"
    exit 1
fi

echo "✅ Flutter found: $(flutter --version | head -n 1)"

# Check Flutter doctor
echo "🏥 Running Flutter doctor..."
flutter doctor

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Generate launcher icons (if available)
if flutter pub deps | grep -q "flutter_launcher_icons"; then
    echo "🎨 Generating launcher icons..."
    flutter pub run flutter_launcher_icons:main
fi

# Analyze code
echo "🔍 Analyzing code..."
flutter analyze

# Run tests
echo "🧪 Running tests..."
flutter test

echo "✨ Setup complete!"
echo ""
echo "To run the app:"
echo "  flutter run"
echo ""
echo "To run on specific device:"
echo "  flutter devices              # List available devices"
echo "  flutter run -d <device_id>   # Run on specific device"
echo ""
echo "To build for release:"
echo "  flutter build apk            # Android APK"
echo "  flutter build ipa            # iOS IPA"
echo "  flutter build web            # Web build"
