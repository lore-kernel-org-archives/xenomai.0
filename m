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
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <49cd0e96-fde0-4d7a-17bc-5ae18d10baac@xenomai.org>
Date: Sun, 25 Mar 2018 14:09:52 +0200
MIME-Version: 1.0
In-Reply-To: <CAOuPNLi28DcSYvuk__P6_o=xZ=O=Wv-k8iXqiUez87PKCKeXfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Simple application for invoking rtdm driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Kumar <pintu.ping@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/23/2018 01:40 PM, Pintu Kumar wrote:
> Dear Philippe,
> 
> Thank you so much for your detailed explanation.
> 
> First to cross-check, I also tried on ARM BeagleBone (White) with
> 256MB RAM, Single core
> These are the values I got.

After how many samples?

> ===========================
> NORMAL KERNEL Driver Build (with xenomai present)
> ---------------------------------------------------------------------------
> write latency: 8235.083 us

Are you sure that any driver (plain Linux or Xenomai) would take up 8.2
MILLIseconds for performing a single write with your test module? Either
you meant 8235 nanoseconds, or something is really wrong with your
system. This said, benchmarking code calling printk() bluntly defeats
the purpose of the test.

> 
> So, looks like random behavior.
> Sometimes normal driver is better, sometime RTDM-native is better,
> sometimes RTDM-posix is better
> I even tried by firing dd commands in background. In this case also
> normal kernel driver is better.
> 
>

[...]

> At the RTDM driver side, I even tried removing memset, printk, and
> kept just copy_from_user, but it just reduces to 1 micro-seconds.
> Also I tried replacing the rtdm_safe_copy_from_user, with just
> rtdm_copy_from_user, nothing much changed.
> So, it seems 2 things to me:
> - rtdm_copy_from_user - takes more thing compare to normal kernel copy_from_user
> - rt_dev_write - takes more time compare to normal write call, in normal kernel.
> 
> OR, is there too many primary<-->secondary switching happening in case
> of my RTDM driver.
> 
> Is there any other way to check this issue and improve latency with
> rtdm driver ?
> 
> If you have any other pointers/suggestions, please let me know.
> 
> 

After many iterations, we still have no precise idea of the actual test
you are actually running, since the application code is only sketched,
and the module code is only partially available to us which does not
help either. Since there is no way we can converge to any sensible
result that way, I have demoed how I would write a simple test:

http://xenomai.org/downloads/xenomai/tmp/posix_test/

This test involves two modules, plan Linux and RTDM, and a single POSIX
client code alternatively built with libcobalt and glibc.

It displays the min, max and average values observed for read() and
write() loops. More details are available from comments in the source
code regarding the measurement.

Once the two modules, and two test executables are built, just push the
modules (they can live together in the kernel, no conflict), then run
either of the executables for measuring 1) the execution time on the
write() side, and 2) the response time on the read side.

On imx6qp (quad-core ARM Cortex A9 1.2Ghz), under stress load (dd loop +
hackbench loops) after 15' runtime (which is not long enough for full
validation but significant for getting the general trend), the figures
are as follows:

Cobalt:

[15' 0"] RD_MIN | RD_MAX |  R_AVG  | WR_MIN | WR_MAX |  WR_AVG
--------------------------------------------------------------
              7 |     49 |   9.100 |      5 |     46 |  6.464

(plain) POSIX [CONFIG_PREEMPT]:

[15' 0"] RD_MIN | RD_MAX |  R_AVG  | WR_MIN | WR_MAX |  WR_AVG
--------------------------------------------------------------
             13 |    456 |  16.325 |      7 |    435 |  9.568


On x86_64 with the exact same code (embbeded SoC 4 x 2Ghz CPU),

Cobalt:

            2 |     12 |   3.059 |      1 |     13 |  2.015

(plain) POSIX [CONFIG_PREEMPT]:

            3 |    182 |   3.702 |      1 |    185 |  2.095


Those figures are consistent with what I'd expect from such test.

The Xenomai code base used is the tip of the stable-3.0.x branch. ARM
kernel is 4.14.4, x86 kernel is 4.9.51 with the latest I-pipe to date
for both.

NOTE about Alchemy: the figures with this API would be in the same
ballpark than Cobalt, slightly higher (2-3 us worst-case) due to the
intermediate libcopperplate layer involved in implementing it. As I
mentioned earlier, using rt_dev* and friends does not make any
difference than using Cobalt directly, those are macro wrappers
expanding to Cobalt calls.

If you want to figure out what a plain Linux kernel is apt to when it
comes to response time to timer events on your SoC, you can configure
Xenomai with --core=mercury, instead of cobalt. The stock "latency" test
will be built against the plain glibc, instead of libcobalt. Then you
can compare the latency figures to the results obtained from the same
test from a Cobalt build. Such test has been carefully crafted and
refined over the years: the results you get from it are trustworthy.

-- 
Philippe.

