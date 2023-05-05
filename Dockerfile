# Use the official .NET Core SDK image as the base image
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env

# Set the working directory inside the container
WORKDIR /app

# Copy the project file and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application code and build the application
COPY . ./
RUN dotnet publish -c Release -o out

# Use the official .NET Core runtime image as the base image
FROM mcr.microsoft.com/dotnet/aspnet:6.0

# Set the working directory inside the container
WORKDIR /app

# Copy the built application from the previous stage
COPY --from=build-env /app/out .

# Expose port 5000 for the application to listen on
EXPOSE 5000

# Start the application and listen on port 5000
ENTRYPOINT ["dotnet", "dotnetcore.dll", "--urls", "http://*:5000"]
