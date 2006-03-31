Message-ID: <442D1CAD.3030007@domain.hid>
Date: Fri, 31 Mar 2006 07:12:29 -0500
From: Sean McGranaghan <smm@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_task_delete() question
References: <442C19F2.206@domain.hid> <442C42B5.2070506@domain.hid>
	<442C4816.6030509@domain.hid>
In-Reply-To: <442C4816.6030509@domain.hid>
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<font size="-1"><font face="Helvetica, Arial, sans-serif">Thanks for
the quick response. We will use the signal work around for now.<br>
<br>
Sean<br>
</font></font><br>
Philippe Gerum wrote:
<blockquote cite="mid442C4816.6030509@domain.hid" type="cite">Jan
Kiszka wrote:
  <br>
  <blockquote type="cite">Sean McGranaghan wrote:
    <br>
    <br>
    <blockquote type="cite">Hello all,
      <br>
      <br>
I am posting this for a co-worker who is having problems with killing a
real-time task. (He is joining the email list shortly but for now I
will pass responses on to him.) Here is the scenario:
      <br>
      <br>
1. A Linux process starts up and detaches from the tty (daemon)
      <br>
2. The daemon creates a xeno message queue
      <br>
2. The daemon spawns a xeno task
      <br>
3. The xeno task on startup binds to the queue rt_queue_bind()
      <br>
4. The xeno task waits on the queue recv with infinite timeout
      <br>
5. The daemon process goes to sleep in a join, waiting for the task to
exit
      <br>
6. Some time later another program starts
      <br>
7. The other non-realtime program looks up the xeno task name via
rt_task_bind()
      <br>
8. The other non-realtime program attempts to delete the task via
rt_task_delete()
      <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Failed Attempt #1 - Non-realtime program calls rt_task_delete()
and gets
      <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a segmentation fault
      <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Failed Attempt #2 - Non-realtime program spawns a realtime task
which
      <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; binds to original task and tries
rt_task_delete().
      <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Also gets segmentation fault.
      <br>
      <br>
The was attempted one a system running the latest Xenomai 2.1 release.
      <br>
      <br>
What is the preferred method to start/join threads from a non-realtime
context?
      <br>
      <br>
Any help is appreciated.
      <br>
      <br>
    </blockquote>
    <br>
    <br>
rt_task_delete is not supposed to work across processes (Hmm, is this
    <br>
detail documented somewhere?).
    <br>
    <br>
  </blockquote>
  <br>
Nope, basically because I totally overlooked the issue... but we should
make this possible, since rt_task_suspend() is already system-scoped.
Ok, this one is on my todo list.
  <br>
  <br>
  <blockquote type="cite">Use a normal Linux signal (e.g. SIGTERM) to
terminate the daemon
    <br>
process. For a clean termination, you should install a signal handler
in
    <br>
the daemon process which triggers an organised clean-up (all
    <br>
RT-resources except tasks have to be released explicitly).
    <br>
    <br>
Jan
    <br>
    <br>
    <br>
    <br>
------------------------------------------------------------------------
    <br>
    <br>
_______________________________________________
    <br>
Xenomai-help mailing list
    <br>
<a class="moz-txt-link-abbreviated" href="mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a>
    <br>
<a class="moz-txt-link-freetext" href="https://mail.gna.org/listinfo/xenomai-help">https://mail.gna.org/listinfo/xenomai-help</a>
    <br>
  </blockquote>
  <br>
  <br>
</blockquote>
</body>
</html>

