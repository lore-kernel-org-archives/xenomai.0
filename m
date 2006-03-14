Message-ID: <441748D5.9050305@domain.hid>
Date: Tue, 14 Mar 2006 23:51:01 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RTDM and Timer functions
References: <200603091443.25714.lbocseg@domain.hid>
	<200603141640.18539.lbocseg@domain.hid> <4417279B.4030103@domain.hid>
	<200603141932.55374.lbocseg@domain.hid>
In-Reply-To: <200603141932.55374.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA9A0E87BAFBA5733B657A326"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA9A0E87BAFBA5733B657A326
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> I really tried to not answer this message and finish the "endless threa=
d" you=20
> mentioned, but I couldn't resist. ;) Maybe this will be the last post f=
rom my=20
> own on this thread and will begin writing in the new thread. See below,=
=20
> please.

I see no problem in continuing it. I guess most subscribers already
created special deletion filter for its keywords anyway. ;)

> ____________________________________________________________
> Em Ter=E7a 14 Mar=E7o 2006 17:29, Jan Kiszka escreveu:
>=20
>> ...
>>
>> Ok, your framework is effectively aiming for relative times here, that=
's
>> clear now. But your driver will deliver individual frames with absolut=
e
>> timestamp, right?
>=20
> Right.
>=20
>> Then it's up to the user to NOT mix up these=20
>> timestamps with dates obtained from the system clock. You will have to=

>> state this clearly!
>=20
> Sure, of course. No problem with that.
>=20
>> Moreover, when considering the TSC as high-resolution timestamp source=
,
>> this is not applicable on SMP / multicore systems. Those tend to have
>> unsynchronised and drifting TSCs. So if the first picture was taken on=

>> one CPU and the second on some other...
>=20
> Unfortunately I can not arguee on that for now since I know almost noth=
ing=20
> about SMP systems. I'll take a look on the topic and hopely soon I'll r=
eturn=20
> you what I think about it.

Then let me continue my sentence:

=2E.. the timestamps can not be used to calculate the delay between both
of them. The reason is that you are lacking the offset between both TSC
sources at the respective timestamp acquisition dates.

>=20
>>> I'm not talking especifically about this application, but giving you =
a
>>> general idea of what is not possible to do currently with RTDM if the=

>>> application set the timer to periodic.
>> And as I have this general view in mind, I want to avoid that the TSC
>> issue gets exported via RTDM drivers to the user. That's already
>> problematic for the other skins, but having to write special notes all=

>> over the documentation of dozens of driver using mixed clocks would be=

>> very unhandy.
>=20
> I don't understand why adding a new function like this would change a l=
ot the=20
> documentation. I really can not see your worries... If you could give m=
e a=20
> practical example, maybe it would be easier for me...

A driver that reports TSC timestamps instead of system clock timestamps
to the user has to state this fact and its potential effects in periodic
mode - as long as both clocks are out of sync. My idea is now to
synchronise them and report corrected TSC-based timestamps via
rtdm_clock_read() when in periodic mode. No need for new functions, use
the old one, and all your problems would be solved automatically.

>=20
>> I see the need for having a high-resolution timestamp aside a
>> low-overhead and low-resolution timer now,=20
>=20
> good, got an ally. ;)
>=20
>> and I think we need to look=20
>> for a way to avoid its negative sides.
>=20
> First I need to understand better what exactly are the negative sides..=
=2E
>=20
>> Not sure yet if it will be=20
>> feasible, but I will come up with a new thread on this topic soon...
>=20
> Yes, I've seen. I'll discuss next messages there.
>=20
> Thank you,
>=20
> Rodrigo.
>=20
> =09

Jan


--------------enigA9A0E87BAFBA5733B657A326
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEF0jVniDOoMHTA+kRAiKcAJ9KLuiqunrQPVA0I6ky80yrpJNDsQCggA6K
4UDHLdhJAZnqIm5k7gW/Q6E=
=dW3e
-----END PGP SIGNATURE-----

--------------enigA9A0E87BAFBA5733B657A326--

