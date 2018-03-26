MIME-Version: 1.0
In-Reply-To: <49cd0e96-fde0-4d7a-17bc-5ae18d10baac@xenomai.org>
References: <CAOuPNLiL2jQ3wcYsxMAO2kqOvCvyPVPnZNakiLX_nhQVtVJk7A@mail.gmail.com>
 <CALLqZ8R77Pv+TRCrXiGkfzrcOdMMY+WfWzpO-qVE6-oFAgpU0g@mail.gmail.com>
 <CAOuPNLhcNcOdveFRLJUvFTLDDfQY4YOYUPRjWiPjK1o0zdTjJg@mail.gmail.com>
 <CAOuPNLgJOsYcT51SHS56mG5KDsS9pOBYPdWY9aWDvv7rfvBTUg@mail.gmail.com>
 <854aec2d-861e-f17e-e57c-d86e9f5e7a90@xenomai.org>
 <CAOuPNLgMJ_cvEsXJd+oF+g0ftMudT4Ztkb_yy=AXBMRDWuGqBg@mail.gmail.com>
 <14040d9b-3b4b-9677-05d0-24773e309310@xenomai.org>
 <CAOuPNLjP+6CPOf-4uYHZCLEfAzGjQOXy32r+5TBwMrVFFH9fOw@mail.gmail.com>
 <20bffd5c-9f11-3bb2-236a-11764a129059@xenomai.org>
 <CAOuPNLi28DcSYvuk__P6_o=xZ=O=Wv-k8iXqiUez87PKCKeXfw@mail.gmail.com>
 <49cd0e96-fde0-4d7a-17bc-5ae18d10baac@xenomai.org>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Mon, 26 Mar 2018 18:42:42 +0530
Message-ID: <CAOuPNLgpwc4+nk=5V_3E0k6V_oYVs1q_gfLpwiN_8jfbsYNq9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Simple application for invoking rtdm driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Philippe,

Thank you so much for your reply.
Please find my comments below.


On Sun, Mar 25, 2018 at 5:39 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 03/23/2018 01:40 PM, Pintu Kumar wrote:
>> Dear Philippe,
>>
>> Thank you so much for your detailed explanation.
>>
>> First to cross-check, I also tried on ARM BeagleBone (White) with
>> 256MB RAM, Single core
>> These are the values I got.
>
> After how many samples?

Just after 3 samples only for each cases. Just an initial run to
understand the difference.

>
>> ===========================
>> NORMAL KERNEL Driver Build (with xenomai present)
>> ---------------------------------------------------------------------------
>> write latency: 8235.083 us
>
> Are you sure that any driver (plain Linux or Xenomai) would take up 8.2
> MILLIseconds for performing a single write with your test module? Either
> you meant 8235 nanoseconds, or something is really wrong with your
> system.

Yes these values are calculated in micro-seconds.
I have used the same to measure latency for native application, and it
reports fine.
These large values are seen only on Beagle bone (white) with just 256MB RAM,
and model name: ARMv7 Processor rev 2 (v7l)
I think this is very old board and its very slow in normal usage itself.
So, these figures could be high.

This is the latency test output from same machine:
# /usr/xenomai/bin/latency
== Sampling period: 1000 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|     25.249|     29.711|     63.749|       0|     0|     25.249|     63.749
RTD|     25.207|     29.589|     60.749|       0|     0|     25.207|     63.749
RTD|     25.207|     29.701|     61.041|       0|     0|     25.207|     63.749
RTD|     22.874|     29.263|     54.749|       0|     0|     22.874|     63.749
RTD|     25.248|     29.542|     78.373|       0|     0|     22.874|     78.373
RTD|     15.081|     29.050|     55.082|       0|     0|     15.081|     78.373
RTD|     22.873|     28.940|     57.415|       0|     0|     15.081|     78.373
RTD|     25.331|     28.972|     55.498|       0|     0|     15.081|     78.373
RTD|     24.164|     28.071|     56.498|       0|     0|     15.081|     78.373
^C---|-----------|-----------|-----------|--------|------|-------------------------
RTS|     15.081|     29.204|     78.373|       0|     0|    00:00:10/00:00:10



> This said, benchmarking code calling printk() bluntly defeats
> the purpose of the test.

I also tried commenting the printk, or replacing it with rt_printk.

