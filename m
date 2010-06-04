From: "Katsuhiko Isono" <k-isono@domain.hid>
Date: Fri, 4 Jun 2010 13:11:39 +0900
Message-ID: <B72938E0E9A84DE3A8F66E90AF8D3BE4@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4C077391.8000006@domain.hid>
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

> -----Original Message-----
> Katsuhiko Isono wrote:
> > I use linux-2.6.26 + xenomai-2.4.10 with custom arm(i.mx31) board.
> >=20
> > When realtime application was executed on my environment,
> > application caused the SIGSEGV fault about once every several hours.
> >=20
> > However, when I applied "arm: fix mm switching" patch of=20
> xenomai-2.5 to=20
> > my environment, SIGSEGV fault did not happen.
> >=20
> > There is a following question.
> >  - Is this patch effective also for 2.4.10 ?
> >  - What trouble is corrected with this patch ?
>=20
> The version of the I-pipe patch you are using has another=20
> known bug than
> the one fixed by the "arm: fix mm switching" patch (by the way, to be
> sure that we are talking about the same patch, I would prefer an URL
> pointing to xenomai's gitweb), the bug mentioned here:
>=20
> https://mail.gna.org/public/xenomai-core/2009-08/msg00021.html
>=20
> And the fix for this bug in the I-pipe patches which comes=20
> with Xenomai
> 2.4.10 should fix both bugs.
>=20
> So, in short, do you oberve the segmentation faults when using the
> I-pipe patches which ship with Xenomai 2.4.10 rather than=20
> whatever patch
> you are using for linux 2.6.26?
>=20

Thank you for your reply.

I use linux-2.6.26 of Freescale BSP because I develop custom board.=20
Therefore, because it is not possible to apply IPIPE patch of =
Xenomai-2.4.10, I applied=20
"adeos-ipipe-2.6.26-arm-1.12-00.patch" included in Xenomai-2.4.8 to my =
kernel, and
backported most of the changes up to xenomai-2.5.3.

To fix other trouble, I had already applied similar patch to which you =
presented .
So that, both patches were applied to my kernel, and I could solve =
trouble.

Here is the URL of "arm: fix mm switching".
http://git.xenomai.org/?p=3Dxenomai-2.5.git;a=3Dcommitdiff;h=3D443c2c93ca=
822088fcf9de65cff128858affa0b8


