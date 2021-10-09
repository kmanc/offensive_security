Assuming you have a Powershell script with the following at the top (for reflection), you can use some useful Win32 APIs

```
function FindFunc {
    	Param ($moduleName, $functionName)
    	$assem = ([AppDomain]::CurrentDomain.GetAssemblies() |
    	Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].
    	Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')
    	$tmp=@()
    	$assem.GetMethods() | ForEach-Object {If($_.Name -eq "GetProcAddress") {$tmp+=$_}}

    	return $tmp[0].Invoke($null, @(($assem.GetMethod('GetModuleHandle')).Invoke($null, @($moduleName)), $functionName))
}

function getDelegateType {
    	Param (
            	[Parameter(Position = 0, Mandatory = $True)] [Type[]] $func,
            	[Parameter(Position = 1)] [Type] $delType = [Void]
    	)
    	$type = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')),
            	[System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).
            	DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass',[System.MulticastDelegate])
    	$type.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $func).
            	SetImplementationFlags('Runtime, Managed')
    	$type.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $delType, $func).
            	SetImplementationFlags('Runtime, Managed')

    	return $type.CreateType()
}
```

## [VirtualAlloc](https://docs.microsoft.com/en-us/windows/win32/api/memoryapi/nf-memoryapi-virtualalloc):

```
$va=[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((LookupFunc kernel32.dll VirtualAlloc), (getDelegateType @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr])))
```

```
$va..Invoke([IntPtr]::Zero, 0x1000, 0x3000, 0x40)
```

## [CreateThread](https://docs.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-createthread):

```
$ct = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((LookupFunc kernel32.dll CreateThread), (getDelegateType @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr])))
```

```
$ct.Invoke([IntPtr]::Zero, 0, $lpMem, [IntPtr]::Zero, 0, [IntPtr]::Zero)
```

## [WaitForSingleObject](https://docs.microsoft.com/en-us/windows/win32/api/synchapi/nf-synchapi-waitforsingleobject):

```
$wso = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((LookupFunc kernel32.dll WaitForSingleObject), (getDelegateType @([IntPtr], [Int32]) ([Int])))
```

```
$wso.Invoke($hThread, 0xFFFFFFFF)
```

## [VirtualProtect](https://docs.microsoft.com/en-us/windows/win32/api/memoryapi/nf-memoryapi-virtualprotect):

```
$vp=[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((FindFunc kernel32.dll VirtualProtect), (getDelegateType @([IntPtr], [UInt32], [UInt32], [UInt32].MakeByRefType()) ([Bool])))
```

```
$va.Invoke($funcAddr, 3, 0x20, [ref]$oldProtectionBuffer)
```

## [Sleep](https://docs.microsoft.com/en-us/windows/win32/api/synchapi/nf-synchapi-sleep):

```
$slp = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((FindFunc kernel32.dll Sleep), (getDelegateType @([UInt32]) ([UInt32])))
```

```
$slp.Invoke(2000);
```
