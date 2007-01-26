Message-ID: <45B9B1E0.1000305@domain.hid>
Date: Fri, 26 Jan 2007 08:46:40 +0100
From: Steven Scholz <steven.scholz@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] [Xenomai-core] rt_task_create() hangs ?
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

Hi all,

we're doing the first steps with Xenomai and stumbled about some problems.

On our AT91RM9200 (adeos-ipipe-2.6.14-arm-1.5-04,
ipipe-2.6.14-at91-1.5-04.patch) a simple application (that just creates and
destroys two threads)

	rt_task_create(&task_1,"task_1",0,50,0);
	rt_task_create(&task_2,"task_2",0,51,0);
	...
	rt_task_delete(&task_2);
	rt_task_delete(&task_1);

runs fine when started for the first time. But when started again it hangs
in the rt_task_create() for the second task.
Funny enough it all runs fine when we first delete task1 and then task2 ...

On an x86 (adeos-ipipe-2.6.19-i386-1.6-03) the application runs fine. Either
way.

We noticed that on the AT91RM9200 we don't see the

Xenomai: POSIX: destroyed thread c14a0320

message. Not even when running (and stopping) cyclictest. I suspect that
this is leading to our problems.

Any idea?

Thanks a million!

--
Steven

