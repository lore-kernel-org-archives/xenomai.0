Message-ID: <48BD5968.6050309@domain.hid>
Date: Tue, 02 Sep 2008 17:19:04 +0200
From: Theo Veenker <Theo.Veenker@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] using a pcmcia parallel port card
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I'm trying to access a pcmcia parallel port (Trans Digital TDC303)
from a kernel space module. When I insert the card into the laptop
pcmcia_cs recognizes it and reports I/O address 0x3378. I tried
to access the device at that address like you would access LPT1
at 0x378. That didn't work; I assume the card is not actually at
that address or not enabled or something.

Does anyone have a clue how to use a pcmcia parallel port card
with xenomai (or any other pcmcia card for that matter)?

Thanks,
Theo



