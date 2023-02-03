import React, {Component, useEffect} from 'react';
import {Button, StyleSheet, Text, View} from 'react-native';
import {
  Thread,
  ExistingThread,
  getThreadsId,
  getAllMessagesInThread,
} from 'react-native-threads';

console.log('App Thread started at', Date.now());

const App = () => {
  const [messages, setMessages] = React.useState<String[]>([]);
  //@ts-ignore
  const workerThread1 = React.useRef<Thread | null>(null);
  const workerThread2 = React.useRef<ExistingThread | Thread | null>(null);
  const handleMessage = (msg: string) => {
    setMessages(prevMsg => [...prevMsg, msg]);
  };

  const loadMisThreadData = async () => {
    const messages = await getAllMessagesInThread();
    const earlyMessages = messages
      .filter(el => !el.parentBridgeExisted)
      .map(el => el.message);
    setMessages(prevMsg => [...prevMsg, ...earlyMessages]);
  };

  const sendMessage = () => {
    try {
      workerThread1.current?.postMessage('Hello 1');
      workerThread2.current?.postMessage('Hello From thread 2');
    } catch (e) {
      console.log('Error App Send Message:', e);
    }
  };

  function onError() {
    workerThread2.current = new Thread('./worker.thread.js', 'test2');
    workerThread2.current.onMessage = handleMessage;
  }
  useEffect(() => {
    workerThread1.current = new Thread('./second.thread.js', 'test1');
    try {
      workerThread2.current = new ExistingThread('test2', onError);
    } catch (e) {
      workerThread2.current = new Thread('./worker.thread.js', 'test2');
    }
    loadMisThreadData();
    workerThread1.current.onMessage = handleMessage;
    workerThread2.current.onMessage = handleMessage;
    return () => {
      workerThread1.current?.terminate();
      workerThread1.current = null;
      workerThread2.current?.terminate();
      workerThread2.current = null;
    };
  }, []);

  return (
    <View style={styles.container}>
      <Text style={styles.welcome}>Welcome to React Native Threads!</Text>

      <Button title="Send Message To Worker Thread" onPress={sendMessage} />

      <View>
        <Text>Messages:</Text>
        {messages.map((message, i) => (
          <Text key={i}>{message}</Text>
        ))}
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
});

export default App;
