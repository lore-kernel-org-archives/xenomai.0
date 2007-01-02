From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-help] Re: A fairly small rtnet/Xenomai...
Date: Tue, 2 Jan 2007 15:09:22 +0100
References: <1167216287.31795.18.camel@domain.hid>
	<23680523.1167726237795.JavaMail.ngmail@domain.hid>
	<1167731631.23346.7.camel@domain.hid>
In-Reply-To: <1167731631.23346.7.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701021509.22689.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Am Dienstag, 2. Januar 2007 10:53 schrieb Philippe Gerum:
> On Tue, 2007-01-02 at 09:23 +0100, M. Koehrer wrote:
> > Happy new year to all!
> >
> > Back in the office, I tried out the patches from Chilles and Philippe.
> > And yes, it is working now! No crash!
> > Using these patches, I can now call a system() call out of a rea ltime
> > task that is followed by a rt_task_sleep() and a printf() without crash
> > on a 2.6.19 kernel.
> >
> > Thanks for the support!
> >
> > Best regards
> >
> > Mathias
> >
> > > > here comes a workaround for the COW issue on Linux 2.6.19. The patch
> > > > relies on a new VM_NOCOW flag which should be set for real-time
> > > > application if you use Xenomai trunk.
> > > >
> > > > It would be nice if you could test it.
> > >
> > > You will additionally need to apply this patch to the Xenomai tree in
> > > order to activate the COW-disable feature:
>
> Great, thanks. Niklaus, could you check the vm-nocow patch for 2.6.14 on
> the ppc board (the hcu, IIRC) that exhibited strange faults in
> user-space while running the latency test, especially when enabling the
> nucleus debug option (the one which also used to cause secondary switch
> warnings being sent by Xenomai to the kernel log)? TIA,
I will check it, but I must first upgrade my board specific patch from Linux 
2.6.17 to 2.6.19. Don't know how much time it will take me.

Best regards
-- 
Niklaus Giger

