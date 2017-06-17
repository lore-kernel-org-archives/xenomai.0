From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Sat, 17 Jun 2017 19:37:30 +0000
Message-ID: <DB6PR0701MB2456852B94D79E5484B67A3DB5C60@DB6PR0701MB2456.eurprd07.prod.outlook.com>
References: <DB6PR0701MB24567D7382C2C3C1C6BBB0A3B5C60@DB6PR0701MB2456.eurprd07.prod.outlook.com>
In-Reply-To: <DB6PR0701MB24567D7382C2C3C1C6BBB0A3B5C60@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Gpio: IRQ handler is called ~4ms after state change
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

> So it seems that in my case it takes a long time for the irq_handler() to=
 be called after the test pin is toggled.
> Am I doing something wrong in the kernel module ?

by the way, I get this in dmesg:

[   76.152289] irq 98, desc: dc18df00, depth: 1, count: 0, unhandled: 0
[   76.152314] ->handle_irq():  c008e008, handle_edge_irq+0x0/0x150
[   76.152351] ->irq_data.chip(): dc18d9d0, 0xdc18d9d0
[   76.152364] ->action():   (null)
[   76.152371]    IRQ_NOPROBE set
[   76.152378] unexpected IRQ trap at vector 62
[   76.156676] ------------[ cut here ]------------
[   76.156692] WARNING: CPU: 0 PID: 0 at kernel/irq/chip.c:843 __ipipe_ack_=
bad_irq+0x3c/0x48()
[   76.156699] Modules linked in: gpio_irq_rtdm(O) c_can_platform c_can can=
_dev tieqep pwm_tiehrpwm pwm_tiecap spidev usb_f_midi snd_rawmidi snd_seq_d=
evice usb_f_acm u_serial usb_f_mass_storage usb_f_rndis u_ether arc4 omap_a=
es_driver omap_sham uio_pruss rt2800usb rt2800lib rt2x00usb rt2x00lib mac80=
211 omap_rng rng_core snd_soc_davinci_mcasp cfg80211 snd_soc_edma snd_soc_o=
map crc_ccitt rfkill snd_soc_core snd_pcm_dmaengine snd_pcm snd_timer snd s=
pi_omap2_mcspi soundcore evdev uio_pdrv_genirq uio libcomposite ip_tables x=
_tables
[   76.156852] CPU: 0 PID: 0 Comm: swapper Tainted: G        W  O    4.4.68=
-ti-xenomai-r106 #1
[   76.156860] Hardware name: Generic AM33XX (Flattened Device Tree)
[   76.156866] I-pipe domain: Linux
[   76.156901] [<c0018d30>] (unwind_backtrace) from [<c0015bfc>] (show_stac=
k+0x20/0x24)
[   76.156922] [<c0015bfc>] (show_stack) from [<c058dc94>] (dump_stack+0x24=
/0x28)
[   76.156950] [<c058dc94>] (dump_stack) from [<c0040294>] (warn_slowpath_c=
ommon+0x94/0xc0)
[   76.156967] [<c0040294>] (warn_slowpath_common) from [<c00403c4>] (warn_=
slowpath_null+0x2c/0x34)
[   76.156985] [<c00403c4>] (warn_slowpath_null) from [<c008d7bc>] (__ipipe=
_ack_bad_irq+0x3c/0x48)
[   76.157004] [<c008d7bc>] (__ipipe_ack_bad_irq) from [<c00e6e8c>] (__ipip=
e_dispatch_irq+0x8c/0x1a8)
[   76.157024] [<c00e6e8c>] (__ipipe_dispatch_irq) from [<c05d7ad4>] (omap_=
gpio_irq_handler+0x170/0x1d8)
[   76.157041] [<c05d7ad4>] (omap_gpio_irq_handler) from [<c008a294>] (hand=
le_irq_event_percpu+0xa4/0x254)
[   76.157057] [<c008a294>] (handle_irq_event_percpu) from [<c008a47c>] (ha=
ndle_irq_event+0x38/0x4c)
[   76.157072] [<c008a47c>] (handle_irq_event) from [<c008dfc8>] (handle_le=
vel_irq+0x78/0xb8)
[   76.157088] [<c008dfc8>] (handle_level_irq) from [<c00898f0>] (generic_h=
andle_irq+0x34/0x44)
[   76.157102] [<c00898f0>] (generic_handle_irq) from [<c0089b9c>] (__handl=
e_domain_irq+0x64/0xb8)
[   76.157125] [<c0089b9c>] (__handle_domain_irq) from [<c00118f4>] (handle=
_IRQ+0x28/0x2c)
[   76.157145] [<c00118f4>] (handle_IRQ) from [<c001c990>] (__ipipe_do_IRQ+=
0x1c/0x24)
[   76.157161] [<c001c990>] (__ipipe_do_IRQ) from [<c00e6810>] (__ipipe_do_=
sync_stage+0x24c/0x270)
[   76.157175] [<c00e6810>] (__ipipe_do_sync_stage) from [<c00e68c8>] (__ip=
ipe_do_sync_pipeline+0x94/0x98)
[   76.157189] [<c00e68c8>] (__ipipe_do_sync_pipeline) from [<c00e6f3c>] (_=
_ipipe_dispatch_irq+0x13c/0x1a8)
[   76.157203] [<c00e6f3c>] (__ipipe_dispatch_irq) from [<c00092a4>] (__ipi=
pe_grab_irq+0x58/0x70)
[   76.157217] [<c00092a4>] (__ipipe_grab_irq) from [<c000961c>] (omap_intc=
_handle_irq+0x48/0xa8)
[   76.157226] Exception stack(0xc0f0dee8 to 0xc0f0df30)
[   76.157240] dee0:                   c00e6908 600c0013 c0f0df5c c0f0df00 =
c0a17494 c00095e0
[   76.157254] df00: 00000000 00000000 00000000 c0f399dc c0ffd040 c0f0c000 =
c0f0f134 c0fe570c
[   76.157264] df20: c0f399dc c0fe4e52 c0c9de24 c0f0df5c
[   76.157284] [<c000961c>] (omap_intc_handle_irq) from [<c0a17494>] (__irq=
_svc+0x54/0x60)
[   76.157292] Exception stack(0xc0f0df00 to 0xc0f0df48)
[   76.157305] df00: 00000000 00000000 00000000 c0f399dc c0ffd040 c0f0c000 =
c0f0f134 c0fe570c
[   76.157319] df20: c0f399dc c0fe4e52 c0c9de24 c0f0df5c c00e68e0 c0f0df50 =
c0011a08 c00e6908
[   76.157327] df40: 600c0013 ffffffff
[   76.157343] [<c0a17494>] (__irq_svc) from [<c00e6908>] (ipipe_unstall_ro=
ot+0x3c/0x4c)
[   76.157357] [<c00e6908>] (ipipe_unstall_root) from [<c0011a08>] (arch_cp=
u_idle+0x84/0x90)
[   76.157374] [<c0011a08>] (arch_cpu_idle) from [<c0072760>] (default_idle=
_call+0x30/0x3c)
[   76.157389] [<c0072760>] (default_idle_call) from [<c00728dc>] (cpu_star=
tup_entry+0x170/0x1b0)
[   76.157403] [<c00728dc>] (cpu_startup_entry) from [<c0a12adc>] (rest_ini=
t+0x80/0x84)
[   76.157430] [<c0a12adc>] (rest_init) from [<c0e91e08>] (start_kernel+0x4=
4c/0x46c)
[   76.157440] ---[ end trace 706c0a6fb4268ac1 ]---


