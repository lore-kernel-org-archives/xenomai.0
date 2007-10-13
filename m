Message-ID: <4710D953.1030604@domain.hid>
Date: Sat, 13 Oct 2007 16:42:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <470E8BFE.4070804@domain.hid>
	<1192179524.5149.23.camel@domain.hid>	<470F3B03.1040501@domain.hid>	<20071012110054.GA26325@domain.hid>	<470FD0AC.6040700@domain.hid>
	<470FD795.9070008@domain.hid>	<20071012215152.GA17187@domain.hid>	<1192226314.6499.174.camel@domain.hid>
	<1192285734.8592.4.camel@domain.hid>
In-Reply-To: <1192285734.8592.4.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Sender: jan.kiszka@domain.hid
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [PATCH] fix hw-timer setup/cleanup for i386
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stelian Pop <stelian@domain.hid>
Cc: Xenomai-core@domain.hid

Stelian Pop wrote:
> Le vendredi 12 octobre 2007 =C3  23:58 +0200, Philippe Gerum a =C3=A9cr=
it :
>> On Fri, 2007-10-12 at 23:51 +0200, Stelian Pop wrote:
>>> On Fri, Oct 12, 2007 at 10:22:45PM +0200, Stelian Pop wrote:
>>>
>>>> Or even go crazy and activate SMP again ?
>>> Would have been too easy:
>>>
>>> # modprobe xeno_native
>>> Xenomai: native skin init failed, code -19.
>>>
>> The I-pipe likely told Xenomai that the LAPIC was unusable, because it
>> has been put in dummy state by the clock event layer. Must be somethin=
g
>> silly going on at I-pipe level. Please switch HPET off just for kicks.
>=20
> No, it doesn't change a thing.
>=20
> What does change something however is CONFIG_X86_UP_IOAPIC. Without it
> (UP or UP+APIC), latency works (albeit with higher latencies - up to 30
> us - than with 2.6.20+xeno-2.3.4 - where I saw latencies up to 20-25

Those 5 us are likely due to the programming overhead of the PIT (in
contrast to the fast IO-APIC in LAPIC/SMP setups).

> _in_SMP_mode_). With IOAPIC I get code 19.
>=20

Where do you get ENODEV? On nucleus startup? Please provide
/proc/timer_list output of the working and non-working setups.

Jan

PS: For unknown reasons your mails don't make it to my web.de address,
only to the list. Do you get any error messages?

