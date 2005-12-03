Message-ID: <4392171A.9070703@domain.hid>
Date: Sat, 03 Dec 2005 23:07:22 +0100
From: Paolo Gai <pj@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Newbie question about priorities of xenomai Threads
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

Dear all,

My name is Paolo and i am brand new to Xenomai :-)

I downloaded and installed the stable version of Xenomai, 2.0.1. I tried 
a few demos, and some POSIX skin examples: they work just fine :-). Then 
and I started reading the documentation and some code (I have to say it 
is very well done). Sorry if my first questions will be a little bit 
simple and obvious.

I have a first question related to Xenomai Threads priorities and 
scheduling. In particular I refer to the "Common priority scheme" in the 
"Life with Adeos" document. What I understood is the following:

- Xenomai threads have a priority value that is compatible (let's say 
transparent) between the primary and secondary domain.
- Xenomai threads in secondary mode and Linux real time threads (let's 
say those with SCHED_FIFO or SCHED_RR policy) have compatible priority 
values.
- Among the pool of ready Xenomai threads, the Xenomai thread with 
highest priority is scheduled first.
- If the selected xenomai thread is in secondary mode and there is a 
Linux thread with higher priority, the Linux thread is scheduled first.


First example:
---------------------
Suppose that at a rescheduling we have the following thread in the ready 
queues
- High Priority -> Linux thread H
- Medium Priority -> Xenomai thread M in PRIMARY domain
- Low Priority -> Xenomai thread L in primary domain

Then, the Xenomai scheduler will select M, and M will be dispatched.

Second example:
--------------------------
- High Priority -> Linux thread H
- Medium Priority -> Xenomai thread M in SECONDARY domain
- Low Priority -> Xenomai thread L in primary domain

Then, the Xenomai scheduler will select M. but M is in secondary mode, 
which means the Linux kernel will be scheduled. The Linux scheduler 
knows H (it's a linux thread), M (it's in secondary mode), and maybe 
about L (if it has been created by UVMs). The Linux scheduler will 
choose H, and H will be scheduled.

Is that right?

bye

Paolo Gai
http://www.evidence.eu.com


