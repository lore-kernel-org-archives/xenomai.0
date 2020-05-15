From: Joshua Karch <jkarch48@hotmail.com>
Subject: RE: Unable to get xeno-gpio-xilinx to work on Zynq Ultrascale +
 platform
Date: Fri, 15 May 2020 20:53:36 +0000
Message-ID: <MW3PR18MB367363218E5F906501D209D2DABD0@MW3PR18MB3673.namprd18.prod.outlook.com>
References: <MW3PR18MB36730B88CBB748555D90D4FCDABD0@MW3PR18MB3673.namprd18.prod.outlook.com>
 <CALLqZ8S0a1TaWX+Q038kD-LLMAr6Q=9PosmLt-JMby8M7OY8FA@mail.gmail.com>
 <MW3PR18MB367372D9FE88BA250C4AC292DABD0@MW3PR18MB3673.namprd18.prod.outlook.com>,
 <CALLqZ8RQ+Yz+mkBXc8S=BmS5_EM1otykiRZQ-KU5gCJu8eM19w@mail.gmail.com>
In-Reply-To: <CALLqZ8RQ+Yz+mkBXc8S=BmS5_EM1otykiRZQ-KU5gCJu8eM19w@mail.gmail.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>



Sent from Mail<https://go.microsoft.com/fwlink/?LinkId=3D550986> for Window=
s 10

From: Greg Gallagher<mailto:greg@embeddedgreg.com>
Sent: Friday, May 15, 2020 4:46 PM
To: Joshua Karch<mailto:jkarch48@hotmail.com>
Cc: xenomai@xenomai.org<mailto:xenomai@xenomai.org>
Subject: Re: Unable to get xeno-gpio-xilinx to work on Zynq Ultrascale + pl=
atform

HI,

On Fri, May 15, 2020 at 4:42 PM Joshua Karch <jkarch48@hotmail.com<mailto:j=
karch48@hotmail.com>> wrote:
Hi Greg!


From: Greg Gallagher <greg@embeddedgreg.com<mailto:greg@embeddedgreg.com>>
Sent: Friday, May 15, 2020 1:35 PM
To: Joshua Karch <jkarch48@hotmail.com<mailto:jkarch48@hotmail.com>>
Cc: xenomai@xenomai.org<mailto:xenomai@xenomai.org> <xenomai@xenomai.org<ma=
ilto:xenomai@xenomai.org>>
Subject: Re: Unable to get xeno-gpio-xilinx to work on Zynq Ultrascale + pl=
atform

Hi,

On Fri, May 15, 2020 at 4:29 PM Joshua Karch via Xenomai
<xenomai@xenomai.org<mailto:xenomai@xenomai.org>> wrote:
>
> Hello,
>
> This my first post in 10 years to the Xenomai group, just as the EVL proj=
ect comes online!  I'm trying to get the xeno-gpio-xilinx driver working bu=
t am encountering the following difficulties:
> (1)  It seems the standard non Xenomai gpio-xilinx driver SysFS are prere=
quisites to making the driver work.  Unlike the SJA1000 CAN Drivers I used =
in the past which were standalone, I'm seeing a lot of clues that the Xeno =
GPIO drivers need to piggyback on top of the core Linux Drivers.   I guess =
this is a change from when I last worked with Xenomai 10 years ago where I =
used xeno-16550A and SJA1000 as RTSER and RTCAN drivers.
>
> When I attempt to modprobe xeno-gpio-xilinx I receive a message stating:
>
> modprobe: ERROR: could not insert 'xeno_gpio_xilinx': No such device
> Device Tree:
> # cat /proc/device-tree/axigpio@a0000000/compatible
> xlnx,xps-gpio-1.00.a
>
> In Xenomai  gpio-xilinx.c:
>         return rtdm_gpiochip_scan_of(NULL, "xlnx,xps-gpio-1.00.a",
>                      RTDM_SUBCLASS_XILINX);
>
>
> I instrumented the Xenomai gpio-xilinx.c  and gpio-core.c to see if the o=
f_find_compatible_node function fails and indeed it does find no such devic=
e.  Also I noted that there are no Xilinx specific registers in the gpio-co=
re.c or in gpio-xilinx.c, making me believe that this driver is piggybackin=
g on top of the Xilinx driver.
>
> However: when I modprobe gpio-xilinx the of_find_compatible_node function=
 no longer fails, so I guess of_find_compatible_node works only with loaded=
 drivers / GPIO Chips.  The issue is, gpio-xilinx has already done the SYSF=
