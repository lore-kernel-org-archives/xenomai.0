Message-ID: <50AB9449.2020203@gmail.com>
Date: Tue, 20 Nov 2012 11:31:37 -0300
From: Sebastian Pavez <sebastian.pavez.t@gmail.com>
MIME-Version: 1.0
References: <CANzNmi-O4C=z-sXqrq7HMTQ=B2apBBnZMco0p-_iHmfuu+Jexg@mail.gmail.com>	<50AA4EC2.1000206@xenomai.org>
	<CANzNmi-dFbx043zCszBwYu2yZh3awGkRAArwOnaTq3k=ijffdA@mail.gmail.com>
	<50AA5B96.9060009@xenomai.org>
In-Reply-To: <50AA5B96.9060009@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Help with Xeno-test please
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

El 19/11/2012 13:17 p.m., Gilles Chanteperdrix escribió:
> On 11/19/2012 04:39 PM, Sebastian Pavez wrote:
>> 2012/11/19 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>
>>> On 11/19/2012 04:10 PM, Sebastian Pavez wrote:
>>>> Hi everybody!
>>>>
>>>> I'm trying to get the latencies values with some load, but I think I'm
>>>> doing something wrong. Below is the command I tried and the results, are
>>>> they the rights parameters? if not, wich ones I should use instead? Some
>>>> recommendations will be appreciated. I read that the xeno-test runs by
>>>> default for 15 min, but I'm not getting that behaviour.
>>>>
>>>> Please some insights, Seba.
>>>>
>>>>
>>>> root@labcontrol:~# /usr/xenomai/bin/xeno-test -l "dohell -b
>>>> /usr/bin/hackbench  -s 192.168.0.5 -l /usr/src/linux-3.2.32/fs/ubifs |
>>> 100"
>>>
>>> The pipe in dohell help string is a "logical or", indicating that you
>>> should either pass the path to ltp installation directory OR a duration
>>> IN SECONDS.
>>>
>>> --
>>>                                              Gilles.
>>>
>> Thanks for your answer,
>> I made the change you suggest me, but I'm getting the same behaviour. It
>> only runs 30 seconds by the clocktest ...
>>
>> root@labcontrol:~# /usr/xenomai/bin/xeno-test -l "dohell -b
>> /usr/bin/hackbench  -s 192.168.0.5 -l 100"
> So, you installed ltp in a directory named "100" ?
>
>> == FPU check routines: OK.
>> == Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4
>> rtk_fp_ufpp0-5 rtk_fp_ufpp0-6 rtup0-7 rtup0-8 rtup_ufpp0-9 rtup_ufpp0-10
>> rtus0-11 rtus0-12 rtus_ufps0-13 rtus_ufps0-14 rtuo0-15 rtuo0-16
>> rtuo_ufpp0-17 rtuo_ufpp0-18 rtuo_ufps0-19 rtuo_ufps0-20 rtuo_ufpp_ufps0-21
>> rtuo_ufpp_ufps0-22 sleeper_ufps1-0 rtk1-1 rtk1-2 rtk_fp1-3 rtk_fp1-4
>> rtk_fp_ufpp1-5 rtk_fp_ufpp1-6 rtup1-7 rtup1-8 rtup_ufpp1-9 rtup_ufpp1-10
>> rtus1-11 rtus1-12 rtus_ufps1-13 rtus_ufps1-14 rtuo1-15 rtuo1-16
>> rtuo_ufpp1-17 rtuo_ufpp1-18 rtuo_ufps1-19 rtuo_ufps1-20 rtuo_ufpp_ufps1-21
>> rtuo_ufpp_ufps1-22 sleeper_ufps2-0 rtk2-1 rtk2-2 rtk_fp2-3 rtk_fp2-4
>> rtk_fp_ufpp2-5 rtk_fp_ufpp2-6 rtup2-7 rtup2-8 rtup_ufpp2-9 rtup_ufpp2-10
>> rtus2-11 rtus2-12 rtus_ufps2-13 rtus_ufps2-14 rtuo2-15 rtuo2-16
>> rtuo_ufpp2-17 rtuo_ufpp2-18 rtuo_ufps2-19 rtuo_ufps2-20 rtuo_ufpp_ufps2-21
>> rtuo_ufpp_ufps2-22 sleeper_ufps3-0 rtk3-1 rtk3-2 rtk_fp3-3 rtk_fp3-4
>> rtk_fp_ufpp3-5 rtk_fp_ufpp3-6 rtup3-7 rtup3-8 rtup_ufpp3-9 rtup_ufpp3-10
>> rtus3-11 rtus3-12 rtus_ufps3-13 rtus_ufps3-14
>> ioctl(RTTST_RTIOC_SWTEST_CREATE_KTASK): Cannot allocate memory
> That is another issue:
> http://www.xenomai.org/documentation/xenomai-2.6/html/TROUBLESHOOTING/#_switchtest_fails_with_pthread_create_resource_temporarily_unavailable
>
>
Sorry for the mistake,

