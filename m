Message-ID: <1397159850.2881.3.camel@localhost.localdomain>
From: Peter Howard <pjh@northern-ridge.com.au>
In-Reply-To: <5346895B.6080401@xenomai.org>
References: <1396407588.27578.5.camel@localhost.localdomain>
 <533BBB11.5090808@xenomai.org>
 <1396848843.2481.15.camel@localhost.localdomain>
 <5343BEFB.7050402@xenomai.org>
 <1396999856.2660.7.camel@localhost.localdomain>
 <53449244.8040502@xenomai.org>
 <1397003664.2660.14.camel@localhost.localdomain>
 <1397017658.2660.16.camel@localhost.localdomain>
 <534534FD.5090805@xenomai.org>
 <1397113300.2720.5.camel@localhost.localdomain>
 <5346895B.6080401@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 11 Apr 2014 05:57:30 +1000
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] OMAP L138
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

On Thu, 2014-04-10 at 14:06 +0200, Gilles Chanteperdrix wrote:
> On 04/10/2014 09:01 AM, Peter Howard wrote:
> > On Wed, 2014-04-09 at 13:54 +0200, Gilles Chanteperdrix wrote:
> >> On 04/09/2014 06:27 AM, Peter Howard wrote:
> >>> On Wed, 2014-04-09 at 10:34 +1000, Peter Howard wrote:
> >>>> On Wed, 2014-04-09 at 02:20 +0200, Gilles Chanteperdrix wrote:
> >>>>> On 04/09/2014 01:30 AM, Peter Howard wrote:
> >>>>>> On Tue, 2014-04-08 at 11:18 +0200, Gilles Chanteperdrix wrote:
> >>>>>>> On 04/07/2014 07:34 AM, Peter Howard wrote:
> >>>>>>>>
> >>>>>>>> On Wed, 2014-04-02 at 09:24 +0200, Gilles Chanteperdrix wrote:
> >>>>>>>>> On 04/02/2014 04:59 AM, Peter Howard wrote:
> >>>>>>>>>> Hi,
> >>>>>>>>>>
> >>>>>>>>>> I'm interested in running xenomai on a TI-OMAP L138 board.  I found the
> >>>>>>>>>> following thread in the archives:
> >>>>>>>>>>
> >>>>>>>>>> http://www.xenomai.org/pipermail/xenomai/2010-January/018898.html
> >>>>>>>>>>
> >>>>>>>>>> where someone was working on porting ipipe and xenomai to that board.
> >>>>>>>>>> However, the thread ended with problems still unresolved, and the patch
> >>>>>>>>>> in the thread (just the changes for ipipe) isn't in the ipipe
> >>>>>>>>>> repository.
> >>>>>>>>>>
> >>>>>>>>>> Does anyone know if this work was completed or just faded into the
> >>>>>>>>>> ether?
> >>>>>>>>>
> >>>>>>>>> We never merged a patch for this processor. And a lot of things changed
> >>>>>>>>> since that time. If you are interested in porting the I-pipe patch to
> >>>>>>>>> this processor, see:
> >>>>>>>>>
> >>>>>>>>> http://www.xenomai.org/index.php/I-pipe-core:ArmPorting
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Contrary to what I said last week, I'm working on a patch off the head
> >>>>>>>> of the ipipe repo.  I have built a kernel with an ipipe port and with
> >>>>>>>> xenomai patched in.  However the latency results are bad right now:
> >>>>>>>>
> >>>>>>>> root@arago:~# xeno latency -T 25
> >>>>>>>> == Sampling period: 1000 us
> >>>>>>>> == Test mode: periodic user-mode task
> >>>>>>>> == All results in microseconds
> >>>>>>>> warming up...
> >>>>>>>> RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
> >>>>>>>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
> >>>>>>>> RTD|      3.541|      8.833|     60.749|       0|     0|      3.541|     60.749
> >>>>>>>> RTD|      3.499|     13.583|     93.916|       0|     0|      3.499|     93.916
> >>>>>>>> RTD|      3.666|     88.999|    109.708|       0|     0|      3.499|    109.708
> >>>>>>>> RTD|      3.541|     14.958|     95.374|       0|     0|      3.499|    109.708
> >>>>>>>> RTD|      3.541|      9.333|     77.583|       0|     0|      3.499|    109.708
> >>>>>>>> RTD|      4.041|     88.416|    109.791|       0|     0|      3.499|    109.791
> >>>>>>>> RTD|      3.499|      8.958|     72.791|       0|     0|      3.499|    109.791
> >>>>>>>> RTD|      3.499|     26.041|    106.874|       0|     0|      3.499|    109.791
> >>>>>>>> RTD|      3.874|     82.708|    107.916|       0|     0|      3.499|    109.791
> >>>>>>>> RTD|      3.499|      9.083|     73.708|       0|     0|      3.499|    109.791
> >>>>>>>> RTD|      3.333|      8.874|     62.458|       0|     0|      3.333|    109.791
> >>>>>>>> RTD|      3.333|      8.749|     62.208|       0|     0|      3.333|    109.791 
> >>>>>>>> RTD|      3.416|     12.708|     99.416|       0|     0|      3.333|    109.791 
> >>>>>>>> RTD|      3.499|     14.249|    106.749|       0|     0|      3.333|    109.791 
> >>>>>>>> RTD|      3.541|      9.083|     76.499|       0|     0|      3.333|    109.791 
> >>>>>>>> RTD|      3.249|      8.791|     63.499|       0|     0|      3.249|    109.791 
> >>>>>>>> RTD|      3.416|      8.999|     62.499|       0|     0|      3.249|    109.791 
> >>>>>>>> RTD|      3.541|     26.166|    101.208|       0|     0|      3.249|    109.791 
> >>>>>>>> RTD|      3.583|     13.624|     92.458|       0|     0|      3.249|    109.791 
> >>>>>>>> RTD|      3.541|      8.916|     73.708|       0|     0|      3.249|    109.791 
> >>>>>>>> RTD|      3.541|      8.999|     64.291|       0|     0|      3.249|    109.791 
> >>>>>>>> RTT|  00:00:22  (periodic user-mode task, 1000 us period, priority 99)          
> >>>>>>>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst 
> >>>>>>>> RTD|      3.499|      8.874|     61.374|       0|     0|      3.249|    109.791 
> >>>>>>>> RTD|      3.499|     13.833|    100.749|       0|     0|      3.249|    109.791 
> >>>>>>>> RTD|      3.541|     13.083|     99.249|       0|     0|      3.249|    109.791 
> >>>>>>>> ---|-----------|-----------|-----------|--------|------|------------------------
> >>>>>>>> RTS|      3.249|     21.458|    109.791|       0|     0|    00:00:25/00:00:25   
> >>>>>>>> root@arago:~# 
> >>>>>>>
> >>>>>>> Note that if the OMAPL138 is an armv4 or armv5, you may want to enable
> >>>>>>> the FCSE in order to reduce context switch time (and latencies).
> >>>>>>>
> >>>>>>>
> >>>>>>
> >>>>>> I enabled FCSE, and the max latency is more consistent (though the min
> >>>>>> and average  latency has climbed).  How do the below figures look?
> >>>>>
> >>>>> Otherwise, it is hard to say whether there is an issue or not. It is not
> >>>>> uncommon for armv4 or armv5 to have high latencies like this.
> >>>>> On what core is this processor based, running at what frequency?
> >>>>>
> >>>>>
> >>>> It's an AMR926EJ-S r5.  Datasheet claims 375MHz, U-boot claims 300MHz.
> >>>>
> >>>> Load test to follow.
> >>>>
> >>>
> >>> OK, this run was done with LTP running on the board (runltplite.sh),
> >>> with cpu utilization between 90% and 100%
> >>
> >> You have to run the latency test while ltp is running, and run this for 
> >> a few hours (ltp runs a few hours anyway).
> >>
> >> We provide the xeno-test script to do this (and dohell to generate 
> >> load).
> >>
> >> See:
> >> http://www.xenomai.org/documentation/xenomai-2.6/html/xeno-test/index.html
> >> http://www.xenomai.org/documentation/xenomai-2.6/html/dohell/index.html
> >>
> > 
> > That's proving to be a bit challenging.  Giving dohell ltp is causing
> > more kernel panics - usually a SIGSEGV to init.  Now I'm aware from your
> > previous thread on the OMAP-L138 that ltp doesn't run cleanly on low-end
> > arm chips as-is, but I'm guessing kernel panics wasn't the failure mode
> > you were seeing.  (running ltp by itself also gives a different kernel
> > panic after about 15-20 minutes)  So I need to look into that more.
> > 
> > I also need to try the ltp build on the stock Ti-supplied system to make
> > sure there's not a pre-existing problem lurking in there; I should do
> > that tomorrow.
> 
> The thing is, if you enabled FCSE in guaranteed mode, it does not really
> make sense to run LTP: most tests will fail because of the processes
> number limit. In that case you should use the -b option, and pass the
> path to hackbench only.
> 
> > 
> > FWIW just running xeno-test with no arguments finishes cleanly after
> > running for 10 minutes or so.
> > 
> > Is it worth putting up the diff to the ipipe tree at this stage for
> > people to look over?
> 
> If you have random segfault, then something is still wrong. Have you
> tried enabling I-pipe debugging options?
> 
> The non-working I-pipe tracer with stack unwinding is not normal either,
> what version of the kernel are you using?
> 
> 
The kernel source I'm modifying is the master branch of the ipipe git
repo.
 
-- 
Peter Howard <pjh@northern-ridge.com.au>


