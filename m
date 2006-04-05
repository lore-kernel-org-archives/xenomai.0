Message-ID: <44343CF6.4090500@domain.hid>
Date: Wed, 05 Apr 2006 23:56:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Frozen timer IRQ
References: <4432E540.1010108@domain.hid>	<17459.46030.997560.684058@domain.hid>	<4433BA43.7000807@domain.hid>
	<4433C087.3020403@domain.hid> <44341AE6.5030804@domain.hid>
In-Reply-To: <44341AE6.5030804@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0B6CD62601BB9CFC4AC5121C"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0B6CD62601BB9CFC4AC5121C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> Philippe Gerum wrote:
>>> Gilles Chanteperdrix wrote:
>>>
>>>> Jan Kiszka wrote:
>>>>  > Hi,
>>>>  >  > my colleagues and I need some hint where to continue our searc=
h
>>>> for the
>>>>  > cause of a weird cleanup issue:
>>>>  >  > An application of our robotics framework sometimes terminates
>>>> (though
>>>>  > successfully) in a way that the system timer IRQ no longer arrive=
s
>>>>  > afterwards or no re-program takes place anymore. All other Linux =
IRQs
>>>>  > are fine (Ethernet, keyboard, etc.). I cannot provide an easy tes=
t
>>>> case
>>>>  > yet as besides the framework some expensive gyroscope and the 165=
50A
>>>>  > driver are involved.
>>>>
>>>> I observed a similar issue when xnpod_stop_timer was called when
>>>> shutting down the posix skin. I assumed that the problem was that
>>>> xnpod_shutdown already called xnpod_stop_timer, so xnpod_stop_timer =
(and
>>>> in particular xnarch_stop_timer) ended up being called twice.
>>>>
>>> Err, sorry. Forget about my previous reply: xnarch_stop_timer is _not=
_
>>> protected by the XNTIMED flag, but only the last part of the
>>> housekeeping chores performed upon stopping the systimer are. IOW,
>>> this is a latent bug, and xnpod_stop_timer should be fixed.
>>>
>> Commit 884 should do that.
>>
>=20
> Sorry for replying late: nope, this has no influence on our issue.
>=20
> Well, someone put that damn piece of hardware on my desk, saying: "It
> doesn't work." What he did not say is that there are multiple issues
> contained :-/. I found and fixed (patch will follow) a severe bug in th=
e
> 16550A driver, but the strange timer issue stays (though it's still
> tricky to reproduce).
>=20
> The point is - and that's likely why your patch doesn't help - that we
> do not stop the system timer, i.e. unload all skins. We just terminate
> an application. I did some research but failed to find a test case (onl=
y
> our software "manages" to trigger this). Actually, it seems the hardwar=
e
> timer is no longer working, because also other RT-tasks no longer time
> out. Moreover, I checked nkpod->htimer.status, but it remains 0 all the=

> time. I need more time...
>=20

Attached is an ipipe-freeze of the frozen system. It's taken at the time
the main thread of the terminating application has successfully
rt_task_join'ed the last remaining RT-thread. I took 2000 trace points
before and after that point and additionally instrumented
rthal_timer_program_shot() (special trace 0x01, the argument is the
delay). The interesting stuff happens around 600 us after the freeze: it
seems the scheduled Linux timer arrives then but doesn't get much
attention beyond from ipipe.

Any idea what to look for next? I have a "perfect" test system now,
though I still see no light at the end of the tunnel how to export it to
other boxes.

Enough for today.

Jan


PS: This trace was taken over 2.6.15 to exclude any issues with the new
2.6.16. Both kernels show the same effect.


--------------enig0B6CD62601BB9CFC4AC5121C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFENDz2niDOoMHTA+kRAksuAJwMsvWwNGYcNV+nj5ycC30cQJeXsQCfa3Xu
duPXXljW34xDsi5XF/H7XqE=
=ddkG
-----END PGP SIGNATURE-----

--------------enig0B6CD62601BB9CFC4AC5121C--

