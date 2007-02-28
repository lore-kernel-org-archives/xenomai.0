Message-ID: <45E58964.5040304@domain.hid>
Date: Wed, 28 Feb 2007 14:53:40 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] warnings and tangled threads.
References: <bc4264770702271525q6d5d164lfa34b421a64eeb70@domain.hid>	<45E5357B.4090107@domain.hid>
	<45E53FF0.7050200@domain.hid>
In-Reply-To: <45E53FF0.7050200@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig44A9896E1E263444597B6177"
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
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig44A9896E1E263444597B6177
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> roland Tollenaar wrote:
>>> Hi,
>>>
>>> Ok I have CAN functionality of some form running in my tasks.
>>> Initializing seems to be successful and I have written some kind of
>>> wrapper to create a can_write() function of my own which also seems t=
o
>>> be -kind of-  working. I have one question and one problem.
>>>
>>> I keep on getting this compile warning
>>>
>>> In file included from /mnt/appusb/xenomai/include/rtdm/rtcan.h:250,
>>>                 from cancom.cpp:15:
>>> /mnt/appusb/xenomai/include/rtdm/rtdm.h: In function `ssize_t
>>> rt_dev_sendto(int, const void*, size_t, int, const sockaddr*,
>>> socklen_t)':
>>> /mnt/appusb/xenomai/include/rtdm/rtdm.h:323: warning: missing
>>> initializer for member `msghdr::msg_flags'
>>>
>>> Its in rtdm.h so I have not looked closely at it yet but I presume I
>>> must be doing something wrong to be getting it?
>> That seems to be due to non-default -Wmissing-field-initializers, righ=
t?
>> Will have a look if we can quiet gcc.
>>
>=20
> This works for me here (and is a bit more telling as well):
>=20
> --- include/rtdm/rtdm.h (Revision 2265)
> +++ include/rtdm/rtdm.h (Arbeitskopie)
> @@ -295,13 +295,22 @@ static inline ssize_t rt_dev_recvfrom(in
>                                        struct sockaddr *from,
>                                        socklen_t *fromlen)
>  {
> -    struct iovec    iov =3D {buf, len};
> -    struct msghdr   msg =3D
> -        {from, (from !=3D NULL) ? *fromlen : 0, &iov, 1, NULL, 0};
> -    int             ret;
> +    struct iovec iov =3D {
> +        .iov_base =3D buf,
> +        .iov_len =3D len
> +    };
> +    struct msghdr msg =3D
                          ^^^
Insert "{", or the kernel build breaks. :(

> +        .msg_name =3D from,
> +        .msg_namelen =3D from ? *fromlen : 0,
> +        .msg_iov =3D &iov,
> +        .msg_iovlen =3D 1,
> +        .msg_control =3D NULL,
> +        .msg_controllen =3D 0
> +    };
> +    int ret;
> =20
>      ret =3D rt_dev_recvmsg(fd, &msg, flags);
> -    if ((ret >=3D 0) && (from !=3D NULL))
> +    if (ret >=3D 0 && from)
>          *fromlen =3D msg.msg_namelen;
>      return ret;
>  }
> @@ -345,9 +354,18 @@ static inline ssize_t rt_dev_sendto(int=20
>                                      int flags, const struct sockaddr *=
to,
>                                      socklen_t tolen)
>  {
> -    struct iovec    iov =3D {(void *)buf, len};
> -    struct msghdr   msg =3D
> -        {(struct sockaddr *)to, tolen, &iov, 1, NULL, 0};
> +    struct iovec iov =3D {
> +        .iov_base =3D (void *)buf,
> +        .iov_len =3D len
> +    };
> +    struct msghdr msg =3D {
> +        .msg_name =3D (struct sockaddr *)to,
> +        .msg_namelen =3D tolen,
> +        .msg_iov =3D &iov,
> +        .msg_iovlen =3D 1,
> +        .msg_control =3D NULL,=20
> +        .msg_controllen =3D 0
> +    };
> =20
>      return rt_dev_sendmsg(fd, &msg, flags);
>  }
>=20
>=20
> Can you confirm it?
>=20
> Jan
>=20
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help



--------------enig44A9896E1E263444597B6177
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5YlkniDOoMHTA+kRAnyKAJ9Mq8GQVVpBDJGF03LYRQAFxcezuwCbBCZk
rg1e83ha+TIsm1OmshqZY4o=
=saWi
-----END PGP SIGNATURE-----

--------------enig44A9896E1E263444597B6177--

