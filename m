From: "Lopes, Alexandre" <alexandre.lopes.ext@zeiss.com>
Date: Thu, 11 Jun 2015 10:29:09 +0000
Message-ID: <79A9E4882C44D44FA53B5AB15E6198011385C369@ADEERL01SMS001.cznet.zeiss.org>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] init failed code -19 on Cyclone V SoC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

I am trying to get Xenomai 3.0 rc4 with the 3.18.12 Linux Kernel and the=20
corresponding ipipe patch to work on an ARM SoC.
The device in question is a MitySoM module which is based on the Cyclone V
from Altera and contains a dual core ARM Cortex A9.

I have followed the "Porting Xenomai dual kernel to a new ARM SoC"=20
guide. Even though Linux boots without any  problems, Xenomai is not=20
working.

The output of dmesg | grep -E 'Xenomai|I-pipe' is the following:

[    0.000000] I-pipe, 200.000 MHz timer
[    0.123073] I-pipe, 200.000 MHz timer
[    0.249682] [Xenomai] scheduling class idle registered.
[    0.249689] [Xenomai] scheduling class rt registered.
[    0.249758] I-pipe: high-resolution clock not working
[    0.249789] [Xenomai] init failed, code -19

Which seems to indicate a problem with the timer.

On my device tree (which is already upstream) the smp_twd timer seems to=20
be properly registered (socfpga.dtsi):

timer@fffec600 {
	compatible =3D "arm,cortex-a9-twd-timer";
	reg =3D <0xfffec600 0x100>;
	interrupts =3D <1 13 0xf04>;
	clocks =3D <&mpu_periph_clk>;
};

I have also disabled CONFIG_CPU_FREQ, CONFIG_CPU_IDLE,=20
CONFIG_CC_STACKPROTECTOR, CONFIG_KGDB as well as hibernation
and sleep support and I have enabled CONFIG_IPIPE_ARM_KUSER_TSC
(it doesn't compile without it, anyway, so I am sure the symbol is
selected).
I have as well enabled the "High Resolution Timer Support" on the Kernel.

As I am rather new to Xenomai, I am clueless of where the problem lies.
I had no problems setting it up on x86 systems, but on SoCs this seems
to be a totally different business...

If anybody has some idea of how I can solve this, I would be greatly=20
appreciated.

Thanks,

Alexandre

