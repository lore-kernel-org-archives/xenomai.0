Subject: Re: [Xenomai-core] Buildbot: Failure building Xenomai kernel for
	TQM860
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200612152130.14387.niklaus.giger@domain.hid>
References: <200612081309.31003.niklaus.giger@domain.hid>
	<45795D28.8010606@domain.hid> <45795DE1.70000@domain.hid>
	<200612152130.14387.niklaus.giger@domain.hid>
Content-Type: text/plain
Date: Sat, 16 Dec 2006 00:36:32 +0100
Message-Id: <1166225792.25160.57.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Fri, 2006-12-15 at 21:30 +0100, Niklaus Giger wrote:
> Am Freitag, 8. Dezember 2006 13:43 schrieb Jan Kiszka:
> > Wolfgang Grandegger wrote:
> > > Hi Niklaus,
> > >
> > > I just compiled my Linux 2.4 kernel for TQM860L with the latest revision
> > > of Xenomai and I cannot reproduce your problem. In you linker path there
> > > are no Xenomai objects. How does it come? Do you use --arch=ppc with
> > > prepare_kernel (--arch=powerpc is not valid any more for the ppc tree).
> >
> > The problem pops up with CONFIG_XENO_OPT_SCALABLE_SCHED.
> >
> > The definition of xnlogerr is not visible to queue.h, namely to the
> > inline function getmlq. Here is possible solution at XENO_ASSERT level.
> >
> > Jan
> Why didn't you apply your patch? It solved my problem and I don't see any risk 
> why you shouldn't apply it and didn't see any objections on this mailing 
> list.

A more general change also fixing this issue has been committed to the
trunk.

> 
> Best regards
> 
-- 
Philippe.



