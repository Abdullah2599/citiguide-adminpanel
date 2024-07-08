const admin = require('firebase-admin');

// Replace the following line with the path to your service account key file
const serviceAccount = require('./citiguide-32c72-firebase-adminsdk-5gcg2-c110514d29.json');

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

const uid = 'GH0e6HXAW5hyL7RS5GW0w0w4Z9n1'; // Replace with the UID of the user you want to make an admin

// node setAdminClaim.js

admin.auth().setCustomUserClaims(uid, { admin: true })
    .then(() => {
        console.log(`Custom claims set for user ${uid}`);
    })
    .catch(error => {
        console.error('Error setting custom claims:', error);
    });
