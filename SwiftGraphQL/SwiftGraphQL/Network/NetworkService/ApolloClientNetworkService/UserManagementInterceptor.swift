//
//  UserManagementInterceptor.swift
//
//  Created by Faran Rasheed on 13/08/2023.
//

import Foundation
import Apollo
import ApolloAPI

class UserManagementInterceptor: ApolloInterceptor {
    var id: String = UUID().uuidString
    
    /// Helper function to add the token then move on to the next step
    private func addTokenAndProceed<Operation: GraphQLOperation>(
        _ token: String,
        to request: HTTPRequest<Operation>,
        chain: RequestChain,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) {
        request.addHeader(name: "Authorization", value: "Bearer \(token)")
        chain.proceedAsync(request: request,
                           response: response,
                           interceptor: self,
                           completion: completion)
    }

    
    func interceptAsync<Operation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) where Operation : GraphQLOperation {
            
            /// Fetch token from Keychain, if no token then return error
            guard let accessToken = AppData.userAccessToken else {
                /// In this instance, no user is logged in, so we want to call
                /// the error handler, then return to prevent further work
                chain.handleErrorAsync(
                    NetworkError.unauthorized,
                    request: request,
                    response: response,
                    completion: completion
                )
                return
            }
            
            // TODO: We can also check for token expiry and refresh here.
            
            /// Continue to add token and proceed
            self.addTokenAndProceed(
                accessToken,
                to: request,
                chain: chain,
                response: response,
                completion: completion
            )
    }
}