>
>>
>> So, looks like random behavior.
>> Sometimes normal driver is better, sometime RTDM-native is better,
>> sometimes RTDM-posix is better
>> I even tried by firing dd commands in background. In this case also
>> normal kernel driver is better.
>>
>>
>
> [...]
>
>> At the RTDM driver side, I even tried removing memset, printk, and
>> kept just copy_from_user, but it just reduces to 1 micro-seconds.
>> Also I tried replacing the rtdm_safe_copy_from_user, with just
>> rtdm_copy_from_user, nothing much changed.
>> So, it seems 2 things to me:
>> - rtdm_copy_from_user - takes more thing compare to normal kernel copy_from_user
>> - rt_dev_write - takes more time compare to normal write call, in normal kernel.
>>
>> OR, is there too many primary<-->secondary switching happening in case
>> of my RTDM driver.
>>
>> Is there any other way to check this issue and improve latency with
>> rtdm driver ?
>>
>> If you have any other pointers/suggestions, please let me know.
>>
>>
>
> After many iterations, we still have no precise idea of the actual test
> you are actually running, since the application code is only sketched,
> and the module code is only partially available to us which does not
> help either.

OK, I will try to post my code on github so that you can review.

> Since there is no way we can converge to any sensible
> result that way, I have demoed how I would write a simple test:
>
> http://xenomai.org/downloads/xenomai/tmp/posix_test/
>

OK. Thank you so much for providing the sample.

> This test involves two modules, plan Linux and RTDM, and a single POSIX
> client code alternatively built with libcobalt and glibc.
>
> It displays the min, max and average values observed for read() and
> write() loops. More details are available from comments in the source
> code regarding the measurement.
>

First of all I checked your code.
I think your driver code (normal/rtdm) is almost same as mine (except
for the event signal part).
>From the application side, the difference is that, you are using
separate real time thread to
read/write the data.
But I am doing everything in main sequentially
(open->write->read->close), and measuring latency
only during write and read.

I even tried running the whole operation inside a RT task with priority 99.
Then in this case, latency values are reduced by almost half, but
still 2-3 us higher than normal driver.

> Once the two modules, and two test executables are built, just push the
> modules (they can live together in the kernel, no conflict), then run
> either of the executables for measuring 1) the execution time on the
> write() side, and 2) the response time on the read side.
>

Anyways, I have build your test application and modules (using my
Makefile) and verified it
on my x86_64 skylake machine.

Here are the results that I obtained:

# ./posix_test ; ./cobalt_test
DEVICE: /dev/bar, all microseconds

