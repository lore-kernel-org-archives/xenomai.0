Date: Mon, 17 Sep 2018 21:18:48 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180917211848.60906825@md1pvb1c.ad001.siemens.net>
In-Reply-To: <f488f920-9bee-0259-6375-10207c78b590@siemens.com>
References: <20180914151018.1226-1-henning.schild@siemens.com>
 <20180914151018.1226-5-henning.schild@siemens.com>
 <5a4e3043-b177-2d8b-fea4-e9365aafc8f2@siemens.com>
 <f488f920-9bee-0259-6375-10207c78b590@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [PATCHv2 4/4] cobalt/x86: add ipipe-4.14 eager fpu
 support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

Am Mon, 17 Sep 2018 20:23:16 +0200
schrieb Jan Kiszka <jan.kiszka@siemens.com>:

> On 17.09.18 20:17, Jan Kiszka wrote:
> > On 14.09.18 17:10, Henning Schild wrote: =20
> >> 4.14 is always eager, unfortunately we will need a few ifdefs
> >> inside the eager fpu support as well.
> >>
> >> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> >> ---
> >> =C2=A0 .../arch/x86/include/asm/xenomai/wrappers.h=C2=A0=C2=A0 |=C2=A0=
 4 ++++
> >> =C2=A0 kernel/cobalt/arch/x86/thread.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 21
> >> ++++++++++++++++++- 2 files changed, 24 insertions(+), 1
> >> deletion(-)
> >>
> >> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h=20
> >> b/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
> >> index a47730106..a4cc368a5 100644
> >> --- a/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
> >> +++ b/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
> >> @@ -32,6 +32,10 @@
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LINUX_VERSION_CODE < KERNEL_VERSION(4,5=
,0)
> >> =C2=A0 #define IPIPE_X86_FPU_EAGER
> >> =C2=A0 #endif
> >> +#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(4,14,0)
> >> +#define IPIPE_X86_FPU_EAGER
> >> +#endif
> >> +
> >> =C2=A0 #if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
> >> =C2=A0 #include <asm/i387.h>
> >> diff --git a/kernel/cobalt/arch/x86/thread.c
> >> b/kernel/cobalt/arch/x86/thread.c index 18cf636e5..2668ce274 100644
> >> --- a/kernel/cobalt/arch/x86/thread.c
> >> +++ b/kernel/cobalt/arch/x86/thread.c
> >> @@ -42,6 +42,7 @@ static struct kmem_cache *xstate_cache;
> >> =C2=A0 #define cpu_has_xsave boot_cpu_has(X86_FEATURE_XSAVE)
> >> =C2=A0 #endif
> >> +#ifndef IPIPE_X86_FPU_EAGER
> >> =C2=A0 #if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
> >> =C2=A0 #include <asm/i387.h>
> >> =C2=A0 #include <asm/fpu-internal.h>
> >> @@ -72,6 +73,9 @@ static inline void x86_fpregs_activate(struct
> >> task_struct *t) #define x86_xstate_alignment
> >> __alignof__(union fpregs_state) #endif
> >> +#else /* IPIPE_X86_FPU_EAGER */
> >> +#define x86_xstate_alignment=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 __alignof__(union
> >> fpregs_state) +#endif /* ! IPIPE_X86_FPU_EAGER */
> >> =C2=A0 #if LINUX_VERSION_CODE < KERNEL_VERSION(4,8,0)
> >> =C2=A0 /*
> >> @@ -465,9 +469,15 @@ void xnarch_leave_root(struct xnthread *root)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // save fpregs from in-kernel use
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 copy_fpregs_to_fpstate(rootcb->kfpu);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_fpu_enable();
> >> +#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(4,14,0)
> >> +=C2=A0=C2=A0=C2=A0 // restore current's fpregs
> >> +=C2=A0=C2=A0=C2=A0 __cpu_invalidate_fpregs_state();
> >> +=C2=A0=C2=A0=C2=A0 switch_fpu_finish(&current->thread.fpu, smp_proces=
sor_id());
> >> +#else
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // mark current thread as not owning th=
e FPU anymore
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (&current->thread.fpu.fpstate_active)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fpregs_deactiva=
te(&current->thread.fpu);
> >> +#endif
> >> =C2=A0 }
> >> =C2=A0 void xnarch_switch_fpu(struct xnthread *from, struct xnthread
> >> *to) @@ -528,7 +538,11 @@ void xnarch_init_shadow_tcb(struct
> >> xnthread *thread) #else /* IPIPE_X86_FPU_EAGER */
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* XNFPU is always set */
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xnthread_set_state(thread, XNFPU);
> >> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4,14,0)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fpu__activate_fpstate_read(&p->thread.f=
pu);
> >> +#else
> >> +=C2=A0=C2=A0=C2=A0 fpu__initialize(&p->thread.fpu);
> >> +#endif
> >> =C2=A0 #endif /* ! IPIPE_X86_FPU_EAGER */
> >> =C2=A0 }
> >> @@ -537,7 +551,12 @@ int mach_x86_thread_init(void)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xstate_cache =3D kmem_cache_create("cob=
alt_x86_xstate",
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fpu_kernel_=
xstate_size,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x86_xstate_=
alignment,
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SLAB_NOTRACK, NULL);
> >> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4,14,0)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SLAB_NOTRACK,
> >> +#else
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,
> >> +#endif
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (xstate_cache =3D=3D NULL)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
> >> =20
> >=20
> > Thanks, taken the whole series to next so that we can move forward.
> > I've just changed "//" (C++) style comments to "old-style" C.
> > Kernel style. Please avoid them in the future.
> >  =20

Sorry missed the // part of the review.

> Forgot: Did you happen to try the series with stable-3.0.x as well? I
> consider them relevant for that branch as well, so that users can
> update the kernel. But I plan to leave them in next until we have
> ipipe kernels available and tested them a bit broader.

Did not do that yet. I guess the ifdefs should all resolve to lazy-fpu,
making the series a no-op for lazy kernels. Will test against 4.9 and
4.4 and confirm that my guess is right.

Henning

> Jan
>=20


