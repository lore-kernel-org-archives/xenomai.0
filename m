From: Joshua Karch <jkarch48@hotmail.com>
Subject: Re: Unable to get xeno-gpio-xilinx to work on Zynq Ultrascale +
 platform
Date: Fri, 15 May 2020 20:42:13 +0000
Message-ID: <MW3PR18MB367372D9FE88BA250C4AC292DABD0@MW3PR18MB3673.namprd18.prod.outlook.com>
References: <MW3PR18MB36730B88CBB748555D90D4FCDABD0@MW3PR18MB3673.namprd18.prod.outlook.com>,
 <CALLqZ8S0a1TaWX+Q038kD-LLMAr6Q=9PosmLt-JMby8M7OY8FA@mail.gmail.com>
In-Reply-To: <CALLqZ8S0a1TaWX+Q038kD-LLMAr6Q=9PosmLt-JMby8M7OY8FA@mail.gmail.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
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

Hi Greg!

________________________________
From: Greg Gallagher <greg@embeddedgreg.com>
Sent: Friday, May 15, 2020 1:35 PM
To: Joshua Karch <jkarch48@hotmail.com>
Cc: xenomai@xenomai.org <xenomai@xenomai.org>
Subject: Re: Unable to get xeno-gpio-xilinx to work on Zynq Ultrascale + pl=
atform

Hi,

On Fri, May 15, 2020 at 4:29 PM Joshua Karch via Xenomai
<xenomai@xenomai.org> wrote:
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


config XENO_DRIVERS_GPIO_XILINX
depends on ARCH_ZYNQ
depends on ARCH_ZYNQ || ARCH_ZYNQMP
tristate "Support for Xilinx GPIOs"

help

Best,

Josh
