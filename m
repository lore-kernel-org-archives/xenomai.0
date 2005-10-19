content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-core] Cosmetic changes to script xeno-config + man page
Date: Wed, 19 Oct 2005 10:15:16 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D4F0E2E@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> > Romain Lenglet wrote:
> > [..]
> > >I found a better solution, that could be a replacement for both a=20
> > >xenomai.m4 trick, and the xeno-config script: pkg-config.
> > >http://pkgconfig.freedesktop.org/wiki/
> > >There are packages for pkgconfig in both Debian and RedHat,=20
> > >AFAIK, and surely for all other distribs.
> > >
> > >I will look into making a xenomai.pc file.
> >=20
> > Make it a xenomai.pc.in file   ;-)
>
> I am not sure we want to depend on pkg-config...

Gilles, put it the other way around. Xenomai won't depend on pkg-config,
but applications using Xenomai, will happily depend on it, if they
choose this option. To me, pkg-config shouldn't be a replacement,
but an alternative choice to xeno-config.

--=20
Stephane


