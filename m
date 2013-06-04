MIME-Version: 1.0
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Tue, 4 Jun 2013 12:56:26 +0200
Message-ID: <CAMJ=MEeeWCB9AgnmjyPjM8F9kLe63UCBCBirB2i_MYvb_UvL5w@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] [xenomai-forge] psos: crash while stressing event timers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello

we are currently running with recent version of xenomai-forge.
The issue we see is a crash while running the attached application code
(pSOS interface).

Basically the test creates a number of "chained" (called batches) tasks.
After setting up the batch, the first task starts a timer and when the
timer expires, an event is sent to the next task in the chain.
This process continues forever.

If only 1 chain is created we do not see issues.
The number of threads in the chain is less relevant since typically there
will be no big impact when the number of tasks increases.

When we start to increase the number of batches we start to see crashes.
For example in the test below we create 20 batches with 1 thread in each
batch.
The -o parameter specifies the timeout used by the timer of each task
before the control is given to the next task in the chain.

ulimit -s 128 ;taskset 2 ./tests -t 1 -b 20 -o 1
Xenomai test: threads 1, batches 20, timeout 1 ms, stats 0
thread_entry(0,0)
thread_entry(1,0)
thread_entry(2,0)
thread_entry(3,0)
thread_entry(4,0)
thread_entry(5,0)
thread_entry(6,0)
thread_entry(7,0)
thread_entry(8,0)
thread_entry(9,0)
thread_entry(10,0)
thread_entry(11,0)
thread_entry(12,0)
thread_entry(13,0)
thread_entry(14,0)
thread_entry(15,0)
thread_entry(16,0)
thread_entry(17,0)
thread_entry(18,0)
thread_entry(19,0)
tm_evafter(4,0) returned 75 (errno 22): tmid=3D4920880
tm_evafter(9,0) returned 75 (errno 22): tmid=3D4919912
Segmentation fault

After some investigation it looks like it has something to do with the
timerhandling in xenomai.
The tm_evafter error indicates that the creation of the underlying posix
timer has failed.
Short after this typically a segmentation fault is seen.

If we run the same test application with an old version of xenomai forge
(1year ago) the issue is not observed.

Other useful information is that we typically see the issue when we start
to reach a high cpuload.
On boards with a stronger processor, the number of batches can be much
higher compared to boards with a low end processor.

The problem is observed in various processor environments (mips/arm/ppc)
and with different versions of the C library.

Best regards,
Ronny
-------------- next part --------------
A non-text attachment was scrubbed...
Name: event_stress.c
Type: text/x-csrc
Size: 7481 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130604/1800cdf=
1/attachment.c>
