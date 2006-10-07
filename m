Message-ID: <4527E457.705@domain.hid>
Date: Sat, 07 Oct 2006 19:31:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rtcan_mscan compilation.
References: <ac3922a00610060437i4735bf7at85ca11beb12ab1be@domain.hid>
	<4526B48F.50705@domain.hid> <452767E0.3050107@domain.hid>
	<4527B59B.1030109@domain.hid>
In-Reply-To: <4527B59B.1030109@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEEBB8AB7FD099E71A700A644"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEEBB8AB7FD099E71A700A644
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Jan Kiszka wrote:
>> Wolfgang Grandegger wrote:
>>> ...
>>> Index: ksrc/drivers/can/rtcan_internal.h
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- ksrc/drivers/can/rtcan_internal.h    (revision 1695)
>>> +++ ksrc/drivers/can/rtcan_internal.h    (working copy)
>>> @@ -111,6 +111,10 @@
>>> =20
>>>  #ifndef compat_module_int_param_array
>>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10)
>>> +# define compat_module_int_param(name) \
>>> +    MODULE_PARM(name, "i")
>>> +# define compat_module_charp_param(name) \
>>> +    MODULE_PARM(name, "s")
>>>  # define compat_module_byte_param_array(name, count) \
>>>      MODULE_PARM(name, "1-" __MODULE_STRING(count) "b")
>>>  # define compat_module_short_param_array(name, count) \
>>> @@ -118,6 +122,10 @@
>>>  # define compat_module_int_param_array(name, count) \
>>>      MODULE_PARM(name, "1-" __MODULE_STRING(count) "i")
>>>  #else
>>> +# define compat_module_int_param(name) \
>>> +    module_param(name, int, 0444)
>>> +# define compat_module_charp_param(name) \
>>> +    module_param(name, charp, 0444)
>>>  # define compat_module_byte_param_array(name, count) \
>>>      module_param_array(name, byte, NULL, 0444)
>>>  # define compat_module_short_param_array(name, count) \
>>
>> No need, module_param comes even with 2.4. We only need wrapping for
>> parameter arrays (due to different semantics of the macro arguments).
>=20
> But with limitations, unfortunately:
>=20
>   /* type is byte, short, ushort, int, uint, long, ulong, bool. (2.6
>      has more, but they are not supported).  perm is permissions when
>      it appears in sysfs: 0 means doens't appear, 0444 means read-only
>      by everyone, 0644 means changable dynamically by root, etc.  name
>      must be in scope (unlike MODULE_PARM).
>   */
>   #define module_param(name, type, perm) \
>         static inline void *__check_existence_##name(void) { return
>              &name; } \
>         MODULE_PARM(name, _MODULE_PARM_STRING_ ## type)
>=20
>   #define _MODULE_PARM_STRING_byte "b"
>   #define _MODULE_PARM_STRING_short "h"
>   #define _MODULE_PARM_STRING_ushort "h"
>   #define _MODULE_PARM_STRING_int "i"
>   #define _MODULE_PARM_STRING_uint "i"
>   #define _MODULE_PARM_STRING_long "l"
>   #define _MODULE_PARM_STRING_ulong "l"
>   #define _MODULE_PARM_STRING_bool "i"
>=20
> Especially "s" is missing. But it could be wrapped with:
>=20
>   #define _MODULE_PARM_STRING_charp "s"
>=20
> Any idea why this is not already done?

Likely because you mostly don't need it? I think mscan is an exception
here, at least from my experience.

When _MODULE_PARM_STRING_charp helps to enhance module_param on 2.4,
lets put it in Xenomai's wrapping header. I think we should also move
the parameter array over (directing it officially through the RTDM layer
can still be done later, at the latest when providing user-space
support). I would support a patch doing this as well.

>=20
> I also want to replace the compat_module_*_param_array functions with
> the attached code snippet.

Ok, I'm awaiting a revised patch.

Jan


--------------enigEEBB8AB7FD099E71A700A644
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFJ+RXniDOoMHTA+kRAiMEAJ0VF0hPNCVyfERgO36jzf3uQxO1mgCfZJy1
AcKBDYAMnWLeELByR8XC94Y=
=Nu3Q
-----END PGP SIGNATURE-----

--------------enigEEBB8AB7FD099E71A700A644--

