Date: Tue, 21 Feb 2006 09:38:21 -0800
From: Steven Seeger <steve@domain.hid>
Message-ID: <C020900D.24A8%steve@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
Subject: [Xenomai-help] no-brainer issue found, but not solved
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I have found what seems to cause my problem.

I have two threads, t1 and t2.

t1 has a priority level of 30, and t2 has a priority level of 5. I am using
the native skin, so t1 has the higher priority.

t2 is flashing an LED on my board every 40 ms, and t1 does nothing until I
hit a key on the keyboard. When t1 activates, it does for(i=0; i<100000000;
i++) which locks up my board for about 3 seconds. During this time, I expect
my LED to stop flashing. However, the LED will flash a few times just once,
at a rate of about 1 second. (Coincidentally, 1 second is the timing of
another unrelated thread in the system.)

At the start of my t1 thread, I use syslog (a system call) to log that the
thread is created. This call is made once before the thread goes into its
loop, waiting for a global variable to be set otherwise just calling
rt_task_wait_period(). If I comment out my call to syslog, which again I
state is NOT in the thread loop, this behavior goes away. It seems that once
a syscall is made in a shadow thread, xenomai fails to have it behave in a
true hard realtime fashion. It's as if the thread stays relaxed.

Does this shed any light on the issue I have?

Steven


