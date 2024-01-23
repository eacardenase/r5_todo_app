import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

import OpenAI from "openai";

admin.initializeApp();

const tasks = admin.firestore().collection("tasks");

export const translateTask = functions.firestore
  .document("tasks/{taskId}")
  .onCreate(async (snapshot, context) => {
    const openai = new OpenAI({
      apiKey: process.env.OPENAI_API_KEY,
    });

    const newTask = snapshot.data();
    const taskId = snapshot.id;

    const taskName = newTask["name"] as string;

    const response = await openai.chat.completions.create({
      model: "gpt-3.5-turbo",
      messages: [
        {
          role: "system",
          content: `Traduce el siguiente texto al idioma inglés: ${taskName}`,
        },
      ],
      temperature: 0.2,
    });

    const translation = response.choices[0].message.content;

    return tasks.doc(taskId).update({...newTask, translation});
  });