S registration, so I get the following errors:  Seems  the driver wants to =
use the same names for RT with SYSFS as non RT. The key error is "
> kobject_add_internal failed for !axigpio@a0000000 with -EEXIST, d
> on't try to register things with the same name in the same directory.
> "
>
> Thoughts?
>
> Josh Karch
>
>
> modprobe xeno-gpio-xilinx
> [   55.778656] test probing xilinx gpio rt
> [   55.782753] sysfs: cannot create duplicate filename '/class/!axigpio@a=
0000000
> '
> [   55.789991] CPU: 1 PID: 237 Comm: modprobe Tainted: G        W  O     =
 4.19.5
> 5 #8
> [   55.797470] Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
> [   55.802422] I-pipe domain: Linux
> [   55.805643] Call trace:
> [   55.808090]  dump_backtrace+0x0/0x160
> [   55.811748]  show_stack+0x14/0x20
> [   55.815056]  dump_stack+0xcc/0xf4
> [   55.818363]  sysfs_warn_dup+0x60/0x80
> [   55.822016]  sysfs_create_dir_ns+0xcc/0xf0
> [   55.826106]  kobject_add_internal+0xac/0x2a0
> [   55.830367]  kset_register+0x50/0x80
> [   55.833937]  __class_register+0xbc/0x170
> [   55.837850]  __class_create+0x50/0x90
> [   55.841507]  rtdm_gpiochip_add+0x30/0x260
> [   55.845507]  rtdm_gpiochip_alloc+0x50/0xe0
> [   55.849596]  rtdm_gpiochip_scan_of.part.1+0x138/0x1e0
> [   55.854640]  rtdm_gpiochip_scan_of+0x20/0x30
> [   55.858905]  xilinx_gpio_init+0x28/0x1000 [xeno_gpio_xilinx]
> [   55.864554]  do_one_initcall+0x74/0x178
> [   55.868382]  do_init_module+0x54/0x1d0
> [   55.872122]  load_module+0x1b90/0x2120
> [   55.875864]  __se_sys_finit_module+0xb8/0xd0
> [   55.880127]  __arm64_sys_finit_module+0x18/0x20
> [   55.884650]  el0_svc_common+0xbc/0x1a0
> [   55.888390]  el0_svc_handler+0x68/0x80
> [   55.892131]  el0_svc+0x8/0x18
> [   55.895114] kobject_add_internal failed for !axigpio@a0000000 with -EE=
XIST, d
> on't try to register things with the same name in the same directory.
> [   55.908254] [Xenomai] cannot create sysfs class
> [   55.912796] sysfs: cannot create duplicate filename '/class/!axigpio@a=
0000000
> '
> [   55.920021] CPU: 1 PID: 237 Comm: modprobe Tainted: G        W  O     =
 4.19.5
