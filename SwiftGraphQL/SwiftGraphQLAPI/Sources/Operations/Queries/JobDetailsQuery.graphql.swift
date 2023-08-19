// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class JobDetailsQuery: GraphQLQuery {
  public static let operationName: String = "JobDetailsQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query JobDetailsQuery($jobId: String!) { job(id: $jobId) { __typename _id haveIApplied description positionTitle salaryRange { __typename min max } } }"#
    ))

  public var jobId: String

  public init(jobId: String) {
    self.jobId = jobId
  }

  public var __variables: Variables? { ["jobId": jobId] }

  public struct Data: SwiftGraphQLAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SwiftGraphQLAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("job", Job?.self, arguments: ["id": .variable("jobId")]),
    ] }

    public var job: Job? { __data["job"] }

    /// Job
    ///
    /// Parent Type: `Job`
    public struct Job: SwiftGraphQLAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SwiftGraphQLAPI.Objects.Job }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("_id", String?.self),
        .field("haveIApplied", Bool?.self),
        .field("description", String?.self),
        .field("positionTitle", String?.self),
        .field("salaryRange", SalaryRange?.self),
      ] }

      public var _id: String? { __data["_id"] }
      public var haveIApplied: Bool? { __data["haveIApplied"] }
      public var description: String? { __data["description"] }
      public var positionTitle: String? { __data["positionTitle"] }
      public var salaryRange: SalaryRange? { __data["salaryRange"] }

      /// Job.SalaryRange
      ///
      /// Parent Type: `SalaryRange`
      public struct SalaryRange: SwiftGraphQLAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SwiftGraphQLAPI.Objects.SalaryRange }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("min", Int?.self),
          .field("max", Int?.self),
        ] }

        public var min: Int? { __data["min"] }
        public var max: Int? { __data["max"] }
      }
    }
  }
}
