Message-ID: <1399330821.4724.10.camel@localhost.localdomain>
From: Peter Howard <pjh@northern-ridge.com.au>
Date: Tue, 06 May 2014 09:00:21 +1000
In-Reply-To: <5366943E.30008@xenomai.org>
References: <1396407588.27578.5.camel@localhost.localdomain>
 <1396999856.2660.7.camel@localhost.localdomain>
 <53449244.8040502@xenomai.org>
 <1397003664.2660.14.camel@localhost.localdomain>
 <1397017658.2660.16.camel@localhost.localdomain>
 <534534FD.5090805@xenomai.org>
 <1397113300.2720.5.camel@localhost.localdomain>
 <5346895B.6080401@xenomai.org>
 <1397159850.2881.3.camel@localhost.localdomain>
 <53471389.6000000@xenomai.org>
 <1397168263.6356.11.camel@localhost.localdomain>
 <534719F5.2020605@xenomai.org>
 <1397169248.6356.15.camel@localhost.localdomain>
 <53471FDB.50008@xenomai.org>
 <1397170339.6356.17.camel@localhost.localdomain>
 <1397541812.6541.3.camel@localhost.localdomain>
 <534D19FA.3040506@xenomai.org>
 <1397599195.2652.0.camel@localhost.localdomain>
 <5356F4FE.3050406@xenomai.org>
 <1398217532.2723.18.camel@localhost.localdomain>
 <5359827E.7040900@xenomai.org>
 <1398735970.3038.1.camel@localhost.localdomain>
 <5366943E.30008@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
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

