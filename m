Message-ID: <482094F1.4080200@domain.hid>
Date: Tue, 06 May 2008 19:27:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20080506160603.216980@domain.hid>
In-Reply-To: <20080506160603.216980@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB83E71AFF6FC94EFA7862714"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Pros/Contras Xenomai - CONFIG_PREEMPT_RT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Karl Reichert <Karl-Trampe@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB83E71AFF6FC94EFA7862714
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Karl Reichert wrote:
> Hello all,
>=20
> I'm currently reading some documents about (standard) linux kernel 2.6.=
23 and it's latest changes. I saw, that it has high resolution timers ava=
ilable, which can reduce interrupt latency a lot. It's said that they als=
o reduced critical sections occurence and their duration, all in all brin=
ging linux closer to real time requirements.
>=20
> I also checked the real time patches of Ingo Molnar and Thomas Gleixner=
 (CONFIG_PREEMPT_RT) and the wiki [1] states, that their patches are repl=
acing most kernel spinlocks with mutexes that support priority inheritanc=
e, as well as moving all interrupt and software interrupts to kernel thre=
ads. Latency tests state times of 24us for a Pentium 4, 2.8 GHz with thei=
r patches applied. [2], [3]
>=20
> I see a lot of advantages from this solution:
> 1) As their patches do have a good chance to be included in linux kerne=
l in future, one doesn't has to patch anymore the kernel to get real time=
 behavoir.

The right tool for the right purpose: -rt serves about 80-90% of
real-time use cases (starting with soft RT, ending with "hard" RT, up to
a certain degree). Once -rt is mainline (chances fell again that this
may happen this year, I would currently see it in 2009), you should have
an easier time setting up the kernel - but that's only one part of the
full story.

> 2) There is only one API to use. No matter if you are creating a progra=
m as real time task or not, you can use the same API.

Someone (no names here ;) ) recently told me: "Actually, I would prefer
to use -RT, because Xenomai will probably tell me how broken (from RT
POV) my application is." :)

In other words: If you have strict RT requirements, you have to design
your application very carefully anyway. In that case the "we make
everything RT" approach of -rt can be counterproductive (it cannot
fulfill that promise, but it doesn't tell you immediately). In contrast,
the dual scheduler of Xenomai provides clear separation and communicates
this to the application (when being asked for).

In case you can live with some uncertainty if all invoked services
always behave like they do under test conditions, then working against
-rt can be more comfortable, no questions.

> 3) One can use CPU isolation on dual core machines, making one core run=
ning only real time tasks and the other the rest.

Also here: Beware of traps and pitfalls! If you follow recent CPU
isolation discussion on LKML, you'll find the missing pieces of mainline
(and -rt) for full isolation.

> 4) As they don't use anything like nucleus, there is less overhead.

Depends. The logic required to apply sleeping locks with priority
inheritance to wide parts of the kernel is far from being trivial or
light-weight. Recently, some patches with benchmarks popped up to reduce
the "collateral damage" of this conversions (noticeable I/O slowdown -
of course only relevant if you do noticeable Linux I/O in parallel to
your RT load). On the other hand, having only one scheduler, keeps
caches warmer and can compensate for some of the downsides if you have a
high context switch rate.

However, to my experience, Xenomai provides better RT (worst case)
performance, generally no longer orders of magnitude better (unless -rt
runs into problems), but measurable. But the precise difference is
highly platform dependent, surely not generalizable from "big honking"
server boxes down to few-10-MHz embedded processors.

>=20
> These are the thoughts running through my mind at the moment. I would l=
ike to discuss these with you. What do you think about this? Where do you=
 see pros and contras for xenomai / CONFIG_PREEMPT_RT?

It all depends on _your_ requirements. Make sure you are fully aware
of them. That's easily said, but not always that easy to fulfill, I
know. If unsure: Developing against Xenomai will not cause harm to your
application design, rather the contrary. Pick POSIX as API, and you will
keep all options open for the future.

Jan

PS: All the above assumes that your kernel (-rt or Xenomai) doesn't
expose critical bugs in your scenario. You can always run into
situations where unfixed bugs stop you from using A or B. E.g, we had to
drop -rt from further consideration for now as neither we nor the
community was able to understand or fix the show-stopping issues we
found on our boxes. Also Xenomai ran into bugs, but so far only fixable
or "work-around-able" ones.


--------------enigB83E71AFF6FC94EFA7862714
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFIIJT0niDOoMHTA+kRAnp5AJ0Z/MHPAbogfITe6Bplhj988fU9bwCfdnwb
1xqPOIuw5CJjdmvJWAplOXk=
=QKiz
-----END PGP SIGNATURE-----

--------------enigB83E71AFF6FC94EFA7862714--

