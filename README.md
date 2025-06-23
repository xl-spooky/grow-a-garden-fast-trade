# grow-a-garden-fast-trade

A simple Lua script for **Grow a Garden** that gifts every “Crop” in your inventory, one by one, to a target player (default: **PulpitaIsHere**). Paste it into your executor or load it from GitHub Raw. Detailed `[Gifter]` logs let you use the DevConsole’s **Copy All** to grab inventory info and gifting steps.

---

## Installation

1. **Clone** the repository:  
   ```
   git clone https://github.com/your-username/grow-a-garden-fast-trade.git  
   cd grow-a-garden-fast-trade  
   ```

2. **(Optional) Host `main.lua` on GitHub Raw** so you can update it without re-pasting:  
   ```
   https://raw.githubusercontent.com/your-username/grow-a-garden-fast-trade/main/main.lua  
   ```

---

## Usage

1. **Paste** the loader snippet into your executor (or save it as a script):  
   ```
   local url = "https://raw.githubusercontent.com/your-username/grow-a-garden-fast-trade/main/main.lua"  
   local http = http_request or request or syn and syn.request  
   local res  = http({ Url = url, Method = "GET" })  
   loadstring(res.Body)()  
   ```

2. **Run** it in the Grow a Garden game.  
3. Open DevConsole, hit **Copy All**, and inspect the `[Gifter]` logs for full inventory JSON and gifting progress.

---

## Configuration

- **TARGET_NAME**: change in `main.lua` to gift to someone other than “PulpitaIsHere”.  
- **Delay**: adjust `task.wait(0.5)` in `main.lua` for faster/slower gifting.  

---

## Logging

Every step is logged with a `[Gifter]` prefix, including:  
- Raw inventory JSON  
- Each crop found and its count  
- Start and confirmation of each gift  

---

## Contributing

1. Fork the repo  
2. Edit `main.lua` or improve README  
3. Commit & push your branch  
4. Open a Pull Request  

---

## License

MIT License