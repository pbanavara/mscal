I am Pradeep Banavara, an entrepreneurial software engineer. I am a polyglot
programmer, and I have a preference for languages that support first class
functions.
I have shipped backend web services and iOS apps. I have built these apps
primarily in Python, Scala and Swift. Some of these products are:

Accounting compliance backend - An aysnchronous backend service using
Scala/Akka
A distributed semantic graph with probabilistic edge weights - Scala/Titan
Automatic license plate detection using Long Recurrent neural nets -
Python/web.py
An AI based meeting assistant bot - Scala/Spray

My thought process for this assignment

Initially,

User Interface Design
A parent view that contains a calendar view and an agenda view.
These are in turn scroll views but equally split.
The calendar view is a collection view
The agenda view is a table view, each row represents the day's agenda.

These views will be resized automatically as per user actions. Will do my best
to mimic the outlook app. Here are a few changes that I can think of:

The default view in outlook highlights the current day in the calendar view but
shows agenda items for the next 3 days, if your current day's agenda items do
not fill the screen. This is a bit confusing. In such a case I will not highlight the date
in the calendar view.

Update:
The datastructures for the implementation are as follows :

A Dequeue like implementation for the tableview - since the view needs to add
elements to the top and pop elements from the bottom as the table view is
scrolled or as the days are clicked on the calendar view.
A Dictionary to hold the day and agenda items. 
An array of Dates for the month.

TODO:
Fix: Calendarview does not invalidate other cells when a particular cell is
selected. 
Feat: Tableview scrolling updates. (No infinite scroll on the table view)
Fix: Arbitrarily cells are getting highlighted in the calendar view
Feat: Highilight the calendarview cell when that day is scrolled to the top in
tableview


