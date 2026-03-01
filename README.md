# OGFN Batch Launcher

> A simple **OGFN launcher made in the Windows language: *Batch***.

Made for fun as a tiny project of mine — exploring the world of OGFN and Batch (and a bit of C++) scripting for educational purposes.

---

## Features

- Batch-based launcher (`FN Launcher.bat`)
- Works inside old Fortnite build folders
- Uses **only 1 helper** component
- Helper is written in **C++** (DLL inject helper since batch doesnt have the ability to inject DLLs)

---

## Project Structure

- `FN Launcher.bat` → main launcher script
- `BasicInjector` (C++) → single DLL inject helper used by the launcher

> This project uses only **one** helper binary.

---

## Requirements

- Windows 10/11
- A supported Fortnite build folder containing:
  - `Engine`
  - `FortniteGame`
- Backend/account credentials Or use any thing random for LawinServer or oher local hosted backends

---

## Setup

1. Download or copy `FN Launcher.bat`.
2. Place it in your Fortnite build folder (same level as `Engine` and `FortniteGame`).
3. Make sure the C++ helper file is present (the only helper used by this launcher).
4. Run `FN Launcher.bat`.

---

## Usage

1. Open `Fn Launcher.bat`.
2. Enter your backend/account details when prompted.
3. Let the launcher start the game and apply helper steps automatically.
4. Wait for the game window to fully load.

**Optional**

If you wanna use DLLs such as Console you should use UUU client or the Basic Injector in `bDevMode` which will act as one but very simplafiyed.

---

## Tested Versions
<details>

<summary>Click here to see!</summary>

>![NOTE]
> These are the versions that i had on my PC to test obv i will **not** test every single possible version. So do it your self.

### Season 0
- [ ] 1.7.2 (Untested)

### Season 1
- [x] 1.8 (Should work)
- [ ] 1.8.2 (does not work)
- [ ] 1.9
- [ ] 1.9.1
- [ ] 1.10

### Season 2
- [x] 1.11 (Works fine)
- [x] 2.5 (Works fine)

### Season 3
- [ ] 3.3
- [ ] 3.5
- [ ] 3.6

### Season 4
- [ ] 4.5

### Season 5
- [ ] 5.10
- [ ] 5.41

### Season 10
- [ ] 10.40

### Season 12
- [ ] 12.61

### Season 13
- [ ] 13.40

### Season 24
- [ ] 24.20 (Should work)

### Season 26
- [x] 26.30 (Tested and works)

### Season 27
- [x] 27.11 (Should work)

### Season 28
- [x] 28.30 (Worked)

</details>
---

## Troubleshooting

- **Launcher closes instantly**
  - Run `FN Launcher.bat` as Administrator.
- **Game does not start**
  - Verify folder contains `Engine` and `FortniteGame`.
- **Login/backend error**
  - Re-check credentials and backend status.
- **Helper-related issue**
  - Confirm the single C++ helper exists and is in the expected location.

---

## Final Notes
Feel free to improve and use this project as you wish.

Contibuitons are wellcome for anyone.

---

## License
This project licensed under the MIT license!