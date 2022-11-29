# Pong64
A remake of **Pong** in assembly for the **Commodore 64**.

This is my first attempt at writing software for the Commodore 64. The game is written using **Turbo Macro Pro** in **VICE C64** to replicate a possible workflow from back in the day

A makefile is also provided which allows extracting the binary source & converting it to an ASCII editable format, for easier versioning & which can be cross-compiled using **TMPx**.

## Instructions
### Development
1. Map the *'VICE -> Preferences -> Settings -> Peripheral devices -> Host file system device'* to the 'd64' folder.
2. Load **Turbo Macro Pro** on the **C64** & open 'pong'

### Makefile
1. Run 'make'
2. The binary source assembly will be converted to ASCII form under the 'src' folder and can be edited & assembled using **TMPx**.
