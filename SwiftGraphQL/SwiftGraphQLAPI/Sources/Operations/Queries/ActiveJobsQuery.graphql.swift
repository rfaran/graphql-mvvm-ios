// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ActiveJobsQuery: GraphQLQuery {
  public static let operationName: String = "ActiveJobsQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query ActiveJobsQuery($page: Int) { active(page: $page) { __typename hasNext jobs { __typename _id positionTitle description haveIApplied } } }"#
    ))

  public var page: GraphQLNullable<Int>

  public init(page: GraphQLNullable<Int>) {
    self.page = page
  }

  public var __variables: Variables? { ["page": page] }

  public struct Data: SwiftGraphQLAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SwiftGraphQLAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("active", Active?.self, arguments: ["page": .variable("page")]),
    ] }

    public var active: Active? { __data["active"] }

    /// Active
    ///
    /// Parent Type: `GetJobsResponse`
    public struct Active: SwiftGraphQLAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SwiftGraphQLAPI.Objects.GetJobsResponse }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("hasNext", Bool?.self),
        .field("jobs", [Job?]?.self),
      ] }

      public var hasNext: Bool? { __data["hasNext"] }
      public var jobs: [Job?]? { __data["jobs"] }

      /// Active.Job
      ///
      /// Parent Type: `Job`
      public struct Job: SwiftGraphQLAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SwiftGraphQLAPI.Objects.Job }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("_id", String?.self),
          .field("positionTitle", String?.self),
          .field("description", String?.self),
          .field("haveIApplied", Bool?.self),
        ] }

        public var _id: String? { __data["_id"] }
        public var positionTitle: String? { __data["positionTitle"] }
        public var description: String? { __data["description"] }
        public var haveIApplied: Bool? { __data["haveIApplied"] }
      }
    }
  }
}
