Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 6 Feb 2009 18:58:48 -0000
Message-ID: <4B3F8896E1733D4787DDB0EA1C7FF91F704567@domain.hid>
In-Reply-To: <498C61B4.8040806@domain.hid>
References: <4B3F8896E1733D4787DDB0EA1C7FF91F704347@domain.hid>
	<498C0EBE.5000004@domain.hid>
	<4B3F8896E1733D4787DDB0EA1C7FF91F70443C@ukmail.uk.wirelessworld.airvananet.com>
	<498C4777.8050801@domain.hid>
	<4B3F8896E1733D4787DDB0EA1C7FF91F7044CD@ukmail.uk.wirelessworld.airvananet.com>
	<498C61B4.8040806@domain.hid>
From: "Mike McTernan" <mmcternan@domain.hid>
Subject: Re: [Xenomai-help] lib order fails for xeno-config --posix-ldflags
	on	Blackfin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Mike McTernan wrote:
> > I think Xenomai should support FLAT though, it's just this link
problem,
> > right?
>=20
> Yes, Xenomai does not care about the underlying binary format. It is
just
> a convenience for us to follow the default one uClinux uses on the
> Blackfin.

I think FLAT is possibly more popular for embedded apps which Blackfin
goes into.  From our experience ZFLAT are much smaller and load quickly.

> I was thinking about something along these lines

You were thinking very well.  That does indeed produce a linked binary
which runs.

Any chance this can be added to future Xenomai releases?  Would it be
okay for me to add a page to your wiki describing how to static link?=20

Regards,

Mike

