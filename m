From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17547.1818.52887.185464@domain.hid>
Date: Sat, 10 Jun 2006 19:53:30 +0200
Subject: Re: [Xenomai-core] [PATCH] Add fptest for powerpc
In-Reply-To: <448AF791.8080707@domain.hid>
References: <448AF791.8080707@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Heikki Lindholm <holindho@domain.hid>
Cc: xenomai@xenomai.org

Heikki Lindholm wrote:
 > This adds powerpc version of fptest.h. It just stores and loads the raw 
 > integer into/from FPU registers without converting to proper IEEE form. 
 > Converting would have added unneccessary complexity. As a side note, the 
 > ppc barfs on the test with "1000 != 10". :I

Ok, this test tool is far from being user-friendly :-)

Just to be sure, I have tested the latest revision on x86 and it still
runs fine, so I guess there really is a bug in power pc fpu switching
code.

Now, if we decode a bit, the integer passed to fp_regs_set and
fp_regs_check are 1000 * iterations + task_index, so
1000 is task 0, iteration 1
10 is task 10, iteration 0.
It means that task 10 after returning from its first context 
switch, is getting the context of task 0 before its second context
switch.

Now the thing to try is to reduce the number of threads involved, since
by default there are 23 threads, so you should add a printk for each
context switch in the kernel driver (and now that I think about it this
printk should be activable with an ioctl), and try and reduce the list
of threads by removing threads which do not appear between the serie of
switches from task 0 to task 10. The correspondance between the task
numbers and their type is not easy, but /proc/xenomai/sched and switch
--help should help... 

Task 0 is the "idle" taks, an ordinary Linux task
Task 10 is of type "rtup_ufpp" here, which means that it is a real-time
task in primary mode using the FPU in primary mode.


-- 


					    Gilles Chanteperdrix.

