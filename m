Message-ID: <47ADCF7E.8050505@domain.hid>
Date: Sat, 09 Feb 2008 17:06:22 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47ACD0FF.8000601@domain.hid> <47ADC480.7010204@domain.hid>
In-Reply-To: <47ADC480.7010204@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig05C728ED3D8F17B1BF2CB447"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] Optional timer freeze during ptracing
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig05C728ED3D8F17B1BF2CB447
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Freezing all Xenomai timers while just a single RT application is unde=
r
>> ptrace control can be helpful in certain debugging scenarios, but it c=
an
>> as well be harmful when other parts of the systems have to continue to=
 work.
>>
>> I brought this concern up back in 2006, and I originally thought we ma=
y
>> address this by freezing per process. But this is far too complex for =
a
>> simple problem like this: Just make the whole thing configurable, and
>> keep it off by default so that -ideally- only users who are aware of t=
he
>> side effects will arm it.
>>
>=20
> No, it's the other way around, you know when you don't want a timer to
> be blocked because it serves some purpose that goes beyond the
> application duty, like keeping a RTnet connection alive through which
> you happen to debug; on the other hand, all other timers relate to the
> logic the application implements, so you most often want them to track
> the debugging state so that they don't mess up behind you back when the=

> debugger halts the application. Blocking timers during ptracing should
> be on by default, no need to break a known behaviour Xenomai had for
> ages for rare cases when some of them are also used to maintain some
> external activity alive. This is the exception, and as such, those
> timers should be marked as non-blockable in the code that defines them;=

> a global knob may then switch them to blockable if needed.

You focus on single application, or single function per system.
Moreover, following this logic, you would have to suppress all
interrupts as well while ptracing some app.

>=20
> An intermediate approach would be to force the threads ptimer and rtime=
r
> as blockable ones, and use a global flag to switch the rest as
> non-blockable, albeit this may cause non-related watchdogs to keep
> triggering, which most of the time could be a real pain in the neck whe=
n
> debugging.

That' sounds better, specifically switching to a XNTIMER_BLCK logic.
What about freezing the ptimer and rtimers of all xnthreads in ptraced
processes? That shouldn't require us to track additional information in
xntimer_t about its owner.

Jan


--------------enig05C728ED3D8F17B1BF2CB447
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHrc9+niDOoMHTA+kRAhscAJ91x5Ymzm8N4qxxenQT0aGFYVjFiwCeKCdD
RwTJf7HGk83SHTmMp6lAYVg=
=nEMR
-----END PGP SIGNATURE-----

--------------enig05C728ED3D8F17B1BF2CB447--

