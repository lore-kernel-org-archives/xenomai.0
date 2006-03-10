Message-ID: <4411C646.80802@domain.hid>
Date: Fri, 10 Mar 2006 19:32:38 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RTDM and Timer functions
References: <200603091443.25714.lbocseg@domain.hid> <4410911F.4070507@domain.hid>
	<200603101054.41122.lbocseg@domain.hid>
In-Reply-To: <200603101054.41122.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDCD7A0C8B6ECB7C440104A51"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDCD7A0C8B6ECB7C440104A51
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Em Quinta 09 Mar=E7o 2006 17:33, Jan Kiszka escreveu:
>=20
>> Rodrigo Rosenfeld Rosas wrote:
>>> Hi Jan,
>>>
>>> I'm still concerned about the future of RTDM and timer functions. I t=
hink
>>> there should be some function for starting the timer manually, since =
the
>>> automatic feature don't work great for RTDM drivers.
>>>
>>> It is not nice to have to run the latency (or any other) program for
>>> starting the timer before I can load my driver. And it is not suffice=
 to
>>> run it once I booted. After I open/close my rtdm device and reload my=

>>> driver the problem will occur again and I'll have to re-run the laten=
cy
>>> program.
>> Sorry I don't see the problem here.
>>
>> # modprobe xeno_nucleus; cat /proc/xenomai/timer
>> status=3Doff:setup=3D1392:tickval=3D0:jiffies=3D0
>>
>> # modprobe xeno_rtdm; cat /proc/xenomai/timer
>> status=3Doneshot:setup=3D1392:tickval=3D1:jiffies=3D8113917792696
>>
>> So the timer is running right since when rtdm is loaded?!
>=20
> Yes, here too.
>=20
>> And that simple heartbeat rtdm example on my rt-addon homepage now
>> cleanly runs even without any further helper to start some timer.
>=20
> Yes, here too. You are right, once the timer is in oneshot mode. My dri=
ver=20
> loads correctly without the helper. Then I start a user application tha=
t=20
> changes the timer to periodic mode and uses my driver. When I reload my=
=20
> driver, now in periodic mode, the problem raises.

What happens if you make the periodic timer the default one in the
kernel configuration?

>=20
> It seems, there is no problem when the timer is set to oneshot. But whe=
n=20
> turning it to periodic, at least one of rtdm_task_busy_sleep() or=20
> rtdm_clock_read() doesn't seem to work. See below:
>=20
> cat /proc/xenomai/timer
>   status=3Dperiodic:setup=3D188:tickval=3D100000:jiffies=3D19972453
>=20
> start_time =3D rtdm_clock_read();
> rtdm_task_busy_sleep(84000);
> temp_time =3D rtdm_clock_read();
> rtdm_printk(KERN_INFO "Should be near 84000: %u\n", (unsigned int)
>                    (temp_time-start_time));
>=20
> Sometimes the result is "Should be near 84000: 100000", that is kind of=
=20
> correct, since the tickval is 100000, although I think that those funct=
ions=20
> in the RTDM driver context should be independent of the tick value set =
by the=20
> user program... Maybe using oneshot in the driver calls and periodic in=
 the=20
> application... I really don't know what would be the best approach here=
=2E..

rtdm_clock_read always uses the nucleus clock. Using something different
(e.g. always TSC) would break applications specifying absolute times
derived from the return values of other skins' functions.

>=20
> But the worst case is that sometimes I get "Should be near 84000: 0" wh=
ich=20
> clearly is a incorrect result.

That might be a rounding issue somewhere, as the sleep than clearly did
not wait at least one tick. Will have to check this when time permits.

>=20
> After I run the latency program, the timer turns to be oneshot again an=
d=20
> everything goes right.
>=20
> What can I do to solve this problem?

Use oneshot mode in the meantime - or even longer ;). Why do you prefer
periodic mode for your application? Another workaround: reduce the tick
interval.

>=20
> Thanks in advance,
>=20
> Rodrigo.
>=20

Jan


--------------enigDCD7A0C8B6ECB7C440104A51
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEEcZGniDOoMHTA+kRAkT8AJwLHv0s+rxqnOE/ja9Q+kVi1sM1RgCeJW/j
8K/8M1rxRrc4RaSwbZygxOE=
=S5qa
-----END PGP SIGNATURE-----

--------------enigDCD7A0C8B6ECB7C440104A51--

