Message-ID: <442C19F2.206@domain.hid>
Date: Thu, 30 Mar 2006 12:48:34 -0500
From: Sean McGranaghan <smm@domain.hid>
MIME-Version: 1.0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] rt_task_delete() question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<big><font size="-1"><big><tt>Hello all,<br>
<br>
I am posting this for a co-worker who is having problems with killing a
real-time task. (He is joining the email list shortly but for now I
will pass responses on to him.) Here is the scenario:<br>
<br>
1. A Linux process starts up and detaches from the tty (daemon)<br>
2. The daemon creates a xeno message queue<br>
2. The daemon spawns a xeno task<br>
3. The xeno task on startup binds to the queue rt_queue_bind()<br>
4. The xeno task waits on the queue recv with infinite timeout<br>
5. The daemon process goes to sleep in a join, waiting for the task to
exit<br>
6. Some time later another program starts<br>
7. The other non-realtime program looks up the xeno task name via
rt_task_bind()<br>
8. The other non-realtime program attempts to delete the task via
rt_task_delete()<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Failed Attempt #1 - Non-realtime program calls rt_task_delete()
and gets<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a segmentation fault<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Failed Attempt #2 - Non-realtime program spawns a realtime task
which <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; binds to original task and tries
rt_task_delete().<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; Also gets segmentation fault.<br>
<br>
The was attempted one a system running the latest Xenomai 2.1 release.<br>
<br>
What is the preferred method to start/join threads from a non-realtime
context?<br>
<br>
Any help is appreciated.<br>
</tt></big></font></big><font size="-1"><font
 face="Helvetica, Arial, sans-serif"><br>
</font></font>
</body>
</html>

