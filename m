MIME-Version: 1.0
In-Reply-To: <5590E4E4.6030101@web.de>
References: <CAJt3u5n2Ay=QSbR-jXtymMLTBWp263km_Q6ByPqqbJR2N179AA@mail.gmail.com>
 <CAJt3u5m6i63UPTG5gOC3L8qkgX_3aKW20u-LwSFDRKd=R5T__Q@mail.gmail.com>
 <5590E4E4.6030101@web.de>
Date: Tue, 30 Jun 2015 09:04:32 +0530
Message-ID: <CAJt3u5=cbY2V0xNy_ug-T8=ZWMazMbT_nit9_e9bEWeo7LMiaw@mail.gmail.com>
From: Madan Sondur <sondur.madan23@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] CyclicTest query on Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: xenomai@xenomai.org

I stress tested the system for an hour using Pi-stress and pumping huge
amount of data through usb3.0 and I perf at network.  What I have observed
is cyclictest from usr/xenomai/bin behaves differently, only the first
thread completes then after all the other threads execute very slowly, you
can see the count value.

But the cyclictest that was downloaded from net completes all the threads
and exits.

The results of sample tests for 5000 loops are as shown.

Xenomai cyclictest T1 count is 120, where as cyclictest which is from net
has T1 count of 4546.

Why is this behaviour?

Thx
M
On 29-Jun-2015 11:55 am, "Jan Kiszka" <jan.kiszka@web.de> wrote:

