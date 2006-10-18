Message-ID: <45368EBD.6020608@domain.hid>
Date: Wed, 18 Oct 2006 22:29:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH 0/3] Reworked nucleus statistics
References: <452E9ACD.20800@domain.hid> <1161178927.5053.81.camel@domain.hid>
	<b647ffbd0610181306k65d7308ei10783073e550f0d1@domain.hid>
In-Reply-To: <b647ffbd0610181306k65d7308ei10783073e550f0d1@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB1F1BCA9274FA42A35AC34C6"
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB1F1BCA9274FA42A35AC34C6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
>> ...
>>
>> Dmitry, are there other issues I'm missing, that you think would be
>> better solved using a simpler accounting model?
>=20
>=20
> So according to you, the more complex model gives users a better
> understanding of behavior of their drivers/applications?
>=20
> ...
>>   0  0      0          201357   0     00000000      2.8  IRQ1: handler=
1
>>   0  0      0          5811       0     00000000      2.4  IRQ1: handl=
er2
>=20
> what is % in this case?
>=20
> it accounts :
>=20
> (1) time spent in ISR;
>=20
> (2) some prologue for the very first shared handler and epilogue - for =
the
> last one.

(2) is the rare case that multiple IRQs happen at the same time on the
same line. As I said, the case when only one occurs and the others are
needlessly tested is more often.

>=20
> So in fact, part (1) can be the same for both handlers (say, just the s=
ame
> code), N can be =3D=3D M (irq frequency) but % numbers are different. I=
s it
> fair?
>=20
> The "simple" model accounts only (1) to ISR time statistics so it's alw=
ays
> easy to say what's this number means. It just describes the load caused=

> by a
> corresponding ISR handler.

[sorry, Dmitry, for this replay ;)]
I designed this instrumentation with a fairly old question of mine in
the head: "What does raising this IRQ, say, at 1 KHz costs the system?"
And this question includes not just the ISR itself, but also the
disturbance due to potential rescheduling.

>=20
> Ok, if somebody wants to tell me that shared interrupts is an exception=
al
> and rare case, then I got it. But anyway, as long as we want to provide=

> per-ISR (and not per-IRQ) statistics, it adds some unclearness (unfairn=
ess)
> on how to consider reported values.

Shared Interrupt are indeed an exception, and if we were only discussing
non-shared instrumentation here, I guess it wouldn't be that tricky to
find a common model. If you look at that part, I'm basically shifting
some instrumentation point after the rescheduling, that's it.

>=20
> I also expected that those prologue and epilogue are likely to cause mu=
ch
> lighter "disturbance" being added to a preempted thread (because such
> threads normally should have higher % load wrt ISR anyway).
>=20
> Regarding accounting only XN_ISR_HANDLED cases. At least, I suppose,
> ISR[n+1] doesn't get accounted the interval of time spent by ISR[n] to
> report XN_ISR_NONE?
>=20
> Which brings us to the next point that I didn't get it from the 3-d pat=
ch
> after looking at it brielfy (well, I didn't apply it yet).
> And in general, it's getting a bit more difficult to see interrupt hand=
ling
> details behind statistic-handling ones, esp. in the case of shared
> interrupts. Of course, that's really a minor issue as long as users may=
 get
> better statistic information :)
>=20
> ok, that was kind of a summary, I hope I didn't forget anything else as=
 we
> already had quite a long discussion with Jan.
>=20
> all in all (yep, I like repeating myself :) IMHO the simple model, at
> least,
> clearly answeres a question what's behind the numbers while the complex=
 one
> makes the answer more complex trying to be fair in one place and at the=

> same
> time adding "unfairness" in another place.
>=20

I don't see that the remaining unfair parts are significant - at least
/wrt what I want to analyse here.

Jan


--------------enigB1F1BCA9274FA42A35AC34C6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNo69niDOoMHTA+kRAvUsAJ91uwV994qaRsuUj5U8ApJo0YG8MgCfZUlD
UER4654hRrJieKNrb0cRQGI=
=lb9w
-----END PGP SIGNATURE-----

--------------enigB1F1BCA9274FA42A35AC34C6--

