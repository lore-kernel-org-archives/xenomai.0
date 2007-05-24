Message-ID: <46555E5F.9020709@domain.hid>
Date: Thu, 24 May 2007 11:43:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <465099CE.2010004@domain.hid> <4651AFF9.5030402@domain.hid>	
	<1179763621.473.145.camel@domain.hid> <4651C70E.8080908@domain.hid>	
	<1179766310.473.168.camel@domain.hid> <4651DBC7.1000305@domain.hid>
	<1179998419.23117.42.camel@domain.hid>
In-Reply-To: <1179998419.23117.42.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4E5954BD66F41AE1D25F0BBA"
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
--------------enig4E5954BD66F41AE1D25F0BBA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Mon, 2007-05-21 at 19:49 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> In the light of what I have just written, you would only cause useles=
s
>>> wakeups doing so.
>> My question was if the test for "useless" was really race-safe on SMP.=

>> Then we could introduce it again in the APC handler. Otherwise, it mig=
ht
>> be safer to live with some degree of uselessness.
>>
>=20
> This test is only a hint; the real problem if any would happen in the
> wakeup routine. As a matter of fact, moving the wakeup call to the APC
> would open a SMP issue, since we would have no guarantee that the targe=
t
> task did not exit in the meantime on another CPU. The current
> implementation prevents this by grabbing the nklock in the taskexit
> hook, which means that once somebody is running the Xenomai deletion
> hook on any CPU, no shadow task can exit on another one, so this has th=
e
> same effect as holding a task reference lock Linux-wise (albeit a bit
> massive). We need to work a bit more on this issue.

Mmm.

>=20
>>>>>> Well, this thing seems to work,
>>>>> It does, actually.
>>>>>
>>>>>>  but it doesn't leave me with a good
>>>>>> feeling. IMHO, there are far too many cleanup cases with all the
>>>>>> combinations of non-shadow termination, shadow self-termination,
>>>>>> termination on task exit, various SMP scenarios, etc.
>>>>>>  Moreover, quite a
>>>>>> lot of stuff is executed in atomic scheduling hooks (namely on cle=
anup).
>>>>>> At least for shadow threads, I don't think all of this is necessar=
y.
>>>>>> Actually, deferring most of the uncritical cleanup work into Linux=

>>>>>> context would make things more regular, easier to review, and like=
ly
>>>>>> less disturbing for overall system latencies. I know that atomic
>>>>>> scheduling hooks are required to implement certain skins, but I do=
n't
>>>>>> see why janitor work should be done there as well. And we also sti=
ll
>>>>>> have that tiny uncleanness on shadow threads termination around TC=
B
>>>>>> release vs. hook execution.
>>>>> Talking about xnshadow_unmap, and as your patch illustrates, what y=
ou
>>>>> could postpone is basically the first part of the routine, which up=
dates
>>>>> the reference counts. The rest _must_ run over the deletion hook in=

>>>>> atomic context (already runs fine all Linux debug switches on). The=

>>>> rpi_pop()? No chance to call it before entering the scheduler and th=
en
>>>> the hooks?
>>> What do you have in mind precisely?
>> Preemptibility whenever having all things in a single atomic region
>> doesn't buy us much. Even if rpi_pop per se might not be heavy, adding=

>> it to an already complex path doesn't improve things.
>>
>> So my spontaneous idea was, as you said the rest _must_ be atomic, if
>> that piece couldn't be actually moved into the task deletion service a=
nd
>> the task_exit Linux hook, ie. before taking the nklock again and do th=
e
>> final reschedule. Just an example for what might be improvable - once =
we
>> dig here again.
>>
>=20
> You don't want to run rpi_pop() after the bulk of xnpod_delete_thread()=


Not after, I meant before. But then...

> has run for the same thread, and you don't want a preemption to occur
> anytime between the thread deletion and the update of the RPI state tha=
t
> still refers to it. You might try moving the call to rpi_pop() to the
> prologue of both routines instead of waiting for the deletion hook to d=
o
> it, but this would introduce a priority issue in the do_taskexit_event
> callout, since we might have lowered the root priority in rpi_pop() and=

> be switched out in the middle of the deletion process. Unless we hold
> the nklock all time long, that is. Back to square #1, I'm afraid.

=2E..there might be other issues, OK.

So we might need some reference counter for the xnthread object so that
the last user actually frees it and some flags to check what jobs remain
to be done for cleanup.

>>>>> latency hit is certainly not seen there; the real issues are left i=
n the
>>>>> native and POSIX skin thread deletion routines (heap management and=

>>>>> other housekeeping calls under nklock and so on).
>>>> That's surely true. Besides RPI manipulation, there is really no
>>>> problematic code left here latency-wise. Other hooks are trickier. B=
ut
>>>> my point is that we first need some infrastructure to provide an
>>>> alternative cleanup context before we can start moving things. My pa=
tch
>>>> today is a hack...err...workaround from this perspective.
>>>>
>>> I don't see it this way. This code is very specific, in the sense it
>>> lays on the inter-domain boundary between Linux and Xenomai's primary=

>>> mode for a critical operation like thread deletion, this is what make=

>>> things a bit confusing. What's below and above this layer has to be a=
s
>>> seamless as possible, this code in particular can't.
>> Well, we could move the memory release of the shadow thread in Linux
>> context e.g. (release on idle, a bit like RCU - uuuh).
>=20
> This is basically what Gilles did in a recent patch to fix some treadin=
g
> on freed memory, by releasing the shadow TCB through
> xnheap_schedule_free(). I think we should have a look at the removal
> from registry operations now.

Look, we now have xnheap_schedule_free, next we a need kind of
xnregistery_schedule_free - that's my point, provide a generic platform
for all these things. More may follow (for new kind of skins eg.).

Jan


--------------enig4E5954BD66F41AE1D25F0BBA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGVV5fniDOoMHTA+kRAhjMAJ0XumUspz0ANRgNgDrng52J3fatxwCfc0Sr
BLiBeYN2x1TJMI+uN7sBf0g=
=XEMD
-----END PGP SIGNATURE-----

--------------enig4E5954BD66F41AE1D25F0BBA--

