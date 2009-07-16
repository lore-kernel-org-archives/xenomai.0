MIME-Version: 1.0
In-Reply-To: <4A5EE47E.5000507@domain.hid>
References: <b88603c30907130031v9ec9618r46bd28b494ac3417@domain.hid>
	<4A5CC870.3030208@domain.hid>
	<b88603c30907160058n55d9a49eq644a2e326626bc01@domain.hid>
	<4A5EE47E.5000507@domain.hid>
Date: Thu, 16 Jul 2009 11:24:36 +0200
Message-ID: <b88603c30907160224o7a0ebde0w6d52016dc40fccbe@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] ARM: userspace apps result in Segmentation fault
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,

Sorry I forgot to mention that I use the following kernel config,
which would match compiling xenomai userspace with --enable-arm-eabi:

CONFIG_AEABI=3Dy
# CONFIG_OABI_COMPAT is not set

Please find the information you asked for below.

root@domain.hid:~# cat /proc/interrupts
           CPU0
  1:       1733         AIC  rtc0, ttyS0
 11:         11         AIC  mmc0
 14:          6         AIC  atmel_spi.0
 19:     345827         AIC  at91_tick
 21:         23         AIC  eth0
 24:        164         AIC  at91_udc
 26:          0         AIC  atmel_lcdfb
 29:          0         AIC  ohci_hcd:usb1
 31:          0         AIC  ads7846
 57:          1        GPIO  at91_udc
178:          0        GPIO  mmc0
Err:          0

root@domain.hid:~# cat /proc/xenomai/irq
IRQ         CPU0
 19:      373801         [timer]
194:           0         [virtual]

I was also able to load an RTDM kernel module and receive irq's from
it in kernel space. This module was not loaded at the time of the
cat's.

The userspace apps are the problem. Probably already at the init of
the xenomai libraries that are linked with them, while
/usr/xenomai/bin/cyclictest -? already makes the system hang.

Thanks,
Henri.

On Thu, Jul 16, 2009 at 10:27 AM, Gilles
Chanteperdrix<gilles.chanteperdrix@xenomai.org> wrote:
> Henri Roosen wrote:
>> The Xenomai applications (cyclictest, latency) result in a hangup of the=
 system.
>>
>> I did a complete rebuild of the openembedded Angstrom console-image
>> distribution, compiled this time with the CodeSourcery 2007q3
>> cross-compile environment. This is a gcc 4.2.1 version. But has the
>> same hangup behaviour as the default 4.3.3 version.
>>
>> I build the xenomai userspace with:
>> ./configure --build=3Di686-pc-linux-gnu
>> --host=3Darm-angstrom-linux-gnueabi --enable-arm-mach=3Dat91sam926x
>> --enable-arm-eabi
>
> I can not tell you if --enable-arm-eabi is correct, it depends on how
> you configured the kernel.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0Gilles
>
>