I'm not getting results with ltp, I mean I get the same as before.
I wanna try hackbench a few hours, I followed this post:
http://www.mail-archive.com/xenomai-help@gna.org/msg14194.html

I tried hackbench only with dohell:
root@labcontrol:~# /usr/xenomai/bin/dohell -b 
"/home/labcontrol/Downloads/ltp-full-20120903/testcases/kernel/sched/cfs-scheduler/hackbench 
-pipe 100 process 100 seconds" 8
Running with 100*40 (== 4000) tasks.
Time: 0.579
Running with 100*40 (== 4000) tasks.
Time: 0.569
Running with 100*40 (== 4000) tasks.
Time: 0.570
Running with 100*40 (== 4000) tasks.
Time: 0.589
Running with 100*40 (== 4000) tasks.
Time: 0.581
Running with 100*40 (== 4000) tasks.
Time: 0.598
Running with 100*40 (== 4000) tasks.
Time: 0.563
Running with 100*40 (== 4000) tasks.
Time: 0.569
Running with 100*40 (== 4000) tasks.
Time: 0.566
Running with 100*40 (== 4000) tasks.
Time: 0.590
Running with 100*40 (== 4000) tasks.
Time: 0.591
Killed

And with xeno-test:
root@labcontrol:~# /usr/xenomai/bin/xeno-test -l "dohell -b 
/home/labcontrol/Downloads/ltp-full-20120903/testcases/kernel/sched/cfs-scheduler/hackbench 
14400"
Started child 22320: /bin/bash /usr/xenomai/bin/xeno-test-run-wrapper 
/usr/xenomai/bin/xeno-test
++ echo 0
++ /usr/xenomai/bin/arith
mul: 0x79364d93, shft: 26
integ: 30, frac: 0x4d9364d9364d9364

signed positive operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 8.003 ns, rejected 0/10000
inlined llimd: 0x79364d9364d9362f: 2.589 ns, rejected 0/10000
inlined llmulshft: 0x79364d92ffffffe1: 1.305 ns, rejected 0/10000
inlined nodiv_llimd: 0x79364d9364d9362f: 1.882 ns, rejected 0/10000
out of line calibration: 0x0000000000000000: 8.046 ns, rejected 0/10000
out of line llimd: 0x79364d9364d9362f: 5.492 ns, rejected 2/10000
out of line llmulshft: 0x79364d92ffffffe1: 1.919 ns, rejected 0/10000
out of line nodiv_llimd: 0x79364d9364d9362f: 6.118 ns, rejected 2/10000

signed negative operation: 0xfc00000000000001 * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 8.118 ns, rejected 0/10000
inlined llimd: 0x86c9b26c9b26c9d1: 3.626 ns, rejected 0/10000
inlined llmulshft: 0x86c9b26d0000001e: 0.706 ns, rejected 0/10000
inlined nodiv_llimd: 0x86c9b26c9b26c9d1: 3.576 ns, rejected 0/10000
out of line calibration: 0x0000000000000000: 8.016 ns, rejected 0/10000
out of line llimd: 0x86c9b26c9b26c9d1: 6.106 ns, rejected 0/10000
out of line llmulshft: 0x86c9b26d0000001e: 1.987 ns, rejected 0/10000
out of line nodiv_llimd: 0x86c9b26c9b26c9d1: 6.009 ns, rejected 0/10000

