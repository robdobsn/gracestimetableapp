// Generated by CoffeeScript 1.7.1
(function() {
  var Booklist, Timetable;

  Timetable = (function() {
    function Timetable(theweek, weekDays, theBooklist) {
      this.theweek = theweek;
      this.weekDays = weekDays;
      this.theBooklist = theBooklist;
      this.periodIds = ["period1", "period2", "period3", "period4", "period5", "period7", "period8", "period9", "after-school"];
      this.periodTimes = [9.0, 9 + 40 / 60, 10 + 20 / 60, 11 + 15 / 60, 11 + 55 / 60, 13 + 15 / 60, 13 + 55 / 60, 14 + 35 / 60, 15 + 15 / 60];
    }

    Timetable.prototype.setDay = function(dayIdx) {
      var dayInfo, i, subject, _i, _len;
      this.dayIdx = dayIdx;
      dayInfo = this.theweek[dayIdx];
      for (i = _i = 0, _len = dayInfo.length; _i < _len; i = ++_i) {
        subject = dayInfo[i];
        this.showPeriod(this.periodIds[i], this.periodIds[i + 1], subject, dayInfo[i + 1]);
      }
      $(".daytitle").text(this.weekDays[dayIdx]);
      return this.theBooklist.showbooks(dayInfo);
    };

    Timetable.prototype.nextDay = function() {
      this.dayIdx = this.dayIdx + 1;
      if (this.dayIdx === 5) {
        this.dayIdx = 4;
      }
      return this.setDay(this.dayIdx);
    };

    Timetable.prototype.prevDay = function() {
      this.dayIdx = this.dayIdx - 1;
      if (this.dayIdx === -1) {
        this.dayIdx = 0;
      }
      return this.setDay(this.dayIdx);
    };

    Timetable.prototype.showPeriod = function(id, nextId, subject, nextSubject) {
      $("#" + id).text(subject);
      if (subject === nextSubject) {
        $("#" + id).attr("class", "alt");
        $("#" + id).attr("rowspan", "2");
        return $("#" + nextId).hide();
      } else {
        $("#" + id).attr("rowspan", "1");
        $("#" + nextId).show();
        return $("#" + id).attr("class", "");
      }
    };

    Timetable.prototype.subjecttime = function() {
      var d;
      return d = new Date();
    };

    return Timetable;

  })();

  Booklist = (function() {
    function Booklist(theweek, thebooks) {
      this.theweek = theweek;
      this.thebooks = thebooks;
    }

    Booklist.prototype.showbooks = function(dayInfo) {
      var book, i, prevSubject, subject, _i, _len, _results;
      $('#booklist').empty();
      prevSubject = "";
      _results = [];
      for (i = _i = 0, _len = dayInfo.length; _i < _len; i = ++_i) {
        subject = dayInfo[i];
        if (subject !== prevSubject) {
          prevSubject = subject;
          if (subject in this.thebooks) {
            $('#booklist').append("<div class = 'subject'> " + subject + " </div>");
            _results.push((function() {
              var _j, _len1, _ref, _results1;
              _ref = this.thebooks[subject];
              _results1 = [];
              for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
                book = _ref[_j];
                _results1.push(this.showbook(book));
              }
              return _results1;
            }).call(this));
          } else {
            _results.push(void 0);
          }
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };

    Booklist.prototype.showbook = function(book) {
      return $('#booklist').append("<div class = 'book'> " + book + " </div>");
    };

    return Booklist;

  })();

  $(document).ready(function() {
    var booklist, books, fridayLessons, mondayLessons, thursdayLessons, timetable, tuesdayLessons, wednesdayLessons, week, weekDayNames;
    mondayLessons = ["English", "Biology", "Biology", "Maths", "Maths", "German", "Art & Design", "Art & Design", "Free Time"];
    tuesdayLessons = ["Citizenship", "Geography", "Geography", "Physics", "Physics", "Maths", "German", "English", "Free Time"];
    wednesdayLessons = ["P & R", "P & R", "Music", "PE", "PE", "Maths", "Physics", "Physics", "Riding"];
    thursdayLessons = ["German", "Music", "Music", "English", "English", "Art & Design", "Art & Design", "Tennis", "Tennis"];
    fridayLessons = ["Geography", "Geography", "Computing", "Maths", "English", "Biology", "Biology", "German", "Free Time"];
    week = [mondayLessons, tuesdayLessons, wednesdayLessons, thursdayLessons, fridayLessons];
    weekDayNames = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];
    books = {
      "English": ["Lined Paper", "Roll of Thunder, Hear My Cry"],
      "Maths": ["Jotter", "SSM R2 Textbook"],
      "German": ["Work Jotter", "Dictionary", "ECHO 2 Workbook", "ECHO 2 Textbook", "Vocab Jotter"]
    };
    booklist = new Booklist(week, books);
    timetable = new Timetable(week, weekDayNames, booklist);
    timetable.setDay(0);
    $("#timetable").on("swipeleft", function() {
      return timetable.nextDay();
    });
    $("#timetable").on("swiperight", function() {
      return timetable.prevDay();
    });
    $("#dialog-message").dialog({
      autoOpen: false,
      modal: true,
      buttons: {
        "Ok": function() {
          return $(this).dialog("close");
        }
      }
    });
    return setInterval(this.timetable.subjecttime, 1 * 60 * 1000);
  });

}).call(this);
