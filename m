Message-ID: <ea7e69bd0811161026q4481e280l7dcf664fee50eeec@domain.hid>
Date: Sun, 16 Nov 2008 12:26:06 -0600
From: "Jefferson Noxon" <jeff@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_18001_26441857.1226859966511"
Subject: [Xenomai-help] Maximum number of kernel tasks?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

------=_Part_18001_26441857.1226859966511
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

This is my first project using Xenomai. I have a Diamond Systems Athena II
board with an 800 MHz VIA Mark (Corefusion) chip. I built Xenomai 2.4.5 with
Linux kernel 2.6.26.5 and I-pipe 2.0-09.

For some reason I can create 7 kernel tasks just fine, but the 8th task
fails with -ENOMEM in rt_task_create(). I increased the heap size from 128Kb
to 256Kb, but the problem persists. If I remove my kernel module and re-load
it after a task creation fails, I get an oops in __xntimer_init after
starting my first task (which is periodic).

If I build the same code to run in user-space (I have ifdefs allowing me to
build it either way), I can create as many tasks as I want and my code
behaves exactly as I would expect it to.

I imagine I am probably doing something stupid, but since it works in user
mode I'm not sure what to check. Is there a limit of RT kernel tasks? If
not, any pointers on how to debug this would be appreciated.

Thanks

Jeff

------=_Part_18001_26441857.1226859966511
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br><br>This is my first project using Xenomai. I have a Diamond Systems Athena II board with an 800 MHz VIA Mark (Corefusion) chip. I built Xenomai 2.4.5 with Linux kernel <a href="http://2.6.26.5">2.6.26.5</a> and I-pipe 2.0-09.<br>
<br>For some reason I can create 7 kernel tasks just fine, but the 8th task fails with -ENOMEM in rt_task_create(). I increased the heap size from 128Kb to 256Kb, but the problem persists. If I remove my kernel module and re-load it after a task creation fails, I get an oops in __xntimer_init after starting my first task (which is periodic).<br>
<br>If I build the same code to run in user-space (I have ifdefs allowing me to build it either way), I can create as many tasks as I want and my code behaves exactly as I would expect it to.<br><br>I imagine I am probably doing something stupid, but since it works in user mode I&#39;m not sure what to check. Is there a limit of RT kernel tasks? If not, any pointers on how to debug this would be appreciated.<br>
<br>Thanks<br><br>Jeff<br>

------=_Part_18001_26441857.1226859966511--