> 5 #8
> [   55.927500] Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
> [   55.932453] I-pipe domain: Linux
> [   55.935672] Call trace:
> [   55.938115]  dump_backtrace+0x0/0x160
> [   55.941769]  show_stack+0x14/0x20
> [   55.945077]  dump_stack+0xcc/0xf4
> [   55.948384]  sysfs_warn_dup+0x60/0x80
> [   55.952038]  sysfs_create_dir_ns+0xcc/0xf0
> [   55.956127]  kobject_add_internal+0xac/0x2a0
> [   55.960389]  kset_register+0x50/0x80
> [   55.963957]  __class_register+0xbc/0x170
> [   55.967872]  __class_create+0x50/0x90
> [   55.971527]  rtdm_gpiochip_add+0x30/0x260
> [   55.975529]  rtdm_gpiochip_alloc+0x50/0xe0
> [   55.979618]  rtdm_gpiochip_scan_of.part.1+0x138/0x1e0
> [   55.984663]  rtdm_gpiochip_scan_of+0x20/0x30
> [   55.988925]  xilinx_gpio_init+0x28/0x1000 [xeno_gpio_xilinx]
> [   55.994576]  do_one_initcall+0x74/0x178
> [   55.998403]  do_init_module+0x54/0x1d0
> [   56.002144]  load_module+0x1b90/0x2120
> [   56.005886]  __se_sys_finit_module+0xb8/0xd0
> [   56.010149]  __arm64_sys_finit_module+0x18/0x20
> [   56.014672]  el0_svc_common+0xbc/0x1a0
> [   56.018412]  el0_svc_handler+0x68/0x80
> [   56.022153]  el0_svc+0x8/0x18
> [   56.025128] kobject_add_internal failed for !axigpio@a0000000 with -EE=
XIST, d
> on't try to register things with the same name in the same directory.
> [   56.038263] [Xenomai] cannot create sysfs class
> [   56.042798] Xeno Scan returns -17
> #
>
>
>
I can take a look.  This was working on the Zynq-7000, but I haven't
tested it on the Ultrascale.  I'll see if I can reproduce.

Thanks

Greg



Thank you for your help with this! The other thing I had to do to make this=
 work was to edit drivers/xenomai/gpio/Kconfig to enable depends on
ARCH_ZYNQ || ARCH_ZYNQMP because I assume the AXI driver should be the same=
 for either ZYNQ or ZYNQMP, is that a safe assumption?

I assume that is correct, but I'll double check.  I have a Ultra96 here tha=
t I can fire up and test on.



config XENO_DRIVERS_GPIO_XILINX

depends on ARCH_ZYNQ

depends on ARCH_ZYNQ || ARCH_ZYNQMP

tristate "Support for Xilinx GPIOs"


Yep, these will need to be enabled for the AXI gpios to build for the ZynqM=
P arch.

help

Best,

Josh
I'll answer the questions you have in your first post once I look at the dr=
iver again, I want to make sure my assumptions are correct.  I haven't look=
ed at the GPIO core in a couple of months.

Thanks

Greg

Greg, sounds great! Thank you!  We are running Linux 4.19.55 which is based=
 on the Linux-xlnx 4.19 distribution, with Xenomai 3.1 and Cobalt Core.  Cu=
rrently I have Sysfs and the kernel module enabled.

One other funky thing that might be involved is with the base gpio-xilinx d=
river.  I get a message and a trace that gpio-xilinx is not =93pipeline saf=
e=94 when loading up on the dmesg.  However the base, non-Xenomai GPIO driv=
er does seem to communicate with hardware.

   13.389070] ------------[ cut here ]------------