[ 0' 0"] RD_MIN | RD_MAX |  R_AVG  | WR_MIN | WR_MAX |  WR_AVG
--------------------------------------------------------------
              0 |     16 |   0.518 |      0 |      7 |  0.338
              0 |     16 |   0.501 |      0 |     16 |  0.337
              0 |     16 |   0.501 |      0 |     16 |  0.337
              0 |     16 |   0.501 |      0 |     16 |  0.337
              0 |     16 |   0.501 |      0 |     16 |  0.337
              0 |     16 |   0.501 |      0 |     16 |  0.337
              0 |     16 |   0.501 |      0 |     16 |  0.337
              0 |     16 |   0.501 |      0 |     16 |  0.337
              0 |     16 |   0.501 |      0 |     16 |  0.337
^C
DEVICE: /dev/rtdm/foo, all microseconds

[ 0' 0"] RD_MIN | RD_MAX |  R_AVG  | WR_MIN | WR_MAX |  WR_AVG
--------------------------------------------------------------
              0 |      1 |   0.573 |      0 |      1 |  0.241
              0 |     17 |   0.570 |      0 |     17 |  0.240
              0 |     17 |   0.570 |      0 |     17 |  0.240
              0 |     17 |   0.570 |      0 |     17 |  0.240
              0 |     17 |   0.570 |      0 |     17 |  0.240
              0 |     17 |   0.570 |      0 |     17 |  0.240
              0 |     17 |   0.570 |      0 |     17 |  0.240
              0 |     17 |   0.570 |      0 |     17 |  0.240
^C

Here, I did not run any dd or hackbench loops.
This is just a plan run on x86 PC.

Here also it looks like read_max is higher for rtdm case.
What does this indicates to you ?

>From this, do you see any configuration problem in my machine?
Can you share your /proc/cmdline for x86, if you added anything?
Also, if any config that you would have enabled/disabled?

One thing is, I am using some 3 months old xenomai-3 kernel drivers.
But ipipe is same, and also I tried upgrading to xenomai-3 latest
libraries as well.

One more thing:
In the same SkyLake machine when I measure latency for a simple
Xenomai task application,
I get better latency compare to normal kernel posix application (with
100 us sleep).

For your reference, I am also providing latency test output from
SkyLake machine.
# /usr/xenomai/bin/latency
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|     -0.176|      0.033|      0.806|       0|     0|     -0.176|      0.806
RTD|     -0.173|      0.033|      0.670|       0|     0|     -0.176|      0.806
RTD|     -0.150|      0.034|      1.000|       0|     0|     -0.176|      1.000
RTD|     -0.155|      0.033|      0.289|       0|     0|     -0.176|      1.000
RTD|     -0.169|      0.033|      0.841|       0|     0|     -0.176|      1.000
RTD|     -0.161|      0.033|      0.895|       0|     0|     -0.176|      1.000
RTD|     -0.177|      0.033|      0.209|       0|     0|     -0.177|      1.000
RTD|     -0.171|      0.033|      0.321|       0|     0|     -0.177|      1.000
RTD|     -0.159|      0.032|      0.208|       0|     0|     -0.177|      1.000
RTD|     -0.163|      0.033|      0.907|       0|     0|     -0.177|      1.000
RTD|     -0.154|      0.033|      0.707|       0|     0|     -0.177|      1.000
RTD|     -0.185|      0.084|      0.401|       0|     0|     -0.185|      1.000
RTD|     -0.175|      0.033|      0.539|       0|     0|     -0.185|      1.000
RTD|     -0.196|      0.033|      0.370|       0|     0|     -0.196|      1.000
RTD|     -0.178|      0.033|      0.800|       0|     0|     -0.196|      1.000
^C---|-----------|-----------|-----------|--------|------|-------------------------
RTS|     -0.196|      0.036|      1.000|       0|     0|    00:00:15/00:00:15



> On imx6qp (quad-core ARM Cortex A9 1.2Ghz), under stress load (dd loop +
> hackbench loops) after 15' runtime (which is not long enough for full
> validation but significant for getting the general trend), the figures
> are as follows:
>
> Cobalt:
>
> [15' 0"] RD_MIN | RD_MAX |  R_AVG  | WR_MIN | WR_MAX |  WR_AVG
> --------------------------------------------------------------
>               7 |     49 |   9.100 |      5 |     46 |  6.464
>
> (plain) POSIX [CONFIG_PREEMPT]:
>
> [15' 0"] RD_MIN | RD_MAX |  R_AVG  | WR_MIN | WR_MAX |  WR_AVG
> --------------------------------------------------------------
>              13 |    456 |  16.325 |      7 |    435 |  9.568
>
>
> On x86_64 with the exact same code (embbeded SoC 4 x 2Ghz CPU),
>
> Cobalt:
>
>             2 |     12 |   3.059 |      1 |     13 |  2.015
>
> (plain) POSIX [CONFIG_PREEMPT]:
>
>             3 |    182 |   3.702 |      1 |    185 |  2.095
>
>
> Those figures are consistent with what I'd expect from such test.
>
> The Xenomai code base used is the tip of the stable-3.0.x branch. ARM
> kernel is 4.14.4, x86 kernel is 4.9.51 with the latest I-pipe to date
> for both.
>
> NOTE about Alchemy: the figures with this API would be in the same
> ballpark than Cobalt, slightly higher (2-3 us worst-case) due to the
> intermediate libcopperplate layer involved in implementing it. As I
> mentioned earlier, using rt_dev* and friends does not make any
> difference than using Cobalt directly, those are macro wrappers
> expanding to Cobalt calls.
>
> If you want to figure out what a plain Linux kernel is apt to when it
> comes to response time to timer events on your SoC, you can configure
> Xenomai with --core=mercury, instead of cobalt. The stock "latency" test
> will be built against the plain glibc, instead of libcobalt. Then you
> can compare the latency figures to the results obtained from the same
> test from a Cobalt build. Such test has been carefully crafted and
> refined over the years: the results you get from it are trustworthy.
>

OK thanks for your suggestions. I will try for mercury core as well.


> --
> Philippe.

