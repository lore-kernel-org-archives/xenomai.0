Message-ID: <1397823282.1378.36.camel@port-msalvini.smigroup.local>
From: Mauro Salvini <mauro.salvini@smigroup.net>
Date: Fri, 18 Apr 2014 14:14:42 +0200
In-Reply-To: <53511687.3010809@xenomai.org>
References: <1397815203.1378.21.camel@port-msalvini.smigroup.local>
 <53510CB4.3000501@xenomai.org>
 <1397822896.1378.34.camel@port-msalvini.smigroup.local>
 <53511687.3010809@xenomai.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Disable L2 write allocate on iMX6q
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, 2014-04-18 at 14:11 +0200, Gilles Chanteperdrix wrote:

> On 04/18/2014 02:08 PM, Mauro Salvini wrote:
> > On Fri, 2014-04-18 at 13:29 +0200, Gilles Chanteperdrix wrote:
> > 
> >> On 04/18/2014 12:00 PM, Mauro Salvini wrote:
> >>> Hello,
> >>> I'm testing an iMX6q Sabrelite board from Element14 with Xenomai 2.6.3.
> >>>
> >>> First of all I tried kernel 3.0.43 from Xenomai git branch
> >>> ipipe-3.0-imx6q. This kernel works well, a 15 hours running latency test
> >>> (with manually generated system load like dd, netcat, ssh) shows an
> >>> average latency of 5.690us and a worst case latency of 42.186us.
> >>> Then I tried 3.4.6 vanilla kernel, but in this case latency test average
> >>> result for is a bit worse, with a value around 18us. Worst case is about
> >>> the same (<50us).
> >>> I read in mailing list that L2 write allocate is disabled in 3.0.43
> >>> kernel (in facts log says: l2x0: 16 ways, CACHE_ID 0x410000c7, AUX_CTRL
> >>> 0x02870000, Cache size: 1048576 B).
> >>> This feature is enabled in 3.4.6 kernel ( log says: l2x0: 16 ways,
> >>> CACHE_ID 0x410000c7, AUX_CTRL 0x02070000, Cache size: 1048576 B). Could
> >>> this be the cause of latency degradation observed in 3.4.6 kernel? I
> >>> also tried 3.8.13 with same results.
> >>> Kernel configurations are the default ones for each kernel, with hw_perf
> >>> disabled.
> >>
> >> Yes, L2 write allocate on imx6 has disastrous effects on latency.
> >> L2 write allocate is disabled starting from the 3.10 kernel for the 
> >> mainline I-pipe patches. See branch ipipe-3.10 in ipipe.git.
> >>
> >> The patch which disables L2 write allocate is:
> >> http://git.xenomai.org/ipipe.git/commit/?h=ipipe-3.10&id=05d6bcc014821c286248f6f4c1c953fcbde67f27
> >>
> >> and is probably easy to backport to earlier branches (but why would you 
> >> want to use a 3.4 kernel anyway?).
> >>
> > 
> > Thank you very much, I will try the patch.
> > 
> > I haven't a strict need to use 3.4 kernel, it was only a test. By the
> > way, is there a general rule to follow to choose a kernel version for an
> > ARM architecture (e.g. latest kernel release against older but
> > most-SOC-optimized release)? For example, for Xenomai 2.6.3 there are
> > three ipipe patches (for 3.4.6, 3.5.7 and 3.8.13 kernels), but as stated
> > into README file iMXQ6 should use ipipe patch contained into mcx dir,
> > that is for 3.0.43 kernel .
> 
> No, the README does not say that you should use the patch for the 3.0.43
> kernel. The patch is there IN CASE you want to use that kernel, because
> that kernel is based on the one provided by Freescale. But you are very
> much encouraged to use more recent mainline releases.
> 

Sorry, my misunderstanding.

Thanks again.

