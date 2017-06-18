References: <DB6PR0701MB24567D7382C2C3C1C6BBB0A3B5C60@DB6PR0701MB2456.eurprd07.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <3f72aa86-8922-540f-36ca-cad41840dcc4@xenomai.org>
Date: Sun, 18 Jun 2017 09:26:44 +0200
MIME-Version: 1.0
In-Reply-To: <DB6PR0701MB24567D7382C2C3C1C6BBB0A3B5C60@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Gpio: IRQ handler is called ~4ms after state change
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/17/2017 06:52 PM, Giulio Moro wrote:
> Hi,
> I ported this GPIO driver from Xenomai 2.6 to Xenomai 3 and I run it on the Beaglebone Black: https://github.com/giuliomoro/gpio-irq-rtdm/
> 
> TheRTDM  irq_handler (in gpio_irq_rtdm.c) toggles a pin "kernel timingpin" as soon as the IRQ is received.
> The test program registers a pin to monitor and sleeps in a ioctl() waiting for the pin to go low. When the kernel unblocks it from the ioctl(), the task toggles another pin "user timingpin".
> 
> The original authors claims that, on the BeagleBone Black, with Xenomai 2.6:
> * the kernel timingpin will change roughly 5us after the test pin is toggled by an external clock
> *  the user timingpin will change roughly 5-10us after the kernel timingpin

If by "user timing", the author claims 10 us worst-case latency for
waking up a user task on this class of hardware, then the machine must
have been fairly idle under test. 50 us would make more sense under
heavy load conditions.

> 
> The above values make sense to me.
> 
> My observations, on the BeagleBone Black, Linux 4.4.65 with Xenomai 3.0.5:
> * the kernel timingpin will change roughly 4ms (milliseconds) after the test pin is toggled by an external clock
> * the user timingpin will change 40 to 60us (microseconds) after the kernel timingpin

4ms do not make sense obviously. You may be measuring the time it takes
to catch and emit this WARN_ON() message over the IRQ handler.

>    76.152289] irq 98, desc: dc18df00, depth: 1, count: 0, unhandled: 0
> [   76.152314] ->handle_irq():  c008e008, handle_edge_irq+0x0/0x150
> [   76.152351] ->irq_data.chip(): dc18d9d0, 0xdc18d9d0
> [   76.152364] ->action():   (null)
> [   76.152371]    IRQ_NOPROBE set
> [   76.152378] unexpected IRQ trap at vector 62
> [   76.156676] ------------[ cut here ]------------
> [   76.156692] WARNING: CPU: 0 PID: 0 at kernel/irq/chip.c:843 __ipipe_ack_bad_irq+0x3c/0x48()
> [   76.156699] Modules linked in: gpio_irq_rtdm(O) c_can_platform c_can can_dev tieqep pwm_tiehrpwm pwm_tiecap spidev usb_f_midi snd_rawmidi snd_seq_device usb_f_acm u_serial usb_f_mass_storage usb_f_rndis u_ether arc4 omap_aes_driver omap_sham uio_pruss rt2800usb rt2800lib rt2x00usb rt2x00lib mac80211 omap_rng rng_core snd_soc_davinci_mcasp cfg80211 snd_soc_edma snd_soc_omap crc_ccitt rfkill snd_soc_core snd_pcm_dmaengine snd_pcm snd_timer snd spi_omap2_mcspi soundcore evdev uio_pdrv_genirq uio libcomposite ip_tables x_tables
> [   76.156852] CPU: 0 PID: 0 Comm: swapper Tainted: G        W  O    4.4.68-ti-xenomai-r106 #1
> [   76.156860] Hardware name: Generic AM33XX (Flattened Device Tree)
> [   76.156866] I-pipe domain: Linux
> [   76.156901] [<c0018d30>] (unwind_backtrace) from [<c0015bfc>] (show_stack+0x20/0x24)
> [   76.156922] [<c0015bfc>] (show_stack) from [<c058dc94>] (dump_stack+0x24/0x28)
> [   76.156950] [<c058dc94>] (dump_stack) from [<c0040294>] (warn_slowpath_common+0x94/0xc0)
> [   76.156967] [<c0040294>] (warn_slowpath_common) from [<c00403c4>] (warn_slowpath_null+0x2c/0x34)
> [   76.156985] [<c00403c4>] (warn_slowpath_null) from [<c008d7bc>] (__ipipe_ack_bad_irq+0x3c/0x48)
> [   76.157004] [<c008d7bc>] (__ipipe_ack_bad_irq) from [<c00e6e8c>] (__ipipe_dispatch_irq+0x8c/0x1a8)
> [   76.157024] [<c00e6e8c>] (__ipipe_dispatch_irq) from [<c05d7ad4>] (omap_gpio_irq_handler+0x170/0x1d8)
> [   76.157041] [<c05d7ad4>] (omap_gpio_irq_handler) from [<c008a294>] (handle_irq_event_percpu+0xa4/0x254)

This is unlikely a Xenomai issue strictly speaking. You may want to
check the I-pipe code instead, there is certainly a problem with the
interrupt delivery code in the low level handler.

-- 
Philippe.

