/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

const tasks = admin.firestore().collection("tasks");

exports.translateTask = functions.firestore
    .document("tasks/{taskId}")
    .onCreate((snapshot, context) => {
      const newTask = snapshot.data();
      const taskId = snapshot.id;

      console.log("New task on collection: ", newTask);

      const translation = newTask["name"].toUpperCase();

      tasks.doc(taskId).update({...newTask, translation});
    });
