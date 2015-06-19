Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
From: Michael Haberler <haberlerm@gmail.com>
In-Reply-To: <55841ABE.9090809@siemens.com>
Date: Fri, 19 Jun 2015 19:51:00 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <9BD99D42-5187-413A-986F-A04189721344@gmail.com>
References: <7B9254AC-C035-4D61-884E-8C9B3706A22B@gmail.com>
 <5581BE6F.4030607@siemens.com>
 <624126A3-294C-48BF-A099-2AA8E000FE11@gmail.com>
 <5584079E.2090000@siemens.com>
 <316F216B-1C02-4EE7-92B8-10FC6DCF6761@gmail.com>
 <55841ABE.9090809@siemens.com>
Subject: Re: [Xenomai] RTDM-native brushup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiska <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>

rebuilt kernel with CONFIG_FRAME_POINTER; in fact different traceback:

> You probably want to enable frame pointers in order to make the
> backtraces more reliable.

# ./rtdmtest -s -c 10

[   47.872760] starting RTDM services.
[   52.376895] __rtdmtest_init: registering device rttest0, err=3D250
[  112.437502] ------------[ cut here ]------------
[  112.437505] kernel BUG at kernel/locking/rtmutex.c:996!
[  112.437511] invalid opcode: 0000 [#1] PREEMPT SMP
[  112.437577] Modules linked in: rtdmtest(O) rtdm(O) rpcsec_gss_krb5 =
nfsv4 binfmt_misc cfg80211 rfkill hid_generic iTCO_wdt =
iTCO_vendor_support ppdev evdev nfsd auth_rpcgss oid_registry nfs_acl =
usbhid nfs hid lockd grace fscache sunrpc coretemp kvm_intel kvm =
snd_hda_codec_hdmi psmouse serio_raw snd_hda_codec_realtek =
snd_hda_codec_generic pcspkr i2c_i801 snd_hda_intel snd_hda_controller =
snd_hda_codec snd_hwdep snd_pcm snd_timer lpc_ich snd mfd_core shpchp =
soundcore battery parport_pc parport i915 video drm_kms_helper =
acpi_cpufreq drm i2c_algo_bit i2c_core button processor loop fuse =
autofs4 ext4 crc16 jbd2 mbcache microcode sg sd_mod xhci_pci xhci_hcd =
crc32c_intel ahci libahci libata r8169 mii usbcore fan thermal =
usb_common scsi_mod thermal_sys
[  112.437584] CPU: 0 PID: 1512 Comm: rtdmtest Tainted: G           O   =
3.18.13-rt10mah+ #2
[  112.437586] Hardware name: Gigabyte Technology Co., Ltd. To be filled =
by O.E.M./J1900N-D3V, BIOS F3 04/29/2014
[  112.437589] task: f0877920 ti: f08a2000 task.ti: f08a2000
[  112.437593] EIP: 0060:[<c133f9a5>] EFLAGS: 00010246 CPU: 0
[  112.437601] EIP is at rt_spin_lock_slowlock+0x50/0x178
[  112.437604] EAX: f0877920 EBX: f6db2ec0 ECX: f0877920 EDX: f0877920
[  112.437607] ESI: 00000001 EDI: f0877920 EBP: f08a3e44 ESP: f08a3e04
[  112.437609]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[  112.437612] CR0: 8005003b CR2: b74f2a2a CR3: 308d5000 CR4: 001007d0
[  112.437613] Stack:
[  112.437620]  f52f9a60 00000002 00000001 f08a3e10 00000000 000003ff =
f08a3e1c f4d3e100
[  112.437627]  00000000 00000000 c15578e0 c1557801 f08a3e3c f6db2ec0 =
f08a3e74 f6db2eb8
[  112.437634]  f08a3e4c c105cd1d f08a3e54 c134060c f08a3e64 c1058c08 =
f6db2eb4 f6db2ec0
[  112.437635] Call Trace:
[  112.437645]  [<c105cd1d>] =
rt_spin_lock_fastlock.constprop.31+0x1e/0x20
[  112.437650]  [<c134060c>] rt_spin_lock+0x8/0xa
[  112.437655]  [<c1058c08>] add_wait_queue_exclusive+0x18/0x3c
[  112.437664]  [<f82f8834>] _rtdm_sem_down+0x57/0x122 [rtdm]
[  112.437670]  [<c104ea24>] ? wake_up_state+0xc/0xc
[  112.437676]  [<f83c75ec>] ? rtdmtest_ioctl+0x318/0x4fd [rtdmtest]
[  112.437680]  [<c104cbcf>] ? get_parent_ip+0xb/0x31
[  112.437685]  [<c104cc5f>] ? preempt_count_add+0x6a/0x7c
[  112.437689]  [<c13404f1>] ? _raw_spin_lock_irqsave+0x14/0x3d
[  112.437694]  [<c1340561>] ? _raw_spin_unlock_irqrestore+0x12/0x36
[  112.437698]  [<c105cf6c>] ? rt_mutex_adjust_pi+0x39/0x6d
[  112.437703]  [<c104dae4>] ? __sched_setscheduler+0x5e9/0x643
[  112.437709]  [<c10b634b>] ? =
perf_swevent_start_hrtimer.part.39+0x89/0x89
[  112.437715]  [<c1081bbc>] ? smp_call_function_single+0x74/0xa1
[  112.437722]  [<f82f8c48>] ? _rtdm_chrdev_ioctl+0x23/0x3e [rtdm]
[  112.437728]  [<f82f8c25>] ? rtdm_context_get+0x3/0x3 [rtdm]
[  112.437734]  [<c11055a2>] ? do_vfs_ioctl+0x371/0x41a
[  112.437739]  [<c110c7f3>] ? __fget+0x4f/0x56
[  112.437744]  [<c110568e>] ? SyS_ioctl+0x43/0x64
[  112.437749]  [<c1340ab0>] ? sysenter_do_call+0x12/0x12
[  112.437798] Code: 00 00 c6 45 ec 01 e8 63 0a 00 00 31 c9 89 fa 6a 01 =
89 d8 e8 80 cd d1 ff 5e 85 c0 0f 85 23 01 00 00 8b 43 0c 83 e0 fe 39 c7 =
75 02 <0f> 0b 8d 87 dc 04 00 00 89 45 c8 e8 4d 0a 00 00 8b 07 89 47 04
[  112.437805] EIP: [<c133f9a5>] rt_spin_lock_slowlock+0x50/0x178 SS:ESP =
0068:f08a3e04
[  112.752423] ---[ end trace 0000000000000002 ]---
[  112.752428] note: rtdmtest[1512] exited with preempt_count 1


