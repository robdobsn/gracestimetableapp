class Timetable
	constructor: (@theweek, @weekDays) ->
		@periodIds = [ "period1", "period2", "period3", "period4", "period5", "period7", "period8", "period9", "after-school" ]
		
	setDay: (@dayIdx) ->
		dayInfo = @theweek[dayIdx]
		@showPeriod @periodIds[i], @periodIds[i+ 1], subject, dayInfo[i+1] for subject, i in dayInfo
		$(".daytitle") .text (@weekDays[dayIdx])

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
			$("#" + id).attr("rowspan", "2")
			$("#" + nextId).hide()
		else
			$("#" + id).attr("rowspan", "1")
			$("#" + nextId).show()

$(document).ready ->


	monday = [ "English", "Biology", "Biology", "Maths", "Maths", "German", "Art & Design", "Art & Design", "Ice Skating" ]
	tuesday = [ "Citizenship", "Geography", "Geography", "Physics", "Physics", "Maths", "German", "English", "Free Time" ]
	wednesday = [ "P & R", "P & R", "Music", "PE", "PE", "Maths", "Physics", "Physics", "Riding" ]
	thursday = [ "German", "Music", "Music", "English", "English", "Art & Design", "Art & Design", "Hockey", "Hockey" ]
	friday = [ "Geography", "Geography", "Computing", "Maths", "English", "Biology", "Biology", "German", "Debating" ]

	week = [ monday, tuesday, wednesday, thursday, friday ]
	weekDayNames = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]

	timetable = new Timetable(week, weekDayNames)
	timetable.setDay(0)

	$("#timetable").on "swiperight", ->
		timetable.nextDay()
    	
	$("#timetable").on "swipeleft", ->
		timetable.prevDay()