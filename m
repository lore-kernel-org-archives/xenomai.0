Subject: Re: [Adeos-main] Re: Adeos-main digest, Vol 1 #39 - 1 msg
From: Philippe Gerum <rpm@xenomai.org>
Reply-To: rpm@xenomai.org
In-Reply-To: <Pine.LNX.4.44L.0410271428370.21604-100000@domain.hid>
References: <20041027042517.19465.86755.Mailman@domain.hid>
	 <Pine.LNX.4.44L.0410271428370.21604-100000@domain.hid>
Content-Type: text/plain
Message-Id: <1098910087.669.7.camel@domain.hid>
Mime-Version: 1.0
Date: Wed, 27 Oct 2004 22:48:07 +0200
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Currie Reid <curriereid@domain.hid>
Cc: adeos-main@gna.org

On Wed, 2004-10-27 at 20:42, Currie Reid wrote:
> Hello,
> 
> It looks like spurious interrupts are ignored during kernel/device
> initialization until __adeos_takeover().  Then, any spurious interrupts
> that occur are counted in the total.
> 

[snip]

> Should Adeos be ignoring these interrupts as the do_IRQ routine seems to
> be doing prior to Adeos pipelining being started?  It seems to be on
> initialisation of the usb keyboards that is causing these interrupts.  As
> I said in my previous e-mail, the total remains stable after the system is
> booted - no more spurious interrupts are registered.

My code looks bugous.  Not all possible return values from
ppc_md.get_irq() are checked against the current context (1st or
subsequent IRQs), so ppc_spurious_interrupts gets spuriously
incremented. Sorry, brain cells shortage...

> It looks like Adeos for the 2.4 kernel did not increment the spurious
> interrupt count, so you don't see the same problem.  I tried commenting
> out the increment in __adeos_grab_irq just to verify, and it seems to
> supress the count, but I'm sure that it is there for a reason.
> 
> Any insight into this is very much appreciated.
> 
> Currie
> 
> 
> > Date: Tue, 26 Oct 2004 10:31:07 -0400 (EDT)
> > From: Currie Reid <curriereid@domain.hid>
> > To: adeos-main@gna.org
> > Subject: [Adeos-main] Spurious interrupts on boot
> >
> >
> > Hello all,
> >
> > I have applied adeos-linuxppc-2.6.8rc1-r6c8.patch to my kernel, and
> > everything seems to be working fine so far, but I notice that the
> > ppc_spurious_interrupts count runs up on boot:
> >
> >            CPU0
> >  19:       2239   OpenPIC   Level     ide0
> >  20:         12   OpenPIC   Level     ide1
> >  25:      10855   OpenPIC   Level     VIA-PMU
> >  41:       4415   OpenPIC   Level     eth0
> >  47:          0   OpenPIC   Level     GPIO1/ADB
> > BAD:       1426
> >
> > The good news is that it doesn't increase, but without the patch, the
> > BAD count stays at 0.  Is this a known issue?  I haven't found any
> > reference to it on the mailing list.
> >
> > My machine g4 powermac:
> > processor       : 0
> > cpu             : 7400, altivec supported
> > temperature     : 7-9 C (uncalibrated)
> > clock           : 400MHz
> > revision        : 2.8 (pvr 000c 0208)
> > bogomips        : 794.62
> > machine         : PowerMac3,3
> > motherboard     : PowerMac3,3 MacRISC2 MacRISC Power Macintosh
> > detected as     : 65 (PowerMac G4 AGP Graphics)
> > pmac flags      : 00000004
> > L2 cache        : 1024K unified
> > memory          : 1024MB
> > pmac-generation : NewWorld
> >
> > Thanks
> >
> > Currie Reid
> 
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
-- 

Philippe.


