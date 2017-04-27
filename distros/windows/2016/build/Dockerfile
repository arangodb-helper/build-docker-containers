FROM microsoft/windowsservercore

SHELL ["powershell"]
RUN Install-PackageProvider -Name "NuGet" -Force
RUN Register-PackageSource -name nuget -provider nuget -location https://www.nuget.org/api/v2 -trusted
RUN iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# the latest version did not install because of an error in the install script.
RUN choco install -y visualcpp-build-tools -version 14.0.25420.1 --params "'/IncludeRecommended'" 
RUN choco install -y cMake
RUN choco install -y git
RUN choco install -y python2

# lol...without specifying a fixed version this failed fetching dependent packages...
RUN Install-Package -RequiredVersion 1.0.2 openssl

COPY scripts/fix.ps1 C:\fix.ps1
RUN & C:\fix.ps1
COPY scripts/build.ps1 c:\build.ps1

CMD ["powershell"]
