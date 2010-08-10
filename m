From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTim1+--sP1vMpaduv9Sey+r6-1fN_L2HZ68X1-+T@mail.gmail.com>
References: <AANLkTim1+--sP1vMpaduv9Sey+r6-1fN_L2HZ68X1-+T@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Aug 2010 23:10:29 +0200
Message-ID: <1281474629.1730.18.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Help on IPC example
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ettore Pedretti <epedrett@domain.hid>
Cc: xenomai@xenomai.org, John Monnier <monnier@domain.hid>

On Tue, 2010-08-10 at 19:20 +0100, Ettore Pedretti wrote:
> Hello All,
>=20
> Since pipes will be soon removed from xenomai I would like to use
> sockets on ipc. I know the question have been already asked but is
> there any documentation other than the examples at present?
>=20

I recently documented those services. The corresponding doc is not yet
available for browsing online from our web site, so I put a PDF there:
http://download.gna.org/xenomai/tmp/rtdm-api.pdf
Check =C2=A75.4, real-time IPC protocols

This documentation is already merged in the upcoming 2.6 -devel branch:
git://git.xenomai.org/xenomai-head.git

> Also, I have compiled the examples in the ipc directory and I get the
> following error while executing any of the programmes:
>=20
>  mirkwood:/home/ep41/ipc# ./bufp-label
> socket: Address family not supported by protocol
>=20
> What am I doing wrong? Attached my .config file.

I see in your configuration that you chose to build the RTIPC support as
a module; did you insmod it before running the examples?

Besides, make sure to use the Makefile in the examples/rtdm/profiles/ipc
directory, or something alike, so that all programs are properly linked
with the Xenomai POSIX support libs.

>=20
> Cheers
> ettore
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

--=20
Philippe.



