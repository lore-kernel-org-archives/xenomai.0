Message-ID: <4BC1FAC9.5040904@domain.hid>
Date: Sun, 11 Apr 2010 18:37:29 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B9A0C25.5010602@domain.hid>
In-Reply-To: <4B9A0C25.5010602@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAC612F268ADF433E11954A0E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [pull request] x86: Fix up regs unconditionally on
	exceptions
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAC612F268ADF433E11954A0E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> The following changes since commit 14023bef1806dd640030d3eaf73c26736345=
bc30:
>   Philippe Gerum (1):
>         ipipe-2.6.32.7-x86-2.6-01
>=20
> are available in the git repository at:
>=20
>   git://git.kiszka.org/ipipe-2.6 queues/2.6.32-x86
>=20
> Found while making KVM work over I-pipe/Xenomai. Its hardware
> activation code triggered a planned #GP in IRQ context.
>=20
>=20
> Jan Kiszka (1):
>       x86: Fix up regs unconditionally on exceptions
>=20
>  arch/x86/kernel/ipipe.c |   24 +++++++++++++-----------
>  1 files changed, 13 insertions(+), 11 deletions(-)
>=20
> ------
>=20
> x86: Fix up regs unconditionally on exceptions
>=20
> Some Linux exception handlers - at least do_general_protection -
> evaluate regs->flags, and that on both x86-32 and -64. So we should fix=

> up the flags according to the pipeline state unconditionally.

Forgotten or intentionally skipped for 2.6-02?

Hmm, I see that even the fixed-up comment in __ipipe_handle_exception is
not correct anymore. I can push an updated version if you're fine with
picking this up.

Jan

>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> ---
>  arch/x86/kernel/ipipe.c |   24 +++++++++++++-----------
>  1 files changed, 13 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
> index 36cd591..dfb76ad 100644
> --- a/arch/x86/kernel/ipipe.c
> +++ b/arch/x86/kernel/ipipe.c
> @@ -495,8 +495,6 @@ out:
>  	local_irq_restore_hw(flags);
>  }
> =20
> -#ifdef CONFIG_X86_32
> -
>  static inline void __fixup_if(int s, struct pt_regs *regs)
>  {
>  	/*
> @@ -510,6 +508,8 @@ static inline void __fixup_if(int s, struct pt_regs=
 *regs)
>  		regs->flags |=3D X86_EFLAGS_IF;
>  }
> =20
> +#ifdef CONFIG_X86_32
> +
>  /*
>   * Check the stall bit of the root domain to make sure the existing
>   * preemption opportunity upon in-kernel resumption could be
> @@ -571,10 +571,6 @@ asmlinkage void __ipipe_unstall_iret_root(struct p=
t_regs regs)
> =20
>  #else /* !CONFIG_X86_32 */
> =20
> -static inline void __fixup_if(int s, struct pt_regs *regs)
> -{
> -}
> -
>  #ifdef CONFIG_PREEMPT
> =20
>  asmlinkage void preempt_schedule_irq(void);
> @@ -746,11 +742,11 @@ int __ipipe_handle_exception(struct pt_regs *regs=
, long error_code, int vector)
> =20
>  	if (likely(ipipe_root_domain_p)) {
>  		/*
> -		 * 32-bit: In case we faulted in the iret path, regs.flags do
> -		 * not match the root domain state as the low-level return
> -		 * code will evaluate it. Fix this up, either by the root
> -		 * state sampled on entry or, if we migrated to root, with the
> -		 * current state.
> +		 * In case we faulted in the iret path, regs.flags do not
> +		 * match the root domain state. The fault handler or the
> +		 * low-level return code may evaluate it. Fix this up, either
> +		 * by the root state sampled on entry or, if we migrated to
> +		 * root, with the current state.
>  		 */
>  		__fixup_if(root_entry ? raw_irqs_disabled_flags(flags) :
>  					raw_irqs_disabled(), regs);
> @@ -876,7 +872,13 @@ int __ipipe_syscall_root(struct pt_regs *regs)
> =20
>  	local_irq_save_hw(flags);
>  	p =3D ipipe_root_cpudom_ptr();
> +#ifdef CONFIG_X86_32
> +	/*
> +	 * Fix-up only required on 32-bit as only here the IRET return code
> +	 * will evaluate the flags.
> +	 */
>  	__fixup_if(test_bit(IPIPE_STALL_FLAG, &p->status), regs);
> +#endif
>  	/*
>  	 * If allowed, sync pending VIRQs before _TIF_NEED_RESCHED is
>  	 * tested.



--------------enigAC612F268ADF433E11954A0E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvB+s0ACgkQitSsb3rl5xTzWwCg01fcw7i7E8Su8XwS9h/jDQfA
b1MAn35J8vU+wCDVN6fUoFrfMYEH9pYA
=Xr+f
-----END PGP SIGNATURE-----

--------------enigAC612F268ADF433E11954A0E--

