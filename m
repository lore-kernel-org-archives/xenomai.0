Message-ID: <44341AE6.5030804@domain.hid>
Date: Wed, 05 Apr 2006 21:30:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Frozen timer IRQ
References: <4432E540.1010108@domain.hid>	<17459.46030.997560.684058@domain.hid>
	<4433BA43.7000807@domain.hid> <4433C087.3020403@domain.hid>
In-Reply-To: <4433C087.3020403@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB48940AB2829AEB35415DAA1"
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
--------------enigB48940AB2829AEB35415DAA1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Philippe Gerum wrote:
>> Gilles Chanteperdrix wrote:
>>
>>> Jan Kiszka wrote:
>>>  > Hi,
>>>  >  > my colleagues and I need some hint where to continue our search=

>>> for the
>>>  > cause of a weird cleanup issue:
>>>  >  > An application of our robotics framework sometimes terminates
>>> (though
>>>  > successfully) in a way that the system timer IRQ no longer arrives=

>>>  > afterwards or no re-program takes place anymore. All other Linux I=
RQs
>>>  > are fine (Ethernet, keyboard, etc.). I cannot provide an easy test=

>>> case
>>>  > yet as besides the framework some expensive gyroscope and the 1655=
0A
>>>  > driver are involved.
>>>
>>> I observed a similar issue when xnpod_stop_timer was called when
>>> shutting down the posix skin. I assumed that the problem was that
>>> xnpod_shutdown already called xnpod_stop_timer, so xnpod_stop_timer (=
and
>>> in particular xnarch_stop_timer) ended up being called twice.
>>>
>>
>> Err, sorry. Forget about my previous reply: xnarch_stop_timer is _not_=

>> protected by the XNTIMED flag, but only the last part of the
>> housekeeping chores performed upon stopping the systimer are. IOW,
>> this is a latent bug, and xnpod_stop_timer should be fixed.
>>
>=20
> Commit 884 should do that.
>=20

Sorry for replying late: nope, this has no influence on our issue.

Well, someone put that damn piece of hardware on my desk, saying: "It
doesn't work." What he did not say is that there are multiple issues
contained :-/. I found and fixed (patch will follow) a severe bug in the
16550A driver, but the strange timer issue stays (though it's still
tricky to reproduce).

The point is - and that's likely why your patch doesn't help - that we
do not stop the system timer, i.e. unload all skins. We just terminate
an application. I did some research but failed to find a test case (only
our software "manages" to trigger this). Actually, it seems the hardware
timer is no longer working, because also other RT-tasks no longer time
out. Moreover, I checked nkpod->htimer.status, but it remains 0 all the
time. I need more time...

Jan


--------------enigB48940AB2829AEB35415DAA1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFENBrmniDOoMHTA+kRAnobAJwKGUhI+gL4jripxE0bdlzAT51B6gCeLLeg
RjewI6BR8HuwHd8Zi/Ynnjg=
=LYUO
-----END PGP SIGNATURE-----

--------------enigB48940AB2829AEB35415DAA1--

