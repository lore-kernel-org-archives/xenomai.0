From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4696082A.5090006@domain.hid>
References: <4696082A.5090006@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Date: Thu, 12 Jul 2007 19:38:46 +0200
Message-Id: <1184261926.6014.157.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] xenomai release check
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?St=E9phane?= ANCELOT <sancelot@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Thu, 2007-07-12 at 10:53 +0000, St=E9phane ANCELOT wrote:
> Hi,
>=20
> Is it possible to setup a function that returns the xeno version string ?
>=20

Have a look at XENO_VERSION_CODE and friends in nucleus/version.h

> In cross compiled environment, this will permit to check at runtime that
> you are running the program with the expected xeno libraries !!!
>=20
> We have had following problem on the target we setted up:
> kernel modules were right, but usr/xenomai/libs  were coming from an
> older xeno release !!
> at runtime , our program had some bad issues !
>=20
> Best Regards
> Steph
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
--=20
Philippe.



