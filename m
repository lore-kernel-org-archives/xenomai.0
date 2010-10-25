Message-ID: <4CC5C80E.2070004@domain.hid>
Date: Mon, 25 Oct 2010 20:10:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20101007115728.GA24500@domain.hid>	<4CADBDC2.8080600@domain.hid>
	<20101008070148.GB2255@domain.hid>	<1286530884.13186.109.camel@domain.hid>	<20101013090353.GA6902@domain.hid>	<1286961375.1759.71.camel@domain.hid>	<20101013092617.GB6902@domain.hid>	<1286981521.1759.83.camel@domain.hid>
	<1288025329.26618.132.camel@domain.hid>
In-Reply-To: <1288025329.26618.132.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4E78637C4557350E3B3D1AB5"
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
--------------enig4E78637C4557350E3B3D1AB5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 25.10.2010 18:48, Philippe Gerum wrote:
> On Wed, 2010-10-13 at 16:52 +0200, Philippe Gerum wrote:=20
>>>
>>> Should we test IPIPE_STALL_FLAG on all but current CPUs?
>>
>> That would solve this particular issue, but we should drain the pipeli=
ne
>> out of any Xenomai critical section. The way it is done now may induce=
 a
>> deadlock (e.g. CPU0 waiting for CPU1 to acknowledge critical entry in
>> ipipe_enter_critical when getting some IPI, and CPU1 waiting hw IRQs o=
ff
>> for CPU0 to release the Xenomai lock that annoys us right now).
>>
>> I'll come up with something hopefully better and tested in the next
>> days.
>>
>=20
> Sorry for the lag. In case that helps, here is another approach, based
> on telling the pipeline to ignore the irq about to be detached, so that=

> it passes all further occurrences down to the next domain, without

Err, won't this irritate that next domain, ie. won't Linux dump warnings
about a spurious/unhandled IRQ? I think either the old handler shall
receive the last event or no one.

Why this complex solution, why not simply draining (via critical_enter
or whatever) - but _after_ xnintr_irq_detach, ie. while the related
resources are still valid?

Jan


--------------enig4E78637C4557350E3B3D1AB5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkzFyBQACgkQitSsb3rl5xT+NwCgm+GjFXBPOAOuuPYdkonvInCP
n1EAoNpKRFaqe6umlKNN3Yhu7FLUAtP+
=zIB+
-----END PGP SIGNATURE-----

--------------enig4E78637C4557350E3B3D1AB5--

