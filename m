Message-ID: <473386E6.4090204@domain.hid>
Date: Thu, 08 Nov 2007 23:00:06 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4732C546.90602@domain.hid> <4733535E.4070700@domain.hid>
	<47336447.8090203@domain.hid> <47336D6D.2020203@domain.hid>
	<473382AB.6040708@domain.hid>
In-Reply-To: <473382AB.6040708@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig53531422824D60A308C76BBE"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Testing LTTng: first insights
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
--------------enig53531422824D60A308C76BBE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> Jan Kiszka wrote:
>>>> Jan Kiszka wrote:
>>>>> ...
>>>>> Xenomai is loaded at this time but not yet used. Linux runs in tick=
less
>>>>> highres mode and obviously had programmed the host timer to fire he=
re.
>>>>> But instead of one timer IRQ (233) + its handling, we see an additi=
onal
>>>>> early shot (about 3 =B5s too early here - the longer the timer is
>>>>> programmed in advance, the larger the error gets) before the xntime=
r
>>>>> finally expires. But at the same time, /proc/xenomai/latency report=
s
>>>>> 1000 (1 =B5s). So there must be more discrepancy between TSC and AP=
IC
>>>>> timebases, no? Well, nothing critical, but at least suboptimal, may=
be
>>>>> pointing at some hidden minor bug. Once time permits, I will check =
the
>>>>> APIC frequency and the delay calculation on my box and compare it t=
o
>>>>> what Linux uses.
>>>> Looks like Xenomai is using an inaccurate APIC frequency (probably s=
ince
>>>> ages): 10.383 MHz on one of my boxes vs. 10.39591 MHz according to
>>>> Linux' calibration ( (1,000,000,000 ns * clock_event_device.mult) >>=

>>>> clock_event_device.shift ), which is based on the PM-timer. As the r=
eal
>>>> frequency is higher, the APIC fires earlier than we want to. Conside=
r,
>>>> e.g., the 4 ms host tick period =3D> 5 =B5s too early! This correlat=
es with
>>>> my LTTng traces.
>>>>
>>> Oops. Once again, this proves that having a permanent trace facility =
in
>>> place is key to uncover bugs.
>>>
>>>> I will try to fix this issue by extending the ipipe_request_tickdev
>>>> interface so that it returns also the frequency of the requested tic=
k
>>>> device - as long as Xenomai 2.4 is not released, such an API breakag=
e
>>>> should not cause any hassle IMHO.
>>>>
>>> You may want to have a look at ipipe_get_sysinfo() first, and track t=
he
>>> use of the tmfreq field in Xenomai. This may be what you want to fix,=

>> Nope tmfreq is not involved. The problem is:
>>
>> 	rthal_timerfreq_arg =3D apic_read(APIC_TMICT) * HZ;
>>
>=20
> Actually, ports should use rthal_get_timerfreq() to get this value whic=
h
>  in turn calls into the I-pipe to determine it accurately, instead of
> approximating it by themselves (this is not to say that the I-pipe
> always does this, though). Only ARM has it right currently.
>=20
>>> IIUC. This would keep the older patches usable with the next Xenomai
>>> version, which is very desirable.
>> We could extend the information ipipe_get_sysinfo returns by the timer=

>> frequency.
>=20
> sysinfo.tmfreq was meant to be such value.

Well, then it is totally mis-initialised on x86 so far, same on powerpc.
In fact, there it is the _clock_ frequency, not the timer frequency. So
what is meant by this? One comment actually call it "Timebase frequency"
(powerpc). This naming looks rather inconsistent.

>=20
>  But to play cleanly, we would have to critical_enter first,
>> look up the currently used clock_event_device, maybe even validate tha=
t
>> it was hijacked, and then return its frequency. The problem with this
>> API is, that it is by nature unsynchronised with ipipe_request_tickdev=
,
>> thus would not always be able to return a valid frequency.
>>
>=20
> You get no special guarantee from getting the frequency out of the
> request_tickdev call, because if the point is to prevent anyone from
> changing/removing such device while you are using such value at Xenomai=

> level, then we can't, by design.
>=20
> So we may as well read per_cpu(ipipe_tick_cpu_device) from
> ipipe_get_sysinfo() to access the current tick device installed, withou=
t
> any downside. After all, the timer is something which has to be
> considered as a reasonably stable property of the system. Btw, we don't=

> currently handle any change of frequency of the underlying hw timer, so=

> changing the device would not actually work, I guess.
>=20
> The next question may be, should we handle such situation? I tend to
> think that we should not, because we just cannot accept any flaky
> situation due to a misbehaving time source which would make the kernel
> downgrade the current clock device, even temporarily, anyway. We have t=
o
> be confident in the current time source when operating.
>=20
>> Actually, we would only exclude a few patches when going the
>> ipipe_request_tickdev way: those few that were clockevent-aware up to
>> today. For all others (namely 2.6.20 on i386 and up to 2.6.23 on
>> x86_64), we would simply fall back to our current inaccurate approach.=
 I
>> think this is more acceptable than an ipipe_get_sysinfo extension.
>>
>=20
> The archdep section from the sysinfo struct has been meant to be
> extended, really, so I think it's actually cleaner to use it - if
> possible - for this purpose, instead of adding new ad hoc interfaces fo=
r
> dealing with a particular kernel feature.

The timer frequency is coupled with the process of requesting a specific
tick device (I'm only talking about GENERIC_CLOCKEVENTS now, because
this is what matters mid-term). Only after deciding what event source to
use, one can obtain its frequency, thus passing it along the request
process appears more than logical and clean to me. Providing this
information "out of band" is broken IMHO, specifically as we need this
value within a very well-define time window (after switching the
clock_event, before using it).

However, that may not prevent us from doing something different for
legacy kernels and not-yet CLOCKEVENT'ized archs, but only temporarily.

Jan


--------------enig53531422824D60A308C76BBE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHM4bmniDOoMHTA+kRAgZjAJsFPxdVieUFShsJbuEXGSRCdgMUPACdHnHN
spq8OtWq7M9tPolLjIgkaSY=
=D0be
-----END PGP SIGNATURE-----

--------------enig53531422824D60A308C76BBE--

