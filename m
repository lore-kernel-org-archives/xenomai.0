Date: Thu, 30 Jun 2016 11:39:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160630093944.GI18662@hermes.click-hack.org>
References: <20160628095543.GM18662@hermes.click-hack.org>
 <57724CFE.2050401@sigmatek.at>
 <20160628101957.GO18662@hermes.click-hack.org>
 <5772520E.8010407@sigmatek.at>
 <20160628103925.GP18662@hermes.click-hack.org>
 <577265AF.9080300@sigmatek.at>
 <20160628120119.GT18662@hermes.click-hack.org>
 <57728A71.6010205@sigmatek.at>
 <20160628144159.GZ18662@hermes.click-hack.org>
 <5774E3C7.9090207@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5774E3C7.9090207@sigmatek.at>
Subject: Re: [Xenomai] Performance impact after switching from 2.6.2.1 to
 2.6.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Cc: xenomai@xenomai.org

On Thu, Jun 30, 2016 at 11:17:59AM +0200, Wolfgang Netbal wrote:
> 
> 
> Am 2016-06-28 um 16:42 schrieb Gilles Chanteperdrix:
> > On Tue, Jun 28, 2016 at 04:32:17PM +0200, Wolfgang Netbal wrote:
> >>
> >> Am 2016-06-28 um 14:01 schrieb Gilles Chanteperdrix:
> >>> On Tue, Jun 28, 2016 at 01:55:27PM +0200, Wolfgang Netbal wrote:
> >>>> Am 2016-06-28 um 12:39 schrieb Gilles Chanteperdrix:
> >>>>> On Tue, Jun 28, 2016 at 12:31:42PM +0200, Wolfgang Netbal wrote:
> >>>>>> Am 2016-06-28 um 12:19 schrieb Gilles Chanteperdrix:
> >>>>>> min: 10, max: 677, avg: 10.5048 -> 0.0265273 us
> >>>>>>
> >>>>>> Here are the output for Kernel 3.0.43 and Xenomai 2.6.2.1
> >>>>>>
> >>>>>> #> ./tsc
> >>>>>> min: 10, max: 667, avg: 11.5755 -> 0.029231 us
> >>>>> Ok. So, first it confirms that the two configurations are running
> >>>>> the processor at the same frequency. But we seem to see a pattern,
> >>>>> the maxima in the case of the new kernel seems consistently higher.
> >>>>> Which would suggest that there is some difference in the cache. What
> >>>>> is the status of the two configurations with regard to the L2 cache
> >>>>> write allocate policy?
> >>>> Do you mean the configuration we checked in this request
> >>>> https://xenomai.org/pipermail/xenomai/2016-June/036390.html
> >>> This answer is based on a kernel message, which may happen before
> >>> or after the I-pipe patch has changed the value passed to the
> >>> register, so, essentially, it is useless. I would not call that
> >>> checking the L2 cache configuration differences.
> >>>
> >> I readed the values from the auxiliary control register,
> >> when the system is up and running.
> >> I get the same values like I see in the Kernel log.
> >>
> >> Kernel 3.10.53 [0xa02104]=0x32c50000
> >> Kernel 3.0.43    [0xa02104]=0x2850000
> > Ok, so, if I read this correctly both values have 0x800000 set,
> > which means "force no allocate", and is what we want. But there are
> > a lot of other questions in my answer which you avoid to answer (and
> > note that that one was only relevant in one of two cases, which I
> > believe is not yours).
> >
> Dear Gilles,

Hi,

> 
> your first intention was correct, that the L2 cache configuration may be
> the reason for our issue.
> I disabled the instruction and data prefetching and my customer application
> is as fast as in our old kernel.

I thought you said the contrary in this mail:
https://xenomai.org/pipermail/xenomai/2016-June/036390.html

Well not exactly the contrary, but that you tried to enable prefetching
with 3.0.43 and that performance did not degrade.

> It was a change in the Kernel file arch/arm/mach-imx/system.c where the 
> prefetching
> was activated.
> 
> We will additional replace the function rt_timer_tsc() by __xn_rdtsc() 
> as you recommended.

No, do not do that. __xn_rdtsc() is a Xenomai internal function. The
"tsc" test uses it because it is a test measuring the execution time
of this function. What I said was to replace __xn_rdtsc() with
rt_timer_tsc() in the "tsc" test, to see if there was no performance
regression in rt_timer_tsc().

Also, I would be curious to understand why the execution time of
__xn_rdtsc() changed, it is just one processor cycle, so, it should not
matter to applications, but still, I do not see what change could
cause this.

> 
> In our customer applications every millisecond the xenomai task with 
> priority 95
> is called and works on different objects that are located on different 
> memory locations.
> When the objects are finished we leave the xenomai domain and let work 
> Linux.
> 
> Do you have any additional hints for me what configrations L2 cache or 
> other that can
> speed up this use case ?

Well, no, I know nothing about the L2 cache configuration. A
customer told me that disabling write allocate was improving the
latency test results greatly on imx6, and I benchmarked it on OMAP4,
another processor based on cortex A9, you can find the benchmark
here:
https://xenomai.org/2014/08/benchmarks-xenomai-dual-kernel-over-linux-3-14/#For_the_Texas_Instrument_Panda_board_running_a_TI_OMAP4430_processor_at_1_GHz

Since it seemed to improve the performance on all the processors
Xenomai supported at the time with this L2 cache (i.e. omap4 and
imx6 really), we made the change in the I-pipe patch with a kernel
parameter to disable it, in case someone would prefer to disable it.

> 
> Thanks a lot for you support and patience. 
> <http://dict.leo.org/ende/index_de.html#/search=patience&searchLoc=0&resultOrder=basic&multiwordShowSingle=on&pos=0>

Well, I am not always patient. But you are welcome.

-- 
					    Gilles.
https://click-hack.org

