Subject: Re: [Xenomai-help] Re: A fairly small rtnet/Xenomai...
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200701042157.43201.niklaus.giger@domain.hid>
References: <1167216287.31795.18.camel@domain.hid>
	<23680523.1167726237795.JavaMail.ngmail@domain.hid>
	<1167731631.23346.7.camel@domain.hid>
	<200701042157.43201.niklaus.giger@domain.hid>
Content-Type: text/plain
Date: Fri, 05 Jan 2007 11:57:21 +0100
Message-Id: <1167994641.6702.65.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

On Thu, 2007-01-04 at 21:57 +0100, Niklaus Giger wrote:
> Am Dienstag, 2. Januar 2007 10:53 schrieb Philippe Gerum:
> > On Tue, 2007-01-02 at 09:23 +0100, M. Koehrer wrote:
> > > Happy new year to all!
> > >
> > > Back in the office, I tried out the patches from Chilles and Philippe.
> > > And yes, it is working now! No crash!
> > > Using these patches, I can now call a system() call out of a rea ltime
> > > task that is followed by a rt_task_sleep() and a printf() without crash
> > > on a 2.6.19 kernel.
> > >
> > > Thanks for the support!
> > >
> > > Best regards
> > >
> > > Mathias
> > >
> > > > > here comes a workaround for the COW issue on Linux 2.6.19. The patch
> > > > > relies on a new VM_NOCOW flag which should be set for real-time
> > > > > application if you use Xenomai trunk.
> > > > >
> > > > > It would be nice if you could test it.
> > > >
> > > > You will additionally need to apply this patch to the Xenomai tree in
> > > > order to activate the COW-disable feature:
> >
> > Great, thanks. Niklaus, could you check the vm-nocow patch for 2.6.14 on
> > the ppc board (the hcu, IIRC) that exhibited strange faults in
> > user-space while running the latency test, especially when enabling the
> > nucleus debug option (the one which also used to cause secondary switch
> > warnings being sent by Xenomai to the kernel log)? TIA,
> Here the results. I had no problems running xeno-test.
> 

Nice.

> I did set in my .config
> CONFIG_XENO_OPT_DEBUG=y
> CONFIG_XENO_OPT_DEBUG_NUCLEUS=y
> 
> Attached is my .config and the output of xeno-test.
> 
> If you need the results of another combination just let me know.

That's fine, thanks.

-- 
Philippe.



