From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Bug in taskSuspend for user mode vxworks
Date: Sat, 28 Oct 2006 14:54:45 +0200
References: <200610252346.34150.niklaus.giger@domain.hid>
	<1161967109.4983.13.camel@domain.hid>
In-Reply-To: <1161967109.4983.13.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610281454.46672.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Am Freitag, 27. Oktober 2006 18:38 schrieb Philippe Gerum:
> On Wed, 2006-10-25 at 23:46 +0200, Niklaus Giger wrote:
> > Hi
> >
> > While trying to make a small demo app for Xenomai's registry I stumbled
> > about the following bug of the vxWorks skin.
> >
> > taskSuspend provokes (sometimes) a switch to the secondary mode, e.g. the
> >
> > output of the attached demo gives:
> > >  reg_demo &
> > > ~ $ Xenomai: Switching ConsumerTask to secondary mode after exception
> > > #1025
>
> This is the same issue that you raised back then, and that we did not
> fix yet:
> https://mail.gna.org/public/xenomai-core/2006-09/msg00177.html
>
> #1025 looks like being an ISI exception due to some unmapped memory
> being referred to. You mentioned CONFIG_XENO_OPT_DEBUG as possibly being
> part of the problem/solution; could you check whether this error still
> occurs when this option is disabled in the nucleus?
I recompiled the kernel with CONFIG_XENO_OPT_DEBUG disabled and the error went 
away.

-- 
Niklaus Giger

