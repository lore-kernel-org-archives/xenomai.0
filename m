Message-ID: <4685F079.7090202@domain.hid>
Date: Sat, 30 Jun 2007 07:56:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4683EAAB.6080401@domain.hid> <1183151844.6574.157.camel@domain.hid>
In-Reply-To: <1183151844.6574.157.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB0072C72EB529D6B620C50E8"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH-STACK] more timer rework,
 group-based	access control
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB0072C72EB529D6B620C50E8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
>> rt-caps-group.patch
>=20
> Good idea, but totally untested on my side (did I already mention my
> laziness?). Will merge and backport to 2.3.x, XENO_OPT_SECURITY_ACCESS
> was too cheap to be good anyway.

What about moving that scheduling parameter settings into the
trampoline? Some legacy RTOS libs would still have to be adapted.

>=20
>> -----------------------------------
>>
>> See dedicated posts earlier on this list.
>>
>>
>> refactor-timer-modes.patch
>> --------------------------
>>
>> xntimers are now of three kinds: XNTM_MONOREL, XNTM_MONOABS, or
>> XNTM_REALABS. This mode is passed on xntimer_start or on invocation of=

>> higher services (xnpod_suspend_thread e.g.). Users were widely
>> automatically converted and may lack optimisation for the new scheme.
>> Please review carefully for regressions!
>>
>=20
> The only reason for me to whine about this one so far concerns naming
> issues. Why do things need to be that picky?
>=20
> I mean, we have only three modes, relative, absolute monotonic and
> absolute realtime and we discussed in great length why we won't have
> more than those. Given that "relative non-monotonic" would make no sens=
e
> here, and that "realtime" carries a strong notion of absoluteness in
> relation to the wallclock, let's keep "relative", "absolute" and
> "realtime". In any case, "mono" is not widespread enough for people to
> immediately catch "monotonic" anyway, so in case of doubt: I'd say
> _RTFM_.
>=20
> Additionally, having XN_INFINITE and XNTM_RELATIVE/ABSOLUTE/REALTIME is=

> a clear sign of discrepancy. Please, keep my laziness intact, and let's=

> keep XN_ for general macros. I know that this is somehow in
> contradiction with the current practice for the native skin, but I'm
> full of contradictions anyway, so...

Hmm, everything has it's pros and cons, but mostly you are right. Here
is a new proposal, please tell me if it's acceptable so that I can
rebase the rest:

--- xenomai.orig/include/nucleus/types.h
+++ xenomai/include/nucleus/types.h
@@ -62,8 +62,13 @@ typedef int (*xniack_t)(unsigned irq);

 #define XN_INFINITE   (0)
 #define XN_NONBLOCK   ((xnticks_t)-1)
-#define XN_RELATIVE   0
-#define XN_ABSOLUTE   1
+
+/* Timer modes */
+typedef enum xntmode {
+       XN_RELATIVE,
+       XN_ABSOLUTE,
+       XN_REALTIME
+} xntmode_t;

 #define XN_APERIODIC_TICK  0
 #define XN_NO_TICK         ((xnticks_t)-1)


Last issue pending is the xintr locking thing. Will try to have a closer
look again and kick Dmitry for some more explanations of his patch.

Jan


--------------enigB0072C72EB529D6B620C50E8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGhfB7niDOoMHTA+kRArw9AJ4xcr5RQ8OSnZj2Zdl80YR2rip2vgCfZqZk
CPs6rbgdr5EXndLxL/ZDKjk=
=VQwN
-----END PGP SIGNATURE-----

--------------enigB0072C72EB529D6B620C50E8--

