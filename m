Message-ID: <4B2B3DC0.3000804@domain.hid>
Date: Fri, 18 Dec 2009 03:30:56 -0500
From: Josh Bowman <jbowman@domain.hid>
MIME-Version: 1.0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Linux-Xenomai Priority Coupling and T_RPIOFF
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
</head>
<body bgcolor="#ffffff" text="#000000">
Hi,<br>
<br>
I'm trying to turn off the "priority coupling" feature for a specific
Xenomai task in our application. (The task in question is a
communications thread, and the only time it goes into secondary mode is
when it calls read() or write() on a TCP socket. At that time, it will <i>not</i>
be holding the RT_MUTEX that protects the data it shares with the other
xenomai tasks, so it should not impact the scheduling of the other real
time tasks in the system.&nbsp; But giving Linux a real time priority could
starve out other equal- and lower-priority real time tasks in the
system.)<br>
<br>
Anyway, turning off the CONFIG_XENO_OPT_PRIOCPL kernel option works
fine, and seems to do want I want. But there's a note in the config
documentation that says I should be able to leave that option On, and
just turn off priority coupling for a specific task at runtime.&nbsp;
According to the API docs, it seems I should be able to write:<br>
<br>
<tt>&nbsp;&nbsp;&nbsp; int prevMode = 0;<br>
&nbsp;&nbsp;&nbsp; int err = rt_task_set_mode( 0, T_RPIOFF, &amp;prevMode );</tt><br>
<br>
from the context of the xenomai task.&nbsp; (I've also tried passing 0
instead of &amp;prevMode.)&nbsp; Either way, it always seems to return
-EINVAL (meaning "either <em>setmask</em> or <em>clrmask</em>
specifies invalid bits.")<br>
<br>
So I have two questions:<br>
1.&nbsp; Is there a bug here, or am I misreading the docs? How do I turn off
priority coupling at runtime?<br>
2.&nbsp; Is there any reason I would want to leave CONFIG_XENO_OPT_PRIOCPL
enabled?<br>
<br>
I'm using Xenomai 2.4.10 on x86 with Linux 2.6.28.9 and ipipe
2.6.28.9-x86-2.2-07.&nbsp; (I've also tested with Linux 2.6.30.8 and ipipe
2.6.30.8-x86-2.4-06, with the same result.)<br>
<br>
Thanks for your help,<br>
Josh<br>
</body>
</html>

