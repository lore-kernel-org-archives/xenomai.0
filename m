From: Wolfgang Denk <wd@domain.hid>
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <1298156382.3304.13.camel@domain.hid>
References: <AANLkTikiCm5B-KwteOfzTwtCV8RXj1QFgfQCAmCCoC8V@mail.gmail.com>
	<20101220154041.48C75CDE29A@gemini.denx.de>
	<AANLkTi=C3FQ_Cms9qanmc1dgMgSvMC1Rrt-0X0tOPZMp@domain.hid>
	<20110215200753.C4B6C146940@domain.hid>
	<1297880887.1947.3.camel@domain.hid>
	<AANLkTin-2JJz3V+7bE7q1SjT0TBniRaO+byS_R0mzJF_@domain.hid>
	<1298111755.3304.1.camel@domain.hid>
	<4D5FE8D6.6030204@domain.hid> <4D601B37.2010003@domain.hid>
	<1298156382.3304.13.camel@domain.hid>
Date: Sun, 20 Feb 2011 01:52:29 +0100
Message-Id: <20110220005229.11CA0146940@domain.hid>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai on Freescale iMX35
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Marten Lootsma <m.lootsma@domain.hid>
Cc: xenomai@xenomai.org

Dear Marten Lootsma,

In message <1298156382.3304.13.camel@domain.hid> you wrote:
>=20
> Do I understand correct that: Xenomai support for iMX35 depends fully o=
n
> the developers of Freescale to put their patches into the mainline
> kernel?

No, the community does not depend on Freescale.  If we did, we would
not be where we are today.

You need to understand that Freescales primary (and sometimes only)
purpose is to sell their chips.  Sometimes they do have to provide a
certain level of enablement services, but they surely don;t get paid
for providing best in class community support.

The community is driven by some people who work on their own time for
free, but more often by people or companies that get paid for such
services by their respective customers.  For example, that's how I've
been earning my bread (and butter) for the past 12 years.


Of course you can ask Freescale to provide better mainline integration
of their code, and most likely they will even listen, but I would not
hold my breath to actually see any quick improvements.

If you need certain features in mainline Linux quickly (or, say,
Xenomai support for a specific kernel version and/or for a specific
piece of hardware), you can either throw in your own ressources, or
you can hire some experts.  There are a number of companies who
provide exactly this type of services.


Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
The inappropriate cannot be beautiful.
             - Frank Lloyd Wright _The Future of Architecture_ (1953)

