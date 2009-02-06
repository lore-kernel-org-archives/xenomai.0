Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 6 Feb 2009 15:21:01 -0000
Message-ID: <4B3F8896E1733D4787DDB0EA1C7FF91F7044CD@ukmail.uk.wirelessworld.airvananet.com>
In-Reply-To: <498C4777.8050801@domain.hid>
References: <4B3F8896E1733D4787DDB0EA1C7FF91F704347@domain.hid>
	<498C0EBE.5000004@domain.hid>
	<4B3F8896E1733D4787DDB0EA1C7FF91F70443C@ukmail.uk.wirelessworld.airvananet.com>
	<498C4777.8050801@domain.hid>
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
> > Philippe Gerum wrote:
> >> Mike McTernan wrote:
> >>> Hi,
> >>>
> > I think you are using ELF, so maybe you don't see the problem - the
> > dynamic linker maybe patching up the internal pthread references?
I'm
> > using FLAT, which is essentially a static link, so everything has to
be
> > fully resolved.
>=20
> Yes, this is where FLAT is biting you. All refs have to be resolved,
so
> the linker tries to pick whatever it needs at link time.
<snip>=20
> This is all due to the FLAT mode. So I guess your next option is
two-stage
> linking in you don't want to rely on shared fdpic libs.

Unfortunately moving away from ZFLAT isn't trivial for us and is an
unlikely step.

I think Xenomai should support FLAT though, it's just this link problem,
right?

Unless you have some hints as to how the two-stage link is done, I'm
going to go and try to get this working and report back later.

Regards,

Mike

