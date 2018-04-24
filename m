MIME-Version: 1.0
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Tue, 24 Apr 2018 13:16:43 +0530
Message-ID: <CAOuPNLgkw9N2ixwb86v_USHhbPwwGh8u6Dn-kCh1UMzpsbSZEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] large number of negative latency with simple task sleep
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I have one doubt with xenomai in general.
I execute a task that does_nothing and simply sleeps for 100 us.
For sleep I used: rt_task_wait_period, with a period of 100 us.
I execute this nothing() function 10 times and measure latency
difference across this, and then print the latency values using:
printf / rt_printf.

I get the following output on x86_64 machine (maxcpus: 8)

main: creating task name: task0, priority: 99
Task: 0, Iteration: 10, Sleep duration: 100 us
1 89.633 -10.367
2 89.542 -10.458
3 93.613 -6.387
4 94.539 -5.461
5 94.767 -5.233
6 93.893 -6.107
7 94.880 -5.120
8 94.775 -5.225
9 94.063 -5.937
10 94.982 -5.018

Task[0] - Avg Latency: -6.531 us
Task[0] - Max Latency: -5.018 us
Task[0] - Min Latency: -10.458 us

------------------
Here if you see, none of the samples crosses the deadline of 100 us.
But on the other hand most of the tasks completed too early.
Thus most of the latency are returning negative.
If I run this for large number of samples, I get too many negative values..
Is this expected ?
Anybody else observed the similar behavior?

AFAIK, for real time timeliness is important, neither too early nor
too late. It should be accurate always....

Whether, it will be the same behavior on a typical RTOS system ?
If somebody can project a real RTOS output in similar manner, it will
be of great help...

If there is anything which can effect this behavior in Xenomai, please
let me know.
Currently I am measuring accuracy, so it is important for me to know....


Thanks,
Pintu

