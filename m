Message-ID: <46C3345A.2000301@domain.hid>
Date: Wed, 15 Aug 2007 19:14:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <469E10D5.8000602@domain.hid> <469E6349.5000209@domain.hid>
	<46C3269F.8070408@domain.hid>
In-Reply-To: <46C3269F.8070408@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF6A96CBC7116C41486BE5FD1"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Problems with compat_module_param_array() with
 Linux	2.4
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF6A96CBC7116C41486BE5FD1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Jan Kiszka wrote:
>> Wolfgang Grandegger wrote:
>>> Hello,
>>>
>>> yesterday I realized a problem with compat_module_param_array() with
>>> ksrc/drivers/can/sja1000/rtcan_mem.c under Linux 2.4. It uses
>>> CONFIG_XENO_DRIVERS_CAN_SJA1000_MEM_MAX_DEV to define the number of m=
em
>>> devices, which is set to '(4)' by "make [menuc]onfig". Unfortunately,=

>>> the brackets '()' break compat_module_param_array() because it treats=

>>> the count as string:
>>>
>>> #define compat_module_param_array(name, type, count, perm) \
>>>          static inline void *__check_existence_##name(void) { return
>>> &name; } \
>>>          MODULE_PARM(name, "1-" __MODULE_STRING(count)
>>> _MODULE_PARM_STRING_##type)
>>>
>>> Any idea how to fix that? I actually tend to remove the configuration=

>>> option CONFIG_XENO_DRIVERS_CAN_SJA1000_MEM_MAX_DEV and hardcode it to=

>>> "4" (without brackets) in the driver. It's kind of overkill, anyhow.
>>
>> I would say that this problem is not "with compat_module_param_array",=

>> but about the Kconfig-based constant. I don't see a way to make the
>> module parameter array size configurable even under vanilla 2.4. Simpl=
y
>> go for a patchable constant in the source code like other drivers do.
>=20
> The attached patch fixes the problem:
>=20
> 2007-08-15  Wolfgang Grandegger  <wg@domain.hid>
>=20
>         * ksrc/drivers/can/sja1000/Kconfig,
>         ksrc/drivers/can/sja1000/{rtcan_isa.c,rtcan_mem.c}: Remove conf=
ig
>         options XENO_DRIVERS_CAN_SJA1000_*_MAX_DEV to avoid problems wi=
th
>         defining module parameters with Linux 2.4.
>=20
> If nobody complains, I'm going to apply it to the trunk and the v2.3.x
> branch.

Looks good, go ahead.

Jan


--------------enigF6A96CBC7116C41486BE5FD1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGwzRaniDOoMHTA+kRAt+xAJ4zL+q4V1QDx7W4KlGQvahCZaKsHQCeOPmT
smkUoHb7Hb6ya+gc7Z2oKQk=
=xubt
-----END PGP SIGNATURE-----

--------------enigF6A96CBC7116C41486BE5FD1--

