Date: Tue, 1 Apr 2008 16:38:07 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@domain.hid>
Message-ID: <20080401143807.GA26081@domain.hid>
References: <20080401103647.GR13814@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20080401103647.GR13814@domain.hid>
Subject: Re: [Xenomai-core] [PATCH][SOLO] add sparse support
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Robert Schwebel <r.schwebel@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Hello,

Robert Schwebel wrote:
> This patch adds static analysis support with sparse to the xenomai-solo
> makefiles. To enable sparse checking, use
>=20
> 	./configure --with-sparse[=3DPATH]
>=20
> and run 'make sparse' afterwards. I don't have a good idea right now how
> to avoid this extra step; it would be much nicer if every call to
> $(COMPILE) could be substituted by a sparse call plus the original one,
> but I didn't find a good method for that yet that also works with the
> libtool calls.
I haven't looked at it, but cgcc might help you.  I don't know how it
interacts with libtool, but maybe simply:

	make CC=3Dcgcc

works?

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig, Software Engineer
Digi International GmbH Branch Breisach, K=FCferstrasse 8, 79206 Breisach, =
Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 13962

