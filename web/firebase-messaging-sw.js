importScripts("https://www.gstatic.com/firebasejs/7.15.5/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.15.5/firebase-messaging.js");

//Using singleton breaks instantiating messaging()
// App firebase = FirebaseWeb.instance.app;


firebase.initializeApp({
    apiKey: 'AIzaSyAgje1juAhSrN2bSyuVS1pq6K_rK2lST7U',
    appId: '1:494484064061:web:8dd4e7a040a7691d8ce754',
    messagingSenderId: '494484064061',
    projectId: 'ecomapp-18dc3',
    authDomain: 'ecomapp-18dc3.firebaseapp.com',
    storageBucket: 'ecomapp-18dc3.appspot.com',
    measurementId: 'G-RKL9P7DVPM',
});

const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});