From: "Katsuhiko Isono" <k-isono@domain.hid>
Date: Mon, 7 Jun 2010 14:54:59 +0900
Message-ID: <5311F6C579A24F0F9BEBD27186749943@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4C08BF6D.1030806@domain.hid>
Subject: Re: [Xenomai-help] "arm: fix mm switching" patch effective also for
	2.4.10 ?
Reply-To: k-isono@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org




> Katsuhiko Isono wrote:
> >> -----Original Message-----
> >> Katsuhiko Isono wrote:
> >>> I use linux-2.6.26 + xenomai-2.4.10 with custom arm(i.mx31) board.
> >>>
> >>> When realtime application was executed on my environment,
> >>> application caused the SIGSEGV fault about once every=20
> several hours.
> >>>
> >>> However, when I applied "arm: fix mm switching" patch of=20
> >> xenomai-2.5 to=20
> >>> my environment, SIGSEGV fault did not happen.
> >>>
> >>> There is a following question.
> >>>  - Is this patch effective also for 2.4.10 ?
> >>>  - What trouble is corrected with this patch ?
> >> The version of the I-pipe patch you are using has another=20
> >> known bug than
> >> the one fixed by the "arm: fix mm switching" patch (by the=20
> way, to be
> >> sure that we are talking about the same patch, I would=20
> prefer an URL
> >> pointing to xenomai's gitweb), the bug mentioned here:
> >>
> >> https://mail.gna.org/public/xenomai-core/2009-08/msg00021.html
> >>
> >> And the fix for this bug in the I-pipe patches which comes=20
> >> with Xenomai
> >> 2.4.10 should fix both bugs.
> >>
> >> So, in short, do you oberve the segmentation faults when using the
> >> I-pipe patches which ship with Xenomai 2.4.10 rather than=20
> >> whatever patch
> >> you are using for linux 2.6.26?
> >>
> >=20
> > Thank you for your reply.
> >=20
> > I use linux-2.6.26 of Freescale BSP because I develop custom board.=20
>=20
> Actually, I do not really understand this argument. It looks as easy =
to
> develop a custom board support with the mainline kernel as with a =
vendor
> version. And at least, with the mainline kernel, you are not stuck =
with
> whatever version the vendor chose.

The reason for using FreeScale BSP is that functions(SDMA,..etc) were =
richer=20
than mainline at the time of transplanted to our board.


