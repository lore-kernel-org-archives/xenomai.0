Message-ID: <470FD795.9070008@domain.hid>
Date: Fri, 12 Oct 2007 22:22:45 +0200
From: Stelian Pop <stelian@domain.hid>
MIME-Version: 1.0
References: <470E8BFE.4070804@domain.hid>
	<1192179524.5149.23.camel@domain.hid>	<470F3B03.1040501@domain.hid>
	<20071012110054.GA26325@domain.hid>
	<470FD0AC.6040700@domain.hid>
In-Reply-To: <470FD0AC.6040700@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-core@domain.hid

Jan Kiszka a =E9crit :
> Stelian Pop wrote:
>> # Automatically generated make config: don't edit
>> # Linux kernel version: 2.6.22.9-xeno
>> # Fri Oct 12 11:45:32 2007
>> #
> ...
>> # CONFIG_X86_UP_APIC is not set
>=20
> As long as APIC is off...
>=20
>> CONFIG_HPET_TIMER=3Dy
>=20
> ...HPET_TIMER must be off as well. Otherwise, Linux may actually pick u=
p
> the HPET which block the PIT for Xenomai usage.

Right. Disabling CONFIG_HPET makes Xenomai work for me on this laptop.=20
Hurray!

I still have a strange problem though: after loading xeno_nucleus and=20
before loading xeno_native, the keyboard reacts strangely: each key=20
press results in at least 6 (and up to 20) letters on the terminal.

Before loading the nucleus and after the skin is loaded everything is=20
ok. And even while the keyboard reacts strangely, I can log in over ssh=20
and the systems seems to be fine.

What should I do next ? Do you want to try looking into the keyboard=20
issue, or should I rather enable the UP_APIC ? Or even go crazy and=20
activate SMP again ?

Stelian.

