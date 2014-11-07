Date: Fri, 7 Nov 2014 21:32:35 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141107203235.GF17476@sisyphus.hd.free.fr>
References: <20141001142416.GA4435@csclub.uwaterloo.ca>
 <20141107182600.GS24110@csclub.uwaterloo.ca>
 <545D12D2.2020104@xenomai.org>
 <20141107202405.GU24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141107202405.GU24110@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] I-pipe error when requesting irq that is on omap gpio
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Fri, Nov 07, 2014 at 03:24:05PM -0500, Lennart Sorensen wrote:
> On Fri, Nov 07, 2014 at 07:43:30PM +0100, Philippe Gerum wrote:
> > For this particular issue, Xenomai 2.x is deadly wrong. Creating,
> > deleting, enabling or disabling an IRQ channel must be done from
> > secondary mode. The syscall mode bits for these native API calls are
> > wrong, should be as follows instead:
> > 
> > diff --git a/ksrc/skins/native/syscall.c b/ksrc/skins/native/syscall.c
> > index 950b092..dff7f4d 100644
> > --- a/ksrc/skins/native/syscall.c
> > +++ b/ksrc/skins/native/syscall.c
> > @@ -4145,12 +4145,12 @@ static xnsysent_t __systab[] = {
> >  	[__native_alarm_stop] = {&__rt_alarm_stop, __xn_exec_any},
> >  	[__native_alarm_wait] = {&__rt_alarm_wait, __xn_exec_primary},
> >  	[__native_alarm_inquire] = {&__rt_alarm_inquire, __xn_exec_any},
> > -	[__native_intr_create] = {&__rt_intr_create, __xn_exec_any},
> > +	[__native_intr_create] = {&__rt_intr_create, __xn_exec_lostage},
> >  	[__native_intr_bind] = {&__rt_intr_bind, __xn_exec_conforming},
> > -	[__native_intr_delete] = {&__rt_intr_delete, __xn_exec_any},
> > +	[__native_intr_delete] = {&__rt_intr_delete, __xn_exec_lostage},
> >  	[__native_intr_wait] = {&__rt_intr_wait, __xn_exec_primary},
> > -	[__native_intr_enable] = {&__rt_intr_enable, __xn_exec_any},
> > -	[__native_intr_disable] = {&__rt_intr_disable, __xn_exec_any},
> > +	[__native_intr_enable] = {&__rt_intr_enable, __xn_exec_lostage},
> > +	[__native_intr_disable] = {&__rt_intr_disable, __xn_exec_lostage},
> >  	[__native_intr_inquire] = {&__rt_intr_inquire, __xn_exec_any},
> >  	[__native_pipe_create] = {&__rt_pipe_create, __xn_exec_lostage},
> >  	[__native_pipe_bind] = {&__rt_pipe_bind, __xn_exec_conforming},
> 
> I get the impression this might also be important:
> 
> Index: linux-3.12.31.rr1/arch/arm/mach-omap2/timer.c
> ===================================================================
> --- linux-3.12.31.rr1.orig/arch/arm/mach-omap2/timer.c  2014-11-07 10:10:47.736200170 -0500
> +++ linux-3.12.31.rr1/arch/arm/mach-omap2/timer.c       2014-11-07 11:42:03.807512821 -0500
> @@ -824,7 +824,8 @@
>                 omap2_sync32k_clocksource_init();                       \
>         if (cpu_is_omap34xx())                                          \
>                 omap3_pic_muter_register();                             \
> -       else if (cpu_is_omap44xx() || soc_is_omap54xx())                \
> +       else if (cpu_is_omap44xx() || soc_is_omap54xx()                 \
> +                || soc_is_dra7xx())                                    \
>                 omap4_pic_muter_register();                             \
>  }
>  #endif
> 
> The dra7xx (am57xx) we are using is very much like the omap54xx, and
> use the same gpio system, so this call probably should be getting done.
> 
> Does that seem plausible?

This call enables "PIC muting". "PIC muting" means disabling non
real-time interrupts when in the Xenomai domain, i.e. when executing
real-time code. The I-pipe can work without that (as it does on many
platforms). So, if you suspect you have IRQ handling issues, you may
prefer to disable it, you do not want to suspect it of being the
cause of the issues you have.

-- 
					    Gilles.

