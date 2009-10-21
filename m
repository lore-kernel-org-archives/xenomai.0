From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <245373446233674495BCA5CA2FC1EB172FEEF2DCD7@domain.hid>
References: <1254853590.3718.28.camel@domain.hid>
	,<1254859856.2784.251.camel@domain.hid>
	<245373446233674495BCA5CA2FC1EB172FEEF2DCD7@domain.hid>
Content-Type: text/plain
Date: Wed, 21 Oct 2009 16:32:39 +0200
Message-Id: <1256135559.2862.418.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] RFC: 2.5 todo list.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Andreas Glatz <AndreasGlatz@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, 2009-10-15 at 15:21 -0400, Andreas Glatz wrote:
> Hi Philippe,
> 
> Back at work. See inline replies below.
> 
> 
> > > > > > - powerpc32 updates for 2.6.30. Mainly to merge the once experimental
> > > > > > bits that prevent most alignment faults from triggering a secondary mode
> > > > > > switch. Andreas told me this works like a charm on 83xx, and I did not
> > > > > > see any issue on 52xx, 85xx or 86xx either.
> > > > > >
> > > > >
> > > > > Can I get a version of that patch for testing? Is it in your git
> > > > > repository?
> > > >
> > > > I just pushed this commit to my remote tree (ipipe-2.6.30-powerpc
> > > > branch); it should appear in a few hours once mirrored (cron job).
> > > >
> > >
> > > I finally had a chance to test the ipipe-2.6.30-powerpc version
> > > from the git repository. Unfortunately, I noticed that our application
> > > dies after some time and that this behaviour is related to that
> > > alignment patch (if I take it out everything runs fine for > 2 days).
> > >
> > > Currently I'm investigating the reasons for that crash. It has
> > > something to do with floating point registers not being restored
> > > properly. Our alignment exceptions are mainly triggered by accesses
> > > to unaligned floating point data.
> > 
> > Does it work any better with this patch in?
> 
> I applied that patch but unfortunately our application still dies. I included
> an application with with you (hopefully) can reproduce the problem 
> which we are seeing. Our system is a MPC8360 with 2.6.30, ipipe 2.7,
> xenomai 2.4.9.1.
> 
> Here are the steps:
> 
> 1) apply ipipe with alignment patch, recompile kernel
> 2) comile test1.c (attached) with: 
>         gcc -Wall -O2 `xeno-config --xeno-cflags` \
>                                 `xeno-config --xeno-ldflags` \
>                                  -l native -l rtdk  -o test1 test1.c
> 3) Start test1 in one shell
> 4) Open a second shell and start 'switchbench'
> 
> Just when 'switchbench' is running, I get the following
> output from my test application:
> ...
> Missmatch: 0xfff8000082064000
> Missmatch: 0xfff8000082064000
> Missmatch: 0xfff8000082064000
> Missmatch: 0xfff8000082064000 
> ...

There is a serious issue going on with this patch, because this
optimization depends on the ability of Xenomai to properly handle
non-linux, non-RT FPU usage in kernel space, which is not guaranteed so
far for powerpc (x86 is ok regarding this, though).

So I'm just reverting this patch, in order to get back to a correct
behavior asap. This will require more thoughts later, when 2.5.0 is out.
Sorry for the delay.

> 
> It seems that test1 is interrupted right between
> the lfd and stfd and the floating point regs aren't
> restored properly.
> 
> Just a side note: I had to add assembly code to my
> C program to force an alignment exception. gcc seems
> to be smart enough to avoid unaligned access. g++
> on the other hand (especially g++ 3.3.6 which we are 
> using) seems to generate assembly code which causes
> alignment exceptions. So it seems that it's really g++'s 
> fault. We also discovered that our g++ generates buggy 
> floating point assembly code when compiling with the 
> -O2 or -Os option. Currently, we compile our application
> with -msoft-float to avoid those issues which has the
> nice side effect that we also don't get alignment exceptions
> anymore.
> 
> Many thanks,
> Andreas
> 
> 
> > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> > index 32cc3df..a04a5e3 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -80,7 +80,9 @@ void flush_fp_to_thread(struct task_struct *tsk)
> >                  * FPU, and then when we get scheduled again we would store
> >                  * bogus values for the remaining FP registers.
> >                  */
> > -               ipipe_preempt_disable(flags);
> > +               if (ipipe_root_domain_p)
> > +                       preempt_disable();
> > +               local_irq_save_hw_cond(flags);
> >                 if (tsk->thread.regs->msr & MSR_FP) {
> >  #ifdef CONFIG_SMP
> >                         /*
> > @@ -94,7 +96,9 @@ void flush_fp_to_thread(struct task_struct *tsk)
> >  #endif
> >                         giveup_fpu(tsk);
> >                 }
> > -               ipipe_preempt_enable(flags);
> > +               local_irq_restore_hw_cond(flags);
> > +               if (ipipe_root_domain_p)
> > +                       preempt_enable();
> >         }
> >  }
-- 
Philippe.



