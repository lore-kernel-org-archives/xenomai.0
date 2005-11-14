Message-ID: <4378CBA6.6000708@domain.hid>
Date: Mon, 14 Nov 2005 18:38:46 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xn_pipe_create [minor]
References: <OF904A8BBE.F91DE4A2-ONC12570B9.005BDDF6-C12570B9.005CB25A@datacon.at>
In-Reply-To: <OF904A8BBE.F91DE4A2-ONC12570B9.005BDDF6-C12570B9.005CB25A@datacon.at>
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
> Ignacio Garc=EDa P=E9rez <iggarpe@domain.hid> wrote on 14.11.2005 17:41:1=
3:
>=20
>  >
>  > >> Using this scheme, user mode programs just need to open()
>  > >> /proc/xenomai/registry/pipes/whatever to access a named pipe, wit=
hout
>  > >> having to know the minor number.
>  > >>
>  > >> Under these circumstances, it would be *very* useful to have
>  > >> rt_pipe_create choose an unused minor automagically (for example=20
> passing
>  > >> -1 as the minor).
>=20
> ah.. yep, that's what I have meant with a PIPE_MINOR_AUTO thing :)
>=20
>  > >>
>  > >
>  > > Sounds reasonable.
>  >
>  > On the heels of our abs/rel discussion, I suggest to use a #define
>  > istead of -1
>  >
>  > Will you implement it, or should I give a try?
>  >
>=20
> If you want to have some fun (and you have some time and desire for=20
> that) then go ahead :) Otherwise, no problem, I'll do that.
>=20

Please make sure to implement this at the nucleus level, and if using a b=
itmap=20
to locate free/busy slots, it should be large enough to handle FDSETSIZE=20
channels, not BITS_PER_LONG.

--=20

Philippe.

