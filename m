Message-ID: <4CE1B213.9000407@domain.hid>
Date: Mon, 15 Nov 2010 23:20:03 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CE18A9F.5030007@domain.hid> <1289852437.1933.173.camel@domain.hid>
In-Reply-To: <1289852437.1933.173.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8D6CF2F11CB38164670E7998"
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
--------------enig8D6CF2F11CB38164670E7998
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 15.11.2010 21:20, Philippe Gerum wrote:
> On Mon, 2010-11-15 at 20:31 +0100, Jan Kiszka wrote:
>> Hi Philippe,
>>
>> debugging some variant of I-pipe over an x86-32 target, I think I foun=
d
>> some fairly old flaw in the IRQ virtualization that causes reschedulin=
g
>> delays (up to deadlocks) for Linux:
>>
>> - we are in sysenter_tail (other exit paths should be affected as well=
)
>> - we DISABLE_INTERRUPTS, but only virtually
>> - we go past "testl $_TIF_ALLWORK_MASK, %ecx", nothing to be done
>> - an IRQ for Linux arrives, it is pushed to the backlog
>> - __ipipe_unstall_iret_root replays the IRQ as the regs we are about t=
o
>>   return to have IF set (obviously, we return from a syscall)
>> - the Linux IRQ handler sets _TIF_NEED_RESCHED, but doesn't perform th=
e
>>   work on return as __ipipe_sync_stage set the stall flag for the Linu=
x
>>   domain before calling the handler
>> - but now the preempted sysenter return also does no reschedule as it
>>   already passed the check - bang!
>=20
> Ouch. You must have had a really busy Monday to find this one.
>=20
>>
>> Another variant of this Linux rescheduling issue:
>>
>> - we are in a lengthy loop inside the kernel, but we are preemptible
>>   most of the time
>> - after disabling Linux IRQs briefly, we are calling
>>   local_irq_enable() again
>> - in the meantime, we received a Linux IRQ which is now pending in the=

>>   backlog
>> - __ipipe_unstall_root triggers __ipipe_sync_stage
>> - Linux handler is called, sets NEED_RESCHED but does not reschedule
>>   (see above)
>> - we do not test for resched again as we are not returning to user
>>   space, and that for quite some time - bang!
>>
>> I think both issues are only related to virtualizing DISABLE_INTERRUPT=
S
>> for entry_32.S and I wonder if this doesn't finally qualify for a swit=
ch
>> to the 64-bit model. Or do you see simpler fixes?
>>
>=20
> We could probably use hw masking from sysenter_tail and on, but quite
> frankly, I think this time, enough is enough and this bug calls for a
> radical fix, which is indeed getting rid of interrupt virtualization in=

> the kernel entry/exit paths for x86_32, which no other arch ever
> implemented anyway.
>=20
> The decision to virtualize there as well was taken circa 2.4.18, when
> upstream did not care that much about latency yet. Things have changed,=

> and there is no more reason to virtualize interrupts in very short
> critical sections, at the expense of a lot more complexity.
>=20
> - __ipipe_unstall_iret_root
> - __ipipe_kpreempt_root
> and much of the nonsense we do to track linux's interrupt state would g=
o
> away.
>=20

Much involved code is shared here, so I will check with $customer if and
how we can contribute to such a cleanup.

Jan


--------------enig8D6CF2F11CB38164670E7998
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkzhshMACgkQitSsb3rl5xR/mwCgkvRhK7COZel/NyxkEo27+TN+
zfQAnAqIvQdVmoz8U8ddzYzTS+fpbieY
=wr1S
-----END PGP SIGNATURE-----

--------------enig8D6CF2F11CB38164670E7998--

