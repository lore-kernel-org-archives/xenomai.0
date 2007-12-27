Message-ID: <4772EF89.4040101@domain.hid>
Date: Thu, 27 Dec 2007 01:19:21 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <477275E0.7080001@domain.hid> <4772D19C.4030506@domain.hid>
In-Reply-To: <4772D19C.4030506@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig96535136BB30FC5FE801E0F4"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [PATCH 3/3] i386: Cleanup root IRQ trampolines
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig96535136BB30FC5FE801E0F4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Simplifies xirq trampoline and applies the xirq refactorings to
>> virq_handler too.
>>
>=20
> --- linux-2.6.23.12-xeno.orig/include/asm-i386/ipipe.h
> +++ linux-2.6.23.12-xeno/include/asm-i386/ipipe.h
> @@ -141,11 +141,7 @@ __ipipe_call_root_xirq_handler(unsigned
>  		"pushl %%ds\n\t"
>  		"pushl %%eax\n\t"
>  		"pushl %%ebp\n\t"
> -		"pushl %%edi\n\t"
> -		"pushl %%esi\n\t"
> -		"pushl %%edx\n\t"
> -		"pushl %%ecx\n\t"
> -		"pushl %%ebx\n\t"
> +		"subl  $5*4,%%esp	# rest can remain unsaved\n\t"
>=20
> This won't work. We actually want to save our regs, so that they are
> restored when going back to xirq_end through the iret path. If we don't=

> save them, the registers will remain terminally clobbered.

General purpose registers aren't stable across functions calls. But it
is a valid question what the compiler assumes due to the function
inlining here. So declaring those five clobbered should be safe enough -
but if you prefer to add a few extra cycles for safety, keep it as
explicit as it was :->.

>=20
>  		"movl  %[regs],%%eax	# always pass tick regs\n\t"
>  		"call *%[handler]\n\t"
> @@ -158,33 +154,41 @@ __ipipe_call_root_xirq_handler(unsigned
>  		 : "eax");
>  }
>=20
> [snip]
>=20
> +static inline void
> +__ipipe_call_root_virq_handler(unsigned irq,
> +			       void (*handler)(unsigned irq, void *cookie),
> +			       void *cookie)
> +{
> +	irq_enter();
> +	__asm__ __volatile__ (
> +		"pushfl\n\t"
> +		"pushl %%cs\n\t"
> +		"pushl $virq_end\n\t"
> +		"pushl %%eax		# dummy value\n\t"
>=20
> We do want -1 to be pushed here, not any dummy value, so that the signa=
l
> handling code is not going to try restarting some interrupted syscall
> when running the Linux epilogue for us. This is consistent with having
> negated irq numbers pushed onto interrupt frames (see handle_signal and=

> friends).

Ah, ok, missed that path. Then we need the right irq number on the stack
of call_root_xirq_handler as well, for both archs.

>=20
> +		"pushl %%fs\n\t"
> +		"pushl %%es\n\t"
> +		"pushl %%ds\n\t"
> +		"pushl %%eax\n\t"
> +		"pushl %%ebp\n\t"
> +		"subl  $5*4,%%esp	# rest can remain unsaved\n\t"
> +
>=20
> Same problem as above.
>=20
> +		"pushl %[cookie]\n\t"
> +		"pushl %[irq]\n\t"
> +		"call *%[handler]\n\t"
>=20
> We need to conform both to regparm(0) and regparm(3) when passing args
> to the interrupt handler (i.e we don't know the convention used,
> especially by assembly code grabbing an IRQ), and regparm(3) is missing=

> now. C-written ones are likely to follow regparm(3) as the rest of the
> kernel unless they explicitly fiddle with compiler pragmas. We could ge=
t
> rid of regparm(0) in x86 code, requiring all handlers to conform to
> regparm(3), but not the other way around.

Previous code wasn't regparm(3)-safe (cookie should have been pinned to
edx then), so I don't see any new problem with this variant - unless we
were just very lucky before. Are you sure we need both here?

>=20
> +		"addl $8,%%esp\n\t" \
> +		 : /* no output */ \
> +		 : [irq] "rm" (irq), [handler] "rm" (handler),
> +		   [cookie] "rm" (cookie));
> +	irq_exit();
> +	__asm__ __volatile__ (
> +		"jmp ret_from_intr	# Linux IRQ epilogue\n\t"
> +		"virq_end: cli\n\t"
> +		 : /* no output */
> +		 : /* no input */);
> +}
>=20
> This said, the fix regarding CPU accounting is right, and passing the
> tick regs from the trampoline looks definitely saner than tweaking
> timer_interrupt() for the same purpose, so I'll merge that part.
>=20

Jan


--------------enig96535136BB30FC5FE801E0F4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHcu+NniDOoMHTA+kRAgT7AJ9HUNFobeF0/WK/OItqDc88l1HndACeP90h
wX3Meqf5QuChw+z+jq99zcc=
=uIPT
-----END PGP SIGNATURE-----

--------------enig96535136BB30FC5FE801E0F4--

