Message-ID: <4648D7AF.7080409@domain.hid>
Date: Mon, 14 May 2007 23:42:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4648C077.2050003@domain.hid> <4648C26F.1020002@domain.hid>
	<4648CA4E.70904@domain.hid>
In-Reply-To: <4648CA4E.70904@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9CCE3DA041120518CFB76285"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] rt_task_set_periodic and different time base
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Koftinoff <jeffk@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9CCE3DA041120518CFB76285
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeff Koftinoff wrote:
> Jan Kiszka wrote:
>>
>> There exists some vague ideas to provide an infrastructure with Xenoma=
i
>> that allows to smoothly synchronise its local clock on whatever extern=
al
>> (jittery) source, but note that "vague" above.
>>
>> Moreover, I don't think you actually want this for your scenario. You
>> may rather look for a hard sync on each audio tick, no?
>>
>>  =20
> correct, a hard sync on each audio tick is what I want. 166 +- 20
> Microseconds.
>=20
>>> My original thought was to use rt_intr_wait() in my user mode program=

>>> and do the scheduling of sub-tasks myself.
>>>    =20
>>
>> Sounds what you need (or directly derive an RTDM device with appropria=
te
>> interface for your audio-hw :)).
>>
>>  =20
> 90% of my CPU time needs to be spent processing audio and the control
> for this audio, at the highest priority above linux, and running in C++=

> in userspace (really!)... There is no 'audio driver' involved, really,
> as the whole point of the hardware is to process live audio in real tim=
e
> from audio in to audio out with very low latency in usermode.

I see.

>>> But it would be ideal if rt_task_set_periodic() could just use the
>>> appropriate time source itself.
>>>    =20
>>
>> Why?
>>
>>  =20
> Because I have many layers of audio processing procedures that need to
> be scheduled at different periodic intervals, with different priorities=
=2E
> lower level audio processing procedures run every 166 microseconds and
> have highest priority, and interrupt higher level lower rate (5.3
> ms,10.66 ms and 32 ms) control processing procedures.

So they are all multiples of the base period? Why not let the high-rate
tasks wake the low-rate ones when time has come, e.g. via semaphores?

> I have non-xenomai usermode code right now that can use a recursive
> signal handler to manually schedule these 'layers' of processing tasks.=
=20
> But then I'm just duplicating the rt_task_set_periodic() capability tha=
t
> is already there in xenomai.
>=20
> I just want the Xenomai task scheduler to be controlled directly by the=

> audio tick interrupt.... Is that a problem to enable?

You may hack this into the code, but I would rather suggest to design
this at application level in order to remain portable across Xenomai
releases. Only if you find relevant performance deficits (but I do not
see any yet), you may consider special solutions (in that case, please
come back with the issue, maybe we can find a generic way that helps
others as well).

Jan


--------------enig9CCE3DA041120518CFB76285
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGSNevniDOoMHTA+kRAqMmAJ9Eg7rOo7cYo1lp9Tju7W2dXDDkwACfbB7Y
v8E6I7ItCDUVppJeJU3kiAw=
=z7dV
-----END PGP SIGNATURE-----

--------------enig9CCE3DA041120518CFB76285--

