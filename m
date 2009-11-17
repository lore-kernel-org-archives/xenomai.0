MIME-Version: 1.0
Sender: lcasassa@domain.hid
In-Reply-To: <47a3101a0911171342y39faa155r9ed7010f672f4e31@domain.hid>
References: <47a3101a0911171342y39faa155r9ed7010f672f4e31@domain.hid>
From: Linus Casassa <linus@domain.hid>
Date: Tue, 17 Nov 2009 19:20:55 -0300
Message-ID: <47a3101a0911171420g2ec0ee69x6a16a55bbdacb40a@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd2118e5a2e040478988bcb
Subject: Re: [Xenomai-help] Wifistix kernel 2.6.24
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

--000e0cd2118e5a2e040478988bcb
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ups I didn't have pxa2xx and pxa2xx_cs module.

Now I have this error:

root@domain.hid:~$ modprobe wlan0
Segmentation fault

root@domain.hid:~$ dmesg
<5>pccard: card ejected from slot 0
<4>cfio: module license 'unspecified' taints kernel.
<5>pccard: PCMCIA card inserted into slot 0
<5>pcmcia: registering new device pcmcia0.0
<4>Before register driver
<4>Entering cf_attach()
<4>pcmcia: request for exclusive IRQ could not be fulfilled.
<4>pcmcia: the driver needs updating to supported shared IRQ lines.
<4>BasePort1=3D0xc48a0000, AssignedIRQ=3D160
<1>Unable to handle kernel NULL pointer dereference at virtual address
00000000
<1>pgd =3D c3f1c000
<1>[00000000] *pgd=3Da3e34031, *pte=3D00000000, *ppte=3D00000000
<4>Internal error: Oops: 17 [#1]
<4>Modules linked in: mcf25(P) cfio(P) i2c_dev i2c_pxa i2c_core robostix_dr=
v
pxamci pxa2xx_cs pxa2xx_core proc_gpio pcmcia pcmcia_core firmware_class
ohci_hcd usbcore mmc_block mmc_core smc911x gumstix_smc911x mii
<4>CPU: 0    Tainted: P         (2.6.24 #2)
<4>PC is at __wake_up_common+0x24/0x84
<4>LR is at __wake_up+0x4c/0x64
<4>pc : [<c0029a38>]    lr : [<c002de90>]    psr: 60000013
<4>sp : c3f0da08  ip : c3f0da38  fp : c3f0da34
<4>r10: 00000000  r9 : 00000001  r8 : c3d07d34
<4>r7 : 00000000  r6 : 00000001  r5 : 00000000  r4 : fffffff4
<4>r3 : 00000000  r2 : 00000001  r1 : 00000001  r0 : 00000000
<4>Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
<4>Control: 0000397f  Table: a3f1c000  DAC: 00000015
<4>Process modprobe (pid: 730, stack limit =3D 0xc3f0c270)
<4>Stack: (0xc3f0da08 to 0xc3f0e000)
<4>da00:                   00000000 00000000 00000000 00000000 00000000
00000003
<4>da20: c3d07360 00000000 c3f0da54 c3f0da38 c002de90 c0029a20 00000000
c0059078
<4>da40: 00000000 c3c2b800 c3f0dab4 c3f0da58 bf07d0bc c002de50 00000000
c3f0da70
<4>da60: bf084e84 00000002 c3f50000 c3e06600 000031c0 c3e7d240 000172e0
00000000
<4>da80: c3d07360 0000c3d0 c3f0dab4 c3f50000 c3f510e4 00000000 c3d07360
c3f0dade
<4>daa0: 00c3d073 000000c3 c3f0db1c c3f0dab8 bf07584c bf07bb9c 00000000
00000000
<4>dac0: c00acc20 000000bf 0000bf07 00bf0750 000000c3 000000bf c3f0db04
ffffdae8
<4>dae0: ffffffff 00000000 00000000 000fda90 c3f0db1c c3d07360 c3d07000
c3c4cc20
<4>db00: 00000000 c3ea5520 00000001 c48b1000 c3f0db3c c3f0db20 bf0748fc
bf075310
<4>db20: c3f0dd8c c3f0dd48 c3e31200 bf072340 c3f0dd8c c3f0db40 bf071358
bf074784
<4>db40: c0114ca8 00013c01 00000201 00000076 00000000 000493e0 00055730
003f1500
<4>db60: 002dc6c0 002dc6c0 000186a0 c3d04200 00000000 c3d04200 c3f0db94
c3f0db88
<4>db80: c00590c0 c0059008 c3f0dbe4 c3f0db00 c3f0dbac c3f0dba0 c00590c0
c0059008
<4>dba0: c3f0dbcc c3f0dbb0 c0075de4 00000000 00001000 00000000 c3e0f420
00000000
<4>dbc0: c3f0dbf4 c3f00167 00000000 00000080 00001000 00028000 c3e0f420
00000000
<4>dbe0: 00000021 c3d7f9a0 c3f0dc0c c3f0dbf8 c0071048 c0070e70 ffffffff
000000d0
<4>dc00: c3f0dc1c c3f0dc10 c0071078 c0071030 c3f0dc74 c3f0dc20 c0025248
c007105c
<4>dc20: c0071400 c487d000 00000000 c01ea200 c0007120 000000a3 28000000
c0007120
<4>dc40: c487c000 28000000 0000007f 0000ffff 00000000 c3e0f420 00000000
00000021
<4>dc60: c3d7f9a0 c3d7f9a0 c3f0dc84 c3f0dc78 c0025518 c00251e8 c3f0dcb4
c3f0dc88
<4>dc80: bf044478 c00254d4 00000005 0000000b c3f0dc90 000000de 00000008
00000000
<4>dca0: c3e0f408 00000021 c3f0dcec c3f0dcb8 c3f0dccc c3f0dc00 c0059000
00000000
<4>dcc0: 00000032 00000032 00000032 c0059078 00000008 00000008 c3e0f4c4
c3e0f408
<4>dce0: 0000006f c3f29fd4 c3f29fc0 bf044864 c3d7f9a0 c3f0dd48 0000001a
00000008
<4>dd00: 0000001a c3e0f408 761901c1 36363d35 ff7f6705 c00590ff c3f0dd44
c3f0dd28
<4>dd20: c00756c0 c0059078 c3f0dd48 00000000 0000001a c3e0f408 c3f0dd8c
c3f0dd48
<4>dd40: bf044ec4 c00755f4 00000000 c3f3471b 00000110 00000000 00000079
40000d1b
<4>dd60: c00dee0d c3f0dd08 c3e31298 c3e31298 c3e31200 bf0720bc bf0720a4
bf052f14
<4>dd80: c3f0ddcc c3f0dd90 bf04ba94 bf0710b4 c3e31300 c3e31201 00000200
00000001
<4>dda0: 00000000 00000000 00000000 c00b3200 c3e31298 c3e31298 bf0720bc
c3e31320
<4>ddc0: c3f0ddec c3f0ddd0 c010a40c bf04b9dc c3e3133c c3e31298 c010a5a0
bf0720bc
<4>dde0: c3f0de04 c3f0ddf0 c010a624 c010a318 00000000 c3f0de0c c3f0de34
c3f0de08
<4>de00: c0109750 c010a5ac 00000001 bf052fac bf052fac c3e312e0 bf0720bc
bf0720c4
<4>de20: 00000000 00000004 c3f0de44 c3f0de38 c010a228 c0109714 c3f0de6c
c3f0de48
<4>de40: c0109acc c010a214 c01f45a0 bf0720bc bf0720a4 bf0720bc 00000004
bf0721a0
<4>de60: c3f0de84 c3f0de70 c010a8bc c0109a64 00000002 00000000 c3f0deb4
c3f0de88
<4>de80: bf04c854 c010a844 bf072340 00000001 bf0a3180 bf072340 00000001
bf0a3180
<4>dea0: c3ea55e0 c48dbfac c3f0decc c3f0deb8 bf071438 bf04c770 bf0a3180
c3ea5628
<4>dec0: c3f0dedc c3f0ded0 bf085c34 bf071410 c3f0deec c3f0dee0 bf074090
bf085c2c
<4>dee0: c3f0dfa4 c3f0def0 c00532b4 bf074080 00000000 c3e94758 c3f0df24
00016368
<4>df00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
<4>df20: 00000000 00000000 00000000 00000000 00000008 c48df03c c3f294e0
c48dc27c
<4>df40: c48dc18c c48dc2a4 00000000 000002d7 000002d7 bf0a318c 00000014
c48dbefc
<4>df60: c48dc2cc 00000014 00000015 00000012 00000000 00000000 00000080
0000a49c
<4>df80: 00000000 000162d8 00000080 c001d26c c3f0c000 00000000 00000000
c3f0dfa8
<4>dfa0: c001d084 c0051f74 0000a49c 00000000 40127000 00032ab4 00016368
be93aa10
<4>dfc0: 0000a49c 00000000 000162d8 00000080 00016238 be93ace8 00015070
000162e4
<4>dfe0: 00000000 be93aa14 0000a9ac 400cabc4 60000010 40127000 00000000
00000000
<4>Backtrace:
<4>[<c0029a14>] (__wake_up_common+0x0/0x84) from [<c002de90>]
(__wake_up+0x4c/0x64)
<4>[<c002de44>] (__wake_up+0x0/0x64) from [<bf07d0bc>]
(PrepareAndSendCommand+0x152c/0x160c [mcf25])
<4> r5:c3c2b800 r4:00000000
<4>[<bf07bb90>] (PrepareAndSendCommand+0x0/0x160c [mcf25]) from [<bf07584c>=
]
(wlan_init_fw+0x548/0x6a0 [mcf25])
<4>[<bf075304>] (wlan_init_fw+0x0/0x6a0 [mcf25]) from [<bf0748fc>]
(wlan_add_card+0x184/0x258 [mcf25])
<4>[<bf074778>] (wlan_add_card+0x0/0x258 [mcf25]) from [<bf071358>]
(mv8385_cf_probe+0x2b0/0x35c [cfio])
<4> r6:bf072340 r5:c3e31200 r4:c3f0dd48
<4>[<bf0710a8>] (mv8385_cf_probe+0x0/0x35c [cfio]) from [<bf04ba94>]
(pcmcia_device_probe+0xc4/0x134 [pcmcia])
<4> r8:bf052f14 r7:bf0720a4 r6:bf0720bc r5:c3e31200 r4:c3e31298
<4>[<bf04b9d0>] (pcmcia_device_probe+0x0/0x134 [pcmcia]) from [<c010a40c>]
(driver_probe_device+0x100/0x1b8)
<4> r7:c3e31320 r6:bf0720bc r5:c3e31298 r4:c3e31298
<4>[<c010a30c>] (driver_probe_device+0x0/0x1b8) from [<c010a624>]
(__driver_attach+0x84/0xe4)
<4> r7:bf0720bc r6:c010a5a0 r5:c3e31298 r4:c3e3133c
<4>[<c010a5a0>] (__driver_attach+0x0/0xe4) from [<c0109750>]
(bus_for_each_dev+0x48/0x80)
<4> r5:c3f0de0c r4:00000000
<4>[<c0109708>] (bus_for_each_dev+0x0/0x80) from [<c010a228>]
(driver_attach+0x20/0x28)
<4> r7:00000004 r6:00000000 r5:bf0720c4 r4:bf0720bc
<4>[<c010a208>] (driver_attach+0x0/0x28) from [<c0109acc>]
(bus_add_driver+0x74/0x1c4)
<4>[<c0109a58>] (bus_add_driver+0x0/0x1c4) from [<c010a8bc>]
(driver_register+0x84/0x8c)
<4> r8:bf0721a0 r7:00000004 r6:bf0720bc r5:bf0720a4 r4:bf0720bc
<4>[<c010a838>] (driver_register+0x0/0x8c) from [<bf04c854>]
(pcmcia_register_driver+0xf0/0x144 [pcmcia])
<4> r4:00000000
<4>[<bf04c764>] (pcmcia_register_driver+0x0/0x144 [pcmcia]) from
[<bf071438>] (register_cf_driver+0x34/0x54 [cfio])
<4> r8:c48dbfac r7:c3ea55e0 r6:bf0a3180 r5:00000001 r4:bf072340
<4>[<bf071404>] (register_cf_driver+0x0/0x54 [cfio]) from [<bf085c34>]
(sbi_register+0x14/0x18 [mcf25])
<4> r4:c3ea5628
<4>[<bf085c20>] (sbi_register+0x0/0x18 [mcf25]) from [<bf074090>]
(wlan_init_module+0x1c/0x34 [mcf25])
<4>[<bf074074>] (wlan_init_module+0x0/0x34 [mcf25]) from [<c00532b4>]
(sys_init_module+0x134c/0x1434)
<4>[<c0051f68>] (sys_init_module+0x0/0x1434) from [<c001d084>]
(ret_fast_syscall+0x0/0x10)
<4>Code: e5900000 e1a09001 e1a06002 e240400c (e594100c)
<4>---[ end trace 15d182c4a81e343c ]---

root@domain.hid:~$ lsmod
Module                  Size  Used by
mcf25                 195280  1
cfio                    4960  2 mcf25
i2c_dev                 5988  0
i2c_pxa                 6176  0
i2c_core               18832  2 i2c_dev,i2c_pxa
robostix_drv            8500  0
pxamci                  6784  0
pxa2xx_cs               3368  3
pxa2xx_core            10464  1 pxa2xx_cs
proc_gpio               4492  0
pcmcia                 33492  1 cfio
pcmcia_core            31504  4 mcf25,cfio,pxa2xx_core,pcmcia
firmware_class          7232  1 pcmcia
ohci_hcd               17092  0
usbcore               118772  2 ohci_hcd
mmc_block              10180  0
mmc_core               43572  2 pxamci,mmc_block
smc911x                19745  0
gumstix_smc911x         2592  1 smc911x
mii                     4704  1 smc911x





On Tue, Nov 17, 2009 at 6:42 PM, Linus Casassa <linus@domain.hid> wrote:

> How do I get the wifistix to work on a kernel 2.6.24?
>
> I maneged to compile wifistix-module but I get this error:
>
> root@domain.hid$ modprobe wlan0
> FATAL: Error inserting cfio (/lib/modules/2.6.24/extra/cfio.ko): Unknown
> symbol in module, or unknown parameter (see dmesg)
> WARNING: Error running install command for cfio
> FATAL: Error inserting mcf25 (/lib/modules/2.6.24/extra/mcf25.ko): Unknow=
n
> symbol in module, or unknown parameter (see dmesg)
>
> root@domain.hid$ dmesg
> <4>cfio: Unknown symbol pcmcia_disable_device
> <4>cfio: Unknown symbol pcmcia_unregister_driver
> <4>cfio: Unknown symbol pccard_get_first_tuple
> <4>cfio: Unknown symbol pcmcia_get_configuration_info
> <4>cfio: Unknown symbol pcmcia_request_io
> <4>cfio: Unknown symbol pcmcia_request_configuration
> <4>cfio: Unknown symbol pcmcia_access_configuration_register
> <4>cfio: Unknown symbol pccard_get_tuple_data
> <4>cfio: Unknown symbol pcmcia_register_driver
> <4>cfio: Unknown symbol pccard_parse_tuple
> <4>cfio: Unknown symbol pcmcia_request_irq
> <4>mcf25: Unknown symbol cfio_read_cfg_reg
> <4>mcf25: Unknown symbol pccard_get_first_tuple
> <4>mcf25: Unknown symbol cardp
> <4>mcf25: Unknown symbol cfio_dev_info
> <4>mcf25: Unknown symbol pccard_get_tuple_data
> <4>mcf25: Unknown symbol register_cf_driver
> <4>mcf25: Unknown symbol pccard_get_next_tuple
> <4>mcf25: Unknown symbol unregister_cf_driver
> root@domain.hid$
>
> thanks for the help :)
>
> --
> Linus Casassa
> Estudiante Ingenier=EDa Civil Electr=F3nica
> Fono: 56-9-97776941
>



--=20
Linus Casassa
Estudiante Ingenier=EDa Civil Electr=F3nica
Fono: 56-9-97776941

--000e0cd2118e5a2e040478988bcb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ups I didn&#39;t have pxa2xx and pxa2xx_cs module.<br><br>Now I have this e=
rror:<br><br>root@domain.hid:~$ modprobe wlan0<br>Segmentation f=
ault<br><br>root@domain.hid:~$ dmesg <br>&lt;5&gt;pccard: card e=
jected from slot 0<br>

&lt;4&gt;cfio: module license &#39;unspecified&#39; taints kernel.<br>&lt;5=
&gt;pccard: PCMCIA card inserted into slot 0<br>&lt;5&gt;pcmcia: registerin=
g new device pcmcia0.0<br>&lt;4&gt;Before register driver<br>&lt;4&gt;Enter=
ing cf_attach()<br>

&lt;4&gt;pcmcia: request for exclusive IRQ could not be fulfilled.<br>&lt;4=
&gt;pcmcia: the driver needs updating to supported shared IRQ lines.<br>&lt=
;4&gt;BasePort1=3D0xc48a0000, AssignedIRQ=3D160<br>&lt;1&gt;Unable to handl=
e kernel NULL pointer dereference at virtual address 00000000<br>

&lt;1&gt;pgd =3D c3f1c000<br>&lt;1&gt;[00000000] *pgd=3Da3e34031, *pte=3D00=
000000, *ppte=3D00000000<br>&lt;4&gt;Internal error: Oops: 17 [#1]<br>&lt;4=
&gt;Modules linked in: mcf25(P) cfio(P) i2c_dev i2c_pxa i2c_core robostix_d=
rv pxamci pxa2xx_cs pxa2xx_core proc_gpio pcmcia pcmcia_core firmware_class=
 ohci_hcd usbcore mmc_block mmc_core smc911x gumstix_smc911x mii<br>

&lt;4&gt;CPU: 0=A0=A0=A0 Tainted: P=A0=A0=A0=A0=A0=A0=A0=A0 (2.6.24 #2)<br>=
&lt;4&gt;PC is at __wake_up_common+0x24/0x84<br>&lt;4&gt;LR is at __wake_up=
+0x4c/0x64<br>&lt;4&gt;pc : [&lt;c0029a38&gt;]=A0=A0=A0 lr : [&lt;c002de90&=
gt;]=A0=A0=A0 psr: 60000013<br>

&lt;4&gt;sp : c3f0da08=A0 ip : c3f0da38=A0 fp : c3f0da34<br>&lt;4&gt;r10: 0=
0000000=A0 r9 : 00000001=A0 r8 : c3d07d34<br>&lt;4&gt;r7 : 00000000=A0 r6 :=
 00000001=A0 r5 : 00000000=A0 r4 : fffffff4<br>&lt;4&gt;r3 : 00000000=A0 r2=
 : 00000001=A0 r1 : 00000001=A0 r0 : 00000000<br>

&lt;4&gt;Flags: nZCv=A0 IRQs on=A0 FIQs on=A0 Mode SVC_32=A0 ISA ARM=A0 Seg=
ment user<br>&lt;4&gt;Control: 0000397f=A0 Table: a3f1c000=A0 DAC: 00000015=
<br>&lt;4&gt;Process modprobe (pid: 730, stack limit =3D 0xc3f0c270)<br>&lt=
;4&gt;Stack: (0xc3f0da08 to 0xc3f0e000)<br>

&lt;4&gt;da00:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 000000=
00 00000000 00000000 00000000 00000000 00000003 <br>&lt;4&gt;da20: c3d07360=
 00000000 c3f0da54 c3f0da38 c002de90 c0029a20 00000000 c0059078 <br>&lt;4&g=
t;da40: 00000000 c3c2b800 c3f0dab4 c3f0da58 bf07d0bc c002de50 00000000 c3f0=
da70 <br>

&lt;4&gt;da60: bf084e84 00000002 c3f50000 c3e06600 000031c0 c3e7d240 000172=
e0 00000000 <br>&lt;4&gt;da80: c3d07360 0000c3d0 c3f0dab4 c3f50000 c3f510e4=
 00000000 c3d07360 c3f0dade <br>&lt;4&gt;daa0: 00c3d073 000000c3 c3f0db1c c=
3f0dab8 bf07584c bf07bb9c 00000000 00000000 <br>

&lt;4&gt;dac0: c00acc20 000000bf 0000bf07 00bf0750 000000c3 000000bf c3f0db=
04 ffffdae8 <br>&lt;4&gt;dae0: ffffffff 00000000 00000000 000fda90 c3f0db1c=
 c3d07360 c3d07000 c3c4cc20 <br>&lt;4&gt;db00: 00000000 c3ea5520 00000001 c=
48b1000 c3f0db3c c3f0db20 bf0748fc bf075310 <br>

&lt;4&gt;db20: c3f0dd8c c3f0dd48 c3e31200 bf072340 c3f0dd8c c3f0db40 bf0713=
58 bf074784 <br>&lt;4&gt;db40: c0114ca8 00013c01 00000201 00000076 00000000=
 000493e0 00055730 003f1500 <br>&lt;4&gt;db60: 002dc6c0 002dc6c0 000186a0 c=
3d04200 00000000 c3d04200 c3f0db94 c3f0db88 <br>

&lt;4&gt;db80: c00590c0 c0059008 c3f0dbe4 c3f0db00 c3f0dbac c3f0dba0 c00590=
c0 c0059008 <br>&lt;4&gt;dba0: c3f0dbcc c3f0dbb0 c0075de4 00000000 00001000=
 00000000 c3e0f420 00000000 <br>&lt;4&gt;dbc0: c3f0dbf4 c3f00167 00000000 0=
0000080 00001000 00028000 c3e0f420 00000000 <br>

&lt;4&gt;dbe0: 00000021 c3d7f9a0 c3f0dc0c c3f0dbf8 c0071048 c0070e70 ffffff=
ff 000000d0 <br>&lt;4&gt;dc00: c3f0dc1c c3f0dc10 c0071078 c0071030 c3f0dc74=
 c3f0dc20 c0025248 c007105c <br>&lt;4&gt;dc20: c0071400 c487d000 00000000 c=
01ea200 c0007120 000000a3 28000000 c0007120 <br>

&lt;4&gt;dc40: c487c000 28000000 0000007f 0000ffff 00000000 c3e0f420 000000=
00 00000021 <br>&lt;4&gt;dc60: c3d7f9a0 c3d7f9a0 c3f0dc84 c3f0dc78 c0025518=
 c00251e8 c3f0dcb4 c3f0dc88 <br>&lt;4&gt;dc80: bf044478 c00254d4 00000005 0=
000000b c3f0dc90 000000de 00000008 00000000 <br>

&lt;4&gt;dca0: c3e0f408 00000021 c3f0dcec c3f0dcb8 c3f0dccc c3f0dc00 c00590=
00 00000000 <br>&lt;4&gt;dcc0: 00000032 00000032 00000032 c0059078 00000008=
 00000008 c3e0f4c4 c3e0f408 <br>&lt;4&gt;dce0: 0000006f c3f29fd4 c3f29fc0 b=
f044864 c3d7f9a0 c3f0dd48 0000001a 00000008 <br>

&lt;4&gt;dd00: 0000001a c3e0f408 761901c1 36363d35 ff7f6705 c00590ff c3f0dd=
44 c3f0dd28 <br>&lt;4&gt;dd20: c00756c0 c0059078 c3f0dd48 00000000 0000001a=
 c3e0f408 c3f0dd8c c3f0dd48 <br>&lt;4&gt;dd40: bf044ec4 c00755f4 00000000 c=
3f3471b 00000110 00000000 00000079 40000d1b <br>

&lt;4&gt;dd60: c00dee0d c3f0dd08 c3e31298 c3e31298 c3e31200 bf0720bc bf0720=
a4 bf052f14 <br>&lt;4&gt;dd80: c3f0ddcc c3f0dd90 bf04ba94 bf0710b4 c3e31300=
 c3e31201 00000200 00000001 <br>&lt;4&gt;dda0: 00000000 00000000 00000000 c=
00b3200 c3e31298 c3e31298 bf0720bc c3e31320 <br>

&lt;4&gt;ddc0: c3f0ddec c3f0ddd0 c010a40c bf04b9dc c3e3133c c3e31298 c010a5=
a0 bf0720bc <br>&lt;4&gt;dde0: c3f0de04 c3f0ddf0 c010a624 c010a318 00000000=
 c3f0de0c c3f0de34 c3f0de08 <br>&lt;4&gt;de00: c0109750 c010a5ac 00000001 b=
f052fac bf052fac c3e312e0 bf0720bc bf0720c4 <br>

&lt;4&gt;de20: 00000000 00000004 c3f0de44 c3f0de38 c010a228 c0109714 c3f0de=
6c c3f0de48 <br>&lt;4&gt;de40: c0109acc c010a214 c01f45a0 bf0720bc bf0720a4=
 bf0720bc 00000004 bf0721a0 <br>&lt;4&gt;de60: c3f0de84 c3f0de70 c010a8bc c=
0109a64 00000002 00000000 c3f0deb4 c3f0de88 <br>

&lt;4&gt;de80: bf04c854 c010a844 bf072340 00000001 bf0a3180 bf072340 000000=
01 bf0a3180 <br>&lt;4&gt;dea0: c3ea55e0 c48dbfac c3f0decc c3f0deb8 bf071438=
 bf04c770 bf0a3180 c3ea5628 <br>&lt;4&gt;dec0: c3f0dedc c3f0ded0 bf085c34 b=
f071410 c3f0deec c3f0dee0 bf074090 bf085c2c <br>

&lt;4&gt;dee0: c3f0dfa4 c3f0def0 c00532b4 bf074080 00000000 c3e94758 c3f0df=
24 00016368 <br>&lt;4&gt;df00: 00000000 00000000 00000000 00000000 00000000=
 00000000 00000000 00000000 <br>&lt;4&gt;df20: 00000000 00000000 00000000 0=
0000000 00000008 c48df03c c3f294e0 c48dc27c <br>

&lt;4&gt;df40: c48dc18c c48dc2a4 00000000 000002d7 000002d7 bf0a318c 000000=
14 c48dbefc <br>&lt;4&gt;df60: c48dc2cc 00000014 00000015 00000012 00000000=
 00000000 00000080 0000a49c <br>&lt;4&gt;df80: 00000000 000162d8 00000080 c=
001d26c c3f0c000 00000000 00000000 c3f0dfa8 <br>

&lt;4&gt;dfa0: c001d084 c0051f74 0000a49c 00000000 40127000 00032ab4 000163=
68 be93aa10 <br>&lt;4&gt;dfc0: 0000a49c 00000000 000162d8 00000080 00016238=
 be93ace8 00015070 000162e4 <br>&lt;4&gt;dfe0: 00000000 be93aa14 0000a9ac 4=
00cabc4 60000010 40127000 00000000 00000000 <br>

&lt;4&gt;Backtrace: <br>&lt;4&gt;[&lt;c0029a14&gt;] (__wake_up_common+0x0/0=
x84) from [&lt;c002de90&gt;] (__wake_up+0x4c/0x64)<br>&lt;4&gt;[&lt;c002de4=
4&gt;] (__wake_up+0x0/0x64) from [&lt;bf07d0bc&gt;] (PrepareAndSendCommand+=
0x152c/0x160c [mcf25])<br>

&lt;4&gt; r5:c3c2b800 r4:00000000<br>&lt;4&gt;[&lt;bf07bb90&gt;] (PrepareAn=
dSendCommand+0x0/0x160c [mcf25]) from [&lt;bf07584c&gt;] (wlan_init_fw+0x54=
8/0x6a0 [mcf25])<br>&lt;4&gt;[&lt;bf075304&gt;] (wlan_init_fw+0x0/0x6a0 [mc=
f25]) from [&lt;bf0748fc&gt;] (wlan_add_card+0x184/0x258 [mcf25])<br>

&lt;4&gt;[&lt;bf074778&gt;] (wlan_add_card+0x0/0x258 [mcf25]) from [&lt;bf0=
71358&gt;] (mv8385_cf_probe+0x2b0/0x35c [cfio])<br>&lt;4&gt; r6:bf072340 r5=
:c3e31200 r4:c3f0dd48<br>&lt;4&gt;[&lt;bf0710a8&gt;] (mv8385_cf_probe+0x0/0=
x35c [cfio]) from [&lt;bf04ba94&gt;] (pcmcia_device_probe+0xc4/0x134 [pcmci=
a])<br>

&lt;4&gt; r8:bf052f14 r7:bf0720a4 r6:bf0720bc r5:c3e31200 r4:c3e31298<br>&l=
t;4&gt;[&lt;bf04b9d0&gt;] (pcmcia_device_probe+0x0/0x134 [pcmcia]) from [&l=
t;c010a40c&gt;] (driver_probe_device+0x100/0x1b8)<br>&lt;4&gt; r7:c3e31320 =
r6:bf0720bc r5:c3e31298 r4:c3e31298<br>

&lt;4&gt;[&lt;c010a30c&gt;] (driver_probe_device+0x0/0x1b8) from [&lt;c010a=
624&gt;] (__driver_attach+0x84/0xe4)<br>&lt;4&gt; r7:bf0720bc r6:c010a5a0 r=
5:c3e31298 r4:c3e3133c<br>&lt;4&gt;[&lt;c010a5a0&gt;] (__driver_attach+0x0/=
0xe4) from [&lt;c0109750&gt;] (bus_for_each_dev+0x48/0x80)<br>

&lt;4&gt; r5:c3f0de0c r4:00000000<br>&lt;4&gt;[&lt;c0109708&gt;] (bus_for_e=
ach_dev+0x0/0x80) from [&lt;c010a228&gt;] (driver_attach+0x20/0x28)<br>&lt;=
4&gt; r7:00000004 r6:00000000 r5:bf0720c4 r4:bf0720bc<br>&lt;4&gt;[&lt;c010=
a208&gt;] (driver_attach+0x0/0x28) from [&lt;c0109acc&gt;] (bus_add_driver+=
0x74/0x1c4)<br>

&lt;4&gt;[&lt;c0109a58&gt;] (bus_add_driver+0x0/0x1c4) from [&lt;c010a8bc&g=
t;] (driver_register+0x84/0x8c)<br>&lt;4&gt; r8:bf0721a0 r7:00000004 r6:bf0=
720bc r5:bf0720a4 r4:bf0720bc<br>&lt;4&gt;[&lt;c010a838&gt;] (driver_regist=
er+0x0/0x8c) from [&lt;bf04c854&gt;] (pcmcia_register_driver+0xf0/0x144 [pc=
mcia])<br>

&lt;4&gt; r4:00000000<br>&lt;4&gt;[&lt;bf04c764&gt;] (pcmcia_register_drive=
r+0x0/0x144 [pcmcia]) from [&lt;bf071438&gt;] (register_cf_driver+0x34/0x54=
 [cfio])<br>&lt;4&gt; r8:c48dbfac r7:c3ea55e0 r6:bf0a3180 r5:00000001 r4:bf=
072340<br>

&lt;4&gt;[&lt;bf071404&gt;] (register_cf_driver+0x0/0x54 [cfio]) from [&lt;=
bf085c34&gt;] (sbi_register+0x14/0x18 [mcf25])<br>&lt;4&gt; r4:c3ea5628<br>=
&lt;4&gt;[&lt;bf085c20&gt;] (sbi_register+0x0/0x18 [mcf25]) from [&lt;bf074=
090&gt;] (wlan_init_module+0x1c/0x34 [mcf25])<br>

&lt;4&gt;[&lt;bf074074&gt;] (wlan_init_module+0x0/0x34 [mcf25]) from [&lt;c=
00532b4&gt;] (sys_init_module+0x134c/0x1434)<br>&lt;4&gt;[&lt;c0051f68&gt;]=
 (sys_init_module+0x0/0x1434) from [&lt;c001d084&gt;] (ret_fast_syscall+0x0=
/0x10)<br>

&lt;4&gt;Code: e5900000 e1a09001 e1a06002 e240400c (e594100c) <br>&lt;4&gt;=
---[ end trace 15d182c4a81e343c ]---<br><br>root@domain.hid:~$ l=
smod<br>Module=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Size=A0 U=
sed by<br>mcf25=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 195280=A0 1=
 <br>

cfio=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4960=A0 2 mcf=
25<br>i2c_dev=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 5988=A0 0 <br=
>i2c_pxa=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 6176=A0 0 <br>i2c_=
core=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 18832=A0 2 i2c_dev,i2c_pxa<b=
r>robostix_drv=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 8500=A0 0 <br>pxamci=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 6784=A0 0 <br>

pxa2xx_cs=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3368=A0 3 <br>pxa2xx_co=
re=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 10464=A0 1 pxa2xx_cs<br>proc_gpio=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4492=A0 0 <br>pcmcia=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 33492=A0 1 cfio<br>pcmcia_core=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 31504=A0 4 mcf25,cfio,pxa2xx_core,pcmcia<br>

firmware_class=A0=A0=A0=A0=A0=A0=A0=A0=A0 7232=A0 1 pcmcia<br>ohci_hcd=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 17092=A0 0 <br>usbcore=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 118772=A0 2 ohci_hcd<br>mmc_block=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 10180=A0 0 <br>mmc_core=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 43572=A0 2 pxamci,mmc_block<br>smc911x=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 19745=A0 0 <br>

gumstix_smc911x=A0=A0=A0=A0=A0=A0=A0=A0 2592=A0 1 smc911x<br>mii=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4704=A0 1 smc911x<br><b=
r><br><br><br><br><div class=3D"gmail_quote">On Tue, Nov 17, 2009 at 6:42 P=
M, Linus Casassa <span dir=3D"ltr">&lt;<a href=3D"mailto:linus@domain.hid">linu=
s@domain.hid</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">How do I get the =
wifistix to work on a kernel 2.6.24?<br><br>I maneged to compile wifistix-m=
odule but I get this error:<br>

<br>root@domain.hid$ modprobe wlan0 <b=
r>FATAL: Error inserting cfio (/lib/modules/2.6.24/extra/cfio.ko): Unknown =
symbol in module, or unknown parameter (see dmesg)<br>
WARNING: Error running install command for cfio<br>FATAL: Error inserting m=
cf25 (/lib/modules/2.6.24/extra/mcf25.ko): Unknown symbol in module, or unk=
nown parameter (see dmesg)<br><br>root@domain.hid=
.6.24/extra$ dmesg <br>


&lt;4&gt;cfio: Unknown symbol pcmcia_disable_device<br>&lt;4&gt;cfio: Unkno=
wn symbol pcmcia_unregister_driver<br>&lt;4&gt;cfio: Unknown symbol pccard_=
get_first_tuple<br>&lt;4&gt;cfio: Unknown symbol pcmcia_get_configuration_i=
nfo<br>


&lt;4&gt;cfio: Unknown symbol pcmcia_request_io<br>&lt;4&gt;cfio: Unknown s=
ymbol pcmcia_request_configuration<br>&lt;4&gt;cfio: Unknown symbol pcmcia_=
access_configuration_register<br>&lt;4&gt;cfio: Unknown symbol pccard_get_t=
uple_data<br>


&lt;4&gt;cfio: Unknown symbol pcmcia_register_driver<br>&lt;4&gt;cfio: Unkn=
own symbol pccard_parse_tuple<br>&lt;4&gt;cfio: Unknown symbol pcmcia_reque=
st_irq<br>&lt;4&gt;mcf25: Unknown symbol cfio_read_cfg_reg<br>&lt;4&gt;mcf2=
5: Unknown symbol pccard_get_first_tuple<br>


&lt;4&gt;mcf25: Unknown symbol cardp<br>&lt;4&gt;mcf25: Unknown symbol cfio=
_dev_info<br>&lt;4&gt;mcf25: Unknown symbol pccard_get_tuple_data<br>&lt;4&=
gt;mcf25: Unknown symbol register_cf_driver<br>&lt;4&gt;mcf25: Unknown symb=
ol pccard_get_next_tuple<br>


&lt;4&gt;mcf25: Unknown symbol unregister_cf_driver<br>root@domain.hid=
verdex:/lib/modules/2.6.24/extra$ <br><br>thanks for the help :)<br><font c=
olor=3D"#888888"><br>-- <br>Linus Casassa<br>Estudiante Ingenier=EDa Civil =
Electr=F3nica<br>

Fono: 56-9-97776941<br>

</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Linus Casassa<br=
>Estudiante Ingenier=EDa Civil Electr=F3nica<br>Fono: 56-9-97776941<br>

--000e0cd2118e5a2e040478988bcb--

