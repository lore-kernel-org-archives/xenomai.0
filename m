Message-ID: <44AE2372.6020006@domain.hid>
Date: Fri, 07 Jul 2006 11:03:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC, PATCH] per-thread exec-time stats
References: <44ACF5FA.2050205@domain.hid> <1152196379.4978.74.camel@domain.hid>	
	<44AD27AF.8050804@domain.hid> <1152200271.4978.85.camel@domain.hid>	
	<44AD3048.5050602@domain.hid> <44AD3C00.9050909@domain.hid>	
	<1152259455.5017.14.camel@domain.hid> <44AE16B3.80901@domain.hid>
	<1152262158.5017.22.camel@domain.hid>
In-Reply-To: <1152262158.5017.22.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBA8BAFEDE5D7A4C0929D28F0"
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
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBA8BAFEDE5D7A4C0929D28F0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Fri, 2006-07-07 at 10:09 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Thu, 2006-07-06 at 18:36 +0200, Jan Kiszka wrote:
>>>> Jan Kiszka wrote:
>>>>> Philippe Gerum wrote:
>>>>>> On Thu, 2006-07-06 at 17:09 +0200, Jan Kiszka wrote:
>>>>>>>> We could do that from the current loop below, given that the
>>>>>>>> accumulation routine is changed to use thread->sched implicitely=
=2E
>>>>>>> The idea is avoid adding even further load to the nklock-protecte=
d loop.
>>>>>>> And we only update the current thread, not each and every.
>>>>>>>
>>>>>> Yes, but why? I mean, accumulated time so far remains significant =
even
>>>>>> for non-running threads.
>>>>> Update must only happen for the currently running thread on each cp=
u,
>>>>> otherwise you skew the stats up.
>>>>>
>>>>>
>>>>> But looking at the whole code in stat_seq_open() again, I now wonde=
r if
>>>>> that whole routine isn't
>>>>>
>>>>> a) fragile on task removal and
>>>>> b) still poorly scaling.
>>>>>
>>>>> The thread name is only copied by reference, a disappearing instanc=
e my
>>>>> cause troubles on printing it. And, instead of holding the lock all=
 the
>>>>> time, shouldn't we better
>>>>>
>>>>> 1. pick some element from the queue and mark it somehow
>>>>>    in-use under lock
>>>>> 2. print or copy the entry
>>>>> 3. reacquire the lock to proceed to the next one - after checking i=
f
>>>>>    that element happened to be removed from the queue meanwhile (in=
 that
>>>>>    case we could abort the output or try to resync)
>>>> Not feasible (threads may not always be prevented from being deleted=
),
>>>> but what about this:
>>>>
>>>> - maintain a modification counter for nkpod->threadq
>>>> - in our /proc-loops (sched and latency e.g.):
>>>>   1. take nklock
>>>>   2. get current counter
>>>>   3. compare with previous, restart whole loop if not matching
>>>>   4. copy current element (including the name...)
>>>>   5. forward element pointer
>>>>   6. release nklock
>>>>   7. goto 1 if not end-of-list
>>>>
>>>> As modifications on threadq should be fairly rare, I don't see a ris=
k of
>>>> looping endlessly here.
>>>>
>>> The more I think of it, the more I'm convinced that we are trying to
>>> tweak /proc/xenomai/stats for the wrong purpose. Actually, some xeno_=
top
>>> tool would rather need the equivalent of individual /proc/<pid> files=
,
>>> thus reducing the contention on access, and the need for weird greppi=
ng
>>> on the output. e.g. /proc/xenomai/threads/<pid> could emit per-thread=

>>> data in some easily greppable form by a user-space tool.
>> Far too complex in my eyes for this simple purpose (what's the pid of
>> kernel-only threads?) -
>=20
> It's symbolic name. It's not a matter of simplicity, your patch for tha=
t
> purpose is rather complex already.

Haven't measured, but the amount of code added for collecting the data
and printing just another column should be marginal as yet. Introducing
a new infrastructure for more /proc subdirs with probably multiple
entries would certainly cost more.

>=20
>>  and we need to solve the latency problem of
>> /sched and /stat anyway.
>=20
> That's separate issues. Solving the scalability issue
> of /proc/xenomai/stats and friends does not improve their usability in
> the context of user-space tools monitoring thread activity. E.g. how ar=
e
> we going to extend the reporting about such activity if need be, adding=

> yet another column to /stats and /sched?

As long as there are no stand-alone tools relying on the layout, just
only our own ones - fairly simple. But before speculating more, I will
have a look now how simple such tool/script may actually be.

Jan


--------------enigBA8BAFEDE5D7A4C0929D28F0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEriNyniDOoMHTA+kRAuRLAJ96oJm8fkm7BxUBw9Ba8bpQRZz3bgCfS4SL
LpH63LmGzutIWbooT56kc/Y=
=GMtX
-----END PGP SIGNATURE-----

--------------enigBA8BAFEDE5D7A4C0929D28F0--

