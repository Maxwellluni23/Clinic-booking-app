// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:string_similarity/string_similarity.dart';

import '../Widgets/home_button.dart';

class MyChatPage extends StatefulWidget {
  MyChatPage({super.key});

  @override
  MyChatPageState createState() => MyChatPageState();
}

class MyChatPageState extends State<MyChatPage> {
  TextEditingController textController = TextEditingController();
  List<ChatMessage> chatHistory = [];

  //Map to store user messages and their corresponding responses.

  Map<String, String> responses = {
    'hello': 'Hello! How can I assist you with your health questions today?',
    'Hi': 'Hello! How can I assist you with your health questions today?',
    'what are the symptoms of COVID-19':
        'Common symptoms of COVID-19 include fever, cough, and difficulty breathing. It\'s important to consult a healthcare professional for accurate information.',
    'how can I stay healthy':
        'Staying healthy involves maintaining a balanced diet, regular exercise, and getting enough sleep. Consult a doctor for personalized advice.',
    'what should I do if I have a cold':
        'If you have a cold, get plenty of rest, drink fluids, and consider over-the-counter cold remedies. If symptoms worsen or persist, consult a healthcare professional.',
    'tell me about a balanced diet':
        'A balanced diet includes a variety of fruits, vegetables, lean proteins, and whole grains. It\'s essential to maintain a healthy, well-rounded diet to stay healthy.',
    'how can I boost my immune system':
        'To boost your immune system, focus on a healthy diet rich in vitamins and minerals, regular exercise, getting enough sleep, and reducing stress.',
    'tips for a good night\'s sleep':
        'To get a good night\'s sleep, establish a regular sleep schedule, create a comfortable sleep environment, limit caffeine and screen time before bed, and manage stress.',
    'how to prevent heart disease':
        'Preventing heart disease involves a heart-healthy diet, regular exercise, avoiding smoking, limiting alcohol consumption, and managing stress.',
    'benefits of regular exercise':
        'Regular exercise has numerous benefits, including weight management, improved cardiovascular health, increased energy, and reduced stress.',
    'what are the best foods for brain health':
        'Foods that promote brain health include fatty fish, blueberries, nuts, and leafy greens. These foods are rich in antioxidants and omega-3 fatty acids.',
    'how to quit smoking':
        'Quitting smoking is challenging but essential for your health. Consider seeking support from a healthcare provider or support groups. Nicotine replacement therapy and prescription medications can also help. Seek support from smoking cessation programs, use nicotine replacement therapy, and set a quit date.',

    'Symptoms of Diabetes':
        'Feeling more thirsty than usual, Urinating often, Losing weight without trying, Feeling tired and weak, Having blurry vision, having slow healing sores, Getting a lot of infection, such as gum, skin and vaginal infections, Presence of ketones in the urine.',

    'Eye infection':
        'These are the signs of eye infection: Pink eye, Cellulitis, Stye, Endophthalmitis, Uveitis, eye pain, watery eye, itching or irritation, swelling, blurred vision, red eyes.',

    'How can I protect myself from contracting HIV':
        'Practice safe sex, use condoms, get regular HIV testing, and consider pre-exposure prophylaxis (PrEP) for high-risk individuals.',

    'How to manage diabetes':
        'Monitor your blood sugar levels, follow a healthy diet, exercise regularly, take prescribed medications, and maintain regular check-ups with your doctor.',

    'How can I prevent malaria':
        'Use mosquito nets, wear long-sleeved clothing, use insect repellent, and take antimalarial medication if recommended for your region.',

    'What are the signs of tuberculosis (TB), and how is it treated':
        'Symptoms include persistent cough, weight loss, and night sweats. TB is treated with a combination of antibiotics over several months.',

    'How can I manage stress and mental health':
        'Seek support from a mental health professional, practice relaxation techniques, and engage in regular physical activity.',

    'How can I prevent the spread of sexually transmitted infections (STIs)':
        'Practice safe sex, use condoms, and get regular STI screenings.',

    'How can I manage hypertension (high blood pressure)':
        'Maintain a healthy diet, exercise regularly, limit salt intake, and take prescribed medications as directed by your doctor.',

    'What are the early signs of pregnancy, and when should I see a healthcare provider':
        'Common signs include missed periods, breast tenderness, and nausea. See a healthcare provider for a pregnancy test and prenatal care.',

    'How can I protect myself from waterborne diseases':
        'Boil or purify drinking water, and practice good hygiene to reduce the risk of diseases like cholera.',

    'How can I prevent and manage common skin conditions such as sunburns and heat rush':
        'Protect your skin from the sun with sunscreen and appropriate clothing, and keep your skin dry to prevent heat rash.',

    'What are the signs of dehydration, and how can I stay hydrated in hot weather':
        'Signs include dark urine and dizziness. Drink plenty of water, especially in hot climates, and avoid excessive caffeine and alcohol.',

    'What is the importance of prenatal care during pregnancy, and when should I start it':
        'Prenatal care is vital for monitoring the health of both the mother and the baby. Start prenatal care as early as possible in your pregnancy, ideally in the first trimester.',

    'How can I prevent and manage chronic conditions like heart disease and hypertension through lifestyle changes?':
        'Maintain a healthy diet low in saturated fats, exercise regularly, manage stress, and avoid smoking and excessive alcohol consumption.',

    'How can I recognize and respond to snakebite emergencies':
        'Remain calm, immobilize the affected limb, and seek immediate medical attention. Do not try to suck out venom or cut the wound.',

    'What are the signs of heatstroke, and how can I prevent it during hot summer':
        'Symptoms include high body temperature, confusion, and nausea. Stay hydrated, seek shade, and avoid strenuous activities during the hottest parts of the day.',

    'How can I protect myself and my family from water-related illnesses during floods and heavy rains':
        'Avoid contact with floodwaters, use clean water sources, and maintain good hygiene practices.',

    'How can I prevent the common cold and flu':
        'Wash your hands regularly, avoid close contact with sick individuals, and get a flu vaccine.',

    'Whats the best way to treat a minor cut or scrape':
        'Clean the wound with soap and water, apply an antiseptic, and cover it with a sterile bandage.',

    'How often should I get a dental check-up and cleaning':
        'Visit your dentist for a check-up and cleaning every six months.',

    'What should I do if I have a fever':
        'Get plenty of rest, stay hydrated, and take over-the-counter fever reducers if necessary.',

    'How can I relieve a headache without medication':
        'Try resting in a dark, quiet room, applying a cold compress, or practicing relaxation techniques.',

    'What are the best practices for maintaining good oral hygiene':
        'Brush your teeth twice a day, floss daily, and limit sugary foods and drinks.',

    'How can I soothe a sore throat':
        'Gargle with warm salt water, drink herbal teas, and rest your voice.',

    'How can I alleviate constipation':
        'Increase fiber intake, drink more water, and engage in regular physical activity.',

    'Whats the recommended daily water intake for adults':
        'Aim for about 8 glasses of water per day, or more in hot weather or during physical activity.',

    'How can I improve my sleep quality':
        'Maintain a regular sleep schedule, create a comfortable sleep environment, and limit caffeine and electronic devices before bedtime.',

    'Whats the proper way to wash hands to prevent the spread of infections':
        'Use soap and water, scrub for at least 20 seconds, and wash all areas of your hands, including between the fingers and under the nails.',

    'Whats the recommended daily serving of fruits and vegetables':
        'Aim for at least 5 servings a day for a balanced diet.',

    'How can I reduce the risk of food poisoning at home':
        'Store food at the right temperatures, cook meat thoroughly, and practice good kitchen hygiene.',

    'How can I prevent muscle cramps during exercise':
        'Stay hydrated, stretch before and after exercise, and make sure you are getting enough electrolytes.',

    'How can I relieve a mild sunburn':
        'Apply aloe vera or a cool compress to the affected area and drink plenty of water.',

    'What is the recommended alcohol intake for adults':
        'Moderation is key; limit alcohol to one drink per day for women and up to two drinks per day for men.',

    'How can I prevent bad breath':
        'Brush and floss regularly, clean your tongue, and stay hydrated.',

    'What should I do if I accidentally swallow something harmful or poisonous':
        'Contact a poison control center or go to the nearest hospital for immediate medical attention.',

    'How often should I replace my toothbrush':
        'Replace your toothbrush every 3-4 months or sooner if the bristles are frayed.',

    'What can I do to ease the discomfort of a common cold or flu':
        'Get plenty of rest, drink fluids, and use over-the-counter cold remedies as needed.',

    'How can I prevent the spread of germs during flu and cold season':
        'Practice good hand hygiene, cover your mouth and nose when coughing or sneezing, and avoid close contact with sick individuals.',

    'What is the best way to protect my skin from aging and wrinkles':
        'Use sunscreen, avoid smoking, and maintain a healthy diet and skincare routine.',
    // Add more responses for different health-related queries.
  };

