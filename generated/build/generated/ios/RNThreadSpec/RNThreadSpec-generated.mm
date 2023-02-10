/**
 * This code was generated by [react-native-codegen](https://www.npmjs.com/package/react-native-codegen).
 *
 * Do not edit this file as changes may cause incorrect behavior and will be lost
 * once the code is regenerated.
 *
 * @generated by codegen project: GenerateModuleObjCpp
 *
 * We create an umbrella header (and corresponding implementation) here since
 * Cxx compilation in BUCK has a limitation: source-code producing genrule()s
 * must have a single output. More files => more genrule()s => slower builds.
 */

#import "RNThreadSpec.h"


namespace facebook {
  namespace react {
    
    static facebook::jsi::Value __hostFunction_NativeSelfSpecJSI_postMessage(facebook::jsi::Runtime& rt, TurboModule &turboModule, const facebook::jsi::Value* args, size_t count) {
      return static_cast<ObjCTurboModule&>(turboModule).invokeObjCMethod(rt, VoidKind, "postMessage", @selector(postMessage:), args, count);
    }

    static facebook::jsi::Value __hostFunction_NativeSelfSpecJSI_addListener(facebook::jsi::Runtime& rt, TurboModule &turboModule, const facebook::jsi::Value* args, size_t count) {
      return static_cast<ObjCTurboModule&>(turboModule).invokeObjCMethod(rt, VoidKind, "addListener", @selector(addListener:), args, count);
    }

    static facebook::jsi::Value __hostFunction_NativeSelfSpecJSI_removeListeners(facebook::jsi::Runtime& rt, TurboModule &turboModule, const facebook::jsi::Value* args, size_t count) {
      return static_cast<ObjCTurboModule&>(turboModule).invokeObjCMethod(rt, VoidKind, "removeListeners", @selector(removeListeners), args, count);
    }

    NativeSelfSpecJSI::NativeSelfSpecJSI(const ObjCTurboModule::InitParams &params)
      : ObjCTurboModule(params) {
        
        methodMap_["postMessage"] = MethodMetadata {1, __hostFunction_NativeSelfSpecJSI_postMessage};
        
        
        methodMap_["addListener"] = MethodMetadata {1, __hostFunction_NativeSelfSpecJSI_addListener};
        
        
        methodMap_["removeListeners"] = MethodMetadata {0, __hostFunction_NativeSelfSpecJSI_removeListeners};
        
    }
  } // namespace react
} // namespace facebook

namespace facebook {
  namespace react {
    
    static facebook::jsi::Value __hostFunction_NativeThreadSpecJSI_startThread(facebook::jsi::Runtime& rt, TurboModule &turboModule, const facebook::jsi::Value* args, size_t count) {
      return static_cast<ObjCTurboModule&>(turboModule).invokeObjCMethod(rt, PromiseKind, "startThread", @selector(startThread:threadId:resolve:reject:), args, count);
    }

    static facebook::jsi::Value __hostFunction_NativeThreadSpecJSI_getExistingThread(facebook::jsi::Runtime& rt, TurboModule &turboModule, const facebook::jsi::Value* args, size_t count) {
      return static_cast<ObjCTurboModule&>(turboModule).invokeObjCMethod(rt, PromiseKind, "getExistingThread", @selector(getExistingThread:resolve:reject:), args, count);
    }

    static facebook::jsi::Value __hostFunction_NativeThreadSpecJSI_terminate(facebook::jsi::Runtime& rt, TurboModule &turboModule, const facebook::jsi::Value* args, size_t count) {
      return static_cast<ObjCTurboModule&>(turboModule).invokeObjCMethod(rt, VoidKind, "terminate", @selector(terminate:), args, count);
    }

    static facebook::jsi::Value __hostFunction_NativeThreadSpecJSI_postMessage(facebook::jsi::Runtime& rt, TurboModule &turboModule, const facebook::jsi::Value* args, size_t count) {
      return static_cast<ObjCTurboModule&>(turboModule).invokeObjCMethod(rt, VoidKind, "postMessage", @selector(postMessage:msg:), args, count);
    }

    static facebook::jsi::Value __hostFunction_NativeThreadSpecJSI_addListener(facebook::jsi::Runtime& rt, TurboModule &turboModule, const facebook::jsi::Value* args, size_t count) {
      return static_cast<ObjCTurboModule&>(turboModule).invokeObjCMethod(rt, VoidKind, "addListener", @selector(addListener:), args, count);
    }

    static facebook::jsi::Value __hostFunction_NativeThreadSpecJSI_removeListeners(facebook::jsi::Runtime& rt, TurboModule &turboModule, const facebook::jsi::Value* args, size_t count) {
      return static_cast<ObjCTurboModule&>(turboModule).invokeObjCMethod(rt, VoidKind, "removeListeners", @selector(removeListeners), args, count);
    }

    NativeThreadSpecJSI::NativeThreadSpecJSI(const ObjCTurboModule::InitParams &params)
      : ObjCTurboModule(params) {
        
        methodMap_["startThread"] = MethodMetadata {2, __hostFunction_NativeThreadSpecJSI_startThread};
        
        
        methodMap_["getExistingThread"] = MethodMetadata {1, __hostFunction_NativeThreadSpecJSI_getExistingThread};
        
        
        methodMap_["terminate"] = MethodMetadata {1, __hostFunction_NativeThreadSpecJSI_terminate};
        
        
        methodMap_["postMessage"] = MethodMetadata {2, __hostFunction_NativeThreadSpecJSI_postMessage};
        
        
        methodMap_["addListener"] = MethodMetadata {1, __hostFunction_NativeThreadSpecJSI_addListener};
        
        
        methodMap_["removeListeners"] = MethodMetadata {0, __hostFunction_NativeThreadSpecJSI_removeListeners};
        
    }
  } // namespace react
} // namespace facebook