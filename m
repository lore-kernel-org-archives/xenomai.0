Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <4B733A96.2060700@domain.hid>
Date: Thu, 11 Feb 2010 00:00:38 +0100
From: Alexis Berlemont <berlemont.hauw@domain.hid>
MIME-Version: 1.0
References: <4bed572e0911221135s64fc4726x1cd7235f116e11a4@domain.hid>
	<4bed572e0912160458i32834958q9512476f1603979d@domain.hid>
	<4B2BF4D9.6000503@domain.hid>
	<4bed572e1001051015l21e71e8eyaec207701c2e21ad@domain.hid>
	<4B43BE72.6040101@domain.hid>
	<4bed572e1001060557x12ffd808k193573c565830a1b@domain.hid>
	<4B450B7E.80106@domain.hid>
	<4bed572e1001071124x55a964f8u22558c05c2a4485c@domain.hid>
	<4B46590F.2060308@domain.hid>
	<4bed572e1001080314n4d723074ld77459d1dffc8c3e@domain.hid>
	<8b216e9e1002090921n61b662ag7a7e7fd6d3d337f4@domain.hid>
In-Reply-To: <8b216e9e1002090921n61b662ag7a7e7fd6d3d337f4@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Help on analogy_ni_pcimio (Alexis Berlemont?)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Cc: xenomai@xenomai.org

Hi,

Felipe Brand=E3o Cavalcanti wrote:
> Hello,
>=20
> I just installed Xenomai 2.5.1, however, I am having the exact same=20
> problem - the computer completely crashes when running analogy_config=20
> analogy0 analogy_ni_pcimio. However, I could not get any significant=20
> debug info before the system crashes.
>=20
> This is the exact behavior I had with Xenomai 2.5.0.
>=20
> I am running Ubuntu 9.04 on a with a AMD Sempron 2800+ with a National=20
> Instruments 6221-37 DAQ card. Xenomai seems to be running pretty well.
I am surprised that it is the same bug. If I remember well, there were=20
two bugs:
- the first one was specific to NI 67xx cards and was fixed
- the second one was supposed to be fixed with the following commits:
analogy: [NI mite] initialize the mite structures after their allocations
analogy: [NI mite] initialize channels' status

I am afraid we are facing a bright new one...

>=20
> So, is this a known issue? Can I help with the debug messages/logs in=20
> any way?
Even if your system crashes, you might be able to catch the log traces=20
printed just before. In such a case, could you set the analogy debug=20
options like this:
CONFIG_XENO_DRIVERS_ANALOGY_DEBUG=3Dy
CONFIG_XENO_DRIVERS_ANALOGY_DEBUG_LEVEL=3D0
CONFIG_XENO_DRIVERS_ANALOGY_DRIVER_DEBUG_LEVEL=3D1

And send your kernel traces, after having launched the attach procedure=20
(which, if I understand well, should have triggered the bug).

>=20
> Thanks for the help,
>      -Felipe Brand=E3o Cavalcanti
>=20
> (Sorry to reply to such an old thread.. but my problem seemed a lot like =

> this one.)
>=20
Alexis.

