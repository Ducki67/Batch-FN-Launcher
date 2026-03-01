#include <iostream>
#include <windows.h>
#include <tlhelp32.h>
#include <string>

namespace Globals {
    bool bDevMode = false; // Set to false for command-line mode, true for manual mode
}

// Function: Get process ID (PID) by process name
DWORD GetProcId(const char* procName) {
    DWORD procId = 0;
    HANDLE hSnap = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    if (hSnap != INVALID_HANDLE_VALUE) {
        PROCESSENTRY32 procEntry;
        procEntry.dwSize = sizeof(procEntry);

        if (Process32First(hSnap, &procEntry)) {
            do {
                if (!_stricmp(procEntry.szExeFile, procName)) {
                    procId = procEntry.th32ProcessID;
                    break;
                }
            } while (Process32Next(hSnap, &procEntry));
        }
    }
    CloseHandle(hSnap);
    return procId;
}

int main(int argc, char* argv[]) {
    if (Globals::bDevMode) {
        SetConsoleTitle("C++ DLL Injector by Ducki67");

        // Manual mode: prompt for process name and DLL path
        std::string procName, dllPath;
        std::cout << "Manual Injector Mode (bDevMode = true)\n";
        std::cout << "Process name (e.g. notepad.exe): ";
        std::getline(std::cin, procName);
        std::cout << "DLL path (e.g. C:\\test\\example.dll): ";
        std::getline(std::cin, dllPath);

        // Prepare arguments for injection logic
        argc = 3;
        argv[1] = const_cast<char*>(procName.c_str());
        argv[2] = const_cast<char*>(dllPath.c_str());
    } else {
        // Command-line mode: check arguments
        if (argc < 3) {
            std::cout << "Usage: injector.exe <process_name> <dll_path>" << std::endl;
            std::cout << "Example: injector.exe notepad.exe C:\\test\\example.dll" << std::endl;
            return 1;
        }
    }

    const char* targetProcess = argv[1];
    const char* dllPath = argv[2];
    char fullPath[MAX_PATH];

    // Get full path to DLL
    GetFullPathNameA(dllPath, MAX_PATH, fullPath, NULL);

    DWORD procId = GetProcId(targetProcess);

    if (!procId) {
        std::cerr << "[!] Process not found: " << targetProcess << std::endl;
        return 1;
    }

    // 1. Open target process
    HANDLE hProc = OpenProcess(PROCESS_ALL_ACCESS, FALSE, procId);
    if (hProc == NULL) {
        std::cerr << "[!] Failed to open process. (Admin rights needed?)" << std::endl;
        return 1;
    }

    // 2. Allocate memory in target process for DLL path
    void* loc = VirtualAllocEx(hProc, 0, MAX_PATH, MEM_COMMIT | MEM_RESERVE, PAGE_READWRITE);
    if (!loc) {
        std::cerr << "[!] Memory allocation error." << std::endl;
        CloseHandle(hProc);
        return 1;
    }

    // 3. Write DLL path to allocated memory
    WriteProcessMemory(hProc, loc, fullPath, strlen(fullPath) + 1, 0);

    // 4. Start remote thread to call LoadLibrary
    HANDLE hThread = CreateRemoteThread(hProc, 0, 0, (LPTHREAD_START_ROUTINE)LoadLibraryA, loc, 0, 0);

    if (hThread) {
        std::cout << "[+] Injection successful: " << targetProcess << " (PID: " << procId << ")" << std::endl;
        CloseHandle(hThread);
    }
    else {
        std::cerr << "[!] CreateRemoteThread failed." << std::endl;
    }

    // Cleanup
    CloseHandle(hProc);
    return 0;
}
