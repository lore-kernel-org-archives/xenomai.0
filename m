Message-ID: <463A1B28.7090701@domain.hid>
Date: Thu, 03 May 2007 19:26:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4639D724.5010702@domain.hid>	<DD39B5C3F4963040ADC9768BE7E430CB01E43D41@domain.hid>	<1178204088.29605.85.camel@domain.hid>
	<4639FAC7.9060207@domain.hid>	<1178208712.29605.109.camel@domain.hid>
	<463A1174.60105@domain.hid> <1178212646.29605.120.camel@domain.hid>
In-Reply-To: <1178212646.29605.120.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8AE669CAD74E7FDDDFB60E1B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Latency calculation and test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8AE669CAD74E7FDDDFB60E1B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2007-05-03 at 18:44 +0200, Gilles Chanteperdrix wrote:
>> Philippe Gerum wrote:
>>> On Thu, 2007-05-03 at 17:07 +0200, Gilles Chanteperdrix wrote:
>>>
>>> That was not my point. My point was: don't stuff huge semi-random val=
ues
>>> into /proc/xenomai/latency to work around terrible jittery especially=

>>> when porting Xenomai over new platforms, because this is _likely_ the=

>>> sign of something going wrong elsewhere.
>>>
>>> E.g. An oldish 90Mhz classic pentium exhibits ~25 us core latency
>>> figures with Xenomai; some ARM hw may require more because of
>>> unfortunate memory sub-systems, but in any case, you have to
>>> _understand_ (e.g. using the tracer) why it is so, first.
>> I agree. I still have to see for myself why these damned ARMs have suc=
h
>> high latencies.
>>
>=20
> Stelian might jump in as well, but IIRC, a problem we saw on the
> Integrator was due to the cost of TLB flushing upon switch_mm with hw
> interrupts off. As a consequence of this, even regular Linux operations=

> would induce jittery for the real-time domain, since enabling hw
> interrupts while invalidating is a no-go (actually, it's a go, even a
> jump, but out of the window, to be precise...).

May I throw in my, granted, rough idea of establishing coloured caches
again? There should exist some older work for Linux already (no cite at
hand :(). $Someone would have to analyse its practicability and the
chances to reserve certain colours for RT apps. Then one could make any
dynamic colour owner change (inside Linux) preemptible by Xenomai
because the latter will never need to flush TLB entries at all nor will
collide with Linux used colours. Just nice theory, I never looked at
real HW nor code yet.

Jan


--------------enig8AE669CAD74E7FDDDFB60E1B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGOhsoniDOoMHTA+kRAl/nAJ4yLdosHUIXp4rQ59xwfVYyS4HioQCdGwvF
3ikAi9AUJxhIA95rJ/h7ssU=
=2pH5
-----END PGP SIGNATURE-----

--------------enig8AE669CAD74E7FDDDFB60E1B--

