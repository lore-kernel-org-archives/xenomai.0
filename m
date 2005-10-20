Message-ID: <4357C3E1.1040701@domain.hid>
Date: Thu, 20 Oct 2005 18:20:49 +0200
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] timeout in native API calls (cond, sem, mutex, etc).
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

Hi,

While porting my application, I noticed that all synchronization
primitives locking calls take a relative timeout as a parameter, right?

Of course, I can get the current time, calculate the timeout interval by
substracting the current time from the desired timeout moment, and call
the function. But wouldn't something like this be possible?:

Suppose I want to wait on a semaphore until t=1000, and now=900.

1- I get current time (900).
2- I calculate the relative timeout as 1000-900 = 100
3- I call rt_sem_p(&mysem, 100);

In the best case, no preemption will occur between steps 1 and 3, but my
thread will still be sleeping not until t=1000, but until some time
later, t=1000+d, where d is the time used by the code in steps 1-3 and
into the native skin/nucleus.

In the worst case, in addition to that, the thread will be preempted
between steps 1 and 3. If it is preempted by another higher priority
thread for, say, 50 ticks, and the call in step 3 is actually executed
at t=950, the thread will be sleeping until t=1050+d, which may not be
acceptable.

What do you think?

Nacho.





