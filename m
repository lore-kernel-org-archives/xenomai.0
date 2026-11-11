Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.178.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438671;
	b=Hqt/qSVzdlmJftxzkJvvrEeGoV5QT/GYULJx1BSU2UIQUtoxOT0MEJrKZG94YdhGIcYx
	 w6dH5PQRyf+yKJ4MT72l/BJRaq1LognkIiX/PEzCIIebcagbMRWgzHq0iuNnGvOQejzwF
	 aG8ORvBIk203rPbinnbRnoImT+FVAsivu2XzrlpOoh0ZJvB361zCukZAI5sdY7jAcovgl
	 7xM5wy4VrRm6YrbRkq2X6eB+hAaaeybExFrIveM5rHEgstYxkyEo98qVX+GMlNI2V3ram
	 3I7gbQ85Wk+p7ZgnWioeBGRSuXT6HuoEM314Nuk8wBWV4+zCTrkVqp66hsYE4M5STsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438671;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Subject:From:To:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Flowmailer-Platform:
	 Feedback-ID:X-GND-Cause:X-GND-State:X-GND-Score;
	bh=hkzprzQY/zuR03tIYCNX/ri8xnVmnja0q4in5ycfd30=;
	b=Z01eT5dC1D2ARtFnkGGit8A4y0OumPvLIJb03sEr603baazDbmXdSFrXu6vRH41znJnB
	 Hn9sHFYb79Yq4JiWae1juqN1bNE2Oi5QrmeZiTJXtt4+zHBz6st12ea4tC0PUug575kAr
	 GBsAd6eyBxmSojOQRLuXW12RlZYna/gY/LFMGLHrXsxQ7NCgJdEOJJIa4HtXBdTNhsXaB
	 dzLHeFiJKlQJMM1nCDiKHrIx1jJ9IpLUrRjiSfM6h0Bujxvq26Qu2dgoa9ueb3unpY6kZ
	 Ef6f4o/V/3IUfKWs0et3giHUrLOyRJHSJj4Z4Tblopl8WmyvEJ8lyPTopw4lltZ9+qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=GYTwi4nm;
	arc=none smtp.remote-ip=217.70.178.231
Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66205606A331
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 23:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66205606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=GYTwi4nm
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id A3AB83ECC6
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 23:11:07 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 4827427E02B0
	for <xenomai@xenomai.org>; Wed, 11 Nov 2026 23:11:07 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=GYTwi4nm;
	spf=pass (spool.mail.gandi.net: domain of fm-68982-202611112311062bf6983d4f000207e6-B2A8u8@rts-flowmailer.siemens.com designates 185.136.65.225 as permitted sender) smtp.mailfrom=fm-68982-202611112311062bf6983d4f000207e6-B2A8u8@rts-flowmailer.siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202611112311062bf6983d4f000207e6
        for <xenomai@xenomai.org>;
        Thu, 12 Nov 2026 00:11:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=hkzprzQY/zuR03tIYCNX/ri8xnVmnja0q4in5ycfd30=;
 b=GYTwi4nmKZj8lm64j4HrTlj2eDDywapj7axZ8WDoy3aBTqoQRGOyrbUEKgBKrKHB5VWNB4
 rzO/t8ajcdneu7Fb+1VzCiiK3yQ/E0JfUAwsKx8lTvrNf1bPE4UxIc4DyK60YNcoi3frvoaP
 UT6ZgVvrohwVCiA1FMZf9MBm64llFnXeLSleniuQ/qadnSCQrt9K3DI+0rR+pltrG0MSHnON
 cth4awu5aGXXdiZsNV3gl3Zip9L6hiIOJqRow/9/Ot3vRx+am6Rb6NKl1RgyzW++pN02t0CM
 zYkrkOYUDRAwzn5H6zt4d7A7QFro8FQ52+biBuIEpLOAnaecXxEjA/Hg==;
Message-ID: <832e3282601842e8f6f620e9c29d0717127efc9d.camel@siemens.com>
Subject: Re: [dovetail][PATCH v2 1/4] dovetail: Track the owner of a trap
 notification by exception frame
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
	xenomai@xenomai.org
