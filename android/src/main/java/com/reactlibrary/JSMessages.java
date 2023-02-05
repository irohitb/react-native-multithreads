package com.reactlibrary;

import java.util.HashMap;

public class JSMessages {
    private static JSMessages jsMessagesInstance;

    private Integer count;
    public HashMap<String, JSMessage> messages;

    public void addMessages (String id, String message, boolean parentBridgeExisted) {
        JSMessage jsMessage = new JSMessage(id, message, parentBridgeExisted);
        messages.put(String.valueOf(count), jsMessage);
        count = count + 1;
    }

    public void resetMessage () {
        messages = new HashMap<String, JSMessage>();
        count = 1;
    }

    public static JSMessages getInstance() {
        if (jsMessagesInstance == null) {
            jsMessagesInstance = new JSMessages();
        }

        return jsMessagesInstance;
    }
    private JSMessages () {
        messages = new HashMap<String, JSMessage>();
        count = 1;
    }
}
