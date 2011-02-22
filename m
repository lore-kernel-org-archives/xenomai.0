From: Nazarov Sergey <s-nazarov@domain.hid>
MIME-Version: 1.0
Message-Id: <274381298405447@domain.hid>
Date: Tue, 22 Feb 2011 23:10:47 +0300
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable
Subject: [Adeos-main] Interrupt handling problem on Compulab EM-X270.
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

=9A=9A=9AHi!
I'm trying to use i-pipe 1.18-01 on ARM XScale-PXA270 based Compulab EM-X=
270 board. Kernel version is 2.6.33.
With kernel, patched by i-pipe patch, network controller Davicom DM9000 s=
tanding unstable: sometimes a lot of packets are losing.
This happens with CONFIG_IPIPE disabled even. The reason is lost interrup=
ts, I see. Network controller uses GPIO line to produce interrupts.
I have found that i-pipe patch changing irq handler handle_irq_edge to ha=
ndle_irq_level (arch/arm/plat-pxa/gpio.c: pxa_init_gpio) without any cond=
itions.
What's the reason for that changing? The back change to edge-type handler=
 returns network controller to stable state.
=9A=9A=9ABest regards, Sergey.

