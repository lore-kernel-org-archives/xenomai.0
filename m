Sender: Michael Welling <mwelling79@gmail.com>
Date: Mon, 28 Nov 2016 20:58:47 -0600
From: Michael Welling <mwelling@ieee.org>
Message-ID: <20161129025847.vllfsneutueikuol@qwertyuiop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] kernel bug using cross link
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I am getting a kernel bug when running the cross-link demo with Xenomai 3.0.3 cobalt kernel 4.1.18.
This is on a core i7 with a PCIe serial port card installed.

The driver loads as expected.

sudo setserial /dev/ttyS4 uart unknown
sudo setserial /dev/ttyS5 uart unknown
sudo modprobe xeno_16550A io=0x3000,0x3008 irq=18,18 baud_base=115200,115200 tx_fifo=1,1
ls -l /dev/rtdm/rtser*
crw-rw---- 1 root xenomai 242, 0 Nov 28 20:44 /dev/rtdm/rtser0
crw-rw---- 1 root xenomai 242, 1 Nov 28 20:44 /dev/rtdm/rtser1

When I start the cross-link demo without the loopback connected it fails as expected but the demo hangs when closing the second serial port.

/usr/xenomai/demo/cross-link 
main : write-file opened
main : write-config written
main : can't open /dev/rtdm/rtser1 (read), Operation not permitted
main : /dev/rtdm/rtser0 (write) -> closed
<locked console>

Here is the error that is printed in the kernel messages:
[  975.790245] ------------[ cut here ]------------
[  975.790248] kernel BUG at mm/slub.c:3413!
[  975.790249] invalid opcode: 0000 [#1] SMP 
[  975.790251] Modules linked in: xeno_16550A(E) snd_hda_codec_hdmi(E) bnep(E) rfcomm(E) bluetooth(E) hp_wmi(E) sparse_keymap(E) snd_hda_codec_realtek(E) snd_hda_codec_generic(E) x86_pkg_temp_thermal(E) coretemp(E) kvm_intel(E) kvm(E) i915(E) crct10dif_pclmul(E) crc32_pclmul(E) aesni_intel(E) aes_x86_64(E) lrw(E) gf128mul(E) glue_helper(E) ablk_helper(E) snd_hda_intel(E) cryptd(E) snd_hda_controller(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) serio_raw(E) snd_pcm(E) snd_seq_midi(E) snd_seq_midi_event(E) snd_rawmidi(E) nouveau(E) snd_seq(E) snd_seq_device(E) snd_timer(E) 8250_fintek(E) mxm_wmi(E) wmi(E) ttm(E) snd(E) drm_kms_helper(E) drm(E) soundcore(E) i2c_algo_bit(E) video(E) tpm_infineon(E) shpchp(E) mac_hid(E) nls_iso8859_1(E) parport_pc(E) ppdev(E) lp(E) parport(E) hid_generic(E) usbhid(E) hid(E) psmouse(E) e1000e(E) ptp(E) pps_core(E) ahci(E) libahci(E) [last unloaded: xeno_16550A]
[  975.790279] CPU: 6 PID: 2211 Comm: cross-link Tainted: G            E   4.1.18-xenomai-3.0.3 #1
[  975.790280] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.24 04/27/2016
[  975.790281] task: ffff88081413e930 ti: ffff880819554000 task.ti: ffff880819554000
[  975.790282] RIP: 0010:[<ffffffff811e6639>]  [<ffffffff811e6639>] kfree+0x129/0x130
[  975.790287] RSP: 0018:ffff880819557cc8  EFLAGS: 00010246
[  975.790288] RAX: 0200000000000000 RBX: ffff880814bb4000 RCX: 0000000000000006
[  975.790289] RDX: 000077ff80000000 RSI: 0000000000000002 RDI: ffff880814bb4000
[  975.790289] RBP: ffff880819557ce8 R08: 000000000000663b R09: ffff88081d55d860
[  975.790290] R10: ffffea002052ed00 R11: ffffffff811842da R12: ffff880817956a00
[  975.790291] R13: ffffffff81174caf R14: ffff880814290818 R15: 0000000000000000
[  975.790292] FS:  0000000000000000(0000) GS:ffff88081d500000(0000) knlGS:0000000000000000
[  975.790293] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  975.790294] CR2: 00007f7888faaaf0 CR3: 0000000816326000 CR4: 00000000001406e0
[  975.790295] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  975.790296] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  975.790297] I-pipe domain Linux
[  975.790297] Stack:
[  975.790298]  ffff880817956a00 ffff880814bb4000 ffff880817956a00 0000000000000000
[  975.790301]  ffff880819557d08 ffffffff81174caf ffff880814bb4000 0000000000031bc8
[  975.790303]  ffff880819557d48 ffffffff81177caa ffff880819557d48 ffffffff8117eb20
[  975.790305] Call Trace:
[  975.790308]  [<ffffffff81174caf>] __rtdm_dev_close+0x2f/0x40
[  975.790310]  [<ffffffff81177caa>] __put_fd+0x17a/0x1a0
[  975.790312]  [<ffffffff8117eb20>] ? cobalt_monitor_reclaim+0xf0/0x100
[  975.790313]  [<ffffffff8117ea30>] ? CoBaLt_monitor_exit+0x1e0/0x1e0
[  975.790315]  [<ffffffff81178e70>] ? rtdm_fd_close+0x270/0x270
[  975.790316]  [<ffffffff81178ee3>] destroy_fd+0x73/0xa0
[  975.790318]  [<ffffffff811715f0>] xntree_cleanup+0x40/0x50
[  975.790320]  [<ffffffff8117971f>] rtdm_fd_cleanup+0x1f/0x30
[  975.790321]  [<ffffffff811842e2>] cobalt_process_detach+0xd2/0x1d0
[  975.790322]  [<ffffffff81183728>] remove_process+0x68/0xb0
[  975.790324]  [<ffffffff81185315>] ipipe_kevent_hook+0x585/0x740
[  975.790326]  [<ffffffff810dc8ea>] ? exit_robust_list+0x6a/0x130
[  975.790329]  [<ffffffff8111780d>] __ipipe_notify_kevent+0x3d/0x70
[  975.790331]  [<ffffffff81062327>] mmput+0x57/0x110
[  975.790332]  [<ffffffff810670df>] do_exit+0x27f/0xb60
[  975.790334]  [<ffffffff81071025>] ? signal_wake_up_state+0x35/0x60
[  975.790336]  [<ffffffff81072402>] ? zap_other_threads+0x82/0xa0
[  975.790337]  [<ffffffff81067a4f>] do_group_exit+0x3f/0xb0
[  975.790339]  [<ffffffff81067ad4>] SyS_exit_group+0x14/0x20
[  975.790341]  [<ffffffff8179c80e>] system_call_fastpath+0x16/0x1b
[  975.790342] Code: b1 49 f7 02 00 c0 00 00 74 21 49 8b 02 31 f6 f6 c4 40 74 04 41 8b 72 68 4c 89 d7 e8 72 86 fb ff eb 90 4d 8b 52 30 e9 3d ff ff ff <0f> 0b 0f 1f 44 00 00 e8 6b 88 5b 00 55 89 f0 48 89 e5 41 57 4c 
[  975.790366] RIP  [<ffffffff811e6639>] kfree+0x129/0x130
[  975.790368]  RSP <ffff880819557cc8>
[  975.790369] ---[ end trace f1ba356caf9967ac ]---
[  975.790370] Fixing recursive fault but reboot is needed!

Any ideas what would cause this to happen?