  // String similarity algorithm for finding the closest matching response.
  final StringSimilarity stringSimilarity = StringSimilarity();

  void sendMessage(String message) {
    // User message
    final userMessage = ChatMessage(
      text: message,
      isUserMessage: true,
    );

    setState(() {
      chatHistory.add(userMessage);
      textController.clear();
    });

    String bestMatchQuestion = '';
    double bestMatchScore = 0.0;

     // Iterate through the responses to find the best-matching question.
     
    for (var question in responses.keys) {
      final similarity = StringSimilarity.compareTwoStrings(
          question.toLowerCase(), message.toLowerCase());
      if (similarity > bestMatchScore) {
        bestMatchScore = similarity;
        bestMatchQuestion = question;
      }
    }

    if (bestMatchScore >= 0.5) {
      // If a relevant response is found, display it as a bot message
      final botReply = ChatMessage(
        text: responses[bestMatchQuestion]!,
        isUserMessage: false,
      );

      setState(() {
        chatHistory.add(botReply);
      });
    } else {
      // If no relevant response is found, display a default bot message
      final defaultBotReply = ChatMessage(
        text: "Sorry but I might  have an answer to that question.",
        isUserMessage: false,
      );

      setState(() {
        chatHistory.add(defaultBotReply);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[90],
      body: Padding(
        padding: const EdgeInsets.only(
          top: 50,
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: HomeButton(),
                ),
                Container(
                  width: 250,
                  height: 49,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      "Health Chatbot",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: chatHistory.length,
                itemBuilder: (context, index) {
                  return chatHistory[index];
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: textController,
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      sendMessage(textController.text);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUserMessage;

  ChatMessage({super.key, required this.text, required this.isUserMessage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: isUserMessage ? Color.fromARGB(255, 0, 212, 141) : Colors.grey,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
