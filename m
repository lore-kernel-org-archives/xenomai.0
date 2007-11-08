Message-ID: <473382AB.6040708@domain.hid>
Date: Thu, 08 Nov 2007 22:42:03 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4732C546.90602@domain.hid> <4733535E.4070700@domain.hid>
	<47336447.8090203@domain.hid> <47336D6D.2020203@domain.hid>
In-Reply-To: <47336D6D.2020203@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Testing LTTng: first insights
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>> Jan Kiszka wrote:
>>>> ...
>>>> Xenomai is loaded at this time but not yet used. Linux runs in tickless
>>>> highres mode and obviously had programmed the host timer to fire here.
>>>> But instead of one timer IRQ (233) + its handling, we see an additional
>>>> early shot (about 3 =B5s too early here - the longer the timer is
>>>> programmed in advance, the larger the error gets) before the xntimer
>>>> finally expires. But at the same time, /proc/xenomai/latency reports
>>>> 1000 (1 =B5s). So there must be more discrepancy between TSC and APIC
>>>> timebases, no? Well, nothing critical, but at least suboptimal, maybe
>>>> pointing at some hidden minor bug. Once time permits, I will check the
>>>> APIC frequency and the delay calculation on my box and compare it to
>>>> what Linux uses.
>>> Looks like Xenomai is using an inaccurate APIC frequency (probably since
>>> ages): 10.383 MHz on one of my boxes vs. 10.39591 MHz according to
>>> Linux' calibration ( (1,000,000,000 ns * clock_event_device.mult) >>
>>> clock_event_device.shift ), which is based on the PM-timer. As the real
>>> frequency is higher, the APIC fires earlier than we want to. Consider,
>>> e.g., the 4 ms host tick period =3D> 5 =B5s too early! This correlates =
with
>>> my LTTng traces.
>>>
>> Oops. Once again, this proves that having a permanent trace facility in
>> place is key to uncover bugs.
>>
>>> I will try to fix this issue by extending the ipipe_request_tickdev
>>> interface so that it returns also the frequency of the requested tick
>>> device - as long as Xenomai 2.4 is not released, such an API breakage
>>> should not cause any hassle IMHO.
>>>
>> You may want to have a look at ipipe_get_sysinfo() first, and track the
>> use of the tmfreq field in Xenomai. This may be what you want to fix,
>=20
> Nope tmfreq is not involved. The problem is:
>=20
> 	rthal_timerfreq_arg =3D apic_read(APIC_TMICT) * HZ;
>=20

Actually, ports should use rthal_get_timerfreq() to get this value which
 in turn calls into the I-pipe to determine it accurately, instead of
approximating it by themselves (this is not to say that the I-pipe
always does this, though). Only ARM has it right currently.

>> IIUC. This would keep the older patches usable with the next Xenomai
>> version, which is very desirable.
>=20
> We could extend the information ipipe_get_sysinfo returns by the timer
> frequency.

sysinfo.tmfreq was meant to be such value.

 But to play cleanly, we would have to critical_enter first,
> look up the currently used clock_event_device, maybe even validate that
> it was hijacked, and then return its frequency. The problem with this
> API is, that it is by nature unsynchronised with ipipe_request_tickdev,
> thus would not always be able to return a valid frequency.
>=20

You get no special guarantee from getting the frequency out of the
request_tickdev call, because if the point is to prevent anyone from
changing/removing such device while you are using such value at Xenomai
level, then we can't, by design.

So we may as well read per_cpu(ipipe_tick_cpu_device) from
ipipe_get_sysinfo() to access the current tick device installed, without
any downside. After all, the timer is something which has to be
considered as a reasonably stable property of the system. Btw, we don't
currently handle any change of frequency of the underlying hw timer, so
changing the device would not actually work, I guess.

The next question may be, should we handle such situation? I tend to
think that we should not, because we just cannot accept any flaky
situation due to a misbehaving time source which would make the kernel
downgrade the current clock device, even temporarily, anyway. We have to
be confident in the current time source when operating.

> Actually, we would only exclude a few patches when going the
> ipipe_request_tickdev way: those few that were clockevent-aware up to
> today. For all others (namely 2.6.20 on i386 and up to 2.6.23 on
> x86_64), we would simply fall back to our current inaccurate approach. I
> think this is more acceptable than an ipipe_get_sysinfo extension.
>=20

The archdep section from the sysinfo struct has been meant to be
extended, really, so I think it's actually cleaner to use it - if
possible - for this purpose, instead of adding new ad hoc interfaces for
dealing with a particular kernel feature.

> Hmm, maybe we could install a temporary API for x86_64 so that users
> don't have to wait for 2.6.24 to get an accurate APIC. This would be
> removed again with the first unified x86-ipipe patch.
>=20
> Jan
>=20


--=20
Philippe.

