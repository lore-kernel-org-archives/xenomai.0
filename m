Message-ID: <2ec96d6e0804301757k53807b0ew6a1b72a199eaa79a@domain.hid>
Date: Thu, 1 May 2008 08:57:32 +0800
From: "Qin Lin" <linkinge@domain.hid>
In-Reply-To: <2ec96d6e0804300116y76e17be6u29d7332542dd6097@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_4519_5826997.1209603452812"
References: <2ec96d6e0804300116y76e17be6u29d7332542dd6097@domain.hid>
Subject: [Xenomai-help] Xenomai booting problem with xilinx xupv2p board
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_4519_5826997.1209603452812
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all:

Is anybody can suggest me something to do?

I am a newer in xenomai,last day i port the
ELDK_4.2/ppc_4xx/usr/src/linux-2.6.24-xenomai
to xilinx  xupv2p borad with powerpc 405

At the first time, i use xilinx ACE driver, kernel panic on the mouting root
file system,
therefore,i try to use NFS file system  as root file system.

fix some problem and patch xilinx EMAC driver and try to booting the kernel
,but the problem still
exist:
................................
[    0.369783] I-pipe: Domain Xenomai registered.
[    0.369910] Xenomai: hal/powerpc started.
[    0.425317] I-pipe: Domain IShield registered.
[    0.431499] Xenomai: real-time nucleus v2.4.2 (One Big Rush) loaded.
[    0.433339] Xenomai: starting native API services.
[    0.433421] Xenomai: starting POSIX services.
[    0.434034] Xenomai: starting RTDM services.
[    0.439588] Installing knfsd (copyright (C) 1996 okir@domain.hid).
[    0.443437] io scheduler noop registered
[    0.443514] io scheduler anticipatory registered (default)
[    0.443542] io scheduler deadline registered
[    0.443875] io scheduler cfq registered
[    0.573667] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ
sharing disabled
[    0.587742] serial8250.0: ttyS0 at MMIO 0x40401003 (irq = 3) is a 16550A
[    0.587890] console [ttyS0] enabled
[    0.844872] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024
blocksize
[    0.856209] tun: Universal TUN/TAP device driver, 1.6
[    0.861489] tun: (C) 1999-2004 Max Krasnyansky <maxk@domain.hid>
[    0.871683] xilinx_emac xilinx_emac.0: MAC address is now  2: 0: 0: 0: 0:
0
[    0.878974] XEmac: using fifo mode.
[    0.882898] XEmac: Detected PHY at address 0, ManufID 0x0013, Rev.
0x78e2.
[    0.890084] eth0: Dropping NETIF_F_SG since no checksum feature.
[    0.901061] eth0: Xilinx 10/100 EMAC at 0x40C00000 mapped to 0xD0000000,
irq=1
[    0.908649] eth0: XEmac id 1.4a, block id 128, type 1
[    0.915736] mice: PS/2 mouse device common for all mice
[    0.921858] TCP cubic registered
[    0.925705] NET: Registered protocol family 1
[    0.930433] NET: Registered protocol family 17
[    0.936684] RPC: Registered udp transport module.
[    0.941668] RPC: Registered tcp transport module.
[    3.557536] Oops: kernel access of bad area, sig: 11 [#1]
[    3.562997] NIP: 00000000 LR: c0009a34 CTR: 00000000
[    3.567977] REGS: c02a5dc0 TRAP: 0400   Not tainted  (2.6.24.2)
[    3.573895] MSR: 00021030 <ME,IR,DR>  CR: 24004028  XER: 00000000
[    3.580104] TASK = c0287528[0] 'swapper' THREAD: c02a4000
[    3.585333] GPR00: 00000000 c02a5e70 c0287528 00000001 c028cc8c 00000000
ce9ff16e 00000002
[    3.593851] GPR08: 00000000 c028cc48 00000002 c028d7dc 00000008 00000000
10000800 00000000
[    3.602359] GPR16: 00000001 ffffffff 007fff00 0fff9e08 00000000 0ffbd958
00000001 0ffff004
[    3.610886] GPR24: 007ffe80 00800000 c02d3c60 00000020 c02d0ee4 00000000
00000001 c02d3bc0
[    3.619603] NIP [00000000] 0x0
[    3.622699] LR [c0009a34] __ipipe_ack_irq+0x28/0x3c
[    3.627673] Call Trace:
[    3.630135] [c02a5e80] [c0009d14] __ipipe_handle_irq+0xe4/0x13c
[    3.636108] [c02a5ea0] [c0009eec] __ipipe_grab_irq+0x3c/0x94
[    3.641819] [c02a5ec0] [c00035a8] __ipipe_ret_from_except+0x0/0xc
[    3.647979] [c02a5f80] [20000000] 0x20000000
[    3.652298] [c02a5fa0] [c00095f0] cpu_idle+0x50/0xe8
[    3.657326] [c02a5fb0] [c0222cd8] rest_init+0x50/0x60
[    3.662493] [c02a5fc0] [c02a69e8] start_kernel+0x2a8/0x2bc
[    3.668064] [c02a5ff0] [c000225c] start_here+0x44/0xb0
...............................

if i unselect xenomai and ipipe in the kernel config ,booting OK!
[    0.000000] Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFE000
[    0.000000] PID hash table entries: 1024 (order: 10, 4096 bytes)
[    0.000350] Console: colour dummy device 80x25
[    0.004749] Dentry cache hash table entries: 32768 (order: 5, 131072
bytes)
[    0.011265] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.131469] Memory: 251136k available (1920k kernel code, 592k data, 108k
init, 0k highmem)
[    0.153872] Mount-cache hash table entries: 512
[    0.163682] net_namespace: 64 bytes
[    0.170470] NET: Registered protocol family 16
[    0.234369] NET: Registered protocol family 2
[    0.245332] IP route cache hash table entries: 2048 (order: 1, 8192
bytes)
[    0.249286] TCP established hash table entries: 8192 (order: 4, 65536
bytes)
[    0.251485] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[    0.252649] TCP: Hash tables configured (established 8192 bind 8192)
[    0.252707] TCP reno registered
[    0.270778] Installing knfsd (copyright (C) 1996 okir@domain.hid).
[    0.274747] io scheduler noop registered
[    0.274827] io scheduler anticipatory registered (default)
[    0.274860] io scheduler deadline registered
[    0.275379] io scheduler cfq registered
[    0.408440] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ
sharing disabled
[    0.422954] serial8250.0: ttyS0 at MMIO 0x40401003 (irq = 3) is a 16550A
[    0.423304] console [ttyS0] enabled
[    0.646932] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024
blocksize
[    0.658492] tun: Universal TUN/TAP device driver, 1.6
[    0.663891] tun: (C) 1999-2004 Max Krasnyansky <maxk@domain.hid>
[    0.674245] xilinx_emac xilinx_emac.0: MAC address is now  2: 0: 0: 0: 0:
0
[    0.681489] XEmac: using fifo mode.
[    0.685449] XEmac: Detected PHY at address 0, ManufID 0x0013, Rev.
0x78e2.
[    0.692764] eth0: Dropping NETIF_F_SG since no checksum feature.
[    0.703788] eth0: Xilinx 10/100 EMAC at 0x40C00000 mapped to 0xD0000000,
irq=1
[    0.711321] eth0: XEmac id 1.4a, block id 128, type 1
[    0.718483] mice: PS/2 mouse device common for all mice
[    0.724481] TCP cubic registered
[    0.728219] NET: Registered protocol family 1
[    0.733102] NET: Registered protocol family 17
[    0.739523] RPC: Registered udp transport module.
[    0.744589] RPC: Registered tcp transport module.
[    4.269751] IP-Config: Guessing netmask 255.255.255.0
[    4.275710] IP-Config: Complete:
[    4.278968]       device=eth0, addr=192.168.26.127, mask=255.255.255.0,
gw=255.255.255.255,
[    4.287826]      host=192.168.26.127, domain=, nis-domain=(none),
[    4.294161]      bootserver=255.255.255.255, rootserver=192.168.26.21,
rootpath=
[    4.304345] Looking up port of RPC 100003/2 on 192.168.26.21
[    4.314376] Looking up port of RPC 100005/1 on 192.168.26.21
[    4.355572] VFS: Mounted root (nfs filesystem).
[    4.361014] Freeing unused kernel memory: 108k init



