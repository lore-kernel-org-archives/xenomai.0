Subject: Re: [Xenomai-core] RTDM timerbench problems
From: Stelian Pop <stelian.pop@domain.hid>
In-Reply-To: <17340.951.310449.498691@domain.hid>
References: <1136391676.5443.57.camel@domain.hid>
	<17340.951.310449.498691@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Date: Wed, 04 Jan 2006 18:28:54 +0100
Message-Id: <1136395735.5443.68.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
Cc: xenomai-core <xenomai@xenomai.org>

Le mercredi 04 janvier 2006 =E0 18:19 +0100, Gilles Chanteperdrix a
=E9crit :
> Stelian Pop wrote:
>  > Before hanging, sometimes it just prints:
>  > 	Unable to handle kernel NULL pointer dereference at virtual address=
 0000004d
>  >=20
>  > Sometimes the oops is more complete (note that sometimes it also han=
gs in the middle of
>  > the printout):
>  > 	Unable to handle kernel NULL pointer dereference at virtual address=
 0000004d
>  > 	pgd =3D c0004000
>  > 	[0000004d] *pgd=3D00000000
>  > 	Internal error: Oops: 817 [#1]
>  > 	Modules linked in: xeno_timerbench
>  > 	CPU: 0
>  > 	PC is at xnpod_schedule+0x6b4/0x7f0
>  > 	LR is at xnpod_schedule+0x54c/0x7f0
>  > 	pc : [<c0056cc4>]    lr : [<c0056b5c>]    Not tainted
>  > 	sp : c7d41830  ip : c79e8044  fp : c7d41860
>  > 	r10: c0283c2c  r9 : c0282
>  >=20
>  > Does this rings a bell to someone ?=20
>=20
> Not much, but two remarks:
> - last summer, there use to be such a problem on x86 because of some
>   wrong FPU switch. So, is FPU enabled ? Are you compiling latency with
>   -msoft-float ?

Yes, everything is soft float.

>   When announcing the ARM Adeos port, you told us that not all
>   exceptions were trapped by the Adeos patch. If one of the FPU
>   exceptions is not trapped, it would explain why we do not get the
>   usual message "Invalid use of FPU at ..." before the oops.

Time has passed and the exceptions are now trapped.=20

> - as far as I know, xnpod_schedule never recurses, so, there is little
>   chance for PC and LR to be both in xnpod_schedule. If I am not wrong,
>   it means that you will have to have a look at the disassembly (sorry)
>   and see in really what functions the bugs happen. Sometimes the -r an=
d
>   -S option of objdump help...

I'll take a look.=20

Stelian.
--=20
Stelian Pop <stelian.pop@domain.hid>


