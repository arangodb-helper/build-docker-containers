New-Item -ItemType Directory -Force -Path c:\arangodb\build
cd c:\arangodb\build
cmake .. -G "Visual Studio 14 2015 Win64" -DCMAKE_BUILD_TYPE=RelWithDebInfo -DOPENSSL_INCLUDE_DIR="$env:OPENSSL_INCLUDE_DIR" -DLIB_EAY_RELEASE="$env:LIB_EAY_RELEASE" -DSSL_EAY_RELEASE="$env:SSL_EAY_RELEASE" -DLIB_EAY_RELEASE_DLL="$env:LIB_EAY_RELEASE_DLL" -DSSL_EAY_RELEASE_DLL="$env:SSL_EAY_RELEASE_DLL" -DDEBUG_SYNC_REPLICATION=On
cmake --build . --config RelWithDebInfo
