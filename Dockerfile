#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
<<<<<<< HEAD:WebAppCICD/WebAppCICD.Api/Dockerfile
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["WebAppCICD.Api/WebAppCICD.Api.csproj", "WebAppCICD.Api/"]
RUN dotnet restore "WebAppCICD.Api/WebAppCICD.Api.csproj"
COPY . .
WORKDIR "/src/WebAppCICD.Api"
=======
#EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["WebAppCICD/WebAppCICD.Api/WebAppCICD.Api.csproj", "WebAppCICD/WebAppCICD.Api/"]
RUN dotnet restore "WebAppCICD/WebAppCICD.Api/WebAppCICD.Api.csproj"
COPY . .
WORKDIR "/src/WebAppCICD/WebAppCICD.Api"
>>>>>>> 5e19a754feb36429946253cd6e3125d24e8d2291:Dockerfile
RUN dotnet build "WebAppCICD.Api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "WebAppCICD.Api.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
<<<<<<< HEAD:WebAppCICD/WebAppCICD.Api/Dockerfile
ENTRYPOINT ["dotnet", "WebAppCICD.Api.dll"]
=======
CMD ASPNETCORE_URLS=http://*:$PORT dotnet WebAppCICD.Api.dll

>>>>>>> 5e19a754feb36429946253cd6e3125d24e8d2291:Dockerfile