-- 
Everyday is a new day!

Regards,

Qin Lin

------=_Part_4519_5826997.1209603452812
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div class="gmail_quote">Hi all:<br><br>Is anybody can suggest me something to do?<br><br>I am a newer in xenomai,last day i port the ELDK_4.2/ppc_4xx/usr/src/linux-2.6.24-xenomai <br>to xilinx&nbsp; xupv2p borad with powerpc 405 <br>
<br> At the first time, i use xilinx ACE driver, kernel panic on the mouting root file system,<br>
therefore,i try to use NFS file system&nbsp; as root file system.<br><br>fix some problem and patch xilinx EMAC driver and try to booting the kernel ,but the problem still<br>exist:<br>................................<br>[&nbsp;&nbsp;&nbsp; 0.369783] I-pipe: Domain Xenomai registered.<br>

[&nbsp;&nbsp;&nbsp; 0.369910] Xenomai: hal/powerpc started.<br>[&nbsp;&nbsp;&nbsp; 0.425317] I-pipe: Domain IShield registered.<br>[&nbsp;&nbsp;&nbsp; 0.431499] Xenomai: real-time nucleus v2.4.2 (One Big Rush) loaded.<br>[&nbsp;&nbsp;&nbsp; 0.433339] Xenomai: starting native API services.<br>

[&nbsp;&nbsp;&nbsp; 0.433421] Xenomai: starting POSIX services.<br>[&nbsp;&nbsp;&nbsp; 0.434034] Xenomai: starting RTDM services.<br>[&nbsp;&nbsp;&nbsp; 0.439588] Installing knfsd (copyright (C) 1996 <a href="mailto:okir@domain.hid" target="_blank">okir@domain.hid</a>).<br>
[&nbsp;&nbsp;&nbsp; 0.443437] io scheduler noop registered<br>
[&nbsp;&nbsp;&nbsp; 0.443514] io scheduler anticipatory registered (default)<br>[&nbsp;&nbsp;&nbsp; 0.443542] io scheduler deadline registered<br>[&nbsp;&nbsp;&nbsp; 0.443875] io scheduler cfq registered<br>[&nbsp;&nbsp;&nbsp; 0.573667] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled<br>

[&nbsp;&nbsp;&nbsp; 0.587742] serial8250.0: ttyS0 at MMIO 0x40401003 (irq = 3) is a 16550A<br>[&nbsp;&nbsp;&nbsp; 0.587890] console [ttyS0] enabled<br>[&nbsp;&nbsp;&nbsp; 0.844872] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize<br>[&nbsp;&nbsp;&nbsp; 0.856209] tun: Universal TUN/TAP device driver, 1.6<br>

[&nbsp;&nbsp;&nbsp; 0.861489] tun: (C) 1999-2004 Max Krasnyansky &lt;<a href="mailto:maxk@domain.hid" target="_blank">maxk@domain.hid</a>&gt;<br>[&nbsp;&nbsp;&nbsp; 0.871683] xilinx_emac xilinx_emac.0: MAC address is now&nbsp; 2: 0: 0: 0: 0: 0<br>[&nbsp;&nbsp;&nbsp; 0.878974] XEmac: using fifo mode.<br>

[&nbsp;&nbsp;&nbsp; 0.882898] XEmac: Detected PHY at address 0, ManufID 0x0013, Rev. 0x78e2.<br>[&nbsp;&nbsp;&nbsp; 0.890084] eth0: Dropping NETIF_F_SG since no checksum feature.<br>[&nbsp;&nbsp;&nbsp; 0.901061] eth0: Xilinx 10/100 EMAC at 0x40C00000 mapped to 0xD0000000, irq=1<br>

[&nbsp;&nbsp;&nbsp; 0.908649] eth0: XEmac id 1.4a, block id 128, type 1<br>[&nbsp;&nbsp;&nbsp; 0.915736] mice: PS/2 mouse device common for all mice<br>[&nbsp;&nbsp;&nbsp; 0.921858] TCP cubic registered<br>[&nbsp;&nbsp;&nbsp; 0.925705] NET: Registered protocol family 1<br>[&nbsp;&nbsp;&nbsp; 0.930433] NET: Registered protocol family 17<br>

[&nbsp;&nbsp;&nbsp; 0.936684] RPC: Registered udp transport module.<br>[&nbsp;&nbsp;&nbsp; 0.941668] RPC: Registered tcp transport module.<br>[&nbsp;&nbsp;&nbsp; 3.557536] Oops: kernel access of bad area, sig: 11 [#1]<br>[&nbsp;&nbsp;&nbsp; 3.562997] NIP: 00000000 LR: c0009a34 CTR: 00000000<br>

[&nbsp;&nbsp;&nbsp; 3.567977] REGS: c02a5dc0 TRAP: 0400&nbsp;&nbsp; Not tainted&nbsp; (<a href="http://2.6.24.2" target="_blank">2.6.24.2</a>)<br>[&nbsp;&nbsp;&nbsp; 3.573895] MSR: 00021030 &lt;ME,IR,DR&gt;&nbsp; CR: 24004028&nbsp; XER: 00000000<br>[&nbsp;&nbsp;&nbsp; 3.580104] TASK = c0287528[0] &#39;swapper&#39; THREAD: c02a4000<br>

[&nbsp;&nbsp;&nbsp; 3.585333] GPR00: 00000000 c02a5e70 c0287528 00000001 c028cc8c 00000000 ce9ff16e 00000002<br>[&nbsp;&nbsp;&nbsp; 3.593851] GPR08: 00000000 c028cc48 00000002 c028d7dc 00000008 00000000 10000800 00000000<br>[&nbsp;&nbsp;&nbsp; 3.602359] GPR16: 00000001 ffffffff 007fff00 0fff9e08 00000000 0ffbd958 00000001 0ffff004<br>

[&nbsp;&nbsp;&nbsp; 3.610886] GPR24: 007ffe80 00800000 c02d3c60 00000020 c02d0ee4 00000000 00000001 c02d3bc0<br>[&nbsp;&nbsp;&nbsp; 3.619603] NIP [00000000] 0x0<br>[&nbsp;&nbsp;&nbsp; 3.622699] LR [c0009a34] __ipipe_ack_irq+0x28/0x3c<br>[&nbsp;&nbsp;&nbsp; 3.627673] Call Trace:<br>

[&nbsp;&nbsp;&nbsp; 3.630135] [c02a5e80] [c0009d14] __ipipe_handle_irq+0xe4/0x13c<br>[&nbsp;&nbsp;&nbsp; 3.636108] [c02a5ea0] [c0009eec] __ipipe_grab_irq+0x3c/0x94<br>[&nbsp;&nbsp;&nbsp; 3.641819] [c02a5ec0] [c00035a8] __ipipe_ret_from_except+0x0/0xc<br>[&nbsp;&nbsp;&nbsp; 3.647979] [c02a5f80] [20000000] 0x20000000<br>

[&nbsp;&nbsp;&nbsp; 3.652298] [c02a5fa0] [c00095f0] cpu_idle+0x50/0xe8<br>[&nbsp;&nbsp;&nbsp; 3.657326] [c02a5fb0] [c0222cd8] rest_init+0x50/0x60<br>[&nbsp;&nbsp;&nbsp; 3.662493] [c02a5fc0] [c02a69e8] start_kernel+0x2a8/0x2bc<br>[&nbsp;&nbsp;&nbsp; 3.668064] [c02a5ff0] [c000225c] start_here+0x44/0xb0<br>

...............................<br><br>if i unselect xenomai and ipipe in the kernel config ,booting OK!<br>[&nbsp;&nbsp;&nbsp; 0.000000] Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFE000<br>[&nbsp;&nbsp;&nbsp; 0.000000] PID hash table entries: 1024 (order: 10, 4096 bytes)<br>

[&nbsp;&nbsp;&nbsp; 0.000350] Console: colour dummy device 80x25<br>[&nbsp;&nbsp;&nbsp; 0.004749] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)<br>[&nbsp;&nbsp;&nbsp; 0.011265] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)<br>[&nbsp;&nbsp;&nbsp; 0.131469] Memory: 251136k available (1920k kernel code, 592k data, 108k init, 0k highmem)<br>

[&nbsp;&nbsp;&nbsp; 0.153872] Mount-cache hash table entries: 512<br>[&nbsp;&nbsp;&nbsp; 0.163682] net_namespace: 64 bytes<br>[&nbsp;&nbsp;&nbsp; 0.170470] NET: Registered protocol family 16<br>[&nbsp;&nbsp;&nbsp; 0.234369] NET: Registered protocol family 2<br>[&nbsp;&nbsp;&nbsp; 0.245332] IP route cache hash table entries: 2048 (order: 1, 8192 bytes)<br>

[&nbsp;&nbsp;&nbsp; 0.249286] TCP established hash table entries: 8192 (order: 4, 65536 bytes)<br>[&nbsp;&nbsp;&nbsp; 0.251485] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)<br>[&nbsp;&nbsp;&nbsp; 0.252649] TCP: Hash tables configured (established 8192 bind 8192)<br>

[&nbsp;&nbsp;&nbsp; 0.252707] TCP reno registered<br>[&nbsp;&nbsp;&nbsp; 0.270778] Installing knfsd (copyright (C) 1996 <a href="mailto:okir@domain.hid" target="_blank">okir@domain.hid</a>).<br>[&nbsp;&nbsp;&nbsp; 0.274747] io scheduler noop registered<br>[&nbsp;&nbsp;&nbsp; 0.274827] io scheduler anticipatory registered (default)<br>

[&nbsp;&nbsp;&nbsp; 0.274860] io scheduler deadline registered<br>[&nbsp;&nbsp;&nbsp; 0.275379] io scheduler cfq registered<br>[&nbsp;&nbsp;&nbsp; 0.408440] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled<br>[&nbsp;&nbsp;&nbsp; 0.422954] serial8250.0: ttyS0 at MMIO 0x40401003 (irq = 3) is a 16550A<br>

[&nbsp;&nbsp;&nbsp; 0.423304] console [ttyS0] enabled<br>[&nbsp;&nbsp;&nbsp; 0.646932] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize<br>[&nbsp;&nbsp;&nbsp; 0.658492] tun: Universal TUN/TAP device driver, 1.6<br>[&nbsp;&nbsp;&nbsp; 0.663891] tun: (C) 1999-2004 Max Krasnyansky &lt;<a href="mailto:maxk@domain.hid" target="_blank">maxk@domain.hid</a>&gt;<br>

[&nbsp;&nbsp;&nbsp; 0.674245] xilinx_emac xilinx_emac.0: MAC address is now&nbsp; 2: 0: 0: 0: 0: 0<br>[&nbsp;&nbsp;&nbsp; 0.681489] XEmac: using fifo mode.<br>[&nbsp;&nbsp;&nbsp; 0.685449] XEmac: Detected PHY at address 0, ManufID 0x0013, Rev. 0x78e2.<br>[&nbsp;&nbsp;&nbsp; 0.692764] eth0: Dropping NETIF_F_SG since no checksum feature.<br>

[&nbsp;&nbsp;&nbsp; 0.703788] eth0: Xilinx 10/100 EMAC at 0x40C00000 mapped to 0xD0000000, irq=1<br>[&nbsp;&nbsp;&nbsp; 0.711321] eth0: XEmac id 1.4a, block id 128, type 1<br>[&nbsp;&nbsp;&nbsp; 0.718483] mice: PS/2 mouse device common for all mice<br>[&nbsp;&nbsp;&nbsp; 0.724481] TCP cubic registered<br>

[&nbsp;&nbsp;&nbsp; 0.728219] NET: Registered protocol family 1<br>[&nbsp;&nbsp;&nbsp; 0.733102] NET: Registered protocol family 17<br>[&nbsp;&nbsp;&nbsp; 0.739523] RPC: Registered udp transport module.<br>[&nbsp;&nbsp;&nbsp; 0.744589] RPC: Registered tcp transport module.<br>[&nbsp;&nbsp;&nbsp; 4.269751] IP-Config: Guessing netmask <a href="http://255.255.255.0" target="_blank">255.255.255.0</a><br>

[&nbsp;&nbsp;&nbsp; 4.275710] IP-Config: Complete:<br>[&nbsp;&nbsp;&nbsp; 4.278968]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=eth0, addr=<a href="http://192.168.26.127" target="_blank">192.168.26.127</a>, mask=<a href="http://255.255.255.0" target="_blank">255.255.255.0</a>, gw=<a href="http://255.255.255.255" target="_blank">255.255.255.255</a>,<br>

[&nbsp;&nbsp;&nbsp; 4.287826]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; host=<a href="http://192.168.26.127" target="_blank">192.168.26.127</a>, domain=, nis-domain=(none),<br>[&nbsp;&nbsp;&nbsp; 4.294161]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bootserver=<a href="http://255.255.255.255" target="_blank">255.255.255.255</a>, rootserver=<a href="http://192.168.26.21" target="_blank">192.168.26.21</a>, rootpath=<br>

[&nbsp;&nbsp;&nbsp; 4.304345] Looking up port of RPC 100003/2 on <a href="http://192.168.26.21" target="_blank">192.168.26.21</a><br>[&nbsp;&nbsp;&nbsp; 4.314376] Looking up port of RPC 100005/1 on <a href="http://192.168.26.21" target="_blank">192.168.26.21</a><br>
[&nbsp;&nbsp;&nbsp; 4.355572] VFS: Mounted root (nfs filesystem).<br>
[&nbsp;&nbsp;&nbsp; 4.361014] Freeing unused kernel memory: 108k init<br><br clear="all"><br></div><br>-- <br>Everyday is a new day!<br><br>Regards, <br><br>Qin Lin

------=_Part_4519_5826997.1209603452812--

