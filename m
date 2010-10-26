Message-ID: <4CC72D27.3010607@domain.hid>
Date: Tue, 26 Oct 2010 21:33:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20101007115728.GA24500@domain.hid>	
	<4CADBDC2.8080600@domain.hid>
	<20101008070148.GB2255@domain.hid>	
	<1286530884.13186.109.camel@domain.hid>	
	<20101013090353.GA6902@domain.hid>	
	<1286961375.1759.71.camel@domain.hid>	
	<20101013092617.GB6902@domain.hid>	
	<1286981521.1759.83.camel@domain.hid>	
	<1288025329.26618.132.camel@domain.hid> <4CC5C80E.2070004@domain.hid>	
	<1288033731.26618.161.camel@domain.hid> <4CC5D742.9080307@domain.hid>	
	<1288034435.26618.164.camel@domain.hid> <4CC5D8FF.5080109@domain.hid>	
	<1288041166.26618.182.camel@domain.hid> <4CC5F525.7040206@domain.hid>	
	<1288042858.26618.204.camel@domain.hid> <4CC5FAE6.6010305@domain.hid>
	<1288068231.26618.224.camel@domain.hid> <4CC665A1.9040707@domain.hid>
In-Reply-To: <4CC665A1.9040707@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig69D7192D4130E5E4B034115F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] kernel oopses when killing realtime task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig69D7192D4130E5E4B034115F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 26.10.2010 07:22, Jan Kiszka wrote:
> Will come up with two patches for stable, one for I-pipe and one for
> Xenomai, later today. Then we can discuss which cases I'm missing.

While meditating over my approach (which turned out to be less trivial
as expected - of course), I also reconsidered your current patches. The
concerns I had (forwarding of spurious IRQ to Linux) turned out to be
harmless (Linux will ignore such few spurious events).

Still, the approach to sync via shutting down the line for the current
domain before xnintr_irq_detach doesn't work for us. It only works if
xnintr_irq_detach actually detaches from the line, but it breaks if
there are users remaining.

We need intrlock to check if we are the last user while removing
ourselves from the list. And we cannot postpone line detaching after the
critical section as we may otherwise race with the next registration on
that line. IOW, I don't see how to solve the issue without moving the
drain after the detach and making the detach safer instead.

Do you agree?

Jan


--------------enig69D7192D4130E5E4B034115F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkzHLS0ACgkQitSsb3rl5xQBPwCfarRJh6jtwwH4W5S5Tmvgy3+K
t8AAmQHicVGXzgMthMraYo0sJnfaIDbD
=7X+d
-----END PGP SIGNATURE-----

--------------enig69D7192D4130E5E4B034115F--

