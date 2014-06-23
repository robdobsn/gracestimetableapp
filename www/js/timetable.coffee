class Timetable
	constructor: (@theweek, @weekDays, @theBooklist) ->
		@periodIds = [ "period1", "period2", "period3", "period4", "period5", "period7", "period8", "period9", "after-school" ]
		@periodTimes = [ 9.0, 9 + 40/60, 10 + 20/60, 11 + 15/60, 11 + 55/60, 13 + 15/60, 13 + 55/60, 14 + 35/60, 15 + 15/60]
		
	setDay: (@dayIdx) ->
		dayInfo = @theweek[dayIdx]
		@showPeriod @periodIds[i], @periodIds[i+ 1], subject, dayInfo[i+1] for subject, i in dayInfo
		$(".daytitle") .text (@weekDays[dayIdx])
		@theBooklist.showbooks dayInfo 

	nextDay: () ->
		@dayIdx = @dayIdx + 1
		if @dayIdx == 5 then @dayIdx = 4
		@setDay (@dayIdx)

	prevDay: () ->
		@dayIdx = @dayIdx - 1
		if @dayIdx == -1 then @dayIdx = 0
		@setDay (@dayIdx)


	showPeriod: (id, nextId, subject, nextSubject) ->
		$("#" + id).text(subject)
		if (subject == nextSubject)
			$("#" + id).attr("class", "alt")
			$("#" + id).attr("rowspan", "2")
			$("#" + nextId).hide()
		else
			$("#" + id).attr("rowspan", "1")
			$("#" + nextId).show()
			$("#" + id).attr("class", "")

	subjecttime: ->
		d = new Date()
		

class Booklist
	constructor: (@theweek, @thebooks) ->

	showbooks: (dayInfo) ->
		$('#booklist').empty()
		prevSubject = ""
		for subject, i in dayInfo
			if subject isnt prevSubject
				prevSubject = subject
				if subject of @thebooks
					$('#booklist').append ("""<div class = 'subject'> #{subject} </div>""")
					@showbook book for book in @thebooks[subject]

	showbook: (book) ->
		$('#booklist').append ("""<div class = 'book'> #{book} </div>""")

$(document).ready ->

	mondayLessons = [ "English", "Biology", "Biology", "Maths", "Maths", "German", "Art & Design", "Art & Design", "Free Time" ]
	tuesdayLessons = [ "Citizenship", "Geography", "Geography", "Physics", "Physics", "Maths", "German", "English", "Free Time" ]
	wednesdayLessons = [ "P & R", "P & R", "Music", "PE", "PE", "Maths", "Physics", "Physics", "Riding" ]
	thursdayLessons = [ "German", "Music", "Music", "English", "English", "Art & Design", "Art & Design", "Tennis", "Tennis" ]
	fridayLessons = [ "Geography", "Geography", "Computing", "Maths", "English", "Biology", "Biology", "German", "Free Time" ]

	week = [ mondayLessons, tuesdayLessons, wednesdayLessons, thursdayLessons, fridayLessons ]
	weekDayNames = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]

	books = {
		"English": ["Lined Paper", "Roll of Thunder, Hear My Cry"],
		"Maths": ["Jotter", "SSM R2 Textbook"],
		"German": ["Work Jotter", "Dictionary", "ECHO 2 Workbook", "ECHO 2 Textbook", "Vocab Jotter"],
		}

	booklist = new Booklist(week, books)

	timetable = new Timetable(week, weekDayNames, booklist)
	timetable.setDay(0)

	$("#timetable").on "swipeleft", ->
		timetable.nextDay()
    	
	$("#timetable").on "swiperight", ->
		timetable.prevDay()

	$( "#dialog-message" ).dialog
		autoOpen: false
		modal: true
		buttons: 
			"Ok": -> 
				$(this).dialog("close")

	setInterval @timetable.subjecttime, 1*60*1000
   