From: Jean-Pascal JULIEN <jean-pascal.julien@domain.hid>
Date: Wed, 16 May 2012 17:55:10 +0200
Message-ID: <C7408997F5B0784C970ED53C11855FAE011112339156@domain.hid>
References: <C7408997F5B0784C970ED53C11855FAE011112339155@domain.hid>,
	<C7408997F5B0784C970ED53C11855FAE01111232AFE7@domain.hid>
In-Reply-To: <C7408997F5B0784C970ED53C11855FAE01111232AFE7@domain.hid>
Content-Language: fr-FR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-help] IRQ latency
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I installed xenomai on an overo water board (cortex A8) and performed laten=
cy tests.
I tested two modules.
The first module is based on an internal timer. It toggles a GPIO each 1ms.
The second module waits for an external interrupt from an input GPIO (squar=
e signal at 1KHz). When that happens, the module toggles a GPIO pin.

When i load the system and do a transfer from Ethernet to the sd card the f=
irst module works fine with a maximum latency less than 50us.
But the second module, in the same context, have a maximum latency of sever=
al milliseconds.

As the first module works fine i think i have a problem with the hardware c=
onfiguration like the hardware irq priority.
In the irq.c file, the irq priority level is not set for the linux domain.

Should i configure the irq level at the initialization of the board ? What =
else could cause this issue ?



Thanks in advance,

JP

