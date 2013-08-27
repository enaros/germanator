wordlist = [
  {
    word: 'die mango'
    plural: 'mangos'
    english: 'mango'
    search: 'mango fruit'
  }
  {
    word: 'die birne'
    plural: 'birnen'
    english: 'pear'
    search: 'pear fruit'    
  }
  {
    word: 'der apfel'
    plural: 'äpfel'
    english: 'apple'
    search: 'apple fruit'
  }
  {
    word: 'der salat'
    plural: 'salate'
    english: 'salat'
  }
  {
    word: 'der pfirsich'
    plural: 'pfirisiche'
    english: 'peach'
    search: 'peach fruit'
  }
  {
    word: 'die gurke'
    plural: 'gurken'
    english: 'cucumber'
  }
  {
    word: 'die erbse'
    plural: 'erbsen'
    english: 'pea'
  }
  {
    word: 'der käse'
    plural: 'käse'
    english: 'cheese'
  }
  {
    word: 'der knoblauch'
    plural: '-'
    english: 'garlic'
  }
  {
    word: 'die milch'
    plural: '-'
    english: 'milk'
  }
  {
    word: 'die zitrone'
    plural: 'zitronen'
    english: 'lemon'
    search: 'lemon fruit'
  }
  {
    word: 'die kartoffel'
    plural: 'kartoffeln'
    english: 'potatos'
  }
  {
    word: 'die tomate'
    plural: 'tomaten'
    english: 'tomato'
  }
  {
    word: 'der pilz'
    plural: 'pilze'
    english: 'mushrooms'
  }
  {
    word: 'das fleisch'
    plural: '-'
    english: 'meat'
  }
  {
    word: 'der fisch'
    plural: 'fische'
    english: 'fish'
  }
  {
    word: 'das brot'
    plural: 'brote'
    english: 'bread'
  }
  {
    word: 'die kirsche'
    plural: 'kirschen'
    english: 'cherries'
  }
  {
    word: 'die traube'
    plural: 'trauben'
    english: 'grapes'
  }
  {
    word: 'die zwiebel'
    plural: 'zwiebeln'
    english: 'onion'
  }
  {
    word: 'die paprika'
    plural: 'paprikas'
    english: 'paprika'
  }  
]

Meteor.startup ->
  if collection.find().count() is 0
    collection.insert(_.extend item, {probability: 1/wordlist.length}) for item in wordlist

  console.log wordlist

  Meteor.publish('words', -> collection.find())