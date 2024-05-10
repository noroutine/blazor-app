FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /BlazorApp

# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /BlazorApp
COPY --from=build-env /BlazorApp/out .
EXPOSE 8080
ENTRYPOINT ["dotnet", "./BlazorApp.dll"]