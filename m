MIME-Version: 1.0
From: =?UTF-8?Q?I=C3=B1aki_Val?= <nahemoth@gmail.com>
Date: Sat, 15 Apr 2017 10:45:42 +0200
Message-ID: <CAJpUn=wHGCXwZxO7uJdGK50tgJ9BxFgVHtTasv3Q-40yKywV8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Beaglebone Black and RTnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,



 I=E2=80=99m running Xenomai 3.0.4 on Beaglebone Black board, which is base=
d on
Linux kernel 4.4.59 and Debian 8. The Xenomai kernel seems to work fine,
but the problems come when I start the network services using RTnet. I
execute the following commands for modules installation:



modprobe rtnet

modprobe rt_smsc

modprobe rt_davinci_mdio

modprobe rt_ticpsw

modprobe rtpacket

modprobe rtipv4

modprobe rtudp



The dmesg output is:



[  820.968951] davinci_mdio 4a101000.mdio: davinci mdio revision 1.6

[  820.984963] davinci_mdio 4a101000.mdio: detected phy mask fffffffe

[  821.017488] libphy: 4a101000.mdio: probed

[  821.026118] davinci_mdio 4a101000.mdio: phy[0]: device 4a101000.mdio:00,
driver SMSC LAN8710/LAN8720

[  821.046599] DT probed OK

[  821.056832] Detected MACID =3D 04:a3:16:b4:3a:f0RTnet: registered rteth0



And the network device is created:



root@arm:~# /usr/xenomai/sbin/rtifconfig -a

rteth0    Medium: Ethernet  Hardware address: 04:A3:16:B4:3A:F0

          BROADCAST  MTU: 1500

          RX packets:0 errors:0 dropped:0 overruns:0 frame:0

          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0

          collisions:0

          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)



But if I open rteth0 device, after some seconds I get a kernel panic:



root@arm:~# /usr/xenomai/sbin/rtifconfig rteth0 up

[  836.140204] cpsw 4a100000.ethernet: initializing cpsw version 1.12 (0)

[  836.152252] cpsw 4a100000.ethernet: phy found : id is : 0x7c0f1

[  839.165294] Unable to handle kernel NULL pointer dereference at virtual
address 00000004

[  839.173524] pgd =3D c0004000

[  839.176251] [00000004] *pgd=3D00000000

[  839.181112] Internal error: Oops: 5 [#1] PREEMPT SMP ARM

[  839.186459] Modules linked in: rtudp rtipv4 rtpacket rt_ticpsw
rt_davinci_mdio rt_smsc rtnet snd_soc_hdmi_codec omap_sham omap_aes_driver
uio_pruss omap_rng rng_core tilcdc snd_soc_davinci_mcasp snd_soc_edma
snd_soc_omap snd_soc_simple_card bridge stp llc snd_soc_core
snd_pcm_dmaengine snd_pcm snd_timer tda998x evdev snd soundcore
uio_pdrv_genirq uio usb_f_acm u_serial usb_f_ecm usb_f_rndis u_ether
libcomposite bluetooth rfkill

[  839.224963] CPU: 0 PID: 1267 Comm: kworker/0:0 Not tainted
4.4.59-ti-xenomai-r96 #26

[  839.232742] Hardware name: Generic AM33XX (Flattened Device Tree)

[  839.238885] Workqueue: events_power_efficient phy_state_machine

[  839.244844] task: dc5f9380 ti: dc632000 task.ti: dc632000

[  839.250283] PC is at linkwatch_urgent_event+0x70/0xc0

[  839.255361] LR is at linkwatch_urgent_event+0x34/0xc0

[  839.260439] pc : [<c095b484>]    lr : [<c095b448>]    psr: a0070013

[  839.260439] sp : dc633e60  ip : c093a85c  fp : dc633e74

[  839.271971] r10: df928605  r9 : c1089658  r8 : 00000020

[  839.277222] r7 : 00000007  r6 : da960000  r5 : 00000000  r4 : daadd400

[  839.283780] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : bf318d5c

[  839.290340] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment
none

[  839.297510] Control: 10c5387d  Table: 9c6dc019  DAC: 00000051

[  839.303284] Process kworker/0:0 (pid: 1267, stack limit =3D 0xdc632220)

[  839.309755] Stack: (0xdc633e60 to 0xdc634000)

[  839.314139] 3e60: daadd400 da960274 dc633e94 dc633e78 c095b76c c095b420
daadd400 da960274

[  839.322359] 3e80: da960000 00000007 dc633eac dc633e98 c096c748 c095b75c
da960224 da960274

[  839.330579] 3ea0: dc633edc dc633eb0 c07cd5dc c096c6f8 00000000 00000000
c006ea64 da960224

[  839.338800] 3ec0: da9ba080 df9242c0 00000000 df928600 dc633f1c dc633ee0
c005f168 c07cd190

[  839.347020] 3ee0: dc633f04 dc633ef0 c006f29c 00000000 df9242c0 da9ba080
df9242c0 da9ba098

[  839.355240] 3f00: df9242d4 dc632000 00000008 00000000 dc633f5c dc633f20
c005f578 c005f034

[  839.363460] 3f20: 00000001 00000000 00000002 c0fb5140 dc633f60 00000000
da9b83c0 da9ba080

[  839.371680] 3f40: c005f524 00000000 00000000 00000000 dc633fac dc633f60
c006575c c005f530

[  839.379900] 3f60: 00000000 00000000 da9ba080 00000000 00000000 dc633f74
dc633f74 00000000

[  839.388121] 3f80: 00000000 dc633f84 dc633f84 dc8ba63b da9b83c0 c0065660
00000000 00000000

[  839.396341] 3fa0: 00000000 dc633fb0 c00114ac c006566c 00000000 00000000
00000000 00000000

[  839.404561] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000

[  839.412781] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
9fde6861 9fde6c61

[  839.421017] [<c095b484>] (linkwatch_urgent_event) from [<c095b76c>]
(linkwatch_fire_event+0x1c/0xbc)

[  839.430205] [<c095b76c>] (linkwatch_fire_event) from [<c096c748>]
(netif_carrier_on+0x5c/0x74)

[  839.438865] [<c096c748>] (netif_carrier_on) from [<c07cd5dc>]
(phy_state_machine+0x458/0x4a8)

[  839.447452] [<c07cd5dc>] (phy_state_machine) from [<c005f168>]
(process_one_work+0x140/0x4fc)

[  839.456027] [<c005f168>] (process_one_work) from [<c005f578>]
(worker_thread+0x54/0x4bc)

[  839.464167] [<c005f578>] (worker_thread) from [<c006575c>]
(kthread+0xfc/0x114)

[  839.471526] [<c006575c>] (kthread) from [<c00114ac>]
(ret_from_fork+0x18/0x2c)

[  839.478791] Code: e5940244 e3500000 089da830 e5943240 (e5931004)

[  839.490104] ---[ end trace 8ca322227746439d ]---



Message from syslogd@arm at Mar  2 22:40:31 ...

 kernel:[  839.181112] Internal error: Oops: 5 [#1] PREEMPT SMP ARM



Message from syslogd@arm at Mar  2 22:40:31 ...

 kernel:[  839.303284] Process kworker/0:0 (pid: 1267, stack limit =3D
0xdc632220[  839.513213] Unable to handle kernel paging request at virtual
address ffffffec



It seems that the problem could be in the phy management=E2=80=A6 any idea?



Thanks in advance.



Best regards,



 Nahemoth
