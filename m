Message-ID: <47782A6F.2060607@domain.hid>
Date: Mon, 31 Dec 2007 00:31:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4776D48E.7050002@domain.hid> <4777785F.2030903@domain.hid>
	<4777D22A.1090805@domain.hid> <4777F7CA.3000305@domain.hid>
In-Reply-To: <4777F7CA.3000305@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEB3052FFE8170F5DD7D9303C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [PATCH 4/5] remove legacy code
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
--------------enigEB3052FFE8170F5DD7D9303C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> Jan Kiszka wrote:
>>>> This patch gets rid of code that is no longer needed or valid:
>>>>
>>>>  - x86_64 APIC frequency is now delivered via ipipe_request_tickdev
>>> Ack.
>>>
>>>>  - __ipipe_tick_irq is maintained via ipipe_update_tick_evtdev also =
on
>>>>    x86_64
>>> Client RTOS may/do assume that timing is always delivered through the=

>>> local APIC timer on x86_64. We could merge that and allow the 8253 to=
 be
>>> used as the timer device, but this would not work in practice.
>> For forget HPET. There is no wiring of the timer IRQ to the APIC
>> anymore.
>=20
> My point is that whatever timer IRQs the kernel routes to INT0, be them=

> from the HPET in legacy route replacement mode or from the i8253 with
> some former routing, we currently rely on the local APIC timer vector.
> No matter what, HPET it's just unsupported by Xenomai right now, so we
> can't see any IRQ0 registered as our tick device interrupt.

__ipipe_tick_irq, as it is used now, is reflecting Linux' tick IRQ, not
necessarily the one that Xenomai prefers.

>=20
> If your point is about allowing HPET to be used, then your patch
> currently expects the HPET to be used in legacy replacement route mode,=

> which is no more the default setup. In short, TIMER_IRQ may not be the

static struct clock_event_device hpet_clockevent =3D {
=2E..
        .irq            =3D 0,

which is TIMER_IRQ.

> right -constant- value in the common case.
>=20
>  The result is that there is no difference between x86_32 and
>> x86_64 anymore, and that's what the code reflects.
>>
>> If the client RTOS is not yet fully prepared for this, this has to be
>> fixed. And only if there is no valid Linux configuration (e.g. HPET of=
f)
>> that results in the same timer assignment as with 2.6.23, we need a
>> workaround at I-pipe level IMHO.
>>
>=20
> Again, I see no basic issue in merging that patch, but the message is:
> Xenomai still has to support more timer devices than the local APIC one=

> on x86_64 (e.g. HPET), before this patch has any real upside for it. In=

> short, it's ok with me, but I feel that we are still half-way from the
> complete support.

As long as the APIC is available to Xenomai, we should no longer worry
about Linux using some other clockevent device. At least in theory. But
I will carefully check again during this week if there are any
regressions or .config limitation related to these hunks.

Jan


--------------enigEB3052FFE8170F5DD7D9303C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHeCp3niDOoMHTA+kRAhYXAJ9GxX8e0z7KNF1MOkCbUrs1AphxHgCfSm9X
0gRfDjTzo4r19itk5SkEBRA=
=gwxH
-----END PGP SIGNATURE-----

--------------enigEB3052FFE8170F5DD7D9303C--

