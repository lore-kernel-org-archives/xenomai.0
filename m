Message-ID: <4C0AB817.2070000@domain.hid>
Date: Sat, 05 Jun 2010 22:48:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4C07BA95.9080402@domain.hid>
	<1275759652.18250.178.camel@domain.hid>
	<4C0A9960.8040609@domain.hid> <4C0AA430.4000205@domain.hid>
In-Reply-To: <4C0AA430.4000205@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCE3CFDC3DACA359D43E2ED0D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [RFC][PATCH 2/2] x86: Add support for
	ipipe_get_irq_regs
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCE3CFDC3DACA359D43E2ED0D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Thu, 2010-06-03 at 16:22 +0200, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@domain.hid>
>>>>
>>>> Implement the x86 arch bits for ipipe_get_irq_regs support. This all=
ows
>>>> to drop __ipipe_tick_regs and use the new service instead.
>>> I'm unsure whether this patch would actually replace __ipipe_tick_reg=
s
>>> properly, particularly regarding how the profiling code works.
>> tick_regs are a "workaround", this approach appears to me way closer t=
o
>> how native works.
>=20
> We do not want ipipe_tick_regs to work the way the native kernel works.=

> We want to fool the kernel by passing it the value of the registers at
> the moment of the real timer tick so that its accounting works more or
> less reliably. When the kernel used the real registers it got the
> accounting wrong.

Right, though current tick_regs approach is not accurate either: the
preempted task gets the full time slice accounted, neglecting the actual
schedule inside the preempting domain.

But to get this right, I-pipe would have to update the stats on behalf
of Linux, maybe even supported by Xenomai delivering the current shadow
task. Not sure if it was worth the effort, though.

Jan


--------------enigCE3CFDC3DACA359D43E2ED0D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkwKuBcACgkQitSsb3rl5xTQZwCg2trha0hGqzgyGV/Held7lR2H
+2MAmgOY2HQaldz8Z+f3o+X0ACeB+lot
=Y0Gb
-----END PGP SIGNATURE-----

--------------enigCE3CFDC3DACA359D43E2ED0D--

