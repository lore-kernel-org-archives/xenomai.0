From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4648AC33.6090902@domain.hid>
References: <46478F98.1040101@domain.hid> <4648A597.70600@domain.hid>
	<4648AC33.6090902@domain.hid>
Content-Type: text/plain
Date: Tue, 15 May 2007 09:57:41 +0200
Message-Id: <1179215861.11297.0.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [Adeos-main] [BUG] pit clocksource broken
	under	Xenomai
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>, xenomai-core <xenomai@xenomai.org>

On Mon, 2007-05-14 at 20:36 +0200, Jan Kiszka wrote:
> Jan Kiszka wrote:
> > Jan Kiszka wrote:
> >> Hi,
> >>
> >> just checked on real hardware (found in qemu originally):
> >>
> >> When Linux uses the pit clocksource AND Xenomai is attached, the system
> >> time no longer makes progress. Observed under 2.6.20 with 1.7-03 and
> >> newer patches, Xenomai trunk.
> >>
> >> I guess not many people will be affected by this and I'm lacking time to
> >> debug, so I'm just dumping the report and running away...
> > 
> > Somehow I hate open issues...
> > 
> > I recalled some private thread with you, Philippe, about this particular
> > line in pid_read(). A look at it again revealed the reason for this bug.
> > 
> > Jan
> > 
> > PS: pending_patches++ ;)
> > 
> > 
> > ---
> >  arch/i386/kernel/i8253.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > Index: linux-2.6.20/arch/i386/kernel/i8253.c
> > ===================================================================
> > --- linux-2.6.20.orig/arch/i386/kernel/i8253.c
> > +++ linux-2.6.20/arch/i386/kernel/i8253.c
> > @@ -47,7 +47,8 @@ static cycle_t pit_read(void)
> >  
> >  #ifdef CONFIG_IPIPE
> >  	if (!__ipipe_pipeline_head_p(ipipe_root_domain))
> > -		return 0;	/* We don't really own the PIT. */
> > +		/* We don't own the PIT, fall back to jiffies. */
> > +		return (cycle_t)(jiffies * LATCH);
> 
> I think even more correct would be
> 
> 	return (cycle_t)(jiffies * LATCH) + (LATCH - 1) - old_count;
> 
> Should avoid the theoretical chance of a clock backward jump when
> Xenomai attaches. I leave it up to the maintainer to decide. :)
> 

Merged this one, thanks.

> Jan
> 
-- 
Philippe.



