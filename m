From: "Bradley Valdenebro Peter (DC-AE/ESW52)"
 <Peter.BradleyValdenebro@boschrexroth.nl>
Subject: failing smokey tests
Date: Fri, 20 Mar 2020 12:23:05 +0000
Message-ID: <4aa7e93eb7c44ec793f9c6bb2c9d8587@boschrexroth.nl>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello Xenomai team,

We are currently running a Xenomai/Linux setup on a Zynq Z-7020 SoC (We run=
 Linux on CPU0 and Xenomai on CPU1):
	$ uname -a
		Linux wom03 4.14.110-mainline #1 SMP PREEMPT Tue Mar 17 17:25:22 CET 2020=
 armv7l GNU/Linux
	$ cat /proc/xenomai/version
		3.1
	$ cat /proc/ipipe/version
		7

We are experiencing two problems with the smokey tests:

1. posix_cond (check POSIX condition variable services). This tests fails 8=
 out of 10 executions with the following message:
=09
	$ sudo /usr/bin/smokey --run=3D14 --verbose=3D2
		autoinit_simple_conddestroy
		autoinit_simple_condwait
		simple_condwait
		relative_condwait
		autoinit_absolute_condwait
		cond_wait waited 9998.799 us

By looking at the test autoinit_absolute_condwait it looks like a timed con=
ditional wait should timeout after 10000us. This is measured in the test an=
d checked.
If it's lower than 10000us it will fail. Should it always be equal or highe=
r than 10000us? Are 9998.799us not acceptable?

2. memory_coreheap and memory_heapmem
First execution of any of these tests goes fine but later executions of any=
 of them always result in a system freeze and a power cycle is necessary.
E.g.: If I execute memory_coreheap after a power cycle it will succeed. If =
I later execute memory_heapmem it will freeze.
        Or if I execute memory_heapmem after a power cycle it will succeed.=
 If I later execute it again it will freeze.

It freezes just after printing "(running the pattern check test for 'heapme=
m' -- this may take some time)"

By freeze I mean the system is unresponsive. I cannot even ping the system.
If I had to guess it looks like something isn't freed or cleaned-up properl=
y after the test.

Thanks for your help.
=09
Best regards,
Peter Bradley


