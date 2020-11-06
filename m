MIME-Version: 1.0
From: Lakshmi Dhanaraj <lakshmi.d@teclever.com>
Date: Fri, 6 Nov 2020 22:00:19 +0530
Message-ID: <CAJCHRmFDvkPHi-dtJDJ3kLBsrxQKwVC5J5HnGT6KLO0OrtGe5A@mail.gmail.com>
Subject: Periodic Scheduler in Kernel Space
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: sunshilong <sunshilong369@gmail.com>, =?UTF-8?B?OiDlrZnkuJbpvpkgc3Vuc2hpbG9uZyB2aWEgWGVub21haQ==?= <xenomai@xenomai.org>

Hi Sunshilong,

I need to create a 12.5ms periodic scheduler in Xenomai(v3.0.5) Kernel
Space on Linux Kernel 4.9.38 under Ubuntu 18.04.1 LTS.Inside my scheduler I
have multiple semaphore down functions to wait for the response from
multiple threads.

1.I created a periodic task using rtdm_task_init() and
rtdm_task_wait_period() with task priority of 90.It is working fine without
any overruns for a while and my system is getting hanged if I tries to open
system monitor Window.May I know why and I need to set any cpu affinity to
the scheduler thread?But in the driver implementation,for CPU affinity is
setted as CPU_MASK_ALL by default.

2.Tried another way using kthread_create() along with hrtimer_create().In
hrtimer callback function,I am not able to use semaphore down func since it
acts like an interrupt.So I created a separate thread in which my sem_downs
are added and waiting for another semaphore trigger from hrtimer callback()
function.
But here the semaphore trigger from the hrtimer exceeds 12.5 ms upto 18ms
under load.

The issue is that in my first case,the timings are ok but the system
hangs,in my second case system not hanging but timing exceeds.

I verified the timings of both the cases by increasing CPU Load using
"taskset -c (0...7) yes" and stress.Is this the correct way to verify the
stability of my scheduler in kernel space?

I was struck with this problem for more than a week, please help me out to
solve the issue as soon as possible.Awaiting for your reply.






With Thanks & Regards,

Lakshmi.D