Date: Thu, 12 Nov 2026 00:11:05 +0100
In-Reply-To: <d40c9a22e1e450a83533ef7d781f88010c2aacc6.1794399047.git.jan.kiszka@siemens.com>
References: <cover.1794399047.git.jan.kiszka@siemens.com>
	 <d40c9a22e1e450a83533ef7d781f88010c2aacc6.1794399047.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
X-GND-Cause: dmFkZTFNZeWru/RQkNzxuXm4rNGb3NispXudv0Vh1JzDT06E0NLSXFdpUD8WqAc9Wh2rhcYKzILRWefNMSFduYT94GYFOcqauJue4c2w5JGVWHg7eb1wZkByvQDYbbZ5akoU8WNe8OO9WfZOWlN3Nw7POa/RWWupXURuYKjOM5kCSeDsneJkLgwWXovArzVHCOV9u0P0dNNqUyvfqLaoS9zaftfmA306WjkhuoaVQyx/RFMFFeb2tUkflZePk1czguigDi14iDv2ASbEcTFB+qOaZnw0kkRsE8ejZl0YR8/UUhZoPxpjJRvxQNCubdv84eKiaNeBWdoDg0oLKOjp+l+qDyrvVzgcHD/Kz/ylBMAnjxr/PHBkLz77XFBjv45UeDYKXPKtJHV9NvypbFXXHqrZjOijWQ/IBbkjIVFiNBEYGARLbpg+UBJXAEMwN8gVWXbo352W28ITOsyn9ZB39cKkl6FMke9yPZpIUSyFh2SRVpQ6OHFb9DBlkOxrmFi131o8LGqwR+vRbWKyg+Lqh8Pw7OFq1gQOoFkewxLkWPU/NuEIlyXVZcMCdoK56fy+hACASTf+ixmxpKxO1ms3d4W22fb0E59+mkhFDVJBaNWUsKMnhyai6opQ+tt4YRcNg1AXDjiycO7T7FwPnLG50C2JGZJvrhFWA6MfaR9jxB7S6cSrxw
X-GND-State: clean
X-GND-Score: -100

On Wed, 2026-11-11 at 13:10 +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> Trap notifications are guarded by _TLF_OOBTRAP: oob_trap_notify() only
> calls into the companion core if the flag is clear, and sets it;
> oob_trap_unwind() calls the exit handler and clears the flag whenever
> it is set.
>=20
> This does not cope with nested traps. A trap handler running on behalf
> of an oob thread may trigger another trap before it reaches its own
> exit annotation, e.g. a user access from an emulation handler faulting
> in a not yet resident page on ARM:
>=20
>   do_alignment()                      <- notify, _TLF_OOBTRAP set
>     do_alignment_ldmstm()
>       ldrt/strt to user address       <- translation fault (SVC mode)
>         do_DataAbort()
>           do_page_fault()
>             dovetail_fault_entry()    <- notify suppressed, fine
>             handle_mm_fault()
>             dovetail_fault_exit()     <- unwind fires: wrong trap number,
>                                          wrong frame, and the core may
>                                          switch us back to oob
>     ...emulation continues oob...
>   dovetail_fault_exit()               <- no-op, flag already clear
>=20
> Since _TLF_OOBTRAP is per-thread and the thread does not change across
> nesting levels, the flag alone cannot tell which trap occurrence owns
> the notification. The exception frame can: every nesting level pushes
> its own pt_regs on the kernel stack, and the frame is already passed
> to both the notify and unwind helpers.
>=20
> Record the owning frame in the task struct when notifying, and only
> unwind when the frame passed to oob_trap_unwind() matches. Inner trap
> exits become no-ops, the outer exit unwinds with the trap number and
> frame the core was notified with. oob_trap_regs can in fact encode the
> semantic of the _TLF_OOBTRAP flag, thus drop it.

struct task_struct is also per-thread. The migrating from thread_info to
task_struct for bookkeeping makes the implementation arch independent.
Which is nice, but not mentioned here.

The implementation looks sane.

