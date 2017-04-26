[Environment]::SetEnvironmentVariable("Path", $env:Path + ';C:\Program Files\CMake\bin\;C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\amd64;C:\Program Files (x86)\MSBuild\14.0\Bin\',[EnvironmentVariableTarget]::Machine)
[Environment]::SetEnvironmentVariable("INCLUDE", 'C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\include;C:\Program Files (x86)\Windows Kits\10\Include\10.0.10240.0\ucrt',[EnvironmentVariableTarget]::Machine)
[Environment]::SetEnvironmentVariable("GYP_MSVS_OVERRIDE_PATH", "C:\Program Files (x86)\Microsoft Visual Studio 14.0", [EnvironmentVariableTarget]::Machine)

$lib = 'C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\lib\amd64;C:\Program Files (x86)\Windows Kits\8.1\Lib\winv6.3\um\x64;C:\Program Files (x86)\Windows Kits\10\Lib\10.0.10240.0\ucrt\x64'

[Environment]::SetEnvironmentVariable("LIBPATH", $lib, [EnvironmentVariableTarget]::Machine)
[Environment]::SetEnvironmentVariable("LIB", $lib, [EnvironmentVariableTarget]::Machine)
[Environment]::SetEnvironmentVariable("OPENSSL_INCLUDE_DIR", 'C:\Program Files\PackageManagement\NuGet\Packages\openssl.v140.windesktop.msvcstl.dyn.rt-dyn.x64.1.0.2.0\build\native\include', [EnvironmentVariableTarget]::Machine)
[Environment]::SetEnvironmentVariable("LIB_EAY_RELEASE", 'C:\Program Files\PackageManagement\NuGet\Packages\openssl.v140.windesktop.msvcstl.dyn.rt-dyn.x64.1.0.2.0\lib\native\v140\windesktop\msvcstl\dyn\rt-dyn\x64\release\libeay32.lib', [EnvironmentVariableTarget]::Machine)
[Environment]::SetEnvironmentVariable("SSL_EAY_RELEASE", 'C:\Program Files\PackageManagement\NuGet\Packages\openssl.v140.windesktop.msvcstl.dyn.rt-dyn.x64.1.0.2.0\lib\native\v140\windesktop\msvcstl\dyn\rt-dyn\x64\release\ssleay32.lib', [EnvironmentVariableTarget]::Machine)
[Environment]::SetEnvironmentVariable("_IsNativeEnvironment", 'true', [EnvironmentVariableTarget]::Machine)

# cmake .. -G "Visual Studio 14 2015 Win64" -DOPENSSL_INCLUDE_DIR="$env:OPENSSL_INCLUDE_DIR" -DLIB_EAY_RELEASE="$env:LIB_EAY_RELEASE" -DSSL_EAY_RELEASE="$env:SSL_EAY_RELEASE" -DOPENSSL_USE_STATIC_LIBS=On
