References: <CAOuPNLg60S+am654fq55vTMoFV1=PfMp3as5MZtt5BHUacFRBQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2ee8fa04-7ad4-58d5-603b-1d41ad2533ec@siemens.com>
Date: Wed, 25 Apr 2018 12:05:45 +0200
MIME-Version: 1.0
In-Reply-To: <CAOuPNLg60S+am654fq55vTMoFV1=PfMp3as5MZtt5BHUacFRBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Kernel oops during rtnet loopback usage on x86_64
	(e1000e)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Kumar <pintu.ping@gmail.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 2018-04-25 10:39, Pintu Kumar wrote:
> Hi,
> 
> I got kernel oops when using rtnet loopback with simple udp socket on
> Xenomai 3.0
> 
> STEPS:
> =========
> # lspci -knn | grep -i ethernet -A 3
> 00:1f.6 Ethernet controller [0200]: Intel Corporation Ethernet
> Connection (2) I219-V [8086:15b8] (rev 31)
>         Subsystem: ASUSTeK Computer Inc. Ethernet Connection (2)
> I219-V [1043:8672]
>         Kernel driver in use: e1000e
>         Kernel modules: e1000e
> 
> -------------
> sudo ifconfig lo down
> sudo modprobe rtnet
> sudo modprobe rtipv4
> sudo modprobe rtudp
> sudo modprobe rtpacket
> sudo modprobe rt_loopback
> sudo /usr/xenomai/sbin/rtifconfig rtlo up 127.0.0.1
> 
> # /usr/xenomai/sbin/rtifconfig
> rtlo      Medium: Local Loopback
>           IP address: 127.0.0.1
>           UP LOOPBACK RUNNING  MTU: 1500
> -------------
> Note: I am not installing e1000e driver, as I am checking on loopback
> interface now.
> 
> # ./rtnet-udp-server 5600 &
> # ./rtnet-udp-client 5800 127.0.0.1 5600
> 
> server => establish the UDP connection and wait for some message from client.
> client => just send the "hello" message to the server
> 
> Note: the same program works when build with normal Linux.
> 
> INFO:
> =============
> # xeno-config --info
> Xenomai version: Xenomai/cobalt v3.0.6 -- #5956064 (2018-03-20 12:13:33 +0100)
> Linux 4.9.51-x86-64-pintu-xeno3-rtdm #2 SMP Wed Apr 25 16:30:53 JST
> 2018 x86_64 x86_64 x86_64 GNU/Linux
> Kernel parameters: initrd=0:\initrd.img-4.9.51-x86-64-pintu-xeno3-rtdm
> root=/dev/disk/by-partlabel/system ro ip=off
> I-pipe release #4 detected
> Cobalt core 3.0.6 detected
> Compiler: gcc version 5.4.0
> Build args:
> 
> =============
> 
> 
> ---------------------
> [  377.304363]
>                *** RTnet for Xenomai v3.0.6 ***
> 
> [  377.304366] RTnet: initialising real-time networking
> [  377.319430] Intel(R) PRO/1000 Network Driver - version 7.1.9
> [  377.319433] Copyright (c) 1999-2006 Intel Corporation.
> [  379.632211] initializing loopback...
> [  379.632218] RTnet: registered rtlo
> [  474.312740] BUG: unable to handle kernel paging request at 00007ffcb25562e8
> [  474.312744] IP: [<ffffffffc0621465>] rt_udp_ioctl+0x45/0x5f [rtudp]
> [  474.312748] PGD 80bccc067
> [  474.312749] PUD 80f039067
> [  474.312750] PMD 80c364067
> [  474.312751] PTE 8000000806e09867
> 
> [  474.312754] Oops: 0001 [#1] SMP
> [  474.312755] Modules linked in: rt_loopback rtpacket rtudp rt_e1000
> rtipv4 rtnet arc4 8021q garp mrp stp llc rfcomm bnep
> snd_hda_codec_hdmi nls_iso8859_1 ath10k_pci ath10k_core ath mac80211
> intel_rapl eeepc_wmi asus_wmi x86_pkg_temp_thermal sparse_keymap
> intel_powerclamp mxm_wmi coretemp kvm irqbypass crct10dif_pclmul
> cfg80211 crc32_pclmul ghash_clmulni_intel aesni_intel
> snd_hda_codec_realtek aes_x86_64 snd_hda_codec_generic lrw gf128mul
> glue_helper snd_hda_intel ablk_helper snd_hda_codec cryptd btusb
> snd_hda_core btrtl snd_hwdep mei_me mei shpchp serio_raw hci_uart
> btbcm btqca btintel bluetooth wmi acpi_als kfifo_buf industrialio
> intel_lpss_acpi intel_lpss mac_hid acpi_pad autofs4 e1000e psmouse ptp
> pps_core ahci libahci video i2c_hid pinctrl_sunrisepoint pinctrl_intel
> hid fjes
> [  474.312806] CPU: 0 PID: 3232 Comm: rtnet-server Not tainted
> 4.9.51-x86-64-pintu-xeno3-rtdm #2
> [  474.312808] Hardware name: SkyLake
> [  474.312809] I-pipe domain: Linux
> [  474.312810] task: ffff8eaa4d090f00 task.stack: ffffa4cc080d4000
> [  474.312811] RIP: 0010:[<ffffffffc0621465>]  [<ffffffffc0621465>]
> rt_udp_ioctl+0x45/0x5f [rtudp]
> [  474.312814] RSP: 0018:ffffa4cc080d7e20  EFLAGS: 00010246
> [  474.312815] RAX: 00007ffcb25562e0 RBX: ffff8eaa4cf52800 RCX: ffff8eaa4cf52840
> [  474.312816] RDX: 0000000000000000 RSI: 0000000040100022 RDI: ffff8eaa4cf52800
> [  474.312817] RBP: ffffa4cc080d7e20 R08: 00007fa113b57d78 R09: 0000000000000105
> [  474.312819] R10: 000000010000aa3a R11: ffff8eaa50e39600 R12: 0000000000000003
> [  474.312820] R13: ffff8eaa4d090f00 R14: 000000004cf52800 R15: ffffa4cc03856040
> [  474.312821] FS:  00007fa1145b3740(0000) GS:ffff8eaa56200000(0000)
> knlGS:0000000000000000
> [  474.312823] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [  474.312824] CR2: 00007ffcb25562e8 CR3: 000000080f0a9000 CR4: 00000000003406f0
> [  474.312825] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  474.312826] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  474.312827] Stack:
> [  474.312828]  ffffa4cc080d7eb0 ffffffffa419a0e7 00007ffcb25562e0
> 4010002200000003
> [  474.312831]  ffff8eaa00000010 ffffa4cc080d7ec0 ffffa4cc080d7e58
> ffff8eaa4d090f00
> [  474.312834]  ffffffffa419e590 00007ffcb25562e0 ffffa4cc080d7e90
> ffffffffa409a6f1
> [  474.312836] Call Trace:
> [  474.312840]  [<ffffffffa419a0e7>] rtdm_fd_ioctl+0xe7/0x280
> [  474.312842]  [<ffffffffa419e590>] ? CoBaLt_fcntl+0x20/0x20
> [  474.312844]  [<ffffffffa409a6f1>] ? __ipipe_migrate_head+0x51/0xb0
> [  474.312846]  [<ffffffffa419e590>] ? CoBaLt_fcntl+0x20/0x20
> [  474.312848]  [<ffffffffa419e59e>] CoBaLt_ioctl+0xe/0x20
> [  474.312850]  [<ffffffffa41ab234>] ipipe_syscall_hook+0x114/0x320
> [  474.312853]  [<ffffffffa412f9bf>] __ipipe_notify_syscall+0xbf/0x170
> [  474.312855]  [<ffffffffa4080c11>] ? sigprocmask+0x51/0x80
> [  474.312858]  [<ffffffffa48fd7b7>] pipeline_syscall+0x8/0x1b
> [  474.312859] Code: 00 10 40 48 8d 4f 40 74 22 81 fe 23 00 10 40 75
> 10 8b 50 08 48 8b 30 48 89 cf e8 b7 fd ff ff 5d c3 48 89 c2 e8 5d 26
> fd ff 5d c3 <8b> 50 08 48 8b 30 48 89 cf e8 6d fa ff ff 5d c3 48 89 c2
> e8 13
> [  474.312890] RIP  [<ffffffffc0621465>] rt_udp_ioctl+0x45/0x5f [rtudp]
> [  474.312892]  RSP <ffffa4cc080d7e20>
> [  474.312893] CR2: 00007ffcb25562e8
> [  474.312895] ---[ end trace b2113f37ad3abd56 ]---
> [  489.183060] BUG: unable to handle kernel paging request at 00007fff6fe2a908
> [  489.183064] IP: [<ffffffffc0621465>] rt_udp_ioctl+0x45/0x5f [rtudp]
> [  489.183067] PGD 80b14a067
> [  489.183068] PUD 812af3067
> [  489.183070] PMD 810e50067
> [  489.183070] PTE 8000000805867867
> 
> ---------------------
> 
> I am using some 3 months old xenomai-3.0.
> But in latest commits also I could not find any fix for it.
> 
> If there is any fix available for it please let me know.
> 

Likely fixed in stable-3.0.x (upcoming 3.0.7). Please retry with that
git branch.

Jan
-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

