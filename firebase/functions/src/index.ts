
import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();
const auth = admin.auth();

export const deleteUser = functions.https.onRequest(async (request, response) => {
     try {
         const { uid } = request.body;
         await auth.deleteUser(uid);
         response.status(200).send('User deleted successfully');
     } catch (error) {
         console.error('Error deleting user:', error);
         response.status(500).send('Error deleting user');
     }
 });