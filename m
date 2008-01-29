Message-ID: <479F2D33.2050209@domain.hid>
Date: Tue, 29 Jan 2008 14:42:11 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <479F2825.4000405@domain.hid>
In-Reply-To: <479F2825.4000405@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] bug in xnintr_irq_proc()
Reply-To: rpm@xenomai.org
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

Wolfgang Grandegger wrote:
> Hello,
>=20
> attached is a fix for a nice bug in xnintr_irq_proc() of Xenomai v2.3.x.

Mmf... Thanks.

> Check for tabs. I have not checked if it's present in recent versions as
> well.

Even if a bit overkill, I would even go for something like
p +=3D sprintf(p, "...
just to be sure we won't get hit again.

(or even snprintf() for the parano=EFds among us).

>=20
> Wolfgang.
>=20
>=20
> ------------------------------------------------------------------------
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


--=20
Philippe.

