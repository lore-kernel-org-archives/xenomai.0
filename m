Message-ID: <4651DBC7.1000305@domain.hid>
Date: Mon, 21 May 2007 19:49:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <465099CE.2010004@domain.hid> <4651AFF9.5030402@domain.hid>	
	<1179763621.473.145.camel@domain.hid> <4651C70E.8080908@domain.hid>
	<1179766310.473.168.camel@domain.hid>
In-Reply-To: <1179766310.473.168.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDAD6CD97D5340057D0D4A9FC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [BUG] module_put called over non-root domain
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
--------------enigDAD6CD97D5340057D0D4A9FC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Mon, 2007-05-21 at 18:21 +0200, Jan Kiszka wrote:
>>> This code has to work with an awful lot of runtime situations, includ=
ing
>>> those raised by ptracing/GDB, and thread signaling in general, so tes=
t
>>> harnessing is key here.
>> Well, what about listing those scenarios and their requirements in a
>> comment if this is so critical?
>=20
> Eh, because I'm likely lazy as you are? :o>
>=20

Sigh, that's not a fair argument... ;->

>>  That may make /me feel better as I could
>> more easily go through them and check changes like those of today
>> against them.
>>
>=20
> Those situations have been encountered when debugging, there is no
> limited set of golden rules to document, I'm afraid, this would have
> been far too easy. The entire signal handling wrt ptracing is a terribl=
e
> mess - somebody must have endured a very bad Karma to implement this th=
e
> way it is (long life utrace). The ChangeLog might be a good start for
> comments related to fixes in shadow.c/unmap and various head banging
> sessions I went through regarding this (2.4/2.6).
>=20
>>>>  and I'm furthermore
>>>> not sure of the old code was handling SMP scenarios safely (What if =
the
>>>> thread to be unmapped was running on different CPU than xnshadow_unm=
ap?
>>>> How to ensure test-atomicity then?).
>>>>
>>> This wakeup call is there to release emerging shadows waiting on thei=
r
>>> start barrier that get killed before start. Other regular cases imply=

>>> that either the current thread is exiting - in which case this is a n=
o
>>> brainer, or it has been sent a group kill signal, in which case it ha=
s
>>> to wake up anyway.
>> I didn't _removed_ cases where the wakeup takes place, I _added_ some
>> more my removing the test.
>>
>=20
> In the light of what I have just written, you would only cause useless
> wakeups doing so.

My question was if the test for "useless" was really race-safe on SMP.
Then we could introduce it again in the APC handler. Otherwise, it might
be safer to live with some degree of uselessness.

>=20
>>>> Well, this thing seems to work,
>>> It does, actually.
>>>
>>>>  but it doesn't leave me with a good
>>>> feeling. IMHO, there are far too many cleanup cases with all the
>>>> combinations of non-shadow termination, shadow self-termination,
>>>> termination on task exit, various SMP scenarios, etc.
>>>>  Moreover, quite a
>>>> lot of stuff is executed in atomic scheduling hooks (namely on clean=
up).
>>>> At least for shadow threads, I don't think all of this is necessary.=

>>>> Actually, deferring most of the uncritical cleanup work into Linux
>>>> context would make things more regular, easier to review, and likely=

>>>> less disturbing for overall system latencies. I know that atomic
>>>> scheduling hooks are required to implement certain skins, but I don'=
t
>>>> see why janitor work should be done there as well. And we also still=

>>>> have that tiny uncleanness on shadow threads termination around TCB
>>>> release vs. hook execution.
>>> Talking about xnshadow_unmap, and as your patch illustrates, what you=

>>> could postpone is basically the first part of the routine, which upda=
tes
>>> the reference counts. The rest _must_ run over the deletion hook in
>>> atomic context (already runs fine all Linux debug switches on). The
>> rpi_pop()? No chance to call it before entering the scheduler and then=

>> the hooks?
>=20
> What do you have in mind precisely?

Preemptibility whenever having all things in a single atomic region
doesn't buy us much. Even if rpi_pop per se might not be heavy, adding
it to an already complex path doesn't improve things.

So my spontaneous idea was, as you said the rest _must_ be atomic, if
that piece couldn't be actually moved into the task deletion service and
the task_exit Linux hook, ie. before taking the nklock again and do the
final reschedule. Just an example for what might be improvable - once we
dig here again.

>=20
>>> latency hit is certainly not seen there; the real issues are left in =
the
>>> native and POSIX skin thread deletion routines (heap management and
>>> other housekeeping calls under nklock and so on).
>> That's surely true. Besides RPI manipulation, there is really no
>> problematic code left here latency-wise. Other hooks are trickier. But=

>> my point is that we first need some infrastructure to provide an
>> alternative cleanup context before we can start moving things. My patc=
h
>> today is a hack...err...workaround from this perspective.
>>
>=20
> I don't see it this way. This code is very specific, in the sense it
> lays on the inter-domain boundary between Linux and Xenomai's primary
> mode for a critical operation like thread deletion, this is what make
> things a bit confusing. What's below and above this layer has to be as
> seamless as possible, this code in particular can't.

Well, we could move the memory release of the shadow thread in Linux
context e.g. (release on idle, a bit like RCU - uuuh). Then the
reference counter can find a new home as well. Maybe some more things,
dunno yet.

>=20
>>>> As we are already at it: LO_MAX_REQUESTS is a hidden limitation that=

>>>> may (theoretically) bite large setups when e.g. too many threads get=
s
>>>> killed from the "wrong" context. At least some overflow detection is=

>>>> required here to warn the unfortunate user that he reached hard-code=
d
>>>> scalability limits.
>>> Yes.
>> CONFIG_XENO_OPT_DEBUG[_NUCLEUS] or unconditionally (error return code)=
?
>>
>=20
> Making it depend on the debug switch looks good. People who are serious=

> about making production software do want to activate this switch once i=
n
> a while while developing it, really.
>=20

--- xenomai.orig/ksrc/nucleus/shadow.c
+++ xenomai/ksrc/nucleus/shadow.c
@@ -890,11 +890,19 @@ static void schedule_linux_call(int type
 		);

 	splhigh(s);
+
 	reqnum =3D rq->in;
+
+	if (XENO_DEBUG(NUCLEUS) &&
+	    ((reqnum + 1) & (LO_MAX_REQUESTS - 1)) =3D=3D rq->out)
+		xnpod_fatal("lostage queue overflow on CPU %d! "
+			    "Increase LO_MAX_REQUESTS", cpuid);
+
 	rq->req[reqnum].type =3D type;
 	rq->req[reqnum].task =3D p;
 	rq->req[reqnum].arg =3D arg;
 	rq->in =3D (reqnum + 1) & (LO_MAX_REQUESTS - 1);
+
 	splexit(s);

 	rthal_apc_schedule(lostage_apc);



Jan


--------------enigDAD6CD97D5340057D0D4A9FC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGUdvHniDOoMHTA+kRAjbhAJkBTLXHi2dYVM0ijUwNnKIf9T/h7ACfQJhL
iohwi1xk793phzDsMpOsnwI=
=s2KB
-----END PGP SIGNATURE-----

--------------enigDAD6CD97D5340057D0D4A9FC--

