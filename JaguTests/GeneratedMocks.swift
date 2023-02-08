// MARK: - Mocks generated from file: Jagu/Services/FileService.swift at 2023-02-08 09:04:54 +0000

//
//  FileService.swift
//  Jagu
//
//  Created by Artur Hellmann on 23.01.23.
//

import Cuckoo
@testable import Jagu

import Foundation
import GitCaller






 class MockFileService: FileService, Cuckoo.ClassMock {
    
     typealias MocksType = FileService
    
     typealias Stubbing = __StubbingProxy_FileService
     typealias Verification = __VerificationProxy_FileService

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: FileService?

     func enableDefaultImplementation(_ stub: FileService) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     override func delete(file: String) throws {
        
    return try cuckoo_manager.callThrows(
    """
    delete(file: String) throws
    """,
            parameters: (file),
            escapingParameters: (file),
            superclassCall:
                
                super.delete(file: file)
                ,
            defaultCall: __defaultImplStub!.delete(file: file))
        
    }
    
    

     struct __StubbingProxy_FileService: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func delete<M1: Cuckoo.Matchable>(file: M1) -> Cuckoo.ClassStubNoReturnThrowingFunction<(String)> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: file) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockFileService.self, method:
    """
    delete(file: String) throws
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_FileService: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func delete<M1: Cuckoo.Matchable>(file: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: file) { $0 }]
            return cuckoo_manager.verify(
    """
    delete(file: String) throws
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class FileServiceStub: FileService {
    

    

    
    
    
    
     override func delete(file: String) throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}




