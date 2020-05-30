enum EmotionType { negative, neutral, positive }

class History {
  final EmotionType emotion;
  final String time;

  History(
    this.emotion,
    this.time,
  );
}
