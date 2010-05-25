From: Josh Karch <JKarch@domain.hid>
Date: Tue, 25 May 2010 09:27:12 -0700
Message-ID: <843773D242212C4882D4EDFFBF665F7F0CA39CB563@domain.hid>
References: <AANLkTinjobDAuybm7LnJTEijjY4CSTArH8TOzFpNzQcp@domain.hid>
In-Reply-To: <AANLkTinjobDAuybm7LnJTEijjY4CSTArH8TOzFpNzQcp@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RT-Socket-CAN: Problem installing
	PMC-CAN266	interface card
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

________________________________________
From: xenomai-help-bounces@domain.hid [xenomai-help-bounces@domain.hid] On Behalf=
 Of Nape Ibrahim Lentsoane [nape.lentsoane@domain.hid]
Sent: Tuesday, May 25, 2010 5:05 AM
To: xenomai@xenomai.org
Subject: [Xenomai-help] RT-Socket-CAN: Problem installing PMC-CAN266    int=
erface card

Hi,

We have recently bought a PMC-CAN/266 from ESD and we  are currently experi=
encing some problems with it when intalling it on a Linux Ubuntu machine wi=
th Xenomai installed. When we plug the board into the PC it[PC] does not wa=
nt to boot successfully, it hangs and gives error messages after an attempt=
 at "Loading Module Drivers...". Just wondering should I install the driver=
 that came with the card first and then install the hardware after?

For info: when I power up the PC without the PMC card it boots normal with =
no errors.

What could I be doing wrong here? please help.

Regards,
Nape


Nape, you may consider checking for PCI IRQ conflicts which could pose a pr=
oblem with the RT drivers loading.

Joshua Karch=

