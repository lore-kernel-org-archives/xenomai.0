Message-ID: <4D709FDC.5030402@domain.hid>
Date: Fri, 04 Mar 2011 09:16:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20110302151603.GA14557@domain.hid>
	<4D6E61B6.906@domain.hid> <4D6E8A06.9060508@domain.hid>
	<20110303072147.GA4353@domain.hid>
	<1299137548.2072.3.camel@domain.hid> <4D6F88D6.4010105@domain.hid>
	<4D6F89C8.9060005@domain.hid> <1299156880.2072.6.camel@domain.hid>
	<4D702802.5080001@domain.hid> <1299225060.2107.20.camel@domain.hid>
	<20110304081121.GA12640@domain.hid>
In-Reply-To: <20110304081121.GA12640@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig00285A39062C7632D09C209D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Stuck MSI in normal Linux driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig00285A39062C7632D09C209D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-03-04 09:11, Richard Cochran wrote:
> On Fri, Mar 04, 2011 at 08:51:00AM +0100, Philippe Gerum wrote:
>>
>> I'm not saying this would be impossible to enable MSIs there, I'm just=

>> saying that so far: nobody cared. Terrae incognitae.
>=20
> I care!
>=20
> When the first MSI interrupt from my PCIe card should arrive, running
> on a P2020RBD, the machine locks up. My BDI shows me that both cores
> are going round in circles.
>=20
> * core 1
>   __ipipe_check_percpu_access ()  at kernel/ipipe/core.c:2067
>   ipipe_suspend_domain ()         at kernel/ipipe/core.c:826
>   __ipipe_check_percpu_access ()  at arch/powerpc/include/asm/ipipe_hwi=
rq.h:57
>   ipipe_suspend_domain ()         at kernel/ipipe/core.c:860
>   cpu_idle ()                     at arch/powerpc/kernel/idle.c:64
>   ipipe_suspend_domain ()         at arch/powerpc/include/asm/ipipe_hwi=
rq.h:57
>=20
> * core 2
>   ipipe_suspend_domain ()         at kernel/ipipe/core.c:858
>   cpu_idle ()                     at arch/powerpc/kernel/idle.c:64
>   ipipe_suspend_domain ()         at arch/powerpc/include/asm/ipipe_hwi=
rq.h:57
>=20
> Any thoughts?

Well, if PPC masks MSIs on ack, you may run on a bug check or on an
already acquired Linux spin lock.

Independent of the need to add RT-safe mask/unmask support for MSIs
midterm, you likely first of all want to get rid of this masking in the
fast-path. I suspect it's not needed, also on PPC.

Jan


--------------enig00285A39062C7632D09C209D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk1wn9wACgkQitSsb3rl5xSgEQCbBzQY0OQYJ+xi8QsUXad8SFbP
NloAoKZGfnP3o0jKxUatNyFwzRUX1hOr
=VAIi
-----END PGP SIGNATURE-----

--------------enig00285A39062C7632D09C209D--

