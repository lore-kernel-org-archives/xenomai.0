From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <450733.63606.qm@domain.hid>
References: <450733.63606.qm@domain.hid>
Content-Type: text/plain
Date: Wed, 22 Jul 2009 11:45:10 +0200
Message-Id: <1248255910.3992.383.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai exceptions tracing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yigal Goldberger <yigal_gold@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2009-07-22 at 02:28 -0700, Yigal Goldberger wrote:
> Hi Philippe,
> Thanks for replying .
> Indeed it's a powerpc . it is a mpc8272 freescale powerpc family cpu.
> I printed the kmsg log and that's what I printed in this email below ,
> from the kmsg log I see that the next message after this exception is
> from where the application is being shut down .
> Could this be a response to this exception , or is it just by chance printed straight after ?

This kind of exception is handled internally between the linux kernel
and the Xenomai core, it would not stop the application. Xenomai would
only kill a kernel-based RT thread dereferencing a bad memory area (with
a non-ambiguous message in the klog), which is certainly not the case
here. Linux would kill a userland thread doing the same (RT / non-RT,
regardless) with a signal.

This is not what happens here. You may want to enable CONFIG_PRINTK_TIME
to have timestamps on your kernel messages, in order to confirm this.

> Thanks,
> Yigal. 
> 
> --- On Wed, 7/22/09, Philippe Gerum <rpm@xenomai.org> wrote:
> 
> > From: Philippe Gerum <rpm@xenomai.org>
> > Subject: Re: [Xenomai-help] xenomai exceptions tracing
> > To: "Yigal Goldberger" <yigal_gold@domain.hid>
> > Cc: xenomai@xenomai.org
> > Date: Wednesday, July 22, 2009, 12:07 PM
> > On Wed, 2009-07-22 at 01:28 -0700,
> > Yigal Goldberger wrote:
> > > Hi all,
> > > I'm using kernel 2.6.29.4 with xenomai .
> > > I'm getting an exception 769 . I'd like to know what
> > this exception means (or hints where to look for it ).
> > > 
> > 
> > It looks like you are running a ppc system. Those are minor
> > MMU faults,
> > due to PTE misses that happen on some platforms (83xx and
> > 85xx come to
> > mind). Those get reported because you turned the nucleus
> > debug switch
> > on. Nothing bad in your case.
> > 
> > > 6>MTD_open
> > > <6>MTD_ioctl
> > > <6>MTD_open
> > > <6>MTD_ioctl
> > > <6>Xenomai: Switching 802Rdr to secondary mode
> > after exception #769 from user-sp
> > > ace at 0x10017cec (pid 974)
> > > <6>Xenomai: Posix: closing message queue
> > descriptor 3.
> > > <6>Xenomai: Posix: closing message queue
> > descriptor 4.
> > > <6>Xenomai: Posix: closing message queue
> > descriptor 5.
> > > <6>Xenomai: Posix: closing message queue
> > descriptor 7.
> > > <6>Xenomai: Posix: closing message queue
> > descriptor 8.
> > > <6>Xenomai: Posix: closing message queue
> > descriptor 9.
> > > <6>Xenomai: Posix: closing message queue
> > descriptor 10.
> > > <6>Xenomai: Posix: closing message queue
> > descriptor 11.
> > > <6>Xenomai: Posix: closing message queue
> > descriptor 12.
> > > <6>Xenomai: Posix: closing message queue
> > descriptor 14.
> > > <6>Xenomai: Posix: closing message queue
> > descriptor 15.
> > > 
> > > Thanks,
> > > Yigal Goldberger.
> > > 
> > > 
> > >       
> > > 
> > > _______________________________________________
> > > Xenomai-help mailing list
> > > Xenomai-help@domain.hid
> > > https://mail.gna.org/listinfo/xenomai-help
> > -- 
> > Philippe.
> > 
> > 
> > 
> 
> 
>       
-- 
Philippe.



