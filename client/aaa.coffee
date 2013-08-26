Meteor.subscribe "words", -> generateRandom()
  
@generateRandom = ->
  $('#word').val('').focus()
  random = Math.random()
  console.log collection.find().count(), random

  prob = 0
  randomWord = null
  collection.find().forEach (word) ->
    return if randomWord
    prob += word.probability
    if prob > random
      randomWord = word

  Session.set 'word', randomWord
  
  param = 
    v: '1.0'
    # as_sitesearch: 'photobucket.com'
    as_filetype: 'jpg'
    q: randomWord.english
    userip: '234.111.111.111'
    # imgc: 'gray'
    imgcolor: 'white'
    imgsz: 'large'

  url = "https://ajax.googleapis.com/ajax/services/search/images?" + _.reduce(param, ((memo, val, key) -> return "#{memo}&#{key}=#{encodeURIComponent(val)}"), '')
  # url = 'http://testapi.bigstockphoto.com/2/267773/search/?q=onion'

  if randomWord.images
    setImages randomWord.images
  else
    $.ajax({
      type: 'GET'
      url: url
      async: false
      jsonpCallback: 'jsonCallback'
      contentType: "application/json"
      dataType: 'jsonp'
      success: (json) -> 
        console.log json
        if json.responseData
          console.log 'yes'
          res = json.responseData.results
          collection.update { _id: randomWord._id }, $set: { images: res }
          setImages res

      error: (e) -> console.log(e.message)
    })

setImages = (imgs) ->
  i = $('img')
  $(i[0]).attr 'src', imgs[0].url
  $(i[1]).attr 'src', imgs[1].url
  $(i[2]).attr 'src', imgs[2].url