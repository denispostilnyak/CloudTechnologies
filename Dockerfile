FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["/CloudTechnologiesTest.csproj", "CloudTechnologiesTest/"]
COPY ["/CloudTechnologiesTest.csproj", "CloudTechnologiesTest/"]
RUN dotnet restore "/CloudTechnologiesTest.csproj"
COPY . .
WORKDIR "/src/CloudTechnologies"
RUN dotnet build "CloudTechnologiesTest.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "CloudTechnologiesTest.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "CloudTechnologiesTest.dll"]