MIME-Version: 1.0
From: Ashok kumar <ashokkumar.bb@gmail.com>
Date: Thu, 28 Jun 2018 19:13:57 +0530
Message-ID: <CAFUnMk=zAOHSm916ngO_kWqnNbHWnAhneso-w3oQ2tmRqX47Tw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] BUG: unable to handle kernel paging request at
 00007ffccbd27e10 using rtnet -xenomai-3.0.5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I am using rtnet with xenomai-3.0.5
and soem ethercat  code to communicate with EK1818 Ethercat coupler , I am
getting the following message in my syslog

and I am not able to get slave information.

Jun 28 19:01:41 texsonics kernel: [ 2173.562482]
BUG: unable to handle kernel paging request at 00007ffccbd27e10

Jun 28 19:01:41 texsonics kernel: [ 2173.562518]
IP: [<ffffffffaa3f174c>] strncmp+0xc/0x50

Jun 28 19:01:41 texsonics kernel: [ 2173.562541]
PGD 6d0f7067

Jun 28 19:01:41 texsonics kernel: [ 2173.562552]
PUD 8484c067

Jun 28 19:01:41 texsonics kernel: [ 2173.562563]
PMD 6d263067

Jun 28 19:01:41 texsonics kernel: [ 2173.562569]
PTE 8000000099010867

Jun 28 19:01:41 texsonics kernel: [ 2173.562581]

