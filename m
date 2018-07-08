References: <ff4b8c3a-c8ca-09b5-d3ac-f1d6e127a4e5@sferapro.com>
 <CALLqZ8SuY4K=PFP6LeCHXU9PXoXnmDv4UCLnqHmnz-8xc3CacA@mail.gmail.com>
 <CALLqZ8Q3uZm8jTmtJLHR=Yz3Cw5g+CGTrXaj-oUFPT=1Rh0JbA@mail.gmail.com>
 <c2d2a625-011c-1c79-0bcc-4830c1d30674@sferapro.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <d496a293-e2b6-c7bb-7382-dc344f5dfd5f@xenomai.org>
Date: Sun, 8 Jul 2018 11:41:10 +0200
MIME-Version: 1.0
In-Reply-To: <c2d2a625-011c-1c79-0bcc-4830c1d30674@sferapro.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] i.MX6q memory write causes high latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Federico Sbalchiero <f.sbalchiero@sferapro.com>, xenomai@xenomai.org

On 07/06/2018 10:07 AM, Federico Sbalchiero wrote:
> adding a break at line 837 in file /arch/arm/mm/cache-l2x0.c enables L2
> write allocate:
> 
> [    0.000000] L2C-310 errata 752271 769419 enabled
> [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
> [    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
> [    0.000000] L2C-310 ID prefetch enabled, offset 16 lines
> [    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
> [    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
> [    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76470001
> 

Adding a break at this location defeats the purpose of the code, you
want it to fall through in order to update the control bits, as seen
from the value of the auxiliary control register above. 0x76470001 now
clears bit 23 (0x800000) due to breaking out of the switch, which should
be set for disabling fetch-on-write upon write misses instead. FWIW, I
don't see any issue in the original code, although the logic should be
made more obvious.

> RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat
> best|--lat worst
> RTD|     42.667|     58.521|     87.667|       0|     0| 42.667|
87.667
> RTD|     42.662|     58.884|     86.995|       0|     0| 35.331|
<snip>
95.665
> RTD|     42.662|     58.852|     88.329|       0|     0| 35.331|
95.665

So these figures above are actually obtained with write_allocate=1, they
are consistent with the results obtained with cache units older than
r3p2. Your cache unit advertises as r3p1-50rel0, where enabling
write-allocate leads to poor, even ugly, performances.

Would you leave the test run for several hours with proper load, I
believe that you should see the latency figures skyrocket way above 100 us.

-- 
Philippe.

