command: "./scripts/spotify info"

refreshFrequency: 5000

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="/nerdbar.widget/colors.css" />
    <div class='spotify'></div>
  """

style: """
  width: 100%
  position: absolute
  margin-top: -26px
  margin-left: -30px
  text-align: center
  font: 18px "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif
  color: #a5a5a5
  font-weight: 700
"""

cutWhiteSpace: (text) ->
  text.replace /^\s+|\s+$/g, ""

update: (output, domEl) ->

   values = output.split('\n');

   if values.length != 10
     $(domEl).find('.spotify').html('')
     return

   artist = @cutWhiteSpace(values[1])
   song = @cutWhiteSpace(values[2])
   totalSeconds = values[5];
   elapsedSeconds = values[6]
   status = @cutWhiteSpace(values[7])

   elapsed = elapsedSeconds / totalSeconds

   if artist.length >= 30
     artist = artist.substring(0,29)
     artist = @cutWhiteSpace(artist)
     song = song + "…"

   if song.length >= 30
     song = song.substring(0,29)
     song = @cutWhiteSpace(song)
     song = song + "…"

   # Create mpdHtmlString
   mpdHtmlString = "<span class='icon switch'></span><span class='white'>  #{artist} - #{song}&nbsp</span>"

   emptySpace = (120 - artist.length - song.length - 3) / 2

   elapsedCounter = parseInt(elapsed * emptySpace)
   remainingCounter = emptySpace - elapsedCounter - 1



   mpdHtmlString += "<span>"
   i = 0
   while i <= elapsedCounter
     i += 1
     mpdHtmlString += " ● "

   mpdHtmlString += "</span>"
   mpdHtmlString += "<span class='grey'>"

   i = 0
   while i <= remainingCounter
     i += 1
     mpdHtmlString += " ● "

   mpdHtmlString += "</span>"


   mpdHtmlString += "<span class='sicon prev'>&nbsp&nbsp</span>" + " "

   if status == "playing"
      mpdHtmlString += "<span class='sicon pause'></span>" + " "
   else
      mpdHtmlString += "<span class='sicon play'></span>" + " "

   mpdHtmlString += "<span class='sicon next'></span>"

   $(domEl).find('.spotify').html(mpdHtmlString)

   $(".pause").on "click", => @run "./scripts/spotify pause"
   $(".play").on "click",  => @run "./scripts/spotify play"
   $(".next").on "click",  => @run "./scripts/spotify next"
   $(".prev").on "click",  => @run "./scripts/spotify prev"
