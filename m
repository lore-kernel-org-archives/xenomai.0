From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Sat, 17 Jun 2017 16:52:18 +0000
Message-ID: <DB6PR0701MB24567D7382C2C3C1C6BBB0A3B5C60@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Gpio: IRQ handler is called ~4ms after state change
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,
I ported this GPIO driver from Xenomai 2.6 to Xenomai 3 and I run it on the=
 Beaglebone Black: https://github.com/giuliomoro/gpio-irq-rtdm/

TheRTDM  irq_handler (in gpio_irq_rtdm.c) toggles a pin "kernel timingpin" =
as soon as the IRQ is received.
The test program registers a pin to monitor and sleeps in a ioctl() waiting=
 for the pin to go low. When the kernel unblocks it from the ioctl(), the t=
ask toggles another pin "user timingpin".

The original authors claims that, on the BeagleBone Black, with Xenomai 2.6=
:
* the kernel timingpin will change roughly 5us after the test pin is toggle=
d by an external clock
*  the user timingpin will change roughly 5-10us after the kernel timingpin

The above values make sense to me.

My observations, on the BeagleBone Black, Linux 4.4.65 with Xenomai 3.0.5:
* the kernel timingpin will change roughly 4ms (milliseconds) after the tes=
t pin is toggled by an external clock
* the user timingpin will change 40 to 60us (microseconds) after the kernel=
 timingpin

So it seems that in my case it takes a long time for the irq_handler() to b=
e called after the test pin is toggled.
Am I doing something wrong in the kernel module ?

See in particular irq_handler() and gpio_irq_ioctl_rt() in gpio_irq_rtdm.c
and demo() in gpio-irq-test.c

$  cat /proc/xenomai/sched/stat
CPU  PID    MSW        CSW        XSC        PF    STAT       %CPU  NAME
  0  0      0          166718     0          0     00018000   99.1  [ROOT]
  0  691    1          1          5          0     000600c0    0.0  gpio-ir=
q-test
  0  698    1          112758     338273     0     00040042    0.6  trivial
  0  0      0          978799     0          0     00000000    0.1  [IRQ16:=
 [timer]]
  0  0      0          112756     0          0     00000000    0.2  [IRQ98:=
 gpio69]

$ cat /proc/xenomai/sched/threads

CPU  PID    CLASS  TYPE      PRI   TIMEOUT       STAT       NAME
  0  0      idle   core       -1   -             R          [ROOT]
  0  691    rt     cobalt      0   -             X          gpio-irq-test
  0  698    rt     cobalt     99   -             W          trivial

Thanks,
Giulio=

