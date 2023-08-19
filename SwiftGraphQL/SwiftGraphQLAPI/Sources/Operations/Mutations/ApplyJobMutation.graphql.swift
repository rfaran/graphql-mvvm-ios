// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ApplyJobMutation: GraphQLMutation {
  public static let operationName: String = "ApplyJob"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation ApplyJob($jobId: String!) { apply(jobId: $jobId) }"#
    ))

  public var jobId: String

  public init(jobId: String) {
    self.jobId = jobId
  }

  public var __variables: Variables? { ["jobId": jobId] }

  public struct Data: SwiftGraphQLAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SwiftGraphQLAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("apply", Bool?.self, arguments: ["jobId": .variable("jobId")]),
    ] }

    public var apply: Bool? { __data["apply"] }
  }
}
