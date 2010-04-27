Message-ID: <4BD68843.4030806@domain.hid>
Date: Tue, 27 Apr 2010 08:46:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4BD5987A.2050804@domain.hid>
	<4BD59A48.5070002@domain.hid>	<4BD5BA03.5000101@domain.hid>
	<1272331158.28983.287.camel@domain.hid>
In-Reply-To: <1272331158.28983.287.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFE4DBA716A61B613A7CD3C26"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] nucleus: Plug race between
	rpi_clear_remote and rpi_next
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFE4DBA716A61B613A7CD3C26
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Mon, 2010-04-26 at 18:06 +0200, Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>> Jan Kiszka wrote:
>>>> Hi,
>>>>
>>>> I'm meditating over an oops in rpi_clear_remote. NULL pointer deref,=
 it
>>>> /seems/ like thread->rpi is invalid. Looking at the code, I wonder i=
f
>>>> this could explain the bug:
>>>>
>>>>
>>>> static void rpi_clear_remote(struct xnthread *thread)
>>>> {
>>>> ...
>>>>         rpi =3D thread->rpi;
>>>>         if (unlikely(rpi =3D=3D NULL))
>>>>                 return;
>>>>
>>>>         xnlock_get_irqsave(&rpi->rpilock, s);
>>>>
>>>>         /*
>>>>          * The RPI slot - if present - is always valid, and won't
>>>>          * change since the thread is resuming on this CPU and canno=
t
>>>>          * migrate under our feet. We may grab the remote slot lock
>>>>          * now.
>>>>          */
>>>>         xnsched_pop_rpi(thread);
>>>>         thread->rpi =3D NULL;
>>>>
>>>> ...
>>>>
>>>> So we deref (xnsched_pop_rpi) and clear thread->rpi under rpilock, b=
ut
>>>> we check for it without any protection? Sounds racy. I think 'thread=
' is
>>>> not only pointing to the current thread but could refer to a foreign=
 one
>>>> as well, right? Don't we need this:
>>>>
>>>> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
>>>> index 872c37f..1f995d6 100644
>>>> --- a/ksrc/nucleus/shadow.c
>>>> +++ b/ksrc/nucleus/shadow.c
>>>> @@ -331,6 +331,12 @@ static void rpi_clear_remote(struct xnthread *t=
hread)
>>>> =20
>>>>  	xnlock_get_irqsave(&rpi->rpilock, s);
>>>> =20
>>>> +	/* Re-check under lock, someone may have cleared rpi by now. */
>>>> +	if (unlikely(thread->rpi =3D=3D NULL)) {
>>>> +		xnlock_put_irqrestore(&rpi->rpilock, s);
>>>> +		return;
>>>> +	}
>>>> +
>>>>  	/*
>>>>  	 * The RPI slot - if present - is always valid, and won't
>>>>  	 * change since the thread is resuming on this CPU and cannot
>>> Another worry: Can thread->rpi become !=3D rpi without being NULL? Or=
 can
>>> we really only race for clearance here?
>>>
>> I think so now, therefore I'm proposing this:
>>
>> ----------->
>>
>> Most RPI services work on the current task or the one to be scheduled =
in
>> next, thus are naturally serialized. But rpi_next is not as it can wal=
k
>> the chain of RPI requests for a CPU independently. In that case,
>> clearing RPI via rpi_clear_remote can race with rpi_next, and if the
>> former loses after checking thread->rpi for NULL, we will dereference =
a
>> NULL pointer in xnsched_pop_rpi().
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>> ---
>>  ksrc/nucleus/shadow.c |    9 +++++++++
>>  1 files changed, 9 insertions(+), 0 deletions(-)
>>
>> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
>> index 872c37f..cf7c08f 100644
>> --- a/ksrc/nucleus/shadow.c
>> +++ b/ksrc/nucleus/shadow.c
>> @@ -332,6 +332,15 @@ static void rpi_clear_remote(struct xnthread *thr=
ead)
>>  	xnlock_get_irqsave(&rpi->rpilock, s);
>> =20
>>  	/*
>> +	 * Re-check under lock. Someone may have invoked rpi_next and cleare=
d
>> +	 * rpi by now.
>> +	 */
>> +	if (unlikely(!rpi_p(thread))) {
>> +		xnlock_put_irqrestore(&rpi->rpilock, s);
>> +		return;
>> +	}
>> +
>> +	/*
>>  	 * The RPI slot - if present - is always valid, and won't
>>  	 * change since the thread is resuming on this CPU and cannot
>>  	 * migrate under our feet. We may grab the remote slot lock
>>
>=20
> The suggested patch papers over the actual issue, which is that
> rpi_clear_remote() may not invoke rpi_next(), because it may only affec=
t

I don't think that in our case rpi_clear_remote called rpi_next and
therefore crashed. It should rather have been the scenario of both
running in parallel on different CPUs, the former on behalf of a
migrated shadow that wants to clear its remainders on the remote CPU,
the latter on that CPU, picking a new top RPI after some other shadow
was removed from the queue. Is this a possible scenario, and would your
patch cover it?

> the RPI state of the argument thread which must be a local one, and not=

> that of any random thread that happens to be linked to the remote RPI
> queue.
>=20
> By calling rpi_next(), rpi_clear_remote() shoots itself in the foot,
> allowing a concurrent invocation of itself on a remote CPU, to fiddle
> with the rpi backlink of a thread which is not active on the
> local/per-cpu Xenomai scheduler instance, which is the point where
> things start to hit the crapper.
>=20
> Now, unless I can't even synchronize the couple of neurons I have left
> at this hour, the following patch should better fix the issue, because
> it restores the two basic rules that apply to the whole RPI machinery,
> namely:
>=20
> - rpi_* calls may only alter the contents of the local scheduler's RPI
> queue, with the notable exception of rpi_clear_remote() which may remov=
e
> the given _local_ thread only, from a remote RPI slot.
>=20
> - rpi_* calls may only change the RPI state of threads which are
> controlled by the local Xenomai scheduler instance, except rpi_push()
> when called for setting up the RPI state of an emerging thread, in whic=
h
> case this is a no-conflict zone.
>=20
> That breakage was introduced in the early 2.5.1 timeframe, so 2.4.x
> should be immune from this particular bug.
>=20
> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
> index 872c37f..1397ed1 100644
> --- a/ksrc/nucleus/shadow.c
> +++ b/ksrc/nucleus/shadow.c
> @@ -340,7 +340,12 @@ static void rpi_clear_remote(struct xnthread *thre=
ad)
>  	xnsched_pop_rpi(thread);
>  	thread->rpi =3D NULL;
> =20
> -	if (rpi_next(rpi, s) =3D=3D NULL)
> +	/*
> +	 * If the remote RPI queue was emptied, prepare for kicking
> +	 * xnshadow_rpi_check() on the relevant CPU to demote the root
> +	 * thread priority there.
> +	 */
> +	if (xnsched_peek_rpi(rpi) =3D=3D NULL) /* No rpi_next() here. */
>  		rcpu =3D xnsched_cpu(rpi);
> =20
>  	xnlock_put_irqrestore(&rpi->rpilock, s);
>=20
>=20

I have to confess, I do not understand how the patch may relate to our
crash. But that's because I still only have a semi-understanding of this
frightening complex RPI code. However, the fact that thread->rpi is now
again only checked outside its protecting lock leaves me with a very bad
feeling...

Jan


--------------enigFE4DBA716A61B613A7CD3C26
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvWiEcACgkQitSsb3rl5xTCYACg0L07L+dbn6a1q44urLY3rRg9
vaQAnRkn520Wa7Tq8hUrytpvyFpUnX+2
=k0x5
-----END PGP SIGNATURE-----

--------------enigFE4DBA716A61B613A7CD3C26--

