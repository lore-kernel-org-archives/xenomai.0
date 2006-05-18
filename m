Message-ID: <446C2C94.70908@domain.hid>
Date: Thu, 18 May 2006 10:13:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <FDBBB5CC70676540B3EF7CFE83FD94E04A4528@domain.hid>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E04A4528@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig54D74252F46EBA768ED0C9A9"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: LTTng intergration roadmap
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig54D74252F46EBA768ED0C9A9
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

ROSSIER Daniel wrote:
> Hi Jan,
>=20
> Sorry for my late answer.
>=20
>> -----Message d'origine-----
>> De : jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid]
>> Envoy=E9 : lundi, 15. mai 2006 17:18
>> =C0 : xenomai-core
>> Cc : Alexis Berlemont; ROSSIER Daniel
>> Objet : LTTng intergration roadmap
>>
>> Hi,
>>
>> the need for a high-level tracing tool constantly increases with the
>> growing code base of Xenomai applications.
>>
>> Yesterday I started a short discussion with Alexis about the status of=

>> his LTTng combo patch, the Xenomai integration, and the advances of
>> LTTng itself. But there are certainly more people interested in this
>> topic and may contribute ideas, comments, or even concrete code.
>>
>> Daniel, you once said that some of your students would start to work o=
n
>> this topic. In which domain precisely, more at patch level or rather o=
n
>> tools? What is the scheduled beginning and/or deadline for this thesis=
?
>>
>=20
> Yes, it's right; my student is actually working on a first investigatio=
n in order to prepare its diploma project which starts from October to De=
cember.
> So, the most insteresting results should not come up until then.=20
>=20
> The project consists in enhancing LTTng with Xenomai events and some sp=
ecific algorithmic filtering on the related events, such as detecting abn=
ormal situations (deadline misses, priority inversion at a certain level,=
 etc.); the way how events are presented are also an issue to be consider=
ed (events per threads and not per process, different ways to represent t=
he events). We are therefore very open to some proposals and ideas.
> The interesting thing is that Jean-Olivier (the student) will perform h=
is project at Matthieu Denoyers's premises at Montreal; besides, he alrea=
dy visited him to have first discussions. I think this will help us great=
ly.

That's indeed a very thrilling chance to exchange our needs with the
ideas and plans of the LTTng community!

>=20
>> Moreover, does anyone on this list recently tried LTTng on standard
>> Linux? Can we consider it reasonably stable and usable? One new thing
>> about LTTng internals which Alexis brought up were changes in the cust=
om
>> tracing event interface. As this is a rather crucial point with respec=
t
>> to the Xenomai instrumentation, we certainly do not want to change it
>> back and forth until LTTng stabilises.
>>
>> Jan
>=20
> Thanks also to Alexis. The way how to generated lttng events matches wi=
th how we're doing now; we will also examine his Xenomai events and give =
you a feedback.
>=20
> Of course, we keep the forum informed about the progress, but as mentio=
ned before, it risks to evolve quite slowly on our side since the "big" p=
roject is for the three last months.

Ok, as I see this we need a clear roadmap for the time until
Jean-Olivier starts his main work, and it would be good to coordinate
his major topics ahead-of-time to avoid duplicate work. I think we
should soon have some basic LTTng support for Xenomai on one or two
major archs which should allow to track task and domain switches. This
would already be very helpful for analysing deadline misses or
application lock-ups, and it is my wish for the near future.

I do not know all features and potential limitations of LTTng in details
but I guess there will still be more than enough room for improvements
by Jean-Olivier. Do you already have concrete ideas for his work? E.g.
improved instrumentation, better filtering, specific arch support, or
extension to the front-end tools? The clearer his plans are, the better
we can coordinate other activities.

Jan


--------------enig54D74252F46EBA768ED0C9A9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEbCyUniDOoMHTA+kRAhE4AJ4uOWEd162aPMSs9etzKhBK6pvtlwCfX3ht
8UX1TamOFUSJ7ZPzP8X0zOw=
=K2fh
-----END PGP SIGNATURE-----

--------------enig54D74252F46EBA768ED0C9A9--

