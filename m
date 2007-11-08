Message-ID: <47336447.8090203@domain.hid>
Date: Thu, 08 Nov 2007 20:32:23 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4732C546.90602@domain.hid> <4733535E.4070700@domain.hid>
In-Reply-To: <4733535E.4070700@domain.hid>
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
> Jan Kiszka wrote:
>> ...
>> Xenomai is loaded at this time but not yet used. Linux runs in tickless
>> highres mode and obviously had programmed the host timer to fire here.
>> But instead of one timer IRQ (233) + its handling, we see an additional
>> early shot (about 3 =B5s too early here - the longer the timer is
>> programmed in advance, the larger the error gets) before the xntimer
>> finally expires. But at the same time, /proc/xenomai/latency reports
>> 1000 (1 =B5s). So there must be more discrepancy between TSC and APIC
>> timebases, no? Well, nothing critical, but at least suboptimal, maybe
>> pointing at some hidden minor bug. Once time permits, I will check the
>> APIC frequency and the delay calculation on my box and compare it to
>> what Linux uses.
>=20
> Looks like Xenomai is using an inaccurate APIC frequency (probably since
> ages): 10.383 MHz on one of my boxes vs. 10.39591 MHz according to
> Linux' calibration ( (1,000,000,000 ns * clock_event_device.mult) >>
> clock_event_device.shift ), which is based on the PM-timer. As the real
> frequency is higher, the APIC fires earlier than we want to. Consider,
> e.g., the 4 ms host tick period =3D> 5 =B5s too early! This correlates wi=
th
> my LTTng traces.
>=20

Oops. Once again, this proves that having a permanent trace facility in
place is key to uncover bugs.

> I will try to fix this issue by extending the ipipe_request_tickdev
> interface so that it returns also the frequency of the requested tick
> device - as long as Xenomai 2.4 is not released, such an API breakage
> should not cause any hassle IMHO.
>

You may want to have a look at ipipe_get_sysinfo() first, and track the
use of the tmfreq field in Xenomai. This may be what you want to fix,
IIUC. This would keep the older patches usable with the next Xenomai
version, which is very desirable.

> (At this chance, I will also try to kill clock_event_device.delta. I
> think I have a nicer approach...)
>=20

Ack.

> Jan
>=20


--=20
Philippe.

