Message-ID: <438211E6.1070905@domain.hid>
Date: Mon, 21 Nov 2005 19:28:54 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] pipe fun
References: <OF9B0F824D.7587E331-ONC12570C0.00465803-C12570C0.0047036C@datacon.at>
In-Reply-To: <OF9B0F824D.7587E331-ONC12570C0.00465803-C12570C0.0047036C@datacon.at>
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
> Philippe Gerum <rpm@xenomai.org> wrote on 21.11.2005 13:36:41:
>=20
>  > Dmitry Adamushko wrote:
>  > > Ignacio Garc=EDa P=E9rez <iggarpe@domain.hid> wrote on 21.11.2005 12=
:24:57:
>  > >
>  > >  > Dmitry Adamushko wrote:
>  > >  >
>  > >  > >            /* Return buffer is too small - message is lost. *=
/
>  > >  > >            ret =3D -ENOSPC; <---- That's the error you are ge=
tting.
>  > >  > >
>  > >  > Maybe "No space left on device" is a bit misleading. Wouldn't=20
> ENOMEM fit
>  > >  > better? (or event EINVAL)
>  > >  >
>  > >
>  > > Actually, looking now at the linux sources, -ENOSPC is used for
>  > > describing the same reason (buffer is not big enough) in some plac=
es;
>  > > although there is, at least, one more value -ENOBUFS that's used=20
> for the
>  > > same reason.
>  > >
>  > > #define ENOSPC          28      /* No space left on device */
>  > > #define ENOBUFS         105     /* No buffer space available */
>  > >
>  > > So it looks like both may be used in the same context but, I guess=
, a
>  > > definition of -ENOBUFS is less confusing.
>  > >
>  > >
>  >
>  > Let's fix this.
>  >
>=20
> Enclosed.
>=20

Applied, thanks.

> One more thing about xnpipe_read() though.
>=20
>=20
> ...
>            }
>        else
>            /* Return buffer is too small - message is lost. */
>            ret =3D -ENOBUFS;
>=20
> So the message is lost in such a case. We may easily avoid that by=20
> making a proper check of the size when we are still in the locked=20
> section and putting the message back into the queue (prependq() of=20
> course). I think that would be more sane.
>

Problem is that if nobody ends up reading the message because the=20
application always passes invalid args, internal heap memory may be=20
exhausted due to unread messages.

>=20
>  > --
>  >
>  > Philippe.
>=20
> ---
> Best regards,
> Dmitry
>=20
> /(See attached file: pipe-ENOBUFS.patch)//(See attached file:=20
> ChangeLog.patch)/
>=20


--=20

Philippe.

