import {self} from 'react-native-threads';

console.log('Worker Thread started at', Date.now());
let count = 0;

self.postMessage(`Sending Message early, probably from queue!`);

self.onMessage = message => {
  try {
    console.log(`Prom THREAD: got message ${message}`);

    count++;

    self.postMessage(`Prime Message #${count} from worker thread!`);
  } catch (e) {
    console.log('Error Thread:', e);
  }
};
