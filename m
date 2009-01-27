Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Jan 2009 11:28:36 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A017A39A7@domain.hid>
In-Reply-To: <497DE125.5020402@domain.hid>
From: <roderik.wildenburg@domain.hid>
Subject: Re: [Xenomai-help] fpu issue on PPC ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

As you certainly allready know, we are facing some FPU problems on PPC =
(2.4 Kernel) too (switchtest reports inconsistent FPU-register; our =
application crashs with FPU-exception or shows sometimes unreasonable =
FP-values).=20
Is the solution you found for i386 applicable for PPC too (does the =
issue, you described, apply to PPC too) ?

Roderik


> -----Urspr=FCngliche Nachricht-----
> Von: xenomai-help-bounces@domain.hid
> [mailto:xenomai-help-bounces@domain.hid] Im Auftrag von Gilles=20
> Chanteperdrix
> Gesendet: Montag, 26. Januar 2009 17:13
> An: Steven Seeger
> Cc: xenomai@xenomai.org; Adeos
> Betreff: Re: [Xenomai-help] fpu issue
>=20
> Steven Seeger wrote:
> > It is being called a lot. Running my test with the break in=20
> both loops
> > yields approximately 60 calls to it. Half of those are called even
> > before i387.c's init_fpu().
>=20
> For the records: we found a solution to this FPU issue. The issue was
> two-fold:
> - when xenomai was preempting some linux kernel code which has called
> kernel_fpu_begin, it was saving the current FPU context over=20
> the current
> thread user-space FPU backup area, erasing its value=20
> previously saved by
> kernel_fpu_begin();
> - xenomai could preempt the linux kernel anywhere within the
> kernel_fpu_begin function, which caused it to observe an incoherent
> state (namely incoherent values of
> current_thread_info()->status & TS_USEDFPU and TS bit in CR0).
>=20
> These issues were easy to observe on Geode, because Linux on these
> processors use MMX, thus kernel_fpu_begin routinely.
>=20
> So, the following patch should be integrated into the I-pipe patch:
>=20
> diff --git a/include/asm-x86/i387.h b/include/asm-x86/i387.h
> index 56d00e3..e850fa1 100644
> --- a/include/asm-x86/i387.h
> +++ b/include/asm-x86/i387.h
> @@ -222,11 +222,14 @@ static inline void __clear_fpu(struct=20
> task_struct
> *tsk)
>  static inline void kernel_fpu_begin(void)
>  {
>  	struct thread_info *me =3D current_thread_info();
> +	unsigned long flags;
>  	preempt_disable();
> +	local_irq_save_hw_cond(flags);
>  	if (me->status & TS_USEDFPU)
>  		__save_init_fpu(me->task);
>  	else
>  		clts();
> +	local_irq_restore_hw_cond(flags);
>  }
>=20
>  static inline void kernel_fpu_end(void)
>=20
>=20
> And the following patch should be applied to Xenomai:
>=20
> Index: include/asm-x86/bits/pod_32.h
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- include/asm-x86/bits/pod_32.h	(revision 4572)
> +++ include/asm-x86/bits/pod_32.h	(working copy)
> @@ -63,7 +63,12 @@ static inline void xnarch_leave_root(xna
>  	rootcb->ts_usedfpu =3D wrap_test_fpu_used(current) !=3D 0;
>  	rootcb->cr0_ts =3D (read_cr0() & 8) !=3D 0;
>  	/* So that xnarch_save_fpu() will operate on the right=20
> FPU area. */
> -	rootcb->fpup =3D x86_fpustate_ptr(&rootcb->user_task->thread);
> +	if (rootcb->cr0_ts || rootcb->ts_usedfpu)
> +		rootcb->fpup =3D=20
> x86_fpustate_ptr(&rootcb->user_task->thread);
> +	else
> +		/* the kernel is currently using fpu in=20
> kernel-space, do not
> +		   clobber the user-space fpu backup area. */
> +		rootcb->fpup =3D &rootcb->i387;
>  }
>=20
>  #define xnarch_enter_root(rootcb)  do { } while(0)
>=20
>=20
>=20
>=20
>=20
> --=20
>                                                  Gilles.
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

