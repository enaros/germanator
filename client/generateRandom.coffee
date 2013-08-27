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

  tag = randomWord.search or randomWord.english
  flickerAPI = "http://api.flickr.com/services/feeds/photos_public.gne?jsoncallback=?";
  $.getJSON(flickerAPI, { lang: "en-us", tags: "#{tag}", tagmode: "any", format: "json" }).done (data) ->
    console.log(data)
    $(".bg").empty()
    for i in [1..2]
      $.each data.items, (i, item) -> $("<div class='img'/>").css( "background-image", 'url(' + item.media.m + ')' ).appendTo(".bg")
  
  # param = 
  #   v: '1.0'
  #   # as_sitesearch: 'photobucket.com'
  #   as_filetype: 'jpg'
  #   q: randomWord.english
  #   userip: '234.111.111.111'
  #   # imgc: 'gray'
  #   imgcolor: 'white'
  #   imgsz: 'large'

  # url = "https://ajax.googleapis.com/ajax/services/search/images?" + _.reduce(param, ((memo, val, key) -> return "#{memo}&#{key}=#{encodeURIComponent(val)}"), '')
  # # url = 'http://testapi.bigstockphoto.com/2/267773/search/?q=onion'

  # if randomWord.images
  #   setImages randomWord.images
  # else
  #   $.ajax({
  #     type: 'GET'
  #     url: url
  #     async: false
  #     jsonpCallback: 'jsonCallback'
  #     contentType: "application/json"
  #     dataType: 'jsonp'
  #     success: (json) -> 
  #       console.log json
  #       if json.responseData
  #         console.log 'yes'
  #         res = json.responseData.results
  #         collection.update { _id: randomWord._id }, $set: { images: res }
  #         setImages res

  #     error: (e) -> console.log(e.message)
  #   })