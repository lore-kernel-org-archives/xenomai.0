Message-ID: <44FF0FC5.1040306@domain.hid>
Date: Wed, 06 Sep 2006 20:13:25 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <44FD7463.7010601@domain.hid> <44FD9F92.4050802@domain.hid>	
	<b647ffbd0609051210p26c56690oe7b332190b3b702e@domain.hid>	
	<44FE6C55.1030900@domain.hid>	
	<b647ffbd0609060159q7677cd30y80208afc58caf17@domain.hid>	
	<44FE943F.9000803@domain.hid>	
	<b647ffbd0609060527o13a077f4ue1fd1b445b1379c7@domain.hid>	
	<44FEE10F.5030208@domain.hid>	
	<b647ffbd0609060808y11d7fd8eg99aee190da05a847@domain.hid>	
	<44FEEF50.2070407@domain.hid>
	<b647ffbd0609061023u7b9aace9i464e9700dee58627@domain.hid>
In-Reply-To: <b647ffbd0609061023u7b9aace9i464e9700dee58627@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig69D6009F1C87D1C61E5C0068"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: Move rtdm_irq_enable close to rtdm_irq_request
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig69D6009F1C87D1C61E5C0068
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> On 06/09/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>
>> Dmitry Adamushko wrote:
>=20
>=20
>=20
>=20
>> -menu "Shared interrupts"
>> >> +menuconfig XENO_OPT_SHIRQ
>> >> +       bool "Shared interrupts"
>> >>
>> >> config XENO_OPT_SHIRQ_LEVEL
>> >>         bool "Level-triggered interrupts"
>> >> -       default n
>> >> +       depends on XENO_OPT_SHIRQ
>> >> +       default y
>> >>         help
>> >> -
>> >> +
>> >>         Enables support for shared level-triggered interrupts, so t=
hat
>> >>         multiple real-time interrupt handlers are allowed to contro=
l
>> >>         dedicated hardware devices which are configured to share
>> >> @@ -369,7 +371,8 @@ config XENO_OPT_SHIRQ_LEVEL
>> >>
>> >> config XENO_OPT_SHIRQ_EDGE
>> >>         bool "Edge-triggered interrupts"
>> >> -       default n
>> >> +       depends on XENO_OPT_SHIRQ
>> >> +       default y
>> >>         help
>> >
>> >
>> > So a user may end up with XENO_OPT_SHIRQ being enabled while both LE=
VEL
>> and
>> > EDGE are disabled? Maybe it's worth to make LEVEL "y" by default as
>> it's
>> > likely to be a required option?
>> >
>>
>> Do you see the "default y" above, no? :)
>=20
>=20
> Arghhh, again... nop, I bet it was not there before! How did you manage=
 to
> hack my gmail account? :)

"Don't comment", my lawyer always says.

>=20
> I thought about making only XENO_OPT_SHIRQ_LEVEL default y, but at leas=
t
>> for poor x86 users on legacy hardware (ISA) sharing takes at least as
>> often place with edge-triggered sources.
>=20
>=20
> I thought it's level-triggered indeed. At least, judging by the fact th=
at
> linux provides a generic support only for level-triggered case.
>=20
> e.g. cross-domain IRQ sharing (with you approach) would require only LE=
VEL
> option (I actually wanted to port/rework, taking into account the
> improvements we have discussed recently, your patch over some recent e.=
g.
> e1000 driver + Xeno so to have an up-to-date example illustrating the
> approach).
>=20

Sounds good. Do you plan to use RTDM for the RT-stub? Then we would only
have to add the propagation flag to the return codes, right?

Anyway. So you have e1000 hardware to test it? [Mmh, then you could also
test our rt_e1000 in RTnet...] Another option would be the UHCI driver,
might be an even more common IRQ hog. But pick whatever is easier to
implement and test.

Jan


--------------enig69D6009F1C87D1C61E5C0068
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE/w/FniDOoMHTA+kRAuONAJ4vMCe6otdidfhVmLHzVIwk3WNpMgCdFfsW
rmcnCKbVgZzta3XodkEdp/4=
=KON4
-----END PGP SIGNATURE-----

--------------enig69D6009F1C87D1C61E5C0068--

