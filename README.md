# iOS-GraphQL-MVVM
Integrating Apollo client - GraphQL with MVVM implementation.

This is a sample app (UIKIT + Swift) integrating Apollo Client to provide GraphQL support.

The app follows MVVM architecture. Feel free to extend the network layer with the RestAPI server if required. 

## Steps to follow
1. Clone the repository.
2. Wait for Xcode to download dependencies.
3. Generate the `.schema.graphqls` file from your server, and replace it in the project.
4. Add your required mutations/queries.
5. Now let's create a configuration file using Apollo CLI.
6. Right-click on the Xcode project, and click `Install CLI` available in Apollo Section, this will add `apollo-ios-cli` shortcut to the project.
7. Open the project in the terminal and run this command to create a configuration file.

   `./apollo-ios-cli init --schema-namespace {PackageName} --module-type swiftPackageManager`
9. You just need to add the configuration file once. Now whenever you add any graphql query or mutation, you have to generate the SwiftPackageManager, this will have all the necessary models. Run this command to generate models.
    
   `./apollo-ios-cli generate`
11. Add this generated swift package to the project, don't forget to add this as a framework in the target's general tab as well.
12. Clean the project and run the app.
13. Of course you have to change the server URL. :)

