Message-ID: <44FEEF50.2070407@domain.hid>
Date: Wed, 06 Sep 2006 17:54:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <44FD7463.7010601@domain.hid> <44FD99E9.6030500@domain.hid>	
	<44FD9F92.4050802@domain.hid>	
	<b647ffbd0609051210p26c56690oe7b332190b3b702e@domain.hid>	
	<44FE6C55.1030900@domain.hid>	
	<b647ffbd0609060159q7677cd30y80208afc58caf17@domain.hid>	
	<44FE943F.9000803@domain.hid>	
	<b647ffbd0609060527o13a077f4ue1fd1b445b1379c7@domain.hid>	
	<44FEE10F.5030208@domain.hid>
	<b647ffbd0609060808y11d7fd8eg99aee190da05a847@domain.hid>
In-Reply-To: <b647ffbd0609060808y11d7fd8eg99aee190da05a847@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB0E2FD0B737203182EDA3D52"
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
--------------enigB0E2FD0B737203182EDA3D52
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> On 06/09/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>
>> See attached patch: XENO_OPT_SHIRQ would just be a menu-enabler withou=
t
>> any affect outside kconfig. You could enabled it and leave the rest of=
f
>> (makes no sense of course) - as long as there are no edge-triggered
>> users around.
>=20
>=20
>=20
>=20
> -menu "Shared interrupts"
>> +menuconfig XENO_OPT_SHIRQ
>> +       bool "Shared interrupts"
>>
>> config XENO_OPT_SHIRQ_LEVEL
>>         bool "Level-triggered interrupts"
>> -       default n
>> +       depends on XENO_OPT_SHIRQ
>> +       default y
>>         help
>> -
>> +
>>         Enables support for shared level-triggered interrupts, so that=

>>         multiple real-time interrupt handlers are allowed to control
>>         dedicated hardware devices which are configured to share
>> @@ -369,7 +371,8 @@ config XENO_OPT_SHIRQ_LEVEL
>>
>> config XENO_OPT_SHIRQ_EDGE
>>         bool "Edge-triggered interrupts"
>> -       default n
>> +       depends on XENO_OPT_SHIRQ
>> +       default y
>>         help
>=20
>=20
> So a user may end up with XENO_OPT_SHIRQ being enabled while both LEVEL=
 and
> EDGE are disabled? Maybe it's worth to make LEVEL "y" by default as it'=
s
> likely to be a required option?
>=20

Do you see the "default y" above, no? :)

I thought about making only XENO_OPT_SHIRQ_LEVEL default y, but at least
for poor x86 users on legacy hardware (ISA) sharing takes at least as
often place with edge-triggered sources.

Jan


--------------enigB0E2FD0B737203182EDA3D52
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE/u9QniDOoMHTA+kRArjKAJ9yGEfAKOSeFLVFNzWq6JvxrQTE9wCbBbdo
bTIJz+30tdPY5zdSDoj3k9M=
=15Na
-----END PGP SIGNATURE-----

--------------enigB0E2FD0B737203182EDA3D52--