[   13.393691] irqchip xgpio is not pipeline-safe!
[   13.393711] WARNING: CPU: 0 PID: 145 at kernel/irq/chip.c:55 irq_set_chi=
p+0xb4/0xd0
[   13.405883] Modules linked in: gpio_xilinx(+)
[   13.410240] CPU: 0 PID: 145 Comm: systemd-udevd Not tainted 4.19.55 #9
[   13.416758] Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
[   13.421713] I-pipe domain: Linux
[   13.424935] pstate: 40000005 (nZcv daif -PAN -UAO)
[   13.429720] pc : irq_set_chip+0xb4/0xd0
[   13.433546] lr : irq_set_chip+0xb4/0xd0
[   13.437372] sp : ffffff8009543820
[   13.440679] x29: ffffff8009543820 x28: ffffff8000a33200
[   13.445985] x27: ffffff8000a307f0 x26: ffffff8000a30b20
[   13.451289] x25: ffffff8000a30410 x24: ffffff8008df9688
[   13.456593] x23: ffffff80080f7300 x22: ffffff8000a33000
[   13.461897] x21: ffffffc85d39be00 x20: ffffff8000a33000
[   13.467201] x19: ffffff8008df9688 x18: 0000000000000010
[   13.472505] x17: 0000000000000001 x16: 0000000000000007
[   13.477809] x15: ffffffffffffffff x14: 0720072007200720
[   13.483113] x13: 0720072007200720 x12: 0720072007200720
[   13.488417] x11: 0720072007200720 x10: 0720072007200720
[   13.493721] x9 : ffffff8009543820 x8 : 61732d656e696c65
[   13.499025] x7 : ffffff8008e97000 x6 : 0000000000000164
[   13.504329] x5 : 0000000000000001 x4 : ffffffc87ff50988
[   13.509633] x3 : ffffffc87ff50988 x2 : 0000000000000007
[   13.514937] x1 : f90b249e3d9add00 x0 : 0000000000000000
[   13.520242] Call trace:
[   13.522682]  irq_set_chip+0xb4/0xd0
[   13.526164]  irq_set_chip_and_handler_name+0x20/0x50
[   13.531125]  xgpio_irq_setup+0xe4/0x180 [gpio_xilinx]
[   13.536175]  xgpio_of_probe+0x25c/0x560 [gpio_xilinx]
[   13.541219]  platform_drv_probe+0x50/0xa0
[   13.545217]  really_probe+0x1d0/0x280
[   13.548871]  driver_probe_device+0x54/0xf0
[   13.552960]  __driver_attach+0xe4/0xf0
[   13.556703]  bus_for_each_dev+0x70/0xc0
[   13.560532]  driver_attach+0x20/0x30
[   13.564099]  bus_add_driver+0x1dc/0x210
[   13.567926]  driver_register+0x60/0x110
[   13.571755]  __platform_driver_register+0x44/0x50
[   13.576455]  xgpio_init+0x20/0x1000 [gpio_xilinx]
[   13.581151]  do_one_initcall+0x74/0x178
[   13.584978]  do_init_module+0x54/0x1d0
[   13.588719]  load_module+0x1b90/0x2120
[   13.592461]  __se_sys_finit_module+0xb8/0xd0
[   13.596722]  __arm64_sys_finit_module+0x18/0x20
[   13.601247]  el0_svc_common+0xbc/0x1a0
[   13.604987]  el0_svc_handler+0x68/0x80
[   13.608728]  el0_svc+0x8/0x18
[   13.611686] ---[ end trace 8ee7549559e499e0 ]---

For reference: my device tree entry if needed:
        axi_gpio_0: axigpio@a0000000
        {
                #gpio-cells =3D <2>;
                #interrupt-cells =3D <2>;
                compatible =3D "xlnx,xps-gpio-1.00.a";
                gpio-controller ;
                interrupt-parent =3D <&gic>;
                interrupts =3D < 0 89 4 >;
                reg =3D < 0x0 0xa0000000 0x0 0x1000 >;
                xlnx,all-inputs =3D <0x0>;
                xlnx,all-inputs-2 =3D <0x0>;
                xlnx,dout-default =3D <0x0>;
                xlnx,dout-default-2 =3D <0x0>;
                xlnx,gpio-width =3D <0x4>;
                xlnx,gpio2-width =3D <0x4>;
                xlnx,interrupt-present =3D <0x1>;
                xlnx,is-dual =3D <0x1>;
                xlnx,tri-default =3D <0xffffffff>;
                xlnx,tri-default-2 =3D <0xffffffff>;
        };

Best,
Josh

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 288EE41577FB40D7ABA30D438BAB4428.png
Type: image/png
Size: 160 bytes
Desc: 288EE41577FB40D7ABA30D438BAB4428.png
URL: <http://xenomai.org/pipermail/xenomai/attachments/20200515/1b16d8fe/at=
tachment.png>
