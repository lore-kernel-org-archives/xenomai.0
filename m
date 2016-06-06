Date: Mon, 6 Jun 2016 17:35:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160606153545.GA376@hermes.click-hack.org>
References: <574D9B03.8080706@sigmatek.at>
 <20160531141646.GG5951@hermes.click-hack.org>
 <574EE886.2020907@sigmatek.at>
 <20160601141238.GC14103@hermes.click-hack.org>
 <574FEB2D.5010509@sigmatek.at>
 <20160602082318.GB1801@hermes.click-hack.org>
 <5755204C.6090701@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5755204C.6090701@sigmatek.at>
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

On Mon, Jun 06, 2016 at 09:03:40AM +0200, Wolfgang Netbal wrote:
> 
> 
> Am 2016-06-02 um 10:23 schrieb Gilles Chanteperdrix:
> > On Thu, Jun 02, 2016 at 10:15:41AM +0200, Wolfgang Netbal wrote:
> >>
> >> Am 2016-06-01 um 16:12 schrieb Gilles Chanteperdrix:
> >>> On Wed, Jun 01, 2016 at 03:52:06PM +0200, Wolfgang Netbal wrote:
> >>>> Am 2016-05-31 um 16:16 schrieb Gilles Chanteperdrix:
> >>>>> On Tue, May 31, 2016 at 04:09:07PM +0200, Wolfgang Netbal wrote:
> >>>>>> Dear all,
> >>>>>>
> >>>>>> we have moved our application from "XENOMAI 2.6.2.1 + Linux 3.0.43" to
> >>>>>> "XENOMAI 2.6.4. + Linux 3.10.53". Our target is an i.MX6DL. The system
> >>>>>> is now up and running and works stable. Unfortunately we see a
> >>>>>> difference in the performance. Our old combination (XENOMAI 2.6.2.1 +
> >>>>>> Linux 3.0.43) was slightly faster.
> >>>>>>
> >>>>>> At the moment it looks like that XENOMAI 2.6.4 calls
> >>>>>> xnpod_schedule_handler much more often then XENOMAI 2.6.2.1 in our old
> >>>>>> system.  Every call of xnpod_schedule_handler interrupts our main
> >>>>>> XENOMAI task with priority = 95.
> >>>>>>
> >>>>>> I have compared the configuration of both XENOMAI versions but did not
> >>>>>> found any difference. I checked the source code (new commits) but did
> >>>>>> also not find a solution.
> >>>>> Have you tried Xenomai 2.6.4 with Linux 3.0.43 ? In order to see
> >>>>> whether it comes from the kernel update or the Xenomai udpate?
> >>>> I've tried Linux 3.0.43 with Xenomai 2.6.4 an there is no difference to
> >>>> Xenomai 2.6.2.1
> >>>> Looks like there is an other reason than Xenomai.
> >>> Ok, one thing to pay attention to on imx6 is the L2 cache write
> >>> allocate policy. You want to disable L2 write allocate on imx6 to
> >>> get low latencies. I do not know which patches exactly you are
> >>> using, so it is difficult to check, but the kernel normally displays
> >>> the value set in the L2 auxiliary configuration register, you can
> >>> check in the datasheet if it means that L2 write allocate is
> >>> disabled or not. And check if you get the same value with 3.0 and
> >>> 3.10.
> >> Thank you for this hint, I looked around in the kernel config, but cant
> >> find
> >> an option sounds like L2 write allocate.
> >> The only option I found was CACHE_L2X0 and that is activated on both
> >> kernels.
> >> Do you have an idea whats the name of this configuration or where in the
> >> kernel sources it should be located, so I can find out whats the name of
> >> the
> >> config flag by searching the sourcecode.
> > I never talked about any kernel configuration option. I am talking
> > checking the value passed to the L2 cache auxiliary configuration
> > register, this is a hardware register. Also, as I said, the value
> > passed to the L2 cache auxiliary register is printed by the kernel
> > during boot.
> >
> >
> Sorry Gilles,
> I found the message in the kernel log, you are right they are different
> Kernel 3.0.43 shows   l2x0: 16 ways, CACHE_ID 0x410000c8, AUX_CTRL 
> 0x02850000, Cache size: 524288 B
> Kernel 3.10.53 shows l2x0: 16 ways, CACHE_ID 0x410000c8, AUX_CTRL 
> 0x32c50000, Cache size: 524288 B
> Kernel 3.10.53 sets addidtional the bits 22 (Shared attribute override 
> enable), 28 (Data prefetch) and 29 (Instruction prefetch)
> I used the same settings on Kernel 3.0.43 but the perfromance didn't 
> change, looks like this configurations didn't slow down my
> system.
> 
> What I have seen while searching the kernel config was that there are a 
> few errate that are activated as dependency in 3.10.53,
> to be sure none of the errata is the source of my performance reduction 
> I activated them on 3.0.43 as well.
> But again no difference to our default configuration.
> 
> To avoid our application is running slower I created a shell-script 
> incrementing a variable
> 10.000 times and measuring the runtime with time
> 
> #!/bin/sh
> var=0
> while [  $var -lt $1 ]; do
>      let var++
> done
> 
>  > time /mnt/drive-C/CpuTime.sh 10000
> 
> On this test
> Kernel 3.0.43 Xenomai 2.6.2.1  needs 480 ms
> Kernel 3.10.53  Xenomai 2.6.4  needs 820ms

If you run the same test several times on the same kernel, do you
reliably always get the same duration?

> 
> This differences are huge, an I'm not sure if I can trust this test
> because we also use a different busybox,
> and the difference using our application are between 2% and 3%
> in the realtime task (Xenomaitask with priority 95)
> Do you have an idea why this is that much slower ?

I would not call a 2% or 3% difference "much slower", only
measurement noise.

> 
> I also see differences when I use the xeno-test command to check the speed
> Some of the operations are faster on newer Xenomai but a few are much 
> slower,
> for example inlined llimd.

The differences in the "arith" test are measurement noise. Chances
are, if you run twice the arith test with the same kernel you are
not going to find the same values.

> 
> With every test I run it looks like the issue is not located in Kernel 
> or Xenomai.
> Do you know any speed issues on system libraries like libc or something 
> like that ?

Stupid question: do the two kernels run the processor at the same
speed? You could have a difference if one kernel runs it at 1GHz and
the other at 800MHz for instance.

-- 
					    Gilles.
https://click-hack.org

