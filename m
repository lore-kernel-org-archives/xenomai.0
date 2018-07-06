References: <ff4b8c3a-c8ca-09b5-d3ac-f1d6e127a4e5@sferapro.com>
 <CALLqZ8SuY4K=PFP6LeCHXU9PXoXnmDv4UCLnqHmnz-8xc3CacA@mail.gmail.com>
 <CALLqZ8Q3uZm8jTmtJLHR=Yz3Cw5g+CGTrXaj-oUFPT=1Rh0JbA@mail.gmail.com>
 <c2d2a625-011c-1c79-0bcc-4830c1d30674@sferapro.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <091bff54-d806-97ce-f418-9148af9bccb1@xenomai.org>
Date: Fri, 6 Jul 2018 10:32:03 +0200
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
> 
> latency under load (four memwrite instances) is better but still high.
> 
> RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat
> best|--lat worst
> RTD|     42.667|     58.521|     87.667|       0|     0| 42.667|     87.667
> RTD|     42.000|     58.935|     89.000|       0|     0| 42.000|     89.000
> RTD|     36.666|     58.707|     90.333|       0|     0| 36.666|     90.333
> RTD|     38.333|     58.439|     92.666|       0|     0| 36.666|     92.666
> RTD|     41.666|     58.595|     84.999|       0|     0| 36.666|     92.666
> RTD|     42.666|     58.698|     89.666|       0|     0| 36.666|     92.666
> RTD|     40.999|     58.999|     95.665|       0|     0| 36.666|     95.665
> RTD|     42.665|     58.823|     88.665|       0|     0| 36.666|     95.665
> RTD|     42.665|     58.570|     84.665|       0|     0| 36.666|     95.665
> RTD|     41.331|     58.599|     86.998|       0|     0| 36.666|     95.665
> RTD|     37.664|     58.596|     92.331|       0|     0| 36.666|     95.665
> RTD|     35.331|     58.893|     85.997|       0|     0| 35.331|     95.665
> RTD|     41.997|     58.704|     86.997|       0|     0| 35.331|     95.665
> RTD|     40.997|     58.723|     94.997|       0|     0| 35.331|     95.665
> RTD|     41.330|     58.710|     88.997|       0|     0| 35.331|     95.665
> RTD|     41.330|     59.080|     92.663|       0|     0| 35.331|     95.665
> RTD|     38.330|     58.733|     85.996|       0|     0| 35.331|     95.665
> RTD|     39.996|     59.095|     90.663|       0|     0| 35.331|     95.665
> RTD|     41.662|     58.967|     86.662|       0|     0| 35.331|     95.665
> RTD|     42.662|     58.884|     86.995|       0|     0| 35.331|     95.665
> RTD|     42.662|     58.852|     88.329|       0|     0| 35.331|     95.665
> 

According to my latest tests, waiting for operations to complete in the
cache unit induces most of the delay. I'm under the impression that the
way we deal with the outer L2 cache is obsolete, based on past
assumptions which may not be valid anymore. Typically, some of them
would involve events that might occur with VIVT caches, which we don't
support in 4.14.

The whole logic requires a fresh review. I'll follow up on this.

-- 
Philippe.