unsigned operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 8.084 ns, rejected 0/10000
inlined nodiv_ullimd: 0x79364d9364d9362f: 3.385 ns, rejected 0/10000
out of line calibration: 0x0000000000000000: 8.015 ns, rejected 0/10000
out of line nodiv_ullimd: 0x79364d9364d9362f: 6.280 ns, rejected 0/10000
++ /usr/xenomai/bin/clocktest -C 42 -T 30
== Tested clock: 42 (CLOCK_HOST_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
   0                  0.7           -0.010          0            0.0
   1                  0.9            0.016          0            0.0
   2                  1.0            0.009          0            0.0
   3                  0.7           -0.006          0            0.0
   4                  1.0            0.010          0            0.0
   5                  0.9            0.007          0            0.0
   6                  1.1            0.004          0            0.0
   7                  0.8            0.004          0            0.0
++ /usr/xenomai/bin/switchtest -T 30
== Testing FPU check routines...
r0: 1 != 2
r1: 1 != 2
r2: 1 != 2
r3: 1 != 2
r4: 1 != 2
r5: 1 != 2
r6: 1 != 2
r7: 1 != 2
== FPU check routines: OK.
== Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4 
rtk_fp_ufpp0-5 rtk_fp_ufpp0-6 rtup0-7 rtup0-8 rtup_ufpp0-9 rtup_ufpp0-10 
rtus0-11 rtus0-12 rtus_ufps0-13 rtus_ufps0-14 rtuo0-15 rtuo0-16 
rtuo_ufpp0-17 rtuo_ufpp0-18 rtuo_ufps0-19 rtuo_ufps0-20 
rtuo_ufpp_ufps0-21 rtuo_ufpp_ufps0-22 sleeper_ufps1-0 rtk1-1 rtk1-2 
rtk_fp1-3 rtk_fp1-4 rtk_fp_ufpp1-5 rtk_fp_ufpp1-6 rtup1-7 rtup1-8 
rtup_ufpp1-9 rtup_ufpp1-10 rtus1-11 rtus1-12 rtus_ufps1-13 rtus_ufps1-14 
rtuo1-15 rtuo1-16 rtuo_ufpp1-17 rtuo_ufpp1-18 rtuo_ufps1-19 
rtuo_ufps1-20 rtuo_ufpp_ufps1-21 rtuo_ufpp_ufps1-22 sleeper_ufps2-0 
rtk2-1 rtk2-2 rtk_fp2-3 rtk_fp2-4 rtk_fp_ufpp2-5 rtk_fp_ufpp2-6 rtup2-7 
rtup2-8 rtup_ufpp2-9 rtup_ufpp2-10 rtus2-11 rtus2-12 rtus_ufps2-13 
rtus_ufps2-14 rtuo2-15 rtuo2-16 rtuo_ufpp2-17 rtuo_ufpp2-18 
rtuo_ufps2-19 rtuo_ufps2-20 rtuo_ufpp_ufps2-21 rtuo_ufpp_ufps2-22 
sleeper_ufps3-0 rtk3-1 rtk3-2 rtk_fp3-3 rtk_fp3-4 rtk_fp_ufpp3-5 
rtk_fp_ufpp3-6 rtup3-7 rtup3-8 rtup_ufpp3-9 rtup_ufpp3-10 rtus3-11 
rtus3-12 rtus_ufps3-13 rtus_ufps3-14 
ioctl(RTTST_RTIOC_SWTEST_CREATE_KTASK): Cannot allocate memory
rtuo3-15 rtuo3-16 rtuo_ufpp3-17 rtuo_ufpp3-18 rtuo_ufps3-19 
rtuo_ufps3-20 rtuo_ufpp_ufps3-21 rtuo_ufpp_ufps3-22 sleeper_ufps4-0 
rtk4-1 rtk4-2 rtk_fp4-3 rtk_fp4-4 rtk_fp_ufpp4-5 rtk_fp_ufpp4-6 rtup4-7 
rtup4-8 rtup_ufpp4-9 rtup_ufpp4-10 rtus4-11 rtus4-12 rtus_ufps4-13 
rtus_ufps4-14 rtuo4-15 rtuo4-16 rtuo_ufpp4-17 rtuo_ufpp4-18 
rtuo_ufps4-19 rtuo_ufps4-20 rtuo_ufpp_ufps4-21 rtuo_ufpp_ufps4-22 
sleeper_ufps5-0 rtk5-1RTT|  375950:26:33
RTH|---------cpu|ctx switches|-------total
RTD|           0|           0|           0
RTD|           1|           0|           0
RTD|           2|           0|           0
RTD|           3|           0|           0
RTD|           4|           0|           0
RTD|           5|           0|           0