> On 2015-06-29 07:33, Madan Sondur wrote:
> > Hi,
> > Any inputs will be greatly appreciated,
>
> Apply proper load on Linux (e.g. via xeno-test) and run the tests over a
> much longer period to get relevant results.
>
> Jan
>
> >
> > Thanks
> > M
> >
> > On Fri, Jun 26, 2015 at 11:46 AM, Madan Sondur <sondur.madan23@gmail.com
> >
> > wrote:
> >
> >> Hi ,
> >>
> >> I have installed Xenomai 2.6.4 on Ubuntu 12.04 64 bit.
> >>
> >> Linux Madan 3.8.13-xenomai-2.6.4 #2 SMP Wed Jun 24 11:22:01 IST 2015
> >> x86_64 x86_64 x86_64 GNU/Linux
> >>
> >> After successfull installation, i am getting varied results with
> >> cyclictest present in /usr/xenomai/bin folder and the one in the
> rt-tests
> >> which i downloaded.
> >>
> >> pi_stress is used in background to stress the system.
> >>
> >> Xenomai cyclictest takes a lot of time to complete other threads, where
> as
> >> the first one completes quickly. This is exactly the opposite if i run
> the
> >> cyclictest, first thread completes and the test stops.
> >>
> >> 1) is my observation correct? I may be missing some understanding here.?
> >>
> >> 2) This is done in Core i7, the difference in latencies with and without
> >> xenomai are noticeable but not significant, Is this correct ?
> >>
> >> 3) I trying to have Hard real time System with minimal latencies ?
> >>
> >> Below are output results.
> >>
> >> Can you please help.
> >>
> >>
> >>
> ------------------------------------------------------------------------------------------------
> >> Linux Madan 3.8.13-xenomai-2.6.4 #2 SMP Wed Jun 24 11:22:01 IST 2015
> >> x86_64 x86_64 x86_64 GNU/Linux
> >>
> >> root@Madan:/usr/xenomai/bin#/home/mymo/MADAN_Xeno/rt-tests/cyclictest
> -t
> >> 21 -p 80 -i 5000 -l 5000
> >> # /dev/cpu_dma_latency set to 0us
> >> policy: fifo: loadavg: 0.00 0.01 0.01 1/405 2756
> >>
> >> T: 0 ( 2736) P:80 I:5000 C:   5000 Min:      2 Act:    5 Avg:    3
> >> Max:      24
> >> T: 1 ( 2737) P:80 I:5500 C:   4546 Min:      1 Act:    2 Avg:    2
> >> Max:      18
> >> T: 2 ( 2738) P:80 I:6000 C:   4167 Min:      2 Act:    2 Avg:    2
> >> Max:      26
> >> T: 3 ( 2739) P:80 I:6500 C:   3847 Min:      1 Act:    2 Avg:    2
> >> Max:      20
> >> T: 4 ( 2740) P:80 I:7000 C:   3572 Min:      1 Act:    3 Avg:    2
> >> Max:      16
> >> T: 5 ( 2741) P:80 I:7500 C:   3334 Min:      2 Act:    2 Avg:    2
> >> Max:      20
> >> T: 6 ( 2742) P:80 I:8000 C:   3125 Min:      1 Act:    4 Avg:    2
> >> Max:      21
> >> T: 7 ( 2743) P:80 I:8500 C:   2942 Min:      1 Act:    2 Avg:    3
> >> Max:      18
> >> T: 8 ( 2744) P:80 I:9000 C:   2778 Min:      1 Act:    3 Avg:    2
> >> Max:      16
> >> T: 9 ( 2745) P:80 I:9500 C:   2632 Min:      1 Act:    3 Avg:    2
> >> Max:      13
> >> T:10 ( 2746) P:80 I:10000 C:   2500 Min:      2 Act:    3 Avg:    2
> >> Max:      26
> >> T:11 ( 2747) P:80 I:10500 C:   2381 Min:      1 Act:    3 Avg:    2
> >> Max:      14
> >> T:12 ( 2748) P:80 I:11000 C:   2273 Min:      2 Act:    3 Avg:    2
> >> Max:      19
> >> T:13 ( 2749) P:80 I:11500 C:   2174 Min:      2 Act:    3 Avg:    2
> >> Max:      18
> >> T:14 ( 2750) P:80 I:12000 C:   2083 Min:      2 Act:    3 Avg:    2
> >> Max:      13
> >> T:15 ( 2751) P:80 I:12500 C:   2000 Min:      2 Act:    3 Avg:    2
> >> Max:      17
> >> T:16 ( 2752) P:80 I:13000 C:   1923 Min:      2 Act:    3 Avg:    2
> >> Max:       9
> >> T:17 ( 2753) P:80 I:13500 C:   1852 Min:      2 Act:    3 Avg:    3
> >> Max:      17
> >> T:18 ( 2754) P:80 I:14000 C:   1786 Min:      1 Act:    3 Avg:    2
> >> Max:      11
> >> T:19 ( 2755) P:80 I:14500 C:   1724 Min:      2 Act:    3 Avg:    3
> >> Max:      21
> >> T:20 ( 2756) P:80 I:15000 C:   1667 Min:      2 Act:    3 Avg:    2
> >> Max:       8
> >>
> >>
> >> root@Madan:/usr/xenomai/bin# ./xeno cyclictest -t 21 -p 80 -i 5000 -l
> 5000
> >> 0.01 0.01 0.01 1/410 2708
> >>
> >> T: 0 ( 2688) P:80 I:    5000 C:    5000 Min:      -2 Act:      -2
> >> Avg:       0 Max:      12
> >> T: 1 ( 2689) P:79 I:  505000 C:     120 Min:       0 Act:       7
> >> Avg:       0 Max:       9
> >> T: 2 ( 2690) P:78 I: 1005000 C:      60 Min:       0 Act:       2
> >> Avg:       0 Max:      11
> >> T: 3 ( 2691) P:77 I: 1505000 C:      40 Min:       0 Act:       2
> >> Avg:       0 Max:      13
> >> T: 4 ( 2692) P:76 I: 2005000 C:      30 Min:       0 Act:       0
> >> Avg:       0 Max:      15
> >> T: 5 ( 2693) P:75 I: 2505000 C:      24 Min:       0 Act:       0
> >> Avg:       0 Max:      16
> >> T: 6 ( 2694) P:74 I: 3005000 C:      20 Min:       0 Act:       0
> >> Avg:       0 Max:      19
> >> T: 7 ( 2695) P:73 I: 3505000 C:      18 Min:       0 Act:       0
> >> Avg:       1 Max:      21
> >> T: 8 ( 2696) P:72 I: 4005000 C:      16 Min:       0 Act:       0
> >> Avg:       1 Max:      23
> >> T: 9 ( 2697) P:71 I: 4505000 C:      14 Min:       0 Act:       0
> >> Avg:       2 Max:      24
> >> T:10 ( 2698) P:70 I: 5005000 C:      12 Min:       0 Act:       2
> >> Avg:       2 Max:      26
> >> T:11 ( 2699) P:69 I: 5505000 C:      12 Min:       0 Act:       2
> >> Avg:       2 Max:      28
> >> T:12 ( 2700) P:68 I: 6005000 C:      10 Min:       0 Act:       0
> >> Avg:       3 Max:      30
> >> T:13 ( 2701) P:67 I: 6505000 C:      10 Min:       1 Act:       1
> >> Avg:       3 Max:      32
> >> T:14 ( 2702) P:66 I: 7005000 C:      10 Min:       0 Act:       0
> >> Avg:       3 Max:      34
> >> T:15 ( 2703) P:65 I: 7505000 C:       8 Min:       0 Act:       2
> >> Avg:       4 Max:      36
> >> T:16 ( 2704) P:64 I: 8005000 C:       8 Min:       0 Act:       1
> >> Avg:       5 Max:      38
> >> T:17 ( 2705) P:63 I: 8505000 C:       8 Min:       0 Act:       1
> >> Avg:       5 Max:      40
> >> T:18 ( 2706) P:62 I: 9005000 C:       8 Min:       0 Act:       0
> >> Avg:       5 Max:      42
> >> T:19 ( 2707) P:61 I: 9505000 C:       8 Min:       0 Act:       0
> >> Avg:       5 Max:      44
> >> T:20 ( 2708) P:60 I:10005000 C:       6 Min:       3 Act:       3
> >> Avg:       8 Max:      46
> >>
> >> This never stops, T0 completes quickly but not others
> >>
> >>
> >>
> ------------------------------------------------------------------------------------------------
> >> Linux Madan 3.13.0-32-generic #57~precise1-Ubuntu SMP Tue Jul 15
> 03:51:20
> >> UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
> >>
> >> root@Madan:/home/mymo/MADAN_Xeno/rt-tests# ./cyclictest -t 21 -p 80 -i
> >> 5000 -l 5000
> >> # /dev/cpu_dma_latency set to 0us
> >> policy: fifo: loadavg: 14.44 5.11 1.85 20/444 2835
> >>
> >> T: 0 ( 2815) P:80 I:5000 C:   5000 Min:      2 Act:    3 Avg:    3
> >> Max:      18
> >> T: 1 ( 2816) P:80 I:5500 C:   4541 Min:      2 Act:    3 Avg:    3
> >> Max:      21
> >> T: 2 ( 2817) P:80 I:6000 C:   4163 Min:      2 Act:    3 Avg:    3
> >> Max:     315
> >> T: 3 ( 2818) P:80 I:6500 C:   3843 Min:      2 Act:    3 Avg:    3
> >> Max:      12
> >> T: 4 ( 2819) P:80 I:7000 C:   3568 Min:      2 Act:    2 Avg:    3
> >> Max:      20
> >> T: 5 ( 2820) P:80 I:7500 C:   3330 Min:      2 Act:    3 Avg:    3
> >> Max:      14
> >> T: 6 ( 2821) P:80 I:8000 C:   3122 Min:      2 Act:    3 Avg:    3
> >> Max:     366
> >> T: 7 ( 2822) P:80 I:8500 C:   2938 Min:      2 Act:    3 Avg:    3
> >> Max:      11
> >> T: 8 ( 2823) P:80 I:9000 C:   2775 Min:      2 Act:    3 Avg:    3
> >> Max:      15
> >> T: 9 ( 2824) P:80 I:9500 C:   2629 Min:      2 Act:    3 Avg:    3
> >> Max:      28
> >> T:10 ( 2825) P:80 I:10000 C:   2497 Min:      2 Act:    2 Avg:    3
> >> Max:      15
> >> T:11 ( 2826) P:80 I:10500 C:   2379 Min:      2 Act:    2 Avg:    3
> >> Max:      13
> >> T:12 ( 2827) P:80 I:11000 C:   2270 Min:      2 Act:    4 Avg:    3
> >> Max:      14
> >> T:13 ( 2828) P:80 I:11500 C:   2172 Min:      2 Act:    3 Avg:    3
> >> Max:      15
> >> T:14 ( 2829) P:80 I:12000 C:   2081 Min:      2 Act:    3 Avg:    4
> >> Max:     469
> >> T:15 ( 2830) P:80 I:12500 C:   1998 Min:      2 Act:    2 Avg:    3
> >> Max:      15
> >> T:16 ( 2831) P:80 I:13000 C:   1921 Min:      2 Act:    3 Avg:    3
> >> Max:      30
> >> T:17 ( 2832) P:80 I:13500 C:   1850 Min:      2 Act:    3 Avg:    3
> >> Max:      14
> >> T:18 ( 2833) P:80 I:14000 C:   1784 Min:      2 Act:    3 Avg:    3
> >> Max:      15
> >> T:19 ( 2834) P:80 I:14500 C:   1722 Min:      2 Act:    3 Avg:    3
> >> Max:      13
> >> T:20 ( 2835) P:80 I:15000 C:   1665 Min:      2 Act:    2 Avg:    3
> >> Max:      11
> >>
> >>
> >>
> >> Thanks
> >>
> >> M
> >>
>
>
>
>
