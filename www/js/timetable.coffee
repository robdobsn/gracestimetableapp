class Timetable
	constructor: (@theweek, @weekDays, @theBooklist) ->
		@periodIds = [ "period1", "period2", "period3", "period4", "period5", "period7", "period8", "period9", "after-school" ]
		
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

class Booklist
	constructor: (@theweek, @thebooks) ->

	showbooks: (dayInfo) ->
		for subject, i in dayInfo
			if subject of @thebooks
				@showbook book for book in @thebooks[subject]

	showbook: (book) ->
		$('#booklist').append (book)

$(document).ready ->


	monday = [ "English", "Biology", "Biology", "Maths", "Maths", "German", "Art & Design", "Art & Design", "Free Time" ]
	tuesday = [ "Citizenship", "Geography", "Geography", "Physics", "Physics", "Maths", "German", "English", "Free Time" ]
	wednesday = [ "P & R", "P & R", "Music", "PE", "PE", "Maths", "Physics", "Physics", "Riding" ]
	thursday = [ "German", "Music", "Music", "English", "English", "Art & Design", "Art & Design", "Tennis", "Tennis" ]
	friday = [ "Geography", "Geography", "Computing", "Maths", "English", "Biology", "Biology", "German", "Free Time" ]

	week = [ monday, tuesday, wednesday, thursday, friday ]
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