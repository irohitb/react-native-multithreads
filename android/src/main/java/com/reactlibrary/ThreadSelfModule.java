package com.reactlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.module.annotations.ReactModule;
import com.facebook.react.modules.core.DeviceEventManagerModule;

@ReactModule(name = ThreadSelfModule.REACT_MODULE_NAME)
public class ThreadSelfModule extends ReactContextBaseJavaModule {
    public static final String REACT_MODULE_NAME = "ThreadSelfManager";

    private String threadId;
    private ReactApplicationContext parentContext;

    public ThreadSelfModule(ReactApplicationContext context) {
        super(context);
    }

    public void initialize(String threadId, ReactApplicationContext parentContext) {
        this.parentContext = parentContext;
        this.threadId = threadId;
    }

    @Override
    public String getName() {
        return REACT_MODULE_NAME;
    }

    @ReactMethod
    public void postMessage(String data) {
        JSMessages instance = JSMessages.getInstance();
        if (parentContext == null) {
            instance.addMessages(threadId, data, false);
            return;
        }
        instance.addMessages(threadId, data, true);
        parentContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                .emit("Thread" + String.valueOf(threadId), data);
    }

    // Required for rn built in EventEmitter Calls.
    @ReactMethod
    public void addListener(String eventName) {

    }

    @ReactMethod
    public void removeListeners(Integer count) {

    }
}
