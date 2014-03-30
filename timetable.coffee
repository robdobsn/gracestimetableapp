class Timetable
	constructor: ->
		@periodIds = [ "period1", "period2", "period3", "period4", "period5", "period7", "period8", "period9", "after-school" ]
		

	setDay: (dayInfo) ->
		@showPeriod @periodIds[i], @periodIds[i+ 1], subject, dayInfo[i+1] for subject, i in dayInfo

	showPeriod: (id, nextId, subject, nextSubject) ->
		$("#" + id).text(subject)
		if (subject == nextSubject)
			$("#" + id).attr("rowspan", "2")
			$("#" + nextId).hide()

$(document).ready ->
	timetable = new Timetable()

	monday = [ "English", "Biology", "Biology", "Maths", "Maths", "German", "Art & Design", "Art & Design", "Ice Skating" ]
	tuesday = [ "Biology", "History", "Maths" ]
	wednesday = [ "Biology", "History", "Maths" ]
	thursday = [ "Biology", "History", "Maths" ]
	friday = [ "Biology", "History", "Maths" ]

	week = [ monday, tuesday, wednesday, thursday, friday ]

	timetable.setDay(monday)