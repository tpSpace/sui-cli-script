# 🚀 Sui CLI Auto-Setup Script

A comprehensive PowerShell script that automatically sets up everything you need to start developing smart contracts on the Sui blockchain. Perfect for beginners who want to get started quickly!

## ✨ What This Script Installs

- **Chocolatey** - Windows package manager
- **Git** - Version control system
- **Sui CLI** - Sui blockchain development tools
- **Rust Toolchain** - Required for Move smart contract compilation
- **VS Code** - Code editor with Move development extensions
- **Move Analyzer Extension** - Syntax highlighting and IntelliSense for Move
- **Rust Analyzer Extension** - Rust language support

## 🎯 How to Use

### Method 1: Right-Click (Recommended)

1. Right-click on `main.bat`
2. Select "Run as Administrator"
3. Follow the on-screen instructions

### Method 2: PowerShell

1. Open PowerShell as Administrator
2. Navigate to the script directory
3. Run: `.\main.bat`

## ⚠️ Requirements

- **Windows 10/11**
- **Administrator privileges**
- **Internet connection**

## 🎉 What Happens After Installation

The script will:

1. Install all necessary tools
2. Verify each installation
3. Create a test Sui project
4. Provide next steps and helpful resources

## 📚 Next Steps for Beginners

After running the script:

1. **Restart your terminal** to refresh PATH variables
2. **Verify installation**: `sui --version`
3. **Create your first project**: `sui move new my-first-project`
4. **Navigate to project**: `cd my-first-project`
5. **Build your project**: `sui move build`
6. **Test your project**: `sui move test`

## 🔗 Helpful Resources

- [Sui Documentation](https://docs.sui.io/)
- [Move Language Guide](https://move-language.github.io/move/)
- [Sui Examples](https://github.com/MystenLabs/sui/tree/main/sui_programmability/examples)
- [Sui Discord Community](https://discord.gg/sui)

## 🛠️ Troubleshooting

### If the script fails

1. Make sure you're running as Administrator
2. Check your internet connection
3. Try running PowerShell as Administrator manually
4. Some tools may require a terminal restart to be available

### Common Issues

- **"sui command not found"**: Restart your terminal
- **"rustc not found"**: Restart your terminal
- **VS Code extensions not installed**: Run `code --install-extension move.move-analyzer`

## 💡 Pro Tips

- Open VS Code in your project folder: `code my-first-project`
- Use the Move Analyzer extension for better development experience
- Join the Sui Discord for community support
- Check out the official Sui examples for learning

## 🤝 Contributing

Found an issue or want to improve the script? Feel free to submit a pull request!

---

**Happy coding! Welcome to the Sui ecosystem! 🎉**
