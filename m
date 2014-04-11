From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 11 Apr 2014 11:46:30 -0400
Message-ID: <20140411154630.GE17765@csclub.uwaterloo.ca>
References: <1397003664.2660.14.camel@localhost.localdomain>
 <1397017658.2660.16.camel@localhost.localdomain>
 <534534FD.5090805@xenomai.org>
 <1397113300.2720.5.camel@localhost.localdomain>
 <5346895B.6080401@xenomai.org>
 <1397159850.2881.3.camel@localhost.localdomain>
 <53471389.6000000@xenomai.org>
 <1397168263.6356.11.camel@localhost.localdomain>
 <534719F5.2020605@xenomai.org>
 <1397170912.6356.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1397170912.6356.19.camel@localhost.localdomain>
Subject: Re: [Xenomai] OMAP L138
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Peter Howard <pjh@northern-ridge.com.au>, ""@csclub.uwaterloo.ca
Cc: xenomai@xenomai.org

On Fri, Apr 11, 2014 at 09:01:52AM +1000, Peter Howard wrote:
> On Fri, 2014-04-11 at 00:23 +0200, Gilles Chanteperdrix wrote:
> > On 04/11/2014 12:17 AM, Peter Howard wrote:
> > > On Thu, 2014-04-10 at 23:56 +0200, Gilles Chanteperdrix wrote:
> > >> On 04/10/2014 09:57 PM, Peter Howard wrote:
> > >>> On Thu, 2014-04-10 at 14:06 +0200, Gilles Chanteperdrix wrote:
> > >>>> On 04/10/2014 09:01 AM, Peter Howard wrote:
> > >>>>> On Wed, 2014-04-09 at 13:54 +0200, Gilles Chanteperdrix wrote:
> > >>>>>> On 04/09/2014 06:27 AM, Peter Howard wrote:
> > >>>>>>> On Wed, 2014-04-09 at 10:34 +1000, Peter Howard wrote:
> > >>>>>>>> On Wed, 2014-04-09 at 02:20 +0200, Gilles Chanteperdrix wrote:
> > >>>>>>>>> On 04/09/2014 01:30 AM, Peter Howard wrote:
> > >>>>>>>>>> On Tue, 2014-04-08 at 11:18 +0200, Gilles Chanteperdrix wrote:
> > >>>>>>>>>>> On 04/07/2014 07:34 AM, Peter Howard wrote:
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> On Wed, 2014-04-02 at 09:24 +0200, Gilles Chanteperdrix wrote:
> > >>>>>>>>>>>>> On 04/02/2014 04:59 AM, Peter Howard wrote:
> > >>>>>>>>>>>>>> Hi,
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> I'm interested in running xenomai on a TI-OMAP L138 board.  I found the
> > >>>>>>>>>>>>>> following thread in the archives:
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> http://www.xenomai.org/pipermail/xenomai/2010-January/018898.html
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> where someone was working on porting ipipe and xenomai to that board.
> > >>>>>>>>>>>>>> However, the thread ended with problems still unresolved, and the patch
> > >>>>>>>>>>>>>> in the thread (just the changes for ipipe) isn't in the ipipe
> > >>>>>>>>>>>>>> repository.
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> Does anyone know if this work was completed or just faded into the
> > >>>>>>>>>>>>>> ether?
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>> We never merged a patch for this processor. And a lot of things changed
> > >>>>>>>>>>>>> since that time. If you are interested in porting the I-pipe patch to
> > >>>>>>>>>>>>> this processor, see:
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>> http://www.xenomai.org/index.php/I-pipe-core:ArmPorting
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> Contrary to what I said last week, I'm working on a patch off the head
> > >>>>>>>>>>>> of the ipipe repo.  I have built a kernel with an ipipe port and with
> > >>>>>>>>>>>> xenomai patched in.  However the latency results are bad right now:
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> root@arago:~# xeno latency -T 25
> > >>>>>>>>>>>> == Sampling period: 1000 us
> > >>>>>>>>>>>> == Test mode: periodic user-mode task
> > >>>>>>>>>>>> == All results in microseconds
> > >>>>>>>>>>>> warming up...
> > >>>>>>>>>>>> RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
> > >>>>>>>>>>>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
> > >>>>>>>>>>>> RTD|      3.541|      8.833|     60.749|       0|     0|      3.541|     60.749
> > >>>>>>>>>>>> RTD|      3.499|     13.583|     93.916|       0|     0|      3.499|     93.916
> > >>>>>>>>>>>> RTD|      3.666|     88.999|    109.708|       0|     0|      3.499|    109.708
> > >>>>>>>>>>>> RTD|      3.541|     14.958|     95.374|       0|     0|      3.499|    109.708
> > >>>>>>>>>>>> RTD|      3.541|      9.333|     77.583|       0|     0|      3.499|    109.708
> > >>>>>>>>>>>> RTD|      4.041|     88.416|    109.791|       0|     0|      3.499|    109.791
> > >>>>>>>>>>>> RTD|      3.499|      8.958|     72.791|       0|     0|      3.499|    109.791
> > >>>>>>>>>>>> RTD|      3.499|     26.041|    106.874|       0|     0|      3.499|    109.791
> > >>>>>>>>>>>> RTD|      3.874|     82.708|    107.916|       0|     0|      3.499|    109.791
> > >>>>>>>>>>>> RTD|      3.499|      9.083|     73.708|       0|     0|      3.499|    109.791
> > >>>>>>>>>>>> RTD|      3.333|      8.874|     62.458|       0|     0|      3.333|    109.791
> > >>>>>>>>>>>> RTD|      3.333|      8.749|     62.208|       0|     0|      3.333|    109.791 
> > >>>>>>>>>>>> RTD|      3.416|     12.708|     99.416|       0|     0|      3.333|    109.791 
> > >>>>>>>>>>>> RTD|      3.499|     14.249|    106.749|       0|     0|      3.333|    109.791 
> > >>>>>>>>>>>> RTD|      3.541|      9.083|     76.499|       0|     0|      3.333|    109.791 
> > >>>>>>>>>>>> RTD|      3.249|      8.791|     63.499|       0|     0|      3.249|    109.791 
> > >>>>>>>>>>>> RTD|      3.416|      8.999|     62.499|       0|     0|      3.249|    109.791 
> > >>>>>>>>>>>> RTD|      3.541|     26.166|    101.208|       0|     0|      3.249|    109.791 
> > >>>>>>>>>>>> RTD|      3.583|     13.624|     92.458|       0|     0|      3.249|    109.791 
> > >>>>>>>>>>>> RTD|      3.541|      8.916|     73.708|       0|     0|      3.249|    109.791 
> > >>>>>>>>>>>> RTD|      3.541|      8.999|     64.291|       0|     0|      3.249|    109.791 
> > >>>>>>>>>>>> RTT|  00:00:22  (periodic user-mode task, 1000 us period, priority 99)          
> > >>>>>>>>>>>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst 
> > >>>>>>>>>>>> RTD|      3.499|      8.874|     61.374|       0|     0|      3.249|    109.791 
> > >>>>>>>>>>>> RTD|      3.499|     13.833|    100.749|       0|     0|      3.249|    109.791 
> > >>>>>>>>>>>> RTD|      3.541|     13.083|     99.249|       0|     0|      3.249|    109.791 
> > >>>>>>>>>>>> ---|-----------|-----------|-----------|--------|------|------------------------
> > >>>>>>>>>>>> RTS|      3.249|     21.458|    109.791|       0|     0|    00:00:25/00:00:25   
> > >>>>>>>>>>>> root@arago:~# 
> > >>>>>>>>>>>
> > >>>>>>>>>>> Note that if the OMAPL138 is an armv4 or armv5, you may want to enable
> > >>>>>>>>>>> the FCSE in order to reduce context switch time (and latencies).
> > >>>>>>>>>>>
> > >>>>>>>>>>>
> > >>>>>>>>>>
> > >>>>>>>>>> I enabled FCSE, and the max latency is more consistent (though the min
> > >>>>>>>>>> and average  latency has climbed).  How do the below figures look?
> > >>>>>>>>>
> > >>>>>>>>> Otherwise, it is hard to say whether there is an issue or not. It is not
> > >>>>>>>>> uncommon for armv4 or armv5 to have high latencies like this.
> > >>>>>>>>> On what core is this processor based, running at what frequency?
> > >>>>>>>>>
> > >>>>>>>>>
> > >>>>>>>> It's an AMR926EJ-S r5.  Datasheet claims 375MHz, U-boot claims 300MHz.
> > >>>>>>>>
> > >>>>>>>> Load test to follow.
> > >>>>>>>>
> > >>>>>>>
> > >>>>>>> OK, this run was done with LTP running on the board (runltplite.sh),
> > >>>>>>> with cpu utilization between 90% and 100%
> > >>>>>>
> > >>>>>> You have to run the latency test while ltp is running, and run this for 
> > >>>>>> a few hours (ltp runs a few hours anyway).
> > >>>>>>
> > >>>>>> We provide the xeno-test script to do this (and dohell to generate 
> > >>>>>> load).
> > >>>>>>
> > >>>>>> See:
> > >>>>>> http://www.xenomai.org/documentation/xenomai-2.6/html/xeno-test/index.html
> > >>>>>> http://www.xenomai.org/documentation/xenomai-2.6/html/dohell/index.html
> > >>>>>>
> > >>>>>
> > >>>>> That's proving to be a bit challenging.  Giving dohell ltp is causing
> > >>>>> more kernel panics - usually a SIGSEGV to init.  Now I'm aware from your
> > >>>>> previous thread on the OMAP-L138 that ltp doesn't run cleanly on low-end
> > >>>>> arm chips as-is, but I'm guessing kernel panics wasn't the failure mode
> > >>>>> you were seeing.  (running ltp by itself also gives a different kernel
> > >>>>> panic after about 15-20 minutes)  So I need to look into that more.
> > >>>>>
> > >>>>> I also need to try the ltp build on the stock Ti-supplied system to make
> > >>>>> sure there's not a pre-existing problem lurking in there; I should do
> > >>>>> that tomorrow.
> > >>>>
> > >>>> The thing is, if you enabled FCSE in guaranteed mode, it does not really
> > >>>> make sense to run LTP: most tests will fail because of the processes
> > >>>> number limit. In that case you should use the -b option, and pass the
> > >>>> path to hackbench only.
> > >>>>
> > >>>>>
> > >>>>> FWIW just running xeno-test with no arguments finishes cleanly after
> > >>>>> running for 10 minutes or so.
> > >>>>>
> > >>>>> Is it worth putting up the diff to the ipipe tree at this stage for
> > >>>>> people to look over?
> > >>>>
> > >>>> If you have random segfault, then something is still wrong. Have you
> > >>>> tried enabling I-pipe debugging options?
> > >>>>
> > >>>> The non-working I-pipe tracer with stack unwinding is not normal either,
> > >>>> what version of the kernel are you using?
> > >>>>
> > >>>>
> > >>> The kernel source I'm modifying is the master branch of the ipipe git
> > >>> repo.
> > >>
> > >> Despite the fact that this branch does not correspond to any released
> > >> I-pipe patch, I can confirm that the I-pipe tracer works with stack
> > >> unwinding on at91rm9200, ,an armv4, and at91sam9263, an armv5. So, you
> > >> must miss something in your patch. Again, I would advise you to use:
> > >>
> > >> http://www.xenomai.org/index.php/I-pipe-core:ArmPorting
> > >>
> > >> As a check list.
> > >>
> > > 
> > > I did indeed use that page as a basis for the porting, and worked
> > > through the "Troubleshooting" section at the bottom.  Going through each
> > > section:
> > >       * Hardware Timer - this is a slight concern as there is no acking
> > >         (hardware or software) of the irq at this level, so struct
> > >         ipipe_timer has .ack as NULL.  Otherwise, set up as per example.
> > >       * High Resolution timer - it's free running, and straightforward
> > >         as per the example.  It's edge triggered; changing to level
> > >         triggering results in no interrupts.
> > >       * Interrupt controller - no multi irqs.  Mask/Unmask have the
> > >         ipipe_{un}lock_irq() added.  Separate hold/release and
> > >         enable/disable calls without the lock (the latter added after
> > >         warnings with ipipe debugging turned on).
> > >       * GPIO - ipipe_handle_demuxed_irq() added in.
> > >       * I-pipe spinlocks - no conversions needed.
> > >       * Interrupt Controller Muting - skipped as recommended.
> > >       * Fast context switch extension - enabled (now - initial
> > >         crashes/panics were without it enabled).
> > >       * Troubleshooting - worked through as best I can with latency
> > >         tracing causing kernel panics.
> > 
> > One missing point: the idle routine. As a quick check, could you boot
> > with the nohlt parameter and see if it changes anything?
> > 
> 
> At least in the "xeno-test + ltp" it doesn't.  Test still runs for
> ~10minutes then the machine dies with init geting a SIGSEGV.

