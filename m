MIME-Version: 1.0
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Thu, 8 Mar 2018 19:46:03 +0530
Message-ID: <CAOuPNLgxO=tNBOAhJ_FO2Qo4chhi1BvCNSYqCL-TX0yA=9rqsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] [xenomai] inconsistency in latency behavior
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>, Greg Gallagher <greg@embeddedgreg.com>, Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@web.de>, Pintu Kumar <pintu.ping@gmail.com>

Hi,

On x86_64 machine (with xenomai 3.0) sometimes I observed a huge
variance and inconsistency in latency data when measuring latency
delay using clock_nanosleep.
I observed this inconsistency in both normal kernel, as well as xenomai kernel.
I observed the same, even when using the direct xenomai API such as:
rt_time_read().

So, I wanted to know if anybody observed the similar behavior.
Or I am not sure if I am doing some thing wrong in measurement itself.

I will explain my scenario below.
1) I created a single thread using the pthread API.
2) Inside the thread function, I just print one message and sleep for
100 micro-seconds using the clock_nanosleep() API.
3) Then I calculate the time difference before and after sleep.
4) I repeat this for 10 times, and then calculate the average.
5) I build this application for normal kernel and for xenomai using posix skin.
6) Then I compare the latency between both.

What I observed is as follows:
1) Even if I give sleep for 100 micro-seconds, the timing difference
comes in: 150, 160, and even in 600, 1000. Thus the average difference
shows very high.

2) Sometimes, the xenomai timing difference is much larger than normal kernel.
LIKE: Normal kernel => Average time taken  = 232.288 us
       Xenomai kernel => Average time taken  = 427.478 us

3) If I give sleep in less than 5 mirco-seconds, then xenomai shows
better. But still the time taken is not accurate.
    Normal kernel => Average time taken  = 42.989 us
 Xenomai kernel => Average time taken  = 26.264 us

4) If I give sleep in 100 milli-seconds, then only the results are
coming some what proper.
    Normal kernel => Average time taken  = 100.465 us
 Xenomai kernel => Average time taken  = 100.409 us


What could be the cause of this inconsistency ?
Did anybody observed the similar issue on some system?


Here, is my code snippet.
------------------------------------------------------------------------------
myfunc(...)
{
        printf("Something !\n");
        tm.tv_sec = 0;
        tm.tv_nsec = 100*1000; /* 100 micro-seconds */
        clock_nanosleep(CLOCK_MONOTONIC, 0, &tm, NULL);
}

ThreadFunction(..)
{
                clock_gettime(CLOCK_MONOTONIC, &prev);
                myfunc();
                clock_gettime(CLOCK_MONOTONIC, &now);
                diff = ((now.tv_sec - prev.tv_sec) * 1000000000ULL +
(now.tv_nsec - prev.tv_nsec)) / 1000;
                printf("time taken: %5.3f us\n", diff);
}

------------------------------------------------------------------------------
I even tried with CLOCK_REALTIME and using the TIMER_ABS. Behavior is same.
Do you see any problem here ?


Note: Earlier, I could see the proper latency but suddenly some
variance are seen now. I did not modify anything in the kernel after
that. I just enabled RTDM, RTNET and related drivers.
          Even after removing rtnet driver also its the same.


Regards,
Pintu