>=20
> A forking parent can never be inside a trap handler, so neither the
> flag nor the owner frame can legitimately be set when a new task
> inherits its state. Add a debug assertion for this in
> inband_task_init(), which turns an unbalanced trap entry into a
> loud warning on the next fork instead of silently propagating the
> stuck state to the children.
>=20
> Assisted-by: opencode:Fable-5.1
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/arm/include/asm/thread_info.h   |  1 -
>  arch/arm64/include/asm/thread_info.h |  1 -
>  arch/riscv/include/asm/thread_info.h |  1 -
>  arch/x86/include/asm/thread_info.h   |  2 --
>  include/linux/dovetail.h             | 12 ++++++++++--
>  include/linux/sched.h                |  5 +++++
>  kernel/dovetail.c                    | 10 ++++++++--
>  7 files changed, 23 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/th=
read_info.h
> index 23cae59037c1e..12ab7e49b7b76 100644
> --- a/arch/arm/include/asm/thread_info.h
> +++ b/arch/arm/include/asm/thread_info.h
> @@ -196,7 +196,6 @@ extern int vfp_restore_user_hwstate(struct user_vfp *=
,
>  #define _TLF_OOB=09=090x0001
>  #define _TLF_DOVETAIL=09=090x0002
>  #define _TLF_OFFSTAGE=09=090x0004
> -#define _TLF_OOBTRAP=09=090x0008
> =20
>  #endif /* __KERNEL__ */
>  #endif /* __ASM_ARM_THREAD_INFO_H */
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/as=
m/thread_info.h
> index 48563d782a99a..934b080246146 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -144,7 +144,6 @@ void arch_setup_new_exec(void);
>  #define _TLF_OOB=09=09=090x0001
>  #define _TLF_DOVETAIL=09=09=090x0002
>  #define _TLF_OFFSTAGE=09=09=090x0004
> -#define _TLF_OOBTRAP=09=09=090x0008
>  #define _TLF_KERNEL_FPU_PREEMPTED=090x0010=09/* Dovetail: kernel mode FP=
SIMD section preempted by OOB */
> =20
>  #endif /* __ASM_THREAD_INFO_H */
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/as=
m/thread_info.h
> index 820a596d9bf65..11164e12317fa 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -140,6 +140,5 @@ int arch_dup_task_struct(struct task_struct *dst, str=
uct task_struct *src);
>  #define _TLF_OOB=09=090x0001
>  #define _TLF_DOVETAIL=09=090x0002
>  #define _TLF_OFFSTAGE=09=090x0004
> -#define _TLF_OOBTRAP=09=090x0008
> =20
>  #endif /* _ASM_RISCV_THREAD_INFO_H */
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/th=
read_info.h
> index 6da425bc87712..0c9cdf60e3f12 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -218,13 +218,11 @@ static inline int arch_within_stack_frames(const vo=
id * const stack,
>  #define TS_OOB=09=09=090x0010=09/* Thread is running out-of-band */
>  #define TS_DOVETAIL=09=090x0020  /* Dovetail notifier enabled */
>  #define TS_OFFSTAGE=09=090x0040=09/* Thread is in-flight to OOB context =
*/
> -#define TS_OOBTRAP=09=090x0080=09/* Handling a trap from OOB context */
>  #define TS_KERNEL_FPU_PREEMPTED=090x0100=09/* Dovetail: kernel mode FPU =
section preempted by OOB */
> =20
>  #define _TLF_OOB=09=09=09TS_OOB
>  #define _TLF_DOVETAIL=09=09=09TS_DOVETAIL
>  #define _TLF_OFFSTAGE=09=09=09TS_OFFSTAGE
> -#define _TLF_OOBTRAP=09=09=09TS_OOBTRAP
>  #define _TLF_KERNEL_FPU_PREEMPTED=09TS_KERNEL_FPU_PREEMPTED
> =20
>  #ifndef __ASSEMBLER__
> diff --git a/include/linux/dovetail.h b/include/linux/dovetail.h
> index 1140c5b7c99f3..645d1eec32aa6 100644
> --- a/include/linux/dovetail.h
> +++ b/include/linux/dovetail.h
> @@ -62,10 +62,18 @@ int pipeline_syscall(unsigned int nr, struct pt_regs =
*regs);
>  void __oob_trap_notify(unsigned int exception,
>  =09=09       struct pt_regs *regs);
> =20
> +/*
> + * Trap notifications do not nest: a trap handler running on behalf
> + * of an oob thread may itself trigger a fault (e.g. a user access
> + * from an emulation handler), landing into another annotated trap
> + * handler. Only the outermost trap occurrence notifies the companion
> + * core, which is told about the exit when that same occurrence
> + * unwinds.
> + */
>  static __always_inline void oob_trap_notify(unsigned int exception,
>  =09=09=09=09=09struct pt_regs *regs)
>  {
> -=09if (running_oob() && !test_thread_local_flags(_TLF_OOBTRAP))
> +=09if (running_oob() && !current->oob_trap_regs)
>  =09=09__oob_trap_notify(exception, regs);
>  }
> =20
> @@ -75,7 +83,7 @@ void __oob_trap_unwind(unsigned int exception,
>  static __always_inline void oob_trap_unwind(unsigned int exception,
>  =09=09=09=09=09struct pt_regs *regs)
>  {
> -=09if (test_thread_local_flags(_TLF_OOBTRAP))
> +=09if (current->oob_trap_regs =3D=3D regs)
>  =09=09__oob_trap_unwind(exception, regs);
>  }
> =20
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index c4291b7f7b6ea..3012926e8e355 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -74,6 +74,7 @@ struct perf_event_context;
>  struct perf_ctx_data;
>  struct pid_namespace;
>  struct pipe_inode_info;
> +struct pt_regs;
>  struct rcu_node;
>  struct reclaim_state;
>  struct root_domain;
> @@ -1302,6 +1303,10 @@ struct task_struct {
>  #ifdef CONFIG_IRQ_PIPELINE
>  =09unsigned long=09=09=09stall_bits;
>  #endif
> +#ifdef CONFIG_DOVETAIL
> +=09/* Exception frame owning the pending oob trap notification. */
> +=09struct pt_regs=09=09=09*oob_trap_regs;
> +#endif
> =20
>  #ifdef CONFIG_LOCKDEP
>  # define MAX_LOCK_DEPTH=09=09=0948UL
> diff --git a/kernel/dovetail.c b/kernel/dovetail.c
> index 16ac66e4529f5..f196a9815dabd 100644
> --- a/kernel/dovetail.c
> +++ b/kernel/dovetail.c
> @@ -22,6 +22,12 @@ void inband_task_init(struct task_struct *p)
>  {
>  =09struct thread_info *ti =3D task_thread_info(p);
> =20
> +=09/*
> +=09 * A forking parent cannot be inside a trap handler. If oob_trap_regs
> +=09 * is non-NULL, some trap entry was not balanced by a matching exit.
> +=09 */
> +=09WARN_ON_ONCE(dovetail_debug() && p->oob_trap_regs);
> +
>  =09clear_ti_local_flags(ti, _TLF_DOVETAIL|_TLF_OOB|_TLF_OFFSTAGE);
>  =09arch_inband_task_init(p);
>  }
> @@ -284,7 +290,7 @@ noinstr void __oob_trap_notify(unsigned int exception=
,
>  =09 * to the in-band stage, may return with hard irqs on.
>  =09 */
>  =09if (dovetail_enabled) {
> -=09=09set_thread_local_flags(_TLF_OOBTRAP);
> +=09=09current->oob_trap_regs =3D regs;
>  =09=09flags =3D hard_local_irq_save();
>  =09=09instrumentation_begin();
>  =09=09handle_oob_trap_entry(exception, regs);
> @@ -306,7 +312,7 @@ noinstr void __oob_trap_unwind(unsigned int exception=
, struct pt_regs *regs)
>  =09 * stage. Must return with hard irqs off.
>  =09 */
>  =09hard_local_irq_disable();
> -=09clear_thread_local_flags(_TLF_OOBTRAP);
> +=09current->oob_trap_regs =3D NULL;
>  =09instrumentation_begin();
>  =09handle_oob_trap_exit(exception, regs);
>  =09instrumentation_end();
> --=20
> 2.47.3