Which kernel are you using?

I was having segfaults in processes doing sigchld handling, and init does
that a lot for any processes that get abandoned.  Going from 3.8 to 3.12
kernel solved it for me, and unfortunately I have not tracked down the
patch that fixed the kernel, although I have one commit I would test at
some point when I have time.  The commit is this one:

t c2cc499c5bcf9040a738f49e8051b42078205748
Author: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Date:   Fri May 24 15:55:18 2013 -0700

    mm compaction: fix of improper cache flush in migration code
    
    Page 'new' during MIGRATION can't be flushed with flush_cache_page().
    Using flush_cache_page(vma, addr, pfn) is justified only if the page is
    already placed in process page table, and that is done right after
    flush_cache_page().  But without it the arch function has no knowledge
    of process PTE and does nothing.
    
    Besides that, flush_cache_page() flushes an application cache page, but
    the kernel has a different page virtual address and dirtied it.
    
    Replace it with flush_dcache_page(new) which is the proper usage.
    
    The old page is flushed in try_to_unmap_one() before migration.
    
    This bug takes place in Sead3 board with M14Kc MIPS CPU without cache
    aliasing (but Harvard arch - separate I and D cache) in tight memory
    environment (128MB) each 1-3days on SOAK test.  It fails in cc1 during
    kernel build (SIGILL, SIGBUS, SIGSEG) if CONFIG_COMPACTION is switched
    ON.
    
    Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
    Cc: Leonid Yegoshin <yegoshin@mips.com>
    Acked-by: Rik van Riel <riel@redhat.com>
    Cc: Michal Hocko <mhocko@suse.cz>
    Acked-by: Mel Gorman <mgorman@suse.de>
    Cc: Ralf Baechle <ralf@linux-mips.org>
    Cc: Russell King <rmk@arm.linux.org.uk>
    Cc: David Miller <davem@davemloft.net>
    Cc: <stable@vger.kernel.org>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Yes it mentions MIPS as a case known to fail, but it is in the general
mm code and should apply potentially to any system.  If you use 3.10 or
higher, you should already have that commit, 3.9 and earlier do not.

-- 
Len Sorensen

