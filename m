MIME-Version: 1.0
References: <CAJA_znn4P=_tmbcKCipcmYrhPUhFw4JrMWv2VAMVR0DYSx9iMA@mail.gmail.com>
In-Reply-To: <CAJA_znn4P=_tmbcKCipcmYrhPUhFw4JrMWv2VAMVR0DYSx9iMA@mail.gmail.com>
From: Ari Mozes <arimozes@neocisinc.com>
Date: Mon, 25 Feb 2019 08:32:14 -0500
Message-ID: <CAJA_znnmCr7QSjsnSQbLRYTM+CyBex05sBV0gbOdVQgYuBK0Tw@mail.gmail.com>
Subject: Fwd: Debugging system freeze, SIGXCPU
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Resending this question with testcase.
Can someone give the testcase a try to see if it reproduces the problem I
am seeing?  Is more information needed?
It takes a couple of minutes before I see the issue occur.

Thanks,
Ari

---------- Forwarded message ---------
From: Ari Mozes <arimozes@neocisinc.com>
Date: Thu, Jan 24, 2019 at 11:35 AM
Subject: Debugging system freeze, SIGXCPU
To: <xenomai@xenomai.org>


I am new to Xenomai and trying to troubleshoot a repeatable Linux
freeze I was experiencing (nothing in the system logs I could find,
unresponsive to any keystrokes like REISUB, etc.)  I then switched
from cobalt 3.0.7 running on Linux 4.4.71 to cobalt 3.0.8 on 4.14.89,
but the problem remained.  I then turned on all Xenomai debugging
options when building the kernel, and I am now seeing SIGXCPU.  I
assume this is the same issue that was causing the freeze before I
enabled Xenomai debugging options, but I am not certain.  Below is the
info from my system as well as a reduced testcase which can reproduce
the SIGXCPU on my system.  Most important (to me) is gaining a better
understanding of what to expect from Xenomai and how to identify
problematic code as I try to transition a much larger code base to an
RTOS (specifically Xenomai).  Any help and insight would be
appreciated.  Happy to provide any missing information and/or run
experiments to help further troubleshoot.

- Ari

Result from running /usr/xenomai/bin/xeno-config --info:
Xenomai version: Xenomai/cobalt v3.0.7
Linux fire 4.14.89 #3 SMP PREEMPT Sat Jan 19 15:34:03 EST 2019 x86_64
x86_64 x86_64 GNU/Linux
Kernel parameters: BOOT_IMAGE=/boot/vmlinuz-4.14.89
root=UUID=2ffdfd76-c81d-4252-88df-b51b6b0fcc9b ro quiet splash
i915.enable_rc6=0 i915.enable_dc=0 xeno_nucleus.xenomai_gid=129 nosmap
i915.modset=0 noapic intremap=off xenomai.allowed_group=129
crashkernel=64M@16M vt.handoff=7
I-pipe release #2 detected
Cobalt core 3.0.8 detected
Compiler: gcc version 6.5.0 20181026 (Ubuntu 6.5.0-2ubuntu1~16.04)
Build args: --with-pic --with-core=cobalt --enable-smp --disable-tls
--enable-dlopen-libs --disable-clock-monotonic-raw

Test case file xenapp.cpp:

#include <stdio.h>
#include <sys/mman.h>
#include <alchemy/task.h>
#include <alchemy/timer.h>
#include <chrono>
#include <unistd.h>

// All times are in nanoseconds
#define TIME_10ms  10000000
#define TIME_100us   100000

#define TASK_PERIOD TIME_10ms
#define TASK_TICKS (rt_timer_ns2ticks(SRTIME(TASK_PERIOD)))

#define SLEEP_TIME TIME_100us
#define SLEEP_TICKS (rt_timer_ns2ticks(SRTIME(SLEEP_TIME)))

#define TASK_BUSY (TASK_PERIOD / 4) // "work" for about 1/4 of the period
#define LOOP_COUNT ((int)(TASK_BUSY / SLEEP_TIME))

void xenTaskFunc(void *cookie)
{
    int errno;
    std::chrono::high_resolution_clock::time_point curTime;
    unsigned long overruns = 0;

    errno = rt_task_set_periodic(NULL, TM_NOW, TASK_TICKS);
    if (errno) {
        printf("rt_task_set_periodic error: %d %s\n", errno,
strerror(-errno));
    }

    while(true) {
        // If I alternate between the std::chrono call and rt_task_sleep for
        // part of the task period, SIGXCPU is thrown.
        for (int i = 0; i < LOOP_COUNT; i++) {
            curTime = std::chrono::high_resolution_clock::now();
            errno = rt_task_sleep(SLEEP_TICKS);
            if (errno) {
                printf("rt_task_sleep error: %d %s\n", errno,
strerror(-errno));
            }
        }
        errno = rt_task_wait_period(&overruns);
        if (errno) {
            if (errno == -ETIMEDOUT) {
                printf("rt_task_wait_period overruns: %ld\n", overruns);
            }
            else {
                printf("rt_task_wait_period error: %d %s\n", errno,
strerror(-errno));
                break;
            }
        }
  }
}

int main(int argc, char **argv)
{
    mlockall(MCL_CURRENT | MCL_FUTURE);

    int errno;
    RT_TASK xenTask;
    errno = rt_task_create(&xenTask, "xenTestTask", 0, 50, 0);
    if (errno) {
        printf("rt_task_create error: %d %s\n", errno, strerror(-errno));
    }
    errno = rt_task_start(&xenTask, &xenTaskFunc, NULL);
    if (errno) {
        printf("rt_task_start error: %d %s\n", errno, strerror(-errno));
    }

    printf("TASK_TICKS %lld, SLEEP_TICKS %lld, LOOP_COUNT %d\n",
        TASK_TICKS, SLEEP_TICKS, LOOP_COUNT);

    // wait for signal
    pause();
}


Test case Makefile:

XENO_CONFIG := /usr/xenomai/bin/xeno-config
CFLAGS := $(shell $(XENO_CONFIG) --alchemy --cflags)
LDFLAGS := $(shell $(XENO_CONFIG) --alchemy --ldflags)
CC := $(shell $(XENO_CONFIG) --cc)

all: xenapp

xenapp: xenapp.cpp
    $(CC) -o $@ $< $(CFLAGS) $(LDFLAGS) -lstdc++


-- 

*Ari Mozes*
*Staff Software Engineer*

*Neocis, Inc. <http://www.neocis.com/>*

*Mobile: 781.266.6553 <(858)%20692-1927>*

* <https://www.linkedin.com/company/neocis-inc-/>
<https://twitter.com/yomirobot>
<https://www.facebook.com/YomiRobot/>
<https://www.instagram.com/yomirobot/>
<https://www.youtube.com/channel/UC0TgygGbBNYX267-o6bnWyg>*
*. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .*

<https://www.neocis.com/>
