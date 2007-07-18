Message-ID: <469E6349.5000209@domain.hid>
Date: Wed, 18 Jul 2007 21:00:25 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <469E10D5.8000602@domain.hid>
In-Reply-To: <469E10D5.8000602@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF9DBB499CB00B58D5095C917"
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
--------------enigF9DBB499CB00B58D5095C917
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hello,
>=20
> yesterday I realized a problem with compat_module_param_array() with
> ksrc/drivers/can/sja1000/rtcan_mem.c under Linux 2.4. It uses
> CONFIG_XENO_DRIVERS_CAN_SJA1000_MEM_MAX_DEV to define the number of mem=

> devices, which is set to '(4)' by "make [menuc]onfig". Unfortunately,=20
> the brackets '()' break compat_module_param_array() because it treats=20
> the count as string:
>=20
> #define compat_module_param_array(name, type, count, perm) \
>          static inline void *__check_existence_##name(void) { return
> &name; } \
>          MODULE_PARM(name, "1-" __MODULE_STRING(count)
> _MODULE_PARM_STRING_##type)
>=20
> Any idea how to fix that? I actually tend to remove the configuration=20
> option CONFIG_XENO_DRIVERS_CAN_SJA1000_MEM_MAX_DEV and hardcode it to=20
> "4" (without brackets) in the driver. It's kind of overkill, anyhow.

I would say that this problem is not "with compat_module_param_array",
but about the Kconfig-based constant. I don't see a way to make the
module parameter array size configurable even under vanilla 2.4. Simply
go for a patchable constant in the source code like other drivers do.

Jan


--------------enigF9DBB499CB00B58D5095C917
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGnmNJniDOoMHTA+kRAq8HAJ4sgufwBxYDt4M3EulpFpvUXNts/gCfTfbq
5kMH5k3s4efGKMewQYgNCA0=
=mE1V
-----END PGP SIGNATURE-----

--------------enigF9DBB499CB00B58D5095C917--

