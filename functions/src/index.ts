import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

const tasks = admin.firestore().collection("tasks");

export const translateTask = functions.firestore
  .document("tasks/{taskId}")
  .onCreate((snapshot, context) => {
    const newTask = snapshot.data();
    const taskId = snapshot.id;

    const translation = (newTask["name"] as string).toUpperCase();

    return tasks.doc(taskId).update({...newTask, translation});
  });
