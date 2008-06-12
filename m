Message-ID: <d6c8ef150806121541m4b31aa79hbaf62e23d50d742f@domain.hid>
Date: Fri, 13 Jun 2008 00:41:02 +0200
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] Change propagation using rt_heap ?
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

Hi all,

I have a quite strange problem. After some hours of trying to
understand what I'm doing wrong, I think that my problem is, actually,
some kind of 'change propagation' between kernel and user space when
using rt_heap_*

In kernel space module, I create and allocate memory:
rt_heap_create(&heap_desc, "Name", Size, H_SHARED);
rt_heap_alloc (&heap_desc, 0, TM_NONBLOCK, &memory);

In userspace I bind and allocate memory:
rt_heap_bind (&heap_desc, "Name", TM_NONBLOCK);
rt_heap_alloc (&heap_desc, 0, TM_NONBLOCK, &memory_start);

I'm updating some regions of that memory from ISR. Also, I have one
small kernel thread (linux kernel thread, created with
kthread_create()) that sends, from time to time, through rt_pipe a
notification to userspace program (ISR is setting a flag, etc). When
userspace program receives notification via rt_pipe_receive() it reads
some parts of the rt_heap memory.

It looks this way:

ISR update memory -> ISR set a flag -> KernelThread reads flag ->
KernelThread sends notification over rt_pipe -> userspace waits in
select() -> userspace reads memory

If this way between first and the last stage is 'very fast' I get,
from time to time, (like every 3rd userspace read) inconsistency.
Userspace is actually reading the previous value of memory region,
like before ISR's update. For the proof of concept, I added usleep
(500000) [0.5 secs] before memory read in usersapce and, after
30minutes, I'm unable to detect reported problem. I noticed that
usleep (100000) is not enough.

My question is: is this behavior expected?

ps. Platform is AT91SAM9260, Xenomai 2.4.4, kernel 2.6.24
pps. From the ISR perspective, values are updated 'immediately'

