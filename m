Message-ID: <4B5D5A14.3030909@domain.hid>
Date: Mon, 25 Jan 2010 09:45:08 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B5D58E2.60603@domain.hid>
In-Reply-To: <4B5D58E2.60603@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAE835B7F8E955202050EE7FB"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Fwd: Re: [RFC][PATCH] x86: Fix root domain state
 restoring on exception return
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Cc: adeos-main@gna.org, "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAE835B7F8E955202050EE7FB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Mauerer wrote:
> (sorry if you get this twice, the cc addresses were screwed up
> by copy and paste last time)
>=20
> Kiszka, Jan wrote:
>=20
>> If we enter __ipipe_handle_exception over a non-root domain and leave =
it
>> due to migration in the event handler over root, we must not restore t=
he
>> root domain state so far saved on entry. This caused subtle pipeline
>> state corruptions. Actually, we only need to save the state if we ente=
r
>> over the root domain and have to align its state to the hardware
>> interrupt mask.
>>
>> Moreover, the x86-32 regs.eflags fix-up must happen based on the curre=
nt
>> root domain state to avoid more spurious corruptions.
>=20
> unfortunately, this won't boot on x86-32: During CPU bug checking
> in check_hlt, the kernel will really go into the halt state and
> never recover. By modifying __ipipe_handle_exception to use
> raw_irqs_disabled_flags as argument to __fixup_if instead of
> raw_irqs_disabled, everything is back to normal again. However,

That would reintroduce the bug we saw on 64 bit to 32 bit (in a slight
variation). So we need to understand what goes wrong here. Can you
generate an ipipe panic trace?

> I'm not sure if this is a) the proper solution or b) won't cause
> problems somewhere else, so a discussion would be highly welcome...
>=20
> Cheers, Wolfgang
>=20

Jan


--------------enigAE835B7F8E955202050EE7FB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAktdWh0ACgkQitSsb3rl5xSx1gCgyYZxLXlFeT2JuqlTX5joPYVz
W7YAnAng8FOZTthCcI3oW0tbZ4wihECv
=i/T/
-----END PGP SIGNATURE-----

--------------enigAE835B7F8E955202050EE7FB--

