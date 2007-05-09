Message-ID: <4641ECCE.6010303@domain.hid>
Date: Wed, 09 May 2007 17:46:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <Pine.LNX.4.64.0705091531560.22958@domain.hid>
	<4641B5CF.80303@domain.hid>	<22908039.1178707932628.JavaMail.ngmail@domain.hid>	<13086080.1178713660670.JavaMail.ngmail@domain.hid>
	<20669310.1178719111471.JavaMail.ngmail@domain.hid>
In-Reply-To: <20669310.1178719111471.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig145D44F699B9B1712D35D870"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai and futexes - Native API optimized for
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig145D44F699B9B1712D35D870
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Herman and Jan,
>=20
> thanks for your replies.
> I agree that is the best to do an approach that avoids critical section=
s.
> However, we have here the typical "historical heritage". Parts of this =
code have
> been ported from another system (where they worked with cli/sti).
> Other parts are generated from a third party code generator.
> This code generator (which is not in my hand) is designed primarily
> for offline simulation within a single task.
> Thus, the guys that programmed that, did not care about multi thread pr=
ogramming.
> The programs write the results into output variables.
> To avoid critical section I have now to do either
> an additional copy (also quite expensive) of the output data to a locat=
ion=20
> where I can work without any risk of being interrupted or I lock the ac=
cess
>  to the data.
> That means either I do lots of additional copy actions (also quite expe=
nsive) or I work
> with the critical region.
>=20
> Thus for me it is not an either - or - option.
> I can not optimize the code to be 100% free of critical sections (howev=
er it can be done in
> some parts..). That means I still have to count on the IPC provided by =
the OS.

OK, seeing your motivation, I would now like to roughly sketch to issue
I see about futexes for Xenomai:

You need user space and kernel space working on the same piece of memory
atomically AND you need to get the contention case right. The latter is
tricky because Xenomai does -for various reasons like robustness- the
sequence "try to acquire, fail, enqueue waiter, suspend" under one
common lock. As with futexes that "try to acquire" may cause page faults
(in buggy programs), you need to redesign things.

I have no model for such a redesign at hand (nor would I like to think
deeper and detract myself from other pending stuff), but my feeling is
that it will be at least, well, challenging. Looking at kernel futex
code and watching its pending issues, you may see that this is actually
not so much Xenomai-specific.

Anyway, go wild people, maybe I'm just too pessimistic. :)

Jan


--------------enig145D44F699B9B1712D35D870
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGQezPniDOoMHTA+kRAtaTAJ9GjsybNeXTLHkAcKLCqfSyAcqlYACfacip
wAC2a1azgMuCPkHbPrLvavY=
=on+R
-----END PGP SIGNATURE-----

--------------enig145D44F699B9B1712D35D870--

