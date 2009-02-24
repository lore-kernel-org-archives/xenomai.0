Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Feb 2009 17:46:42 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D590FE0@domain.hid>
In-Reply-To: <49A30B86.7080106@domain.hid>
References: <67b6b3430902231216k11c5addahaafef823075e7e54@domain.hid>
	<49A30B86.7080106@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] Error building
	2.6.27.19w/	adeos-ipipe-2.6.27.19-x86-2.2-06.patch
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org, Mark Saiia <mark.saiia@domain.hid>
Cc: xenomai@xenomai.org

Sorry for all the emails. As the FPU issue is still present on the geode
boards, I had to disable 3DNOW in the kernel in order to run stable.
Things are stable on my end now with the patch. Hopefully Mark can test
it with our application as he has access to the hardware. I didn't have
issues with fs/buffer.c with my own tests, however.

Steven


> -----Original Message-----
> From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-
> bounces@domain.hid] On Behalf Of Philippe Gerum
> Sent: Monday, February 23, 2009 1:48 PM
> To: Mark Saiia
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] Error building 2.6.27.19w/ adeos-ipipe-
> 2.6.27.19-x86-2.2-06.patch
>=20
> Mark Saiia wrote:
> > When building 2.6.27.19 w/ adeos-ipipe-2.6.27.19-x86-2.2-06.patch. I
> get
> > the following error.
> >
> > CC      kernel/xenomai/arch/generic/hal.o
> > kernel/xenomai/arch/generic/hal.c: In function
'rthal_irq_host_pend':
> > kernel/xenomai/arch/generic/hal.c:301: error: void value not ignored
> as
> > it ought to be
> >
> >
> > Has anyone else ran into this issue?
> >
>=20
> This patch is supported by the v2.4.x maintenance branch, or the
> Xenomai dev trunk.
>=20
> > Deleting the return on that line appears to fix the issue.
> >
>=20
> This will work as well.
>=20
> > Mark Saiia
> >
> >
> >
---------------------------------------------------------------------
> ---
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
>=20
>=20
> --
> Philippe.
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

