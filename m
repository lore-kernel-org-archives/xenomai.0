Message-ID: <43C58820.5010006@domain.hid>
Date: Wed, 11 Jan 2006 23:35:12 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency kernel part crashes on ppc64
References: <43C12304.4040802@domain.hid>	<43C12CEC.8070403@domain.hid>	<43C14453.3040907@domain.hid>	<1136754149.17443.21.camel@domain.hid>	<43C18CE1.5040509@domain.hid>	<43C1CFC2.8040104@domain.hid>	<43C21BA7.4050806@domain.hid>	<43C220FE.4010100@domain.hid>	<17346.57955.432284.905332@domain.hid>	<43C37926.5060007@domain.hid>
	<17349.33404.156585.857948@domain.hid>
In-Reply-To: <17349.33404.156585.857948@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCCB9D0E2D6EF794EA393A9A3"
Sender: jan.kiszka@domain.hid
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCCB9D0E2D6EF794EA393A9A3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Philippe Gerum wrote:
>  > >  > Likely not this time (keep it cold anyway, who knows); I strongly suspect a bug in 
>  > >  > xnarch_switch_to() for all archs but x86
>  > > 
>  > > Now that you are talking about it, I may be the one who owes a beer to
>  > > everyone by first having put a bug in ia64 context-switch code... If I
>  > > am not wrong, the bug should be observed on ia64 too. Unfortunately, I
>  > > am unable to compile my ia64 kernel right now, so I wrote a patch for
>  > > power PC, and would be glad if some power PC owner could try it.
>  > > 
>  > 
>  > Nope, same lockup with hybrid scheduling.
> 
> The latency -t 1 crash may be observed on ia64 too.
> 
> But it does not seem to be due to the bug I was suspecting in context
> switch code.
> 

What about the PPC world? I saw some SVN commits claiming to fix this
(also for blackfin) - but there was no "Hey, it's fixed now!" on the
mailing list.

Jan


--------------enigCCB9D0E2D6EF794EA393A9A3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDxYggniDOoMHTA+kRAiiIAJ94Ey/nTmFP+AjhQ5K7jzGGCrYrhgCeKlXk
iw4C6lL1o6dDZ0YaPQrp5tI=
=qztt
-----END PGP SIGNATURE-----

--------------enigCCB9D0E2D6EF794EA393A9A3--

