From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46975A02.3030704@domain.hid>
References: <4696082A.5090006@domain.hid> <1184261926.6014.157.camel@domain.hid>
	<4696A9BE.4090008@domain.hid>  <46975A02.3030704@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 13 Jul 2007 14:35:55 +0200
Message-Id: <1184330155.6014.252.camel@domain.hid>
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
Cc: xenomai-help <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

On Fri, 2007-07-13 at 10:54 +0000, St=E9phane ANCELOT wrote:
> Jan Kiszka a =E9crit :
> > Philippe Gerum wrote:
> >> On Thu, 2007-07-12 at 10:53 +0000, St=E9phane ANCELOT wrote:
> >>> Hi,
> >>>
> >>> Is it possible to setup a function that returns the xeno version stri=
ng ?
> >>>
> >> Have a look at XENO_VERSION_CODE and friends in nucleus/version.h
> >=20
> > I think Stephan has a different problem:
> >=20
> >>> In cross compiled environment, this will permit to check at runtime t=
hat
> >>> you are running the program with the expected xeno libraries !!!
> >>>
> >>> We have had following problem on the target we setted up:
> >>> kernel modules were right, but usr/xenomai/libs  were coming from an
> >>> older xeno release !!
> >>> at runtime , our program had some bad issues !
> >=20
>=20
> YES, YOU ARE RIGHT , we linked 2.3.0 compiled programs against 2.1.2 libs
>=20

Unfortunately, our ABI revs between those versions are wrong then.

> > He dynamically linked against some old Xenomai lib over a new kernel,
> > right? That should be caught by the ABI check on library init these
> > days. Stephan, can you tell us which versions where involved here?
> >=20
> > Jan
> >=20
>=20
>=20
--=20
Philippe.