On Sun, 2014-05-04 at 21:25 +0200, Gilles Chanteperdrix wrote:
> On 04/29/2014 03:46 AM, Peter Howard wrote:
> > On Thu, 2014-04-24 at 23:30 +0200, Gilles Chanteperdrix wrote:
> >> On 04/23/2014 03:45 AM, Peter Howard wrote:
> >>> On Wed, 2014-04-23 at 01:02 +0200, Gilles Chanteperdrix wrote:
> >>>> On 04/15/2014 11:59 PM, Peter Howard wrote:
> >>>>> On Tue, 2014-04-15 at 13:37 +0200, Gilles Chanteperdrix wrote:
> >>>>>> On 04/15/2014 08:03 AM, Peter Howard wrote:
> >>>>>>> On Fri, 2014-04-11 at 08:52 +1000, Peter Howard wrote:
> >>>>>>>> On Fri, 2014-04-11 at 00:48 +0200, Gilles Chanteperdrix wrote:
> >>>>>>>>> On 04/11/2014 12:34 AM, Peter Howard wrote:
> >>>>>>>>>> On Fri, 2014-04-11 at 00:23 +0200, Gilles Chanteperdrix wrote:
> >>>>>>>>>> (Stripping back conversation on this one - apologies if that's bad
> >>>>>>>>>> etiquette for this list)
> >>>>>>>>>>  
> >>>>>>>>>>> Attachment is better. Also please post the changes you made for omapL138
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
> >>>>>>>>>> index a075b3e..3d8bc59 100644
> >>>>>>>>>> --- a/arch/arm/mach-davinci/Kconfig
> >>>>>>>>>> +++ b/arch/arm/mach-davinci/Kconfig
> >>>>>>>>>> @@ -41,6 +41,8 @@ config ARCH_DAVINCI_DA850
> >>>>>>>>>>  	select ARCH_DAVINCI_DA8XX
> >>>>>>>>>>  	select ARCH_HAS_CPUFREQ
> >>>>>>>>>>  	select CP_INTC
> >>>>>>>>>> +    select IPIPE_ARM_KUSER_TSC if IPIPE
> >>>>>>>>>> +    select ARM_FCSE if IPIPE
> >>>>>>>>>
> >>>>>>>>> You may want to leave the choice of enabling or disabling FCSE to the user.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Understood; at the moment the variance on max latency is really bad if
> >>>>>>>> you don't enable FCSE.  When I sort out the crashing issues I'll re-test
> >>>>>>>> with it off.
> >>>>>>>
> >>>>>>> Well, FCSE turned out to be my problem.
> >>>>>>>
> >>>>>>> More specifically,  FCSE and ARM_FCSE_BEST_EFFORT.  Either a) disabling
> >>>>>>> ARM_FCSE altogether, or b) selecting ARM_FCSE with ARM_FCSE_GUARENTEED
> >>>>>>> gets rid of the crashes/panics with ipipe latency tracing enabled.
> >>>>>>>
> >>>>>>> So now things seem reasonably stable, I'll go through the full set of
> >>>>>>> tests.  Though I still can't do 'xeno-test -l "dohell -l /opt/ltp"' as
> >>>>>>> ltp takes out the system without any ipipe/xenomai bits.
> >>>>>>>
> >>>>>> Ok, FCSE best effort is currently being validated on 3.14, so it may
> >>>>>> well be broken. After all, the raw/* branches are work in progress.
> >>>>>>
> >>>>>
> >>>>> Note: selecting ARM_FCSE_BEST_EFFORT produces the same result on the
> >>>>> master branch too . . .
> >>>>>
> >>>> Hi Peter,
> >>>>
> >>>> I am unable to reproduce these issues with 3.14, FCSE seems to be doing
> >>>> just fine, I can boot and run the LTP testsuite and get almost the same
> >>>> results as a non patched kernel. I have tried with and without
> >>>> preemptible cache flushes, and with and without Xenomai. My rootfs is
> >>>> based on busybox and minimal, maybe that is the reason why it works
> >>>> fine, could you put a tarball with your rootfs somewhere?
> >>>
> >>> A bit of testing shows (at least) one case is directly related to the
> >>> rootfs.  This is the Texas Instruments rootfs that is supplied for the
> >>> DA850 board.  During normal startup, it wants to start the GUI for the
> >>> LCD which would go past the 32MB process limit with FCSE enabled.  With
> >>> FCSE_GUARENTEED selected this is noted but doesn't cause a crash.  With
> >>> FCSE_BEST_EFFORT selected this is noted and then the system crashes
> >>> within a few seconds.  I'm not sure if this counts as a bug in
> >>> BEST_EFFORT or whether all bets are off if you try to start a process
> >>> that's too large.
> >>>
> >>> At this point I'm not sure if anything else is specific to that rootfs
> >>> but I'll still make it available to you to have a look.
> >>
> >> No luck with your rootfs: matrix_GUI craches indeed, but it also crashes
> >> without CONFIG_FCSE, so it would seem the crash is unrelated to the
> >> FCSE. Obviously it does not crash with FCSE_GUARANTEED, because it is
> >> stopped as soon as it wants to go over 32 MB. And that crash does not
> >> cause the cascade of crashes you mentioned, ending with init crashing.
> >> The processor on which I am running the tests does not have a
> >> framebuffer maybe that is the reason I get a crash, and do not go as far
> >> as in your case.
> >>
> >> Could you post the kernel configuration you use?
> >>
> > 
> > Take 3.  Ignore the previous two.  They will probably trigger it, but
> > this one I actually tested to confirm it does cause the crash.
> 
> This configuration with only omapl138 replaced with at91sam9263 seems to
> run correctly, except for the segfault in the matrix_guiE application,
> which I also have on an unpatched kernel. Note that this configuration
> sets the cache to writethrough mode which, at least on at91sam9263
> results in a much slower kernel than writeback mode.
> 

Yep. Writethrough is forced by that defconfig selecting the da830 as
well as the da850.  Disabling the da830 and turning writethrough off
speeds things up slightly but doesn't have any other effect.

> So, I would say any remaining issue is specific to omapl138.
> 

Seems a reasonable assumption.

Right now I'm largely stumped.  I'm not always getting meaningful
backtraces on panic, but when I do they invariably pass through
__do_kernel_fault() - often more than once.  It seems I can also trigger
the problem if I *disable* xenomai and ipipe, but leave FCSE best-effort
and lots of tracing enabled.

On best-effort that >32MB process won't be killed - correct?  Is it
possible to hit problems with the 32MB boundary while in the kernel?


-- 
Peter Howard <pjh@northern-ridge.com.au>


