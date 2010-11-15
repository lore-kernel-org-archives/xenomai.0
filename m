Message-ID: <4CE18FDF.4010700@domain.hid>
Date: Mon, 15 Nov 2010 20:54:07 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CE18A9F.5030007@domain.hid>
In-Reply-To: <4CE18A9F.5030007@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC230C0D00F633EBD25B8982C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] Flaw in x86-32 syscall/irq return path - and maybe
 more
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC230C0D00F633EBD25B8982C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 15.11.2010 20:31, Jan Kiszka wrote:
> Hi Philippe,
>=20
> debugging some variant of I-pipe over an x86-32 target, I think I found=

> some fairly old flaw in the IRQ virtualization that causes rescheduling=

> delays (up to deadlocks) for Linux:
>=20
> - we are in sysenter_tail (other exit paths should be affected as well)=

> - we DISABLE_INTERRUPTS, but only virtually
> - we go past "testl $_TIF_ALLWORK_MASK, %ecx", nothing to be done
> - an IRQ for Linux arrives, it is pushed to the backlog
> - __ipipe_unstall_iret_root replays the IRQ as the regs we are about to=

>   return to have IF set (obviously, we return from a syscall)
> - the Linux IRQ handler sets _TIF_NEED_RESCHED, but doesn't perform the=

>   work on return as __ipipe_sync_stage set the stall flag for the Linux=

>   domain before calling the handler
> - but now the preempted sysenter return also does no reschedule as it
>   already passed the check - bang!
>=20
> Another variant of this Linux rescheduling issue:
>=20
> - we are in a lengthy loop inside the kernel, but we are preemptible
>   most of the time
> - after disabling Linux IRQs briefly, we are calling
>   local_irq_enable() again
> - in the meantime, we received a Linux IRQ which is now pending in the
>   backlog
> - __ipipe_unstall_root triggers __ipipe_sync_stage
> - Linux handler is called, sets NEED_RESCHED but does not reschedule
>   (see above)
> - we do not test for resched again as we are not returning to user
>   space, and that for quite some time - bang!

And this one actually affects x86-64 as well: Here, ret_from_intr checks
for NEED_RESCHED only if IF is set in the flags of the preempted
context. But if the Linux domain is alone, we enter __ipipe_do_root_xirq
with hard IRQs disabled, thus we push this information incorrectly on
the Linux handler stack, preventing the required rescheduling check.

I guess the simplest fix for this is to drop the
"!__ipipe_pipeline_head_p(ipd)" check from __ipipe_sync_stage.

>=20
> I think both issues are only related to virtualizing DISABLE_INTERRUPTS=

> for entry_32.S and I wonder if this doesn't finally qualify for a switc=
h
> to the 64-bit model. Or do you see simpler fixes?
>=20

Jan


--------------enigC230C0D00F633EBD25B8982C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkzhj+MACgkQitSsb3rl5xTruACfcwi803Q2z7PKRt845Ce8k5Xn
zqQAoL3ct/cH8aQssajg0nIQf2yPhPsc
=Uaem
-----END PGP SIGNATURE-----

--------------enigC230C0D00F633EBD25B8982C--

