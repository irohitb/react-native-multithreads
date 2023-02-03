package com.reactlibrary;

public class JSMessage {
    private String threadId;

    private String message;
    private boolean parentBridgeExisted;

    public JSMessage(String threadId, String message, boolean parentBridgeExisted) {
        this.threadId = threadId;
        this.message = message;
        this.parentBridgeExisted = parentBridgeExisted;
    }
}
