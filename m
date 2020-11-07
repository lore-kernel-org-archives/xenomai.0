From: =?utf-8?Q?Deniz_U=C4=9Fur?= <deniz343@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: Probe failure with xeno_spi
Date: Sat, 7 Nov 2020 20:21:23 +0300
References: <32DE4B3D-6A64-4829-BE04-7290906404F7@gmail.com>
In-Reply-To: <32DE4B3D-6A64-4829-BE04-7290906404F7@gmail.com>
Message-Id: <03C5B1A5-B68C-47F7-AB60-D5EC02A8B859@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Solved.

For future referance, CONFIG_SPI_SPIDEV was built into kernel. Removing =
it allowed driver to function.

> On 7 Nov 2020, at 12:37, Deniz U=C4=9Fur <deniz343@gmail.com> wrote:
>=20
> Hello all,
>=20
> There seems to be a fatal error when initializing the xeno_spi module =
on BBB during boot. Device Tree has been modified with these nodes [1]. =
The addresses defined in [1] are the same as [2], which I put that in =
case [1] gets deleted. Along with that HDMI was also disabled with =
u-boot overlays in uEnv.txt. A stack trace concerning this problem is =
attached below.
>=20
> Is there anything I can do to solve this problem?
>=20
> Thanks.
> Best regards.
>=20
> Technical Information:
> Xenomai version: next-branch
> Linux version: 4.19.55+
> Arch: armhf
> Target: BeagleBone Black
> Built using: xenomai-images
>=20
> [1]: =
https://github.com/laurentiuduca/real-time-spi/blob/master/xenomai/kernel/=
arch/arm/boot/dts/am335x-boneblack-spi.dtsi =
<https://github.com/laurentiuduca/real-time-spi/blob/master/xenomai/kernel=
/arch/arm/boot/dts/am335x-boneblack-spi.dtsi>
> [2]: https://elinux.org/BeagleBone_Black_Enable_SPIDEV =
<https://elinux.org/BeagleBone_Black_Enable_SPIDEV>
>=20
> DMESG OUTPUT:
> [   35.044891] Unable to handle kernel paging request at virtual =
address 4803012c
> [   35.052690] pgd =3D bd494b82
> [   35.055530] [4803012c] *pgd=3D00000000
> [   35.059285] Internal error: Oops: 5 [#1] SMP ARM
> [   35.064122] Modules linked in: xeno_spi(+)
> [   35.068428] CPU: 0 PID: 201 Comm: systemd-udevd Not tainted =
4.19.55+ #1
> [   35.075354] Hardware name: Generic AM33XX (Flattened Device Tree)
> [   35.081734] I-pipe domain: Linux
> [   35.085138] PC is at __rtdm_spi_setup_driver+0x1c/0x158 [xeno_spi]
> [   35.091619] LR is at spi_device_probe+0x50/0x5c [xeno_spi]
> [   35.097362] pc : [<bf000be0>]    lr : [<bf001094>]    psr: 600a0013
> [   35.103925] sp : dd157cd8  ip : dd157cd4  fp : 00000000
> [   35.109394] r10: 00000009  r9 : bf003044  r8 : 00000000
> [   35.114865] r7 : 00000000  r6 : bf0030c0  r5 : ddb18c00  r4 : =
ddb18b40
> [   35.121701] r3 : 48030100  r2 : bbc1de89  r1 : 006000c0  r0 : =
ddb18b40
> [   35.128539] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  =
Segment none
> [   35.136011] Control: 10c5387d  Table: 9e2b0019  DAC: 00000051
> [   35.142029] Process systemd-udevd (pid: 201, stack limit =3D =
0xacfee0ee)
> [   35.148864] Stack: (0xdd157cd8 to 0xdd158000)
> [   35.153427] 7cc0:                                                   =
    ddb18b40 ddb18c00
> [   35.161996] 7ce0: bf003034 bf001094 ddb18c00 00000000 bf003034 =
c0a3b8d8 c182e4f4 ddb18c00
> [   35.170565] 7d00: c182e4f8 c0972850 ddb18c00 bf003044 ddb18c34 =
c0972b78 00000000 c1604c88
> [   35.179133] 7d20: bf0030c0 c0972a70 bf002064 c0e4a424 bf002064 =
ddb18c00 bf003044 ddb18c34
> [   35.187702] 7d40: c0972b78 00000000 c1604c88 bf0030c0 00000000 =
c0972c54 ddac5334 c1604c88
> [   35.196270] 7d60: bf003044 c0970b38 00000000 df163358 ddac5334 =
bbc1de89 c174a4c8 bf003044
> [   35.204838] 7d80: de2ff500 c174a4c8 00000000 c0971cdc bf0023a8 =
ddf640c0 bf003044 bf003044
> [   35.213406] 7da0: c1604c88 ffffe000 bf006000 c09737bc c1788380 =
c1604c88 ffffe000 c0303010
> [   35.221975] 7dc0: c11fc79c dfdb7c80 8040003e c1566cb0 e19f2000 =
bbc1de89 df001e40 dfdb7c80
> [   35.230544] 7de0: c1566cb0 de082700 c16050b0 a00a0013 00010511 =
0000000c de082840 df9d8cb0
> [   35.239112] 7e00: 00000001 bf0030c0 00000002 bbc1de89 bf0030c0 =
00000002 de082800 00000002
> [   35.247680] 7e20: de082740 c03d22dc 00000002 de082700 00000002 =
dd157f40 00000002 de082700
> [   35.256248] 7e40: 00000002 c03d4690 bf0030cc 00007fff bf0030c0 =
c03d152c 00000000 c03d0e40
> [   35.264817] 7e60: bf003108 bf0031c0 bf00329c bf0031f0 c0f08980 =
c132f874 c1203074 c1203080
> [   35.273386] 7e80: c12030d8 c1604c88 00000000 bf0023fb 00600001 =
ffffe000 bf000000 de3050c0
> [   35.281953] 7ea0: 00000000 00000000 bf00203c 00000005 00000000 =
00000000 6e72656b 00006c65
> [   35.290520] 7ec0: 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000 00000000
> [   35.299088] 7ee0: 00000000 00000000 00000000 00000000 00000000 =
bbc1de89 7fffffff c1604c88
> [   35.307655] 7f00: 00000000 00000006 b6e4959c c0301308 dd156000 =
0000017b 00549680 c03d4b58
> [   35.316223] 7f20: 7fffffff 00000000 00000003 00000001 00549680 =
e19f2000 00003d28 00000000
> [   35.324790] 7f40: e19f33f3 e19f3680 e19f2000 00003d28 e19f5760 =
e19f55dc e19f4764 00004000
> [   35.333357] 7f60: 00004260 00000000 00000000 00000000 00002470 =
00000022 00000023 0000001a
> [   35.341924] 7f80: 00000000 0000000e 00000000 bbc1de89 00549680 =
00549680 00000000 88aece00
> [   35.350492] 7fa0: 0000017b c03012d4 00549680 00000000 00000006 =
b6e4959c 00000000 00000000
> [   35.359059] 7fc0: 00549680 00000000 88aece00 0000017b 00549ef8 =
0050d870 00000000 00549680
> [   35.367626] 7fe0: beb30150 beb30140 b6e431cd b6ef3d92 400a0030 =
00000006 00000000 00000000
> [   35.376221] [<bf000be0>] (__rtdm_spi_setup_driver [xeno_spi]) from =
[<bf001094>] (spi_device_probe+0x50/0x5c [xeno_spi])
> [   35.387547] [<bf001094>] (spi_device_probe [xeno_spi]) from =
[<c0a3b8d8>] (spi_drv_probe+0x7c/0xa0)
> [   35.396940] [<c0a3b8d8>] (spi_drv_probe) from [<c0972850>] =
(really_probe+0x1fc/0x2b8)
> [   35.405146] [<c0972850>] (really_probe) from [<c0972a70>] =
(driver_probe_device+0x60/0x168)
> [   35.413805] [<c0972a70>] (driver_probe_device) from [<c0972c54>] =
(__driver_attach+0xdc/0xe0)
> [   35.422655] [<c0972c54>] (__driver_attach) from [<c0970b38>] =
(bus_for_each_dev+0x74/0xb4)
> [   35.431224] [<c0970b38>] (bus_for_each_dev) from [<c0971cdc>] =
(bus_add_driver+0x1c0/0x204)
> [   35.439883] [<c0971cdc>] (bus_add_driver) from [<c09737bc>] =
(driver_register+0x74/0x108)
> [   35.448366] [<c09737bc>] (driver_register) from [<c0303010>] =
(do_one_initcall+0x54/0x208)
> [   35.456947] [<c0303010>] (do_one_initcall) from [<c03d22dc>] =
(do_init_module+0x64/0x214)
> [   35.465428] [<c03d22dc>] (do_init_module) from [<c03d4690>] =
(load_module+0x219c/0x2414)
> [   35.473817] [<c03d4690>] (load_module) from [<c03d4b58>] =
(sys_finit_module+0xc4/0xdc)
> [   35.482021] [<c03d4b58>] (sys_finit_module) from [<c03012d4>] =
(__sys_trace_return+0x0/0x10)
> [   35.490767] Exception stack(0xdd157fa8 to 0xdd157ff0)
> [   35.496058] 7fa0:                   00549680 00000000 00000006 =
b6e4959c 00000000 00000000
> [   35.504626] 7fc0: 00549680 00000000 88aece00 0000017b 00549ef8 =
0050d870 00000000 00549680
> [   35.513191] 7fe0: beb30150 beb30140 b6e431cd b6ef3d92
> [   35.518483] Code: e3a010c0 e3401060 e30360c0 e34b6f00 (e593002c)
> [   35.525019] ---[ end trace f361d1ec65f56b66 ]---