Jun 28 19:01:41 texsonics kernel: [ 2173.562589]
Oops: 0001 [#1] SMP

Jun 28 19:01:41 texsonics kernel: [ 2173.562601]
Modules linked in: tdma(E) rtmac(E) rtcfg(E) rtcap(E) rt_loopback(E)
rtudp(E) rtpacket(E) rtipv4(E) nls_utf8(E) isofs(E) uas(E)
usb_storage(E) bnep(E) rfcomm(E) snd_hda_codec_hdmi(E)
snd_hda_codec_realtek(E) intel_rapl(E) snd_hda_codec_generic(E)
x86_pkg_temp_thermal(E) intel_powerclamp(E) i915(E) coretemp(E)
kvm_intel(E) snd_hda_intel(E) kvm(E) snd_hda_codec(E) snd_hda_core(E)
drm_kms_helper(E) joydev(E) input_leds(E) snd_hwdep(E) drm(E)
snd_pcm(E) snd_seq_midi(E) snd_seq_midi_event(E) snd_rawmidi(E)
snd_seq(E) irqbypass(E) snd_seq_device(E) snd_timer(E) hci_uart(E)
i2c_algo_bit(E) btbcm(E) btqca(E) btintel(E) fb_sys_fops(E) snd(E)
bluetooth(E) syscopyarea(E) crct10dif_pclmul(E) crc32_pclmul(E)
ghash_clmulni_intel(E) aesni_intel(E) soundcore(E) rt_e1000e(E)
sysfillrect(E) eeepc_wmi(E)

Jun 28 19:01:41 texsonics kernel: [ 2173.562924]
 asus_wmi(E) sparse_keymap(E) aes_x86_64(E) sysimgblt(E) mxm_wmi(E)
lrw(E) gf128mul(E) glue_helper(E) rtnet(E) acpi_als(E) serio_raw(E)
ablk_helper(E) cryptd(E) intel_lpss_acpi(E) kfifo_buf(E)
pinctrl_sunrisepoint(E) intel_lpss(E) shpchp(E) i2c_hid(E) video(E)
industrialio(E) wmi(E) mei_me(E) mei(E) pinctrl_intel(E) mac_hid(E)
parport_pc(E) ppdev(E) lp(E) parport(E) hid_generic(E) usbhid(E)
hid(E) psmouse(E) e1000e(E) ptp(E) pps_core(E) ahci(E) libahci(E)
fjes(E)

Jun 28 19:01:41 texsonics kernel: [ 2173.563124]
CPU: 0 PID: 2858 Comm: slave Tainted: G            E
4.9.38-xenomai-3.0.5 #1

Jun 28 19:01:41 texsonics kernel: [ 2173.563152]
Hardware name: System manufacturer System Product Name/H110M-D, BIOS
3601 12/12/2017

Jun 28 19:01:41 texsonics kernel: [ 2173.563182]
I-pipe domain: Linux

Jun 28 19:01:41 texsonics kernel: [ 2173.563195]
task: ffff93b6c4866740 task.stack: ffffbb53c1eb4000

Jun 28 19:01:41 texsonics kernel: [ 2173.563216]
RIP: 0010:[<ffffffffaa3f174c>]  [<ffffffffaa3f174c>]
strncmp+0xc/0x50

Jun 28 19:01:41 texsonics kernel: [ 2173.563244]
RSP: 0018:ffffbb53c1eb7d58  EFLAGS: 00010202

Jun 28 19:01:41 texsonics kernel: [ 2173.563264]
RAX: ffffbb53c0917040 RBX: ffffffffc0358780 RCX: 0000000000000072

Jun 28 19:01:41 texsonics kernel: [ 2173.563288]
RDX: 0000000000000010 RSI: 00007ffccbd27e10 RDI: ffff93b6c48c4004

Jun 28 19:01:41 texsonics kernel: [ 2173.563313]
RBP: ffffbb53c1eb7d58 R08: 0000000000000010 R09: 0000000000000008

Jun 28 19:01:41 texsonics kernel: [ 2173.563338]
R10: 0000000000000001 R11: 0000000000000000 R12: ffff93b6c48c4000

Jun 28 19:01:41 texsonics kernel: [ 2173.563362]
R13: 00007ffccbd27e10 R14: 00007ffccbd27e10 R15: ffffffffaa19d3f0

Jun 28 19:01:41 texsonics kernel: [ 2173.563387]
FS:  00007fb983c68780(0000) GS:ffff93b772200000(0000)
knlGS:0000000000000000

Jun 28 19:01:41 texsonics kernel: [ 2173.563415]
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b

Jun 28 19:01:41 texsonics kernel: [ 2173.563435]
CR2: 00007ffccbd27e10 CR3: 0000000080b92000 CR4: 00000000003406f0

Jun 28 19:01:41 texsonics kernel: [ 2173.563460]
Stack:

Jun 28 19:01:41 texsonics kernel: [ 2173.563469]
 ffffbb53c1eb7d80 ffffffffc0352152 00007ffccbd27e10 0000000000000000

Jun 28 19:01:41 texsonics kernel: [ 2173.563500]
 0000000000054888 ffffbb53c1eb7da8 ffffffffc0352673 ffff93b6d8682200

Jun 28 19:01:41 texsonics kernel: [ 2173.563532]
 0000000040180021 ffff93b6c4866740 ffffbb53c1eb7de0 ffffffffc0355494

Jun 28 19:01:41 texsonics kernel: [ 2173.563564]
Call Trace:

Jun 28 19:01:41 texsonics kernel: [ 2173.563577]
 [<ffffffffc0352152>] __rtdev_get_by_name+0x32/0x60 [rtnet]

Jun 28 19:01:41 texsonics kernel: [ 2173.563602]
 [<ffffffffc0352673>] rtdev_get_by_name+0x53/0xc0 [rtnet]

Jun 28 19:01:41 texsonics kernel: [ 2173.563626]
 [<ffffffffc0355494>] rt_socket_if_ioctl+0x34/0x240 [rtnet]

Jun 28 19:01:41 texsonics kernel: [ 2173.563651]
 [<ffffffffaa19d3f0>] ? CoBaLt_fcntl+0x20/0x20

Jun 28 19:01:41 texsonics kernel: [ 2173.563671]
 [<ffffffffc06d1934>] rt_packet_ioctl+0x154/0x310 [rtpacket]

Jun 28 19:01:41 texsonics kernel: [ 2173.563695]
 [<ffffffffaa19d3f0>] ? CoBaLt_fcntl+0x20/0x20

Jun 28 19:01:41 texsonics kernel: [ 2173.563715]
 [<ffffffffaa198ff1>] rtdm_fd_ioctl+0xe1/0x210

Jun 28 19:01:41 texsonics kernel: [ 2173.563736]
 [<ffffffffaa18a1bd>] ? xnthread_switch_fpu+0x2d/0x40

Jun 28 19:01:41 texsonics kernel: [ 2173.563758]
 [<ffffffffaa19d3f0>] ? CoBaLt_fcntl+0x20/0x20

Jun 28 19:01:41 texsonics kernel: [ 2173.563778]
 [<ffffffffaa19d400>] CoBaLt_ioctl+0x10/0x20

Jun 28 19:01:41 texsonics kernel: [ 2173.563797]
 [<ffffffffaa1a9d4a>] ipipe_syscall_hook+0x11a/0x320

Jun 28 19:01:41 texsonics kernel: [ 2173.563819]
 [<ffffffffaa12bc9c>] __ipipe_notify_syscall+0xbc/0x170

Jun 28 19:01:41 texsonics kernel: [ 2173.563842]
 [<ffffffffaa822e37>] pipeline_syscall+0x8/0x1b

Jun 28 19:01:41 texsonics kernel: [ 2173.563862]
Code: ff 48 83 c6 01 3a 46 ff 74 eb 19 c0 83 c8 01 5d c3 31 c0 5d c3
66 2e 0f 1f 84 00 00 00 00 00 55 48 85 d2 48 89 e5 74 35 0f b6 0f
<44> 0f b6 06 44 38 c1 75 2d 84 c9 74 25 48 83 ea 01 31 c0 eb
18

Jun 28 19:01:41 texsonics kernel: [ 2173.565120]
RIP  [<ffffffffaa3f174c>] strncmp+0xc/0x50

Jun 28 19:01:41 texsonics kernel: [ 2173.566230]
 RSP <ffffbb53c1eb7d58>

Jun 28 19:01:41 texsonics kernel: [ 2173.567315]
CR2: 00007ffccbd27e10

Jun 28 19:01:41 texsonics kernel: [ 2173.572649]
---[ end trace 38cea6a9115ac66f ]---

Jun 28 19:02:14 texsonics kernel: [ 2207.171516]
e1000e: rteth0 NIC Link is Down

Jun 28 19:02:32 texsonics kernel: [ 2224.656356]
e1000e: rteth0 NIC Link is Up 100 Mbps Full Duplex, Flow Control:
None

Jun 28 19:02:32 texsonics kernel: [ 2224.656358]
rt_e1000e: 10/100 speed: disabling TSO

kindly help me to solve this issue

thank you
Ashok
