Message-ID: <469F9CE2.9080603@domain.hid>
Date: Thu, 19 Jul 2007 19:18:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <469BF43D.1040704@domain.hid> <46973753.6010206@domain.hid>	
	<4694ED98.6000000@domain.hid>	<46937E70.10903@domain.hid>
	<469345EB.6060302@domain.hid>	
	<22554361.1184054457326.JavaMail.ngmail@domain.hid>	
	<2026261.1184070574283.JavaMail.ngmail@domain.hid>	
	<1982070.1184078400928.JavaMail.ngmail@domain.hid>
	<4693A702.1010604@domain.hid>	
	<913919.1184311634860.JavaMail.ngmail@domain.hid>	
	<21969019.1184569651818.JavaMail.ngmail@domain.hid>	
	<29054475.1184842736562.JavaMail.ngmail@domain.hid>	
	<469F4A98.3080307@domain.hid> <1184847549.28303.46.camel@domain.hid>	
	<469F5BA5.1030407@domain.hid> <1184858093.28303.85.camel@domain.hid>	
	<469F84B3.6070104@domain.hid> <1184861035.28303.108.camel@domain.hid>
In-Reply-To: <1184861035.28303.108.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB67EEB8A6C377411B30F22A3"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-help] Sporadic PC freeze after
	rt_task_start
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB67EEB8A6C377411B30F22A3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2007-07-19 at 17:35 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Thu, 2007-07-19 at 14:40 +0200, Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>>> And when looking at the holders of rpilock, I think one issue coul=
d be
>>>>>> that we hold that lock while calling into xnpod_renice_root [1], i=
e.
>>>>>> doing a potential context switch. Was this checked to be save?
>>>>> xnpod_renice_root() does no reschedule immediately on purpose, we w=
ould
>>>>> never have been able to run any SMP config more than a couple of se=
conds
>>>>> otherwise. (See the NOSWITCH bit).
>>>> OK, then it's not the cause.
>>>>
>>>>>> Furthermore, that code path reveals that we take nklock nested int=
o
>>>>>> rpilock [2]. I haven't found a spot for the other way around (and =
I hope
>>>>>> there is none)
>>>>> xnshadow_start().
>>>> Nope, that one is not holding nklock. But I found an offender...
>>> Gasp. xnshadow_renice() kills us too.
>> Looks like we are approaching mainline "qualities" here - but they hav=
e
>> at least lockdep (and still face nasty races regularly).
>>
>=20
> We only have a 2-level locking depth at most, thare barely qualifies fo=
r
> being compared to the situation with mainline. Most often, the more
> radical the solution, the less relevant it is: simple nesting on very
> few levels is not bad, bugous nesting sequence is.
>=20
>> As long as you can't avoid nesting or the inner lock only protects
>> really, really trivial code (list manipulation etc.), I would say ther=
e
>> is one lock too much... Did I mention that I consider nesting to be
>> evil? :-> Besides correctness, there is also an increasing worst-case
>> behaviour issue with each additional nesting level.
>>
>=20
> In this case, we do not want the RPI manipulation to affect the
> worst-case of all other threads by holding the nklock. This is
> fundamentally a migration-related issue, which is a situation that must=

> not impact all other contexts relying on the nklock. Given this, you
> need to protect the RPI list and prevent the scheduler data to be
> altered at the same time, there is no cheap trick to avoid this.
>=20
> We need to keep the rpilock, otherwise we would have significantly larg=
e
> latency penalties, especially when domain migration are frequent, and
> yes, we do need RPI, otherwise the sequence for emulated RTOS services
> would be plain wrong (e.g. task creation).

If rpilock is known to protect potentially costly code, you _must not_
hold other locks while taking it. Otherwise, you do not win a dime by
using two locks, rather make things worse (overhead of taking two locks
instead of just one). That all relates to the worst case, of course, the
one thing we are worried about most.

In that light, the nesting nklock->rpilock must go away, independently
of the ordering bug. The other way around might be a different thing,
though I'm not sure if there is actually so much difference between the
locks in the worst case.

What is the actual _combined_ lock holding time in the longest
nklock/rpilock nesting path? Is that one really larger than any other
pre-existing nklock path? Only in that case, it makes sense to think
about splitting, though you will still be left with precisely the same
(rather a few cycles more) CPU-local latency. Is there really no chance
to split the lock paths?

> Ok, the rpilock is local, the nesting level is bearable, let's focus on=

> putting this thingy straight.

The whole RPI thing, though required for some scenarios, remains ugly
and error-prone (including worst-case latency issues). I can only
underline my recommendation to switch off complexity in Xenomai when one
doesn't need it - which often includes RPI. Sorry, Philippe, but I think
we have to be honest to the users here. RPI remains problematic, at
least /wrt your beloved latency.

Jan


--------------enigB67EEB8A6C377411B30F22A3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGn5ziniDOoMHTA+kRAmT8AJ4tGCKuh6gKOLoXgsynArHRU3gatQCeNoOb
xndm91vfBebRKnbFafZ3Mug=
=Xwye
-----END PGP SIGNATURE-----

--------------enigB67EEB8A6C377411B30F22A3--

