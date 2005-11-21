Message-ID: <4381BF59.1050704@domain.hid>
Date: Mon, 21 Nov 2005 13:36:41 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] pipe fun
References: <OFB5DCE336.B4DDC2FD-ONC12570C0.00415BF3-C12570C0.0042FBDA@datacon.at>
In-Reply-To: <OFB5DCE336.B4DDC2FD-ONC12570C0.00415BF3-C12570C0.0042FBDA@datacon.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:
> Ignacio Garc=EDa P=E9rez <iggarpe@domain.hid> wrote on 21.11.2005 12:24:5=
7:
>=20
>  > Dmitry Adamushko wrote:
>  >
>  > >            /* Return buffer is too small - message is lost. */
>  > >            ret =3D -ENOSPC; <---- That's the error you are getting=
.
>  > >
>  > Maybe "No space left on device" is a bit misleading. Wouldn't ENOMEM=
 fit
>  > better? (or event EINVAL)
>  >
>=20
> Actually, looking now at the linux sources, -ENOSPC is used for=20
> describing the same reason (buffer is not big enough) in some places;=20
> although there is, at least, one more value -ENOBUFS that's used for th=
e=20
> same reason.
>=20
> #define ENOSPC          28      /* No space left on device */
> #define ENOBUFS         105     /* No buffer space available */
>=20
> So it looks like both may be used in the same context but, I guess, a=20
> definition of -ENOBUFS is less confusing.
>=20
>=20

Let's fix this.

> ---
> Best regards,
> Dmitry
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--=20

Philippe.

