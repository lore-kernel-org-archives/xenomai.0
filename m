MIME-Version: 1.0
Date: Sun, 23 Dec 2012 20:12:56 +0800
Message-ID: <CAGVaUoFsUJKCSOMrDuq3htrLzScpzjVP8oKs2ARp7k7o8KbRfQ@mail.gmail.com>
From: Bao Rui <rbaocug@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] About the timer interrupt in beaglebone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I worked on the beaglebone with Xenomai, currently I meet a problem about
the timer interrupt after integrated Xenomai into my beaglebone,

The beaglebone can startup after integrating Xenomai and IPIPE, but the
timer seems not work properly. Here I add a printk in the timer interrut:
static irqreturn_t omap2_gp_timer_interrupt(int irq, void *dev_id)
{
    struct clock_event_device *evt = &clockevent_gpt;

    if (!clockevent_ipipe_stolen(evt))
        omap2_gp_timer_ack();

    if (num_online_cpus() == 1)
        __ipipe_tsc_update();
    pr_info("testtimer\n");
    evt->event_handler(evt);
    return IRQ_HANDLED;
}

And the kernel logs here:
......
NR_IRQS:396
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 5.0) with 128
interrus
[    0.000000] Total of 128 interrupts on 1 active
controller
[    0.000000]
omap2_gp_timer_set_mode:mode=1,clkev.rate:24000000l,HZ=100
[    0.000000]
omap2_gp_timer_set_mode:mode=2,clkev.rate:24000000l,HZ=100
[    0.000000] OMAP clockevent source: GPTIMER2 at 24000000
Hz
[    0.000000] OMAP clocksource: GPTIMER3 at 24000000
Hz
[    0.000000] I-pipe, 24.000 MHz
clocksource
[    0.000000] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every
1789s
[    0.000000] Interrupt pipeline (release
#1)
[    0.000000] Console: colour dummy device
80x30
[    0.000514] Calibrating delay
loop...
[    0.009032]
testtimer
[    0.019013]
testtimer
[    0.029013]
testtimer
[    0.039013]
testtimer
[    0.049012]
testtimer
[    0.059012]
testtimer
[    0.069013]
testtimer
[    0.079012]
testtimer
[    0.089012]
testtimer
[    0.099012]
testtimer
[    0.109012]
testtimer
[    0.119012]
testtimer
[    0.119054] 718.02 BogoMIPS
(lpj=3590144)
[    0.119064] pid_max: default: 32768 minimum:
301
[    0.119196] Security Framework
initialized
[    0.119301] Mount-cache hash table entries:
512
[    0.119712] CPU: Testing write buffer coherency:
ok
[    0.129031]
testtimer
[    0.139013]
testtimer
[    0.139918] omap_hwmod: gfx: failed to
hardreset
[    0.149013]
testtimer
[    0.156191] omap_hwmod: pruss: failed to
hardreset
[    0.157420] print_constraints:
dummy:
[    0.157810] NET: Registered protocol family
16
[    0.159025]
testtimer
[    0.160259] OMAP GPIO hardware version
0.1
[    0.163100] omap_mux_init: Add partition: #1: core, flags:
0
[    0.165344]
HB:am335x_evm_i2c_init
[    0.165586]  omap_i2c.1: alias fck already
exists
[    0.166245] HB:End
am335x_evm_init
[    0.166573]  omap2_mcspi.1: alias fck already
exists
[    0.166819]  omap2_mcspi.2: alias fck already
exists
[    0.167096]  edma.0: alias fck already
exists
[    0.167117]  edma.0: alias fck already
exists
[    0.167136]  edma.0: alias fck already
exists
[    0.169030]
testtimer
[    0.179036]
testtimer
[    0.189026]
testtimer
[    0.193574] bio: create slab <bio-0> at
0
[    0.196996] usbcore: registered new interface driver
usbfs
[    0.197349] usbcore: registered new interface driver
hub
[    0.197577] usbcore: registered new device driver
usb
[    0.197725] musb-ti81xx musb-ti81xx: musb0, board_mode=0x13,
plat_mode=0x3
[    0.198020] musb-ti81xx musb-ti81xx: musb1, board_mode=0x13,
plat_mode=0x1
[    0.199029]
testtimer
[    0.199348] omap_i2c omap_i2c.1: bus 1 rev2.4.0 at 100
kHz
[    0.200917] tps65910 1-002d: could not be
detected
[    0.202916] Switching to clocksource
ipipe_tsc
[    0.209036]
testtimer
[    0.209088]
omap2_gp_timer_set_mode:mode=3,clkev.rate:24000000l,HZ=100
[    0.219143]
testtimer
[    0.220092] musb-hdrc: version 6.0, ?dma?, otg
(peripheral+host)
[    0.220271] musb-hdrc musb-hdrc.0: dma type:
pio
[    0.221242] musb-hdrc musb-hdrc.0: USB OTG mode controller at d081c000
using8
[    0.221419] musb-hdrc musb-hdrc.1: dma type:
pio
[    0.221872] musb-hdrc musb-hdrc.1: MUSB HDRC host
driver
[    0.221949] musb-hdrc musb-hdrc.1: new USB bus registered, assigned bus
numb1
[    0.222094] usb usb1: New USB device found, idVendor=1d6b,
idProduct=0002
[    0.222110] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber1
[    0.222124] usb usb1: Product: MUSB HDRC host
driver
[    0.222135] usb usb1: Manufacturer: Linux 3.2.0
musb-hcd
[    0.222147] usb usb1: SerialNumber:
musb-hdrc.1
[    0.223028] hub 1-0:1.0: USB hub
found
[    0.223069] hub 1-0:1.0: 1 port detected

First we can see the "testtimer" logs, but after some while, this interrupt
will not enter again. If I disable the Xenomai and IPIPE, I can get the
"testtimer" working always.

If omap2_gp_timer_interrupt() does not work properly, the kernel will stop
after a msleep() call(The i2c driver will call this msleep() to read the
eeprom information).

Could you give some suggestions about this issue? I can try it on my target.

Best Regards,
Henry
