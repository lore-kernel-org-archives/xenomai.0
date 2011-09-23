MIME-Version: 1.0
In-Reply-To: <CAL8zT=i-c0Oib2giMNcqe8_ZBh-qBHn9zHy0xZUCN=ii6p2vPQ@mail.gmail.com>
References: <CAL8zT=g-Mo1VDk2X9zE1d=j-k2wVRFVeNVHEuX50p7Bee5rKaQ@mail.gmail.com>
	<4E7C46C7.4050203@domain.hid>
	<CAL8zT=i-c0Oib2giMNcqe8_ZBh-qBHn9zHy0xZUCN=ii6p2vPQ@mail.gmail.com>
From: Jean-Michel Hautbois <jhautbois@domain.hid>
Date: Fri, 23 Sep 2011 11:49:07 +0200
Message-ID: <CAL8zT=jTaCy1x+UMmSLyFmeYR4K05KRoTCnkwsCfCt7UcS+XpQ@mail.gmail.com>
Content-Type: multipart/alternative; boundary=20cf30025e5a96be5204ad98b92e
Subject: Re: [Xenomai-core] P2020 support for ftrace with ipipe 2.12-01 and
 xeno 2.5.5.1
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-core@domain.hid

--20cf30025e5a96be5204ad98b92e
Content-Type: text/plain; charset=UTF-8

OK, I have more traces (a few :)) :

[   65.835519] Kernel BUG at c008c380 [verbose debug info unavailable]
[   65.910627] Oops: Exception in kernel mode, sig: 5 [#1]
[   65.973157] SMP NR_CPUS=2 P2020 GMEG
[   66.015908] last sysfs file: /sys/class/i2c-dev/i2c-1/dev
[   66.080519] Modules linked in:
[   66.117015] NIP: c008c380 LR: c008c380 CTR: c008c360
[   66.176420] REGS: dc71e460 TRAP: 0700   Tainted: G        W
(2.6.35.11)
[   66.258737] MSR: 00029000 <EE,ME,CE>  CR: 24448624  XER: 00000000
[   66.331761] TASK = dc6b8e70[184] 'bash' THREAD: dc71e000 CPU: 1
[   66.400551] GPR00: c0422da0 dc71e510 dc6b8e70 00000001 00000200 15f275c0
e1197000 c0425238
[   66.500726] GPR08: c0425240 c0455fe0 00000000 00000001 22448624 100f9d24
00002020 c0095624
[   66.600902] GPR16: c00a636c c00a60a8 c0445040 c042e8e0 ffffffff c045a6f0
00000200 dc747e7c
[   66.701078] GPR24: c043fa64 c0422d98 c0440000 c047dd40 c044809c c04473a4
c047dd40 dc71e510
[   66.803368] NIP [c008c380] __ipipe_dispatch_wired_nocheck+0x2c/0x26c
[   66.879443] LR [c008c380] __ipipe_dispatch_wired_nocheck+0x2c/0x26c
[   66.954466] Call Trace:
[   66.983656] [dc71e510] [c008c380]
__ipipe_dispatch_wired_nocheck+0x2c/0x26c (unreliable)
[   67.080604] [dc71e550] [c0017728] return_to_handler+0x0/0x34
(ret_from_except_full+0x0/0x4c)
[   67.181710] [dc71e580] [c0017728] return_to_handler+0x0/0x34
(__ipipe_grab_timer+0x138/0x1a0)
[   67.283867] --- Exception: 901 at __ipipe_unstall_root+0xac/0x100
[   67.283882]     LR = __ipipe_unstall_root+0xa8/0x100
[   67.416207] [dc71e660] [c0017728] return_to_handler+0x0/0x34
(__ipipe_ret_from_except+0x0/0xc)
[   67.519399] [dc71e680] [c00a5f64] ftrace_return_to_handler+0x74/0xd4
[   67.595485] [dc71e6b0] [c0017740] return_to_handler+0x18/0x34
[   67.664276] [dc71e6d0] [c0017728] return_to_handler+0x0/0x34
(trace_graph_return+0xbc/0xd4)
[   67.764342] [dc71e6f0] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   67.837306] [dc71e720] [c00176e4] ftrace_graph_caller+0x10/0x54
[   67.908180] [dc71e750] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0x144/0x16c)
[   68.009286] [dc71e770] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   68.082244] [dc71e7a0] [c00176e4] ftrace_graph_caller+0x10/0x54
[   68.153119] [dc71e7d0] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   68.253184] [dc71e7f0] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   68.326142] [dc71e820] [c00176e4] ftrace_graph_caller+0x10/0x54
[   68.397017] [dc71e850] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   68.497080] [dc71e870] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   68.570038] [dc71e8a0] [c00176e4] ftrace_graph_caller+0x10/0x54
[   68.640913] [dc71e8d0] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   68.740978] [dc71e8f0] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   68.813937] [dc71e920] [c00176e4] ftrace_graph_caller+0x10/0x54
[   68.884816] [dc71e950] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   68.984881] [dc71e970] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   69.057839] [dc71e9a0] [c00176e4] ftrace_graph_caller+0x10/0x54
[   69.128714] [dc71e9d0] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   69.228778] [dc71e9f0] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   69.301736] [dc71ea20] [c00176e4] ftrace_graph_caller+0x10/0x54
[   69.372611] [dc71ea50] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   69.472676] [dc71ea70] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   69.545634] [dc71eaa0] [c00176e4] ftrace_graph_caller+0x10/0x54
[   69.616509] [dc71ead0] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   69.716572] [dc71eaf0] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   69.789531] [dc71eb20] [c00176e4] ftrace_graph_caller+0x10/0x54
[   69.860405] [dc71eb50] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   69.960470] [dc71eb70] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   70.033429] [dc71eba0] [c00176e4] ftrace_graph_caller+0x10/0x54
[   70.104302] [dc71ebd0] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   70.204367] [dc71ebf0] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   70.277325] [dc71ec20] [c00176e4] ftrace_graph_caller+0x10/0x54
[   70.348200] [dc71ec50] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   70.448264] [dc71ec70] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   70.521223] [dc71eca0] [c00176e4] ftrace_graph_caller+0x10/0x54
[   70.592103] [dc71ecd0] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   70.692168] [dc71ecf0] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   70.765126] [dc71ed20] [c00176e4] ftrace_graph_caller+0x10/0x54
[   70.836001] [dc71ed50] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   70.936064] [dc71ed70] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   71.009024] [dc71eda0] [c00176e4] ftrace_graph_caller+0x10/0x54
[   71.079904] [dc71edd0] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   71.179969] [dc71edf0] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   71.252927] [dc71ee20] [c00176e4] ftrace_graph_caller+0x10/0x54
[   71.323802] [dc71ee50] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   71.423865] [dc71ee70] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   71.496825] [dc71eea0] [c00176e4] ftrace_graph_caller+0x10/0x54
[   71.567704] [dc71eed0] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   71.667769] [dc71eef0] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   71.740728] [dc71ef20] [c00176e4] ftrace_graph_caller+0x10/0x54
[   71.811602] [dc71ef50] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   71.911666] [dc71ef70] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   71.984625] [dc71efa0] [c00176e4] ftrace_graph_caller+0x10/0x54
[   72.055499] [dc71efd0] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   72.155564] [dc71eff0] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   72.228522] [dc71f020] [c00176e4] ftrace_graph_caller+0x10/0x54
[   72.299397] [dc71f050] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   72.399456] Instruction dump:
[   72.434911] 4e800020 7c0802a6 90010004 4bf8b2bd 9421ffc0 7c0802a6
90010044 bea10014
[   72.527782] 7c3f0b78 7c7e1b78 7c962378 4bffc20d <2f830000> 3f20c042
3b392d98 38190008
[   72.622742] I-pipe tracer log (100 points):
[   72.672766]      +func                    0 ipipe_trace_panic_freeze+0x8
(oops_enter+0x28)
[   72.771927]      +func                    0 oops_enter+0x8 (die+0x30)
[   72.849200]      +func                    0 die+0x8 (_exception+0xa4)
[   72.926473]      +func                    0 _exception+0x8
(program_check_exception+0x1e8)
[   73.025627]  |   +end     0x80000000      0 __ipipe_unstall_root+0xa8
(vprintk+0x348)
[   73.119567]  |   #func                    0 ipipe_check_context+0x8
(__ipipe_unstall_root+0x3c)
[   73.223916]  |   #begin   0x80000000      0 __ipipe_unstall_root+0xbc
(vprintk+0x348)
[   73.317848]      #func                    0 __ipipe_unstall_root+0x8
(vprintk+0x348)
[   73.410745]  |   #end     0x80000001      0 ipipe_check_context+0xdc
(vprintk+0x344)
[   73.503643]  |   #begin   0x80000001      0 ipipe_check_context+0xf0
(vprintk+0x344)
[   73.596535]      #func                    0 ipipe_check_context+0x8
(vprintk+0x344)
[   73.688391]      #func                    0
_raw_spin_unlock_irqrestore+0x8 (release_console_sem+0x11c)
[   73.801079]      #func                    0 __ipipe_spin_unlock_debug+0x8
(release_console_sem+0x110)
[   73.911691]      #func                    0
_raw_spin_unlock_irqrestore+0x8 (up+0x68)
[   74.005636]      #func                    0 __ipipe_spin_unlock_debug+0x8
(up+0x5c)
[   74.097492]  |   #end     0x80000001      0
__ipipe_test_and_stall_root+0xa8 (_raw_spin_lock_irqsave+0x28)
[   74.213318]  |   #begin   0x80000001      0
__ipipe_test_and_stall_root+0xb8 (_raw_spin_lock_irqsave+0x28)
[   74.329144]      #func                    0
__ipipe_test_and_stall_root+0x8 (_raw_spin_lock_irqsave+0x28)
[   74.443922]      #func                    0 _raw_spin_lock_irqsave+0x8
(up+0x28)
[   74.532653]      #func                   -1 up+0x8
(release_console_sem+0x108)
[   74.619301]  |   #end     0x80000001     -1
__ipipe_test_and_stall_root+0xa8 (_raw_spin_lock_irqsave+0x28)
[   74.735121]  |   #begin   0x80000001     -1
__ipipe_test_and_stall_root+0xb8 (_raw_spin_lock_irqsave+0x28)
[   74.850940]      #func                   -1
__ipipe_test_and_stall_root+0x8 (_raw_spin_lock_irqsave+0x28)
[   74.965718]      #func                   -1 _raw_spin_lock_irqsave+0x8
(release_console_sem+0x60)
[   75.072157]      #func                   -1 _call_console_drivers+0x8
(release_console_sem+0xbc)
[   75.177553]      #func                   -1 mem_serial_out+0x8
(serial8250_console_write+0xfc)
[   75.280880]      #func                   -1 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   75.372736]      #func                   -1 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   75.464593]      #func                   -1 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   75.556448]      #func                   -1 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   75.648304]      #func                   -1 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   75.740161]      #func                   -1 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   75.832011]      #func                   -2 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   75.923866]      #func                   -2 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   76.015722]      #func                   -2 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   76.107572]      #func                   -2 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   76.199428]      #func                   -2 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   76.291284]      #func                   -2 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   76.383134]      #func                   -2 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   76.474989]      #func                   -2 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   76.566846]      #func                   -3 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   76.658702]      #func                   -3 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   76.750552]      #func                   -3 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   76.842407]      #func                   -3 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   76.934264]      #func                   -3 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   77.026114]      #func                   -3 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   77.117969]      #func                   -3 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   77.209825]      #func                   -3 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   77.301682]      #func                   -3 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   77.393532]      #func                   -4 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   77.485387]      #func                   -4 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   77.577243]      #func                   -4 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   77.669094]      #func                   -4 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   77.760949]      #func                   -4 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   77.852805]      #func                   -4 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   77.944655]      #func                   -4 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   78.036511]      #func                   -4 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   78.128367]      #func                   -4 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   78.220217]      #func                   -5 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   78.312072]      #func                   -5 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   78.403929]      #func                   -5 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   78.495785]      #func                   -5 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   78.587641]      #func                   -5 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   78.679497]      #func                   -5 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   78.771347]      #func                   -5 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   78.863197]      #func                   -5 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   78.955052]      #func                   -5 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   79.046908]      #func                   -6 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   79.138765]      #func                   -6 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   79.230615]      #func                   -6 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   79.322470]      #func                   -6 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   79.414326]      #func                   -6 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   79.506176]      #func                   -6 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   79.598032]      #func                   -6 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   79.689882]      #func                   -6 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   79.781732]      #func                   -6 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   79.873587]      #func                   -7 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   79.965437]      #func                   -7 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   80.057287]      #func                   -7 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   80.149142]      #func                   -7 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   80.240999]      #func                   -7 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   80.332855]      #func                   -7 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   80.424705]      #func                   -7 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   80.516560]      #func                   -7 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   80.608417]      #func                   -7 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   80.700273]      #func                   -8 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   80.792123]      #func                   -8 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   80.883978]      #func                   -8 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   80.975835]      #func                   -8 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   81.067685]      #func                   -8 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   81.159540]      #func                   -8 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   81.251396]      #func                   -8 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   81.343246]      #func                   -8 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   81.435101]      #func                   -8 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   81.526958]      #func                   -9 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   81.618814]      #func                   -9 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   81.710664]      #func                   -9 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   81.802520]      #func                   -9 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   81.894376]      #func                   -9 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   81.986226]      #func                   -9 mem_serial_in+0x8
(wait_for_xmitr+0x64)
[   82.078103] Kernel panic - not syncing: Fatal exception in interrupt
[   82.154172] Call Trace:
[   82.183369] [dc71e230] [c0009d3c] show_stack+0x108/0x1c0 (unreliable)
[   82.260524] [dc71e280] [c0340af4] dump_stack+0x2c/0x44
[   82.322030] [dc71e290] [c0340bc4] panic+0xb8/0x138
[   82.379363] [dc71e2e0] [c0011184] die+0x13c/0x1fc
[   82.435655] [dc71e310] [c0011354] _exception+0xa4/0x118
[   82.498197] [dc71e400] [c00129e8] program_check_exception+0x1e8/0x774
[   82.575329] [dc71e450] [c0017728] return_to_handler+0x0/0x34
(ret_from_except_full+0x0/0x4c)
[   82.676445] --- Exception: 700 at
__ipipe_dispatch_wired_nocheck+0x2c/0x26c
[   82.676462]     LR = __ipipe_dispatch_wired_nocheck+0x2c/0x26c
[   82.829623] [dc71e550] [c0017728] return_to_handler+0x0/0x34
(__ipipe_grab_timer+0x138/0x1a0)
[   82.931776] [dc71e580] [c0017728] return_to_handler+0x0/0x34
(__ipipe_ret_from_except+0x0/0xc)
[   83.034976] --- Exception: 901 at __ipipe_unstall_root+0xac/0x100
[   83.034991]     LR = __ipipe_unstall_root+0xa8/0x100
[   83.167316] [dc71e660] [c0017728] return_to_handler+0x0/0x34
(trace_graph_return+0xbc/0xd4)
[   83.267386] [dc71e680] [c00a5f64] ftrace_return_to_handler+0x74/0xd4
[   83.343483] [dc71e6b0] [c0017740] return_to_handler+0x18/0x34
[   83.412286] [dc71e6d0] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0x144/0x16c)
[   83.513399] [dc71e6f0] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   83.586371] [dc71e720] [c00176e4] ftrace_graph_caller+0x10/0x54
[   83.657258] [dc71e750] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   83.757329] [dc71e770] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   83.830301] [dc71e7a0] [c00176e4] ftrace_graph_caller+0x10/0x54
[   83.901188] [dc71e7d0] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   84.001265] [dc71e7f0] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   84.074230] [dc71e820] [c00176e4] ftrace_graph_caller+0x10/0x54
[   84.145118] [dc71e850] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   84.245195] [dc71e870] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   84.318159] [dc71e8a0] [c00176e4] ftrace_graph_caller+0x10/0x54
[   84.389033] [dc71e8d0] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   84.489098] [dc71e8f0] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   84.562064] [dc71e920] [c00176e4] ftrace_graph_caller+0x10/0x54
[   84.632951] [dc71e950] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   84.733022] [dc71e970] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   84.805993] [dc71e9a0] [c00176e4] ftrace_graph_caller+0x10/0x54
[   84.876880] [dc71e9d0] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   84.976951] [dc71e9f0] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   85.049916] [dc71ea20] [c00176e4] ftrace_graph_caller+0x10/0x54
[   85.120790] [dc71ea50] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   85.220855] [dc71ea70] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   85.293820] [dc71eaa0] [c00176e4] ftrace_graph_caller+0x10/0x54
[   85.364707] [dc71ead0] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   85.464778] [dc71eaf0] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   85.537742] [dc71eb20] [c00176e4] ftrace_graph_caller+0x10/0x54
[   85.608617] [dc71eb50] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   85.708681] [dc71eb70] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   85.781647] [dc71eba0] [c00176e4] ftrace_graph_caller+0x10/0x54
[   85.852534] [dc71ebd0] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   85.952605] [dc71ebf0] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   86.025577] [dc71ec20] [c00176e4] ftrace_graph_caller+0x10/0x54
[   86.096464] [dc71ec50] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   86.196535] [dc71ec70] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   86.269506] [dc71eca0] [c00176e4] ftrace_graph_caller+0x10/0x54
[   86.340394] [dc71ecd0] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   86.440464] [dc71ecf0] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   86.513429] [dc71ed20] [c00176e4] ftrace_graph_caller+0x10/0x54
[   86.584303] [dc71ed50] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   86.684368] [dc71ed70] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   86.757333] [dc71eda0] [c00176e4] ftrace_graph_caller+0x10/0x54
[   86.828220] [dc71edd0] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   86.928291] [dc71edf0] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   87.001257] [dc71ee20] [c00176e4] ftrace_graph_caller+0x10/0x54
[   87.072137] [dc71ee50] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   87.172215] [dc71ee70] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   87.245179] [dc71eea0] [c00176e4] ftrace_graph_caller+0x10/0x54
[   87.316060] [dc71eed0] [c0017728] return_to_handler+0x0/0x34
(trace_graph_entry+0xa4/0x16c)
[   87.416124] [dc71eef0] [c001ac80] prepare_ftrace_return+0x74/0xb0
[   87.489090] [dc71ef20] [c00176e4] ftrace_graph_caller+0x10/0x54
[   87.559994] Rebooting in 30 seconds..
[  100.139790] Kernel stack overflow in process dc6b8e70, r1=dc71e260
[  100.215869] NIP: c000fed4 LR: c003c9a8 CTR: c003c91<1>[  100.270738Unable
to handle kernel paging request for unknown fault
[  100.272990] Unable to handle kernel paging request for instruction fetch
[  100.273287] Unable to handle kernel paging request for unknown fault
[  100.275392] Faulting instruction address: 0xc0231620
[  100.277251] Oops: Kernel access of bad area, sig: 11 [#2]
[  100.279083] SMP NR_CPUS=2 P2020 GMEG
[  100.280668] last sysfs file: /sys/class/i2c-dev/i2c-1/dev
[  100.282574] Modules linked in:
[  100.284012] NIP: c0231620 LR: c0231608 CTR: c000b8e4
[  100.285747] REGS: c04416f0 TRAP: c04417b0   Tainted: G      D W
(2.6.35.11)
[  100.288097] MSR: 00021000 <ME,CE>  CR: 24042082  XER: 20000000
[  100.291295] TASK = c042a3a0[0] 'swapper' THREAD: c0440000 CPU: 0
[  100.293547] GPR00: 0000270f c04417a0 c042a3a0 00000000 00000014 00000014
00000000 00010000
[  100.298204] GPR08: c0446ecc 00000000 00000000 c04417a0 24042084 100aa930
c038ddfc c0441b90
[  100.302861] GPR16: c0441b90 c00176e4 28444624 00000201 c0441c00 00000001
0000000f c0441eaf
[  100.307518] GPR24: c0441eaf 00008000 c038fe64 c045a750 c04417b0 00000000
c0441854 00000001
[  100.312554] NIP [c0231620] wait_for_xmitr+0x50/0x120
[  100.314389] LR [c0231608] wait_for_xmitr+0x38/0x120
[  100.316097] Call Trace:
[  100.317241] [c04417a0] [c0231634] wait_for_xmitr+0x64/0x120 (unreliable)
[  100.319988] Instruction dump:
[  100.321424] 8003000c 7c9c2378 38800005 7c0903a6 7c7e1b78 4e800421
881e00c7 546906fc
[  100.326303] 7d200378 981e00c7 3800270f 7c7d1b78 <901f0008> 48000034
801e000c 7c0903a6
[  100.331455] Kernel panic - not syncing: Fatal exception in interrupt
[  100.333608] Call Trace:
[  100.334752] [c04415e0] [c0009d3c] show_stack+0x108/0x1c0 (unreliable)
[  100.337552] [c0441630] [c0340af4] dump_stack+0x2c/0x44
[  100.339733] [c0441640] [c0340bc4] panic+0xb8/0x138
[  100.341815] [c0441690] [c0011184] die+0x13c/0x1fc
[  100.343874] [c04416c0] [c001bd0c] bad_page_fault+0x90/0xe0
[  100.346155] [c04416e0] [c0016df8] handle_page_fault+0x7c/0x80
[  100.348613] --- Exception: c04417b0 at wait_for_xmitr+0x50/0x120
[  100.350369]     LR = wait_for_xmitr+0x38/0x120
[  100.352081] [c04417a0] [c0231634] wait_for_xmitr+0x64/0x120 (unreliable)
[  100.355673] Rebooting in 30 seconds..
[  102.652340] Faulting instruction address: 0x00000000
[  102.713835] Oops: Kernel access of bad area, sig: 11 [#3]
[  102.778443] SMP NR_CPUS=2 P2020 GMEG
[  102.821195] last sysfs file: /sys/class/i2c-dev/i2c-1/dev
[  102.885807] Modules linked in:
[  102.922303] NIP: 00000000 LR: 00000000 CTR: c0340394
[  102.981707] REGS: c0441a80 TRAP: 0400   Tainted: G      D W
(2.6.35.11)
[  103.064024] MSR: 00029000 <EE,ME,CE>  CR: 28444682  XER: 00000000
[  103.137047] TASK = dc6b8e70[184] 'bash' THREAD: dc71e000 CPU: 1
[  103.205838] GPR00: 00000000 c0441b30 dc6b8e70 00000040 c0441b38 c038ddfc
c0441c38 c0446bb8
[  103.306020] GPR08: 00000001 c038de3c 00000000 c0441b30 28444622 100f9d24
0000000f c0441eaf
[  103.406196] GPR16: c0441eaf 00000000 c038fe64 10624dd3 c038ddfc c0350ec8
00000025 c0350000
[  103.506372] GPR24: c044b10c 00000020 c0350e80 c0441c38 c044b50c c042c158
24042080 c0441b60
[  103.608645] NIP [00000000] (null)
[  103.648252] LR [00000000] (null)
[  103.686816] Call Trace:
[  103.716001] Instruction dump:
[  103.751455] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX
[  103.844333] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX
[  103.937209] Kernel panic - not syncing: Fatal exception in interrupt

2011/9/23 Jean-Michel Hautbois <jhautbois@domain.hid>

> Yes, ipipe tracing works.
> When it is the case, BTW, Here is the result of echoing a new tracer :
>
> $>cat max
>
> I-pipe worst-case tracing service on 2.6.35.11/ipipe-2.12-01
> ------------------------------
> ------------------------------
> CPU: 0, Begin: 2593605556 cycles, Trace Points: 12 (-10/+5), Length: 268166
> us
> Calibrated minimum trace-point overhead: 0.023 us
>
>  +----- Hard IRQs ('|': locked)
>  |+---- <unused>
>  ||+--- <unused>
>  |||+-- Xenomai
>  ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
>  |||||                        +---------- Delay flag ('+': > 1 us, '!': >
> 10 us)
>  |||||                        |        +- NMI noise ('N')
>  |||||                        |        |
>       Type    User Val.   Time    Delay  Function (Parent)
>      #func                   0    0.039  ipipe_check_context+0x8
> (tick_nohz_stop_sched_tick+0x31c)
>  |   #begin   0x80000001     0    0.051  ipipe_check_context+0xf0
> (tick_nohz_stop_sched_tick+0x31c)
>  |   #end     0x80000001     0    0.039  ipipe_check_context+0xdc
> (tick_nohz_stop_sched_tick+0x31c)
>      #func                   0    0.039  __ipipe_unstall_root+0x8
> (tick_nohz_stop_sched_tick+0x320)
>  |   #begin   0x80000000     0    0.043  __ipipe_unstall_root+0xbc
> (tick_nohz_stop_sched_tick+0x320)
>  |   #func                   0    0.058  ipipe_check_context+0x8
> (__ipipe_unstall_root+0x3c)
>  |   +end     0x80000000     0    0.046  __ipipe_unstall_root+0xa8
> (tick_nohz_stop_sched_tick+0x320)
>      +func                   0    0.041  ipipe_suspend_domain+0x8
> (cpu_idle+0xb0)
>  |   +begin   0x80000001     0    0.060  ipipe_suspend_domain+0x1e0
> (cpu_idle+0xb0)
>  |   +end     0x80000001     0    0.043  ipipe_suspend_domain+0x220
> (cpu_idle+0xb0)
> >|   +begin   0x80000000     0! 2146.524  cpu_idle+0xe8 (rest_init+0x94)
> :|   +func               268166    0.045  __ipipe_grab_timer+0x8
> (__ipipe_ret_from_except+0x0)
> :|   +begin   0x00000200 268166    0.046  __ipipe_grab_timer+0x84
> (__ipipe_ret_from_except+0x0)
> :|   +func               268166    0.060
> __ipipe_dispatch_wired_nocheck+0x8 (__ipipe_grab_timer+0x138)
> :|  # func               268166    0.054  xnintr_clock_handler+0x8
> (__ipipe_dispatch_wired_nocheck+0x104)
> :|  # func               268166    0.050  xntimer_tick_aperiodic+0x8
> (xnintr_clock_handler+0xd0)
> :|  # func               268166    0.060  xntimer_next_local_shot+0x8
> (xntimer_tick_aperiodic+0x304)
> :|  # func               268166    0.049  xnintr_host_tick+0x8
> (xnintr_clock_handler+0x1f4)
> :|  # func               268166    0.085  __ipipe_set_irq_pending+0x8
> (xnintr_host_tick+0x94)
> :|   +func               268166    0.065  __ipipe_walk_pipeline+0x8
> (__ipipe_dispatch_wired_nocheck+0x148)
> :|   +func               268166    0.061  __ipipe_sync_stage+0x8
> (__ipipe_walk_pipeline+0x1a8)
> <|   #end     0x80000000 268166    0.042  __ipipe_sync_stage+0x238
> (__ipipe_walk_pipeline+0x1a8)
>      #func               268166    0.042  irq_enter+0x8
> (__ipipe_sync_stage+0x260)
>      #func               268166    0.046  rcu_irq_enter+0x8
> (irq_enter+0x38)
>      #func               268167    0.043  idle_cpu+0x8 (irq_enter+0x44)
>      #func               268167    0.039  ipipe_check_context+0x8
> (irq_enter+0x84)
>  |   #begin   0x80000001 268167    0.000  ipipe_check_context+0xf0
> (irq_enter+0x84)
>
>
> $>echo function_graph > current_tracer
> [  275.698664] ------------[ cut here ]------------
> [  275.755250] ------------[ cut here ]------------
> [  275.810547] Kernel stack overflow in process dc6bf020, r1=dc838250
> [  275.896276] Kernel panic - not syncing: kernel stack overflow
> [  275.965200] Rebooting in 30 seconds..
>
> 2011/9/23 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>
>> On 09/23/2011 09:58 AM, Jean-Michel Hautbois wrote:
>> > Hi List,
>> >
>> > I am trying to use ftrace on a P2020 board, using the following :
>> > - Linux 2.6.35-11
>> > - Xenomai 2.5.5.1 (or 2.5.6, same problem)
>> > - ipipe 2.12-01
>> >
>> > I launch it using :
>> > $> mkdir /tmp/debug
>> > $> mount -t debugfs nodev /tmp/debug
>> > $> cd /tmp/debug/tracing
>> > $> echo function_graph > current_tracer
>> >
>> > The last one fails (it hangs the CPU, I cannot do anything than hard
>> reset).
>> > Do you know what could cause that ?
>> > As I can't have any trace, I don't really know how to go further, and
>> before
>> > using a BDI I would like to know if it is a known issue, as I could not
>> find
>> > anything related to this in the recent changes...
>> >
>> > Thanks in advance for your help,
>> > Regards,
>> > JM
>>
>> Does the I-pipe tracer work?
>> See:
>> http://www.xenomai.org/index.php/I-pipe:Tracer
>>
>>
>> --
>>                                            Gilles.
>>
>
>

--20cf30025e5a96be5204ad98b92e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

T0ssIEkgaGF2ZSBtb3JlIHRyYWNlcyAoYSBmZXcgOikpIDo8YnI+PGJyPlvCoMKgIDY1LjgzNTUx
OV0gS2VybmVsIEJVRyBhdCBjMDA4YzM4MCBbdmVyYm9zZSBkZWJ1ZyBpbmZvIHVuYXZhaWxhYmxl
XTxicj5bwqDCoCA2NS45MTA2MjddIE9vcHM6IEV4Y2VwdGlvbiBpbiBrZXJuZWwgbW9kZSwgc2ln
OiA1IFsjMV08YnI+W8KgwqAgNjUuOTczMTU3XSBTTVAgTlJfQ1BVUz0yIFAyMDIwIEdNRUc8YnI+
CgpbwqDCoCA2Ni4wMTU5MDhdIGxhc3Qgc3lzZnMgZmlsZTogL3N5cy9jbGFzcy9pMmMtZGV2L2ky
Yy0xL2Rldjxicj5bwqDCoCA2Ni4wODA1MTldIE1vZHVsZXMgbGlua2VkIGluOjxicj5bwqDCoCA2
Ni4xMTcwMTVdIE5JUDogYzAwOGMzODAgTFI6IGMwMDhjMzgwIENUUjogYzAwOGMzNjA8YnI+W8Kg
wqAgNjYuMTc2NDIwXSBSRUdTOiBkYzcxZTQ2MCBUUkFQOiAwNzAwwqDCoCBUYWludGVkOiBHwqDC
oMKgwqDCoMKgwqAgV8KgwqDCoCAoMi42LjM1LjExKTxicj4KClvCoMKgIDY2LjI1ODczN10gTVNS
OiAwMDAyOTAwMCAmbHQ7RUUsTUUsQ0UmZ3Q7wqAgQ1I6IDI0NDQ4NjI0wqAgWEVSOiAwMDAwMDAw
MDxicj5bwqDCoCA2Ni4zMzE3NjFdIFRBU0sgPSBkYzZiOGU3MFsxODRdICYjMzk7YmFzaCYjMzk7
IFRIUkVBRDogZGM3MWUwMDAgQ1BVOiAxPGJyPlvCoMKgIDY2LjQwMDU1MV0gR1BSMDA6IGMwNDIy
ZGEwIGRjNzFlNTEwIGRjNmI4ZTcwIDAwMDAwMDAxIDAwMDAwMjAwIDE1ZjI3NWMwIGUxMTk3MDAw
IGMwNDI1MjM4PGJyPgoKW8KgwqAgNjYuNTAwNzI2XSBHUFIwODogYzA0MjUyNDAgYzA0NTVmZTAg
MDAwMDAwMDAgMDAwMDAwMDEgMjI0NDg2MjQgMTAwZjlkMjQgMDAwMDIwMjAgYzAwOTU2MjQ8YnI+
W8KgwqAgNjYuNjAwOTAyXSBHUFIxNjogYzAwYTYzNmMgYzAwYTYwYTggYzA0NDUwNDAgYzA0MmU4
ZTAgZmZmZmZmZmYgYzA0NWE2ZjAgMDAwMDAyMDAgZGM3NDdlN2M8YnI+W8KgwqAgNjYuNzAxMDc4
XSBHUFIyNDogYzA0M2ZhNjQgYzA0MjJkOTggYzA0NDAwMDAgYzA0N2RkNDAgYzA0NDgwOWMgYzA0
NDczYTQgYzA0N2RkNDAgZGM3MWU1MTA8YnI+CgpbwqDCoCA2Ni44MDMzNjhdIE5JUCBbYzAwOGMz
ODBdIF9faXBpcGVfZGlzcGF0Y2hfd2lyZWRfbm9jaGVjaysweDJjLzB4MjZjPGJyPlvCoMKgIDY2
Ljg3OTQ0M10gTFIgW2MwMDhjMzgwXSBfX2lwaXBlX2Rpc3BhdGNoX3dpcmVkX25vY2hlY2srMHgy
Yy8weDI2Yzxicj5bwqDCoCA2Ni45NTQ0NjZdIENhbGwgVHJhY2U6PGJyPlvCoMKgIDY2Ljk4MzY1
Nl0gW2RjNzFlNTEwXSBbYzAwOGMzODBdIF9faXBpcGVfZGlzcGF0Y2hfd2lyZWRfbm9jaGVjaysw
eDJjLzB4MjZjICh1bnJlbGlhYmxlKTxicj4KClvCoMKgIDY3LjA4MDYwNF0gW2RjNzFlNTUwXSBb
YzAwMTc3MjhdIHJldHVybl90b19oYW5kbGVyKzB4MC8weDM0IChyZXRfZnJvbV9leGNlcHRfZnVs
bCsweDAvMHg0Yyk8YnI+W8KgwqAgNjcuMTgxNzEwXSBbZGM3MWU1ODBdIFtjMDAxNzcyOF0gcmV0
dXJuX3RvX2hhbmRsZXIrMHgwLzB4MzQgKF9faXBpcGVfZ3JhYl90aW1lcisweDEzOC8weDFhMCk8
YnI+W8KgwqAgNjcuMjgzODY3XSAtLS0gRXhjZXB0aW9uOiA5MDEgYXQgX19pcGlwZV91bnN0YWxs
X3Jvb3QrMHhhYy8weDEwMDxicj4KClvCoMKgIDY3LjI4Mzg4Ml3CoMKgwqDCoCBMUiA9IF9faXBp
cGVfdW5zdGFsbF9yb290KzB4YTgvMHgxMDA8YnI+W8KgwqAgNjcuNDE2MjA3XSBbZGM3MWU2NjBd
IFtjMDAxNzcyOF0gcmV0dXJuX3RvX2hhbmRsZXIrMHgwLzB4MzQgKF9faXBpcGVfcmV0X2Zyb21f
ZXhjZXB0KzB4MC8weGMpPGJyPlvCoMKgIDY3LjUxOTM5OV0gW2RjNzFlNjgwXSBbYzAwYTVmNjRd
IGZ0cmFjZV9yZXR1cm5fdG9faGFuZGxlcisweDc0LzB4ZDQ8YnI+CgpbwqDCoCA2Ny41OTU0ODVd
IFtkYzcxZTZiMF0gW2MwMDE3NzQwXSByZXR1cm5fdG9faGFuZGxlcisweDE4LzB4MzQ8YnI+W8Kg
wqAgNjcuNjY0Mjc2XSBbZGM3MWU2ZDBdIFtjMDAxNzcyOF0gcmV0dXJuX3RvX2hhbmRsZXIrMHgw
LzB4MzQgKHRyYWNlX2dyYXBoX3JldHVybisweGJjLzB4ZDQpPGJyPlvCoMKgIDY3Ljc2NDM0Ml0g
W2RjNzFlNmYwXSBbYzAwMWFjODBdIHByZXBhcmVfZnRyYWNlX3JldHVybisweDc0LzB4YjA8YnI+
CgpbwqDCoCA2Ny44MzczMDZdIFtkYzcxZTcyMF0gW2MwMDE3NmU0XSBmdHJhY2VfZ3JhcGhfY2Fs
bGVyKzB4MTAvMHg1NDxicj5bwqDCoCA2Ny45MDgxODBdIFtkYzcxZTc1MF0gW2MwMDE3NzI4XSBy
ZXR1cm5fdG9faGFuZGxlcisweDAvMHgzNCAodHJhY2VfZ3JhcGhfZW50cnkrMHgxNDQvMHgxNmMp
PGJyPlvCoMKgIDY4LjAwOTI4Nl0gW2RjNzFlNzcwXSBbYzAwMWFjODBdIHByZXBhcmVfZnRyYWNl
X3JldHVybisweDc0LzB4YjA8YnI+CgpbwqDCoCA2OC4wODIyNDRdIFtkYzcxZTdhMF0gW2MwMDE3
NmU0XSBmdHJhY2VfZ3JhcGhfY2FsbGVyKzB4MTAvMHg1NDxicj5bwqDCoCA2OC4xNTMxMTldIFtk
YzcxZTdkMF0gW2MwMDE3NzI4XSByZXR1cm5fdG9faGFuZGxlcisweDAvMHgzNCAodHJhY2VfZ3Jh
cGhfZW50cnkrMHhhNC8weDE2Yyk8YnI+W8KgwqAgNjguMjUzMTg0XSBbZGM3MWU3ZjBdIFtjMDAx
YWM4MF0gcHJlcGFyZV9mdHJhY2VfcmV0dXJuKzB4NzQvMHhiMDxicj4KClvCoMKgIDY4LjMyNjE0
Ml0gW2RjNzFlODIwXSBbYzAwMTc2ZTRdIGZ0cmFjZV9ncmFwaF9jYWxsZXIrMHgxMC8weDU0PGJy
PlvCoMKgIDY4LjM5NzAxN10gW2RjNzFlODUwXSBbYzAwMTc3MjhdIHJldHVybl90b19oYW5kbGVy
KzB4MC8weDM0ICh0cmFjZV9ncmFwaF9lbnRyeSsweGE0LzB4MTZjKTxicj5bwqDCoCA2OC40OTcw
ODBdIFtkYzcxZTg3MF0gW2MwMDFhYzgwXSBwcmVwYXJlX2Z0cmFjZV9yZXR1cm4rMHg3NC8weGIw
PGJyPgoKW8KgwqAgNjguNTcwMDM4XSBbZGM3MWU4YTBdIFtjMDAxNzZlNF0gZnRyYWNlX2dyYXBo
X2NhbGxlcisweDEwLzB4NTQ8YnI+W8KgwqAgNjguNjQwOTEzXSBbZGM3MWU4ZDBdIFtjMDAxNzcy
OF0gcmV0dXJuX3RvX2hhbmRsZXIrMHgwLzB4MzQgKHRyYWNlX2dyYXBoX2VudHJ5KzB4YTQvMHgx
NmMpPGJyPlvCoMKgIDY4Ljc0MDk3OF0gW2RjNzFlOGYwXSBbYzAwMWFjODBdIHByZXBhcmVfZnRy
YWNlX3JldHVybisweDc0LzB4YjA8YnI+CgpbwqDCoCA2OC44MTM5MzddIFtkYzcxZTkyMF0gW2Mw
MDE3NmU0XSBmdHJhY2VfZ3JhcGhfY2FsbGVyKzB4MTAvMHg1NDxicj5bwqDCoCA2OC44ODQ4MTZd
IFtkYzcxZTk1MF0gW2MwMDE3NzI4XSByZXR1cm5fdG9faGFuZGxlcisweDAvMHgzNCAodHJhY2Vf
Z3JhcGhfZW50cnkrMHhhNC8weDE2Yyk8YnI+W8KgwqAgNjguOTg0ODgxXSBbZGM3MWU5NzBdIFtj
MDAxYWM4MF0gcHJlcGFyZV9mdHJhY2VfcmV0dXJuKzB4NzQvMHhiMDxicj4KClvCoMKgIDY5LjA1
NzgzOV0gW2RjNzFlOWEwXSBbYzAwMTc2ZTRdIGZ0cmFjZV9ncmFwaF9jYWxsZXIrMHgxMC8weDU0
PGJyPlvCoMKgIDY5LjEyODcxNF0gW2RjNzFlOWQwXSBbYzAwMTc3MjhdIHJldHVybl90b19oYW5k
bGVyKzB4MC8weDM0ICh0cmFjZV9ncmFwaF9lbnRyeSsweGE0LzB4MTZjKTxicj5bwqDCoCA2OS4y
Mjg3NzhdIFtkYzcxZTlmMF0gW2MwMDFhYzgwXSBwcmVwYXJlX2Z0cmFjZV9yZXR1cm4rMHg3NC8w
eGIwPGJyPgoKW8KgwqAgNjkuMzAxNzM2XSBbZGM3MWVhMjBdIFtjMDAxNzZlNF0gZnRyYWNlX2dy
YXBoX2NhbGxlcisweDEwLzB4NTQ8YnI+W8KgwqAgNjkuMzcyNjExXSBbZGM3MWVhNTBdIFtjMDAx
NzcyOF0gcmV0dXJuX3RvX2hhbmRsZXIrMHgwLzB4MzQgKHRyYWNlX2dyYXBoX2VudHJ5KzB4YTQv
MHgxNmMpPGJyPlvCoMKgIDY5LjQ3MjY3Nl0gW2RjNzFlYTcwXSBbYzAwMWFjODBdIHByZXBhcmVf
ZnRyYWNlX3JldHVybisweDc0LzB4YjA8YnI+CgpbwqDCoCA2OS41NDU2MzRdIFtkYzcxZWFhMF0g
W2MwMDE3NmU0XSBmdHJhY2VfZ3JhcGhfY2FsbGVyKzB4MTAvMHg1NDxicj5bwqDCoCA2OS42MTY1
MDldIFtkYzcxZWFkMF0gW2MwMDE3NzI4XSByZXR1cm5fdG9faGFuZGxlcisweDAvMHgzNCAodHJh
Y2VfZ3JhcGhfZW50cnkrMHhhNC8weDE2Yyk8YnI+W8KgwqAgNjkuNzE2NTcyXSBbZGM3MWVhZjBd
IFtjMDAxYWM4MF0gcHJlcGFyZV9mdHJhY2VfcmV0dXJuKzB4NzQvMHhiMDxicj4KClvCoMKgIDY5
Ljc4OTUzMV0gW2RjNzFlYjIwXSBbYzAwMTc2ZTRdIGZ0cmFjZV9ncmFwaF9jYWxsZXIrMHgxMC8w
eDU0PGJyPlvCoMKgIDY5Ljg2MDQwNV0gW2RjNzFlYjUwXSBbYzAwMTc3MjhdIHJldHVybl90b19o
YW5kbGVyKzB4MC8weDM0ICh0cmFjZV9ncmFwaF9lbnRyeSsweGE0LzB4MTZjKTxicj5bwqDCoCA2
OS45NjA0NzBdIFtkYzcxZWI3MF0gW2MwMDFhYzgwXSBwcmVwYXJlX2Z0cmFjZV9yZXR1cm4rMHg3
NC8weGIwPGJyPgoKW8KgwqAgNzAuMDMzNDI5XSBbZGM3MWViYTBdIFtjMDAxNzZlNF0gZnRyYWNl
X2dyYXBoX2NhbGxlcisweDEwLzB4NTQ8YnI+W8KgwqAgNzAuMTA0MzAyXSBbZGM3MWViZDBdIFtj
MDAxNzcyOF0gcmV0dXJuX3RvX2hhbmRsZXIrMHgwLzB4MzQgKHRyYWNlX2dyYXBoX2VudHJ5KzB4
YTQvMHgxNmMpPGJyPlvCoMKgIDcwLjIwNDM2N10gW2RjNzFlYmYwXSBbYzAwMWFjODBdIHByZXBh
cmVfZnRyYWNlX3JldHVybisweDc0LzB4YjA8YnI+CgpbwqDCoCA3MC4yNzczMjVdIFtkYzcxZWMy
MF0gW2MwMDE3NmU0XSBmdHJhY2VfZ3JhcGhfY2FsbGVyKzB4MTAvMHg1NDxicj5bwqDCoCA3MC4z
NDgyMDBdIFtkYzcxZWM1MF0gW2MwMDE3NzI4XSByZXR1cm5fdG9faGFuZGxlcisweDAvMHgzNCAo
dHJhY2VfZ3JhcGhfZW50cnkrMHhhNC8weDE2Yyk8YnI+W8KgwqAgNzAuNDQ4MjY0XSBbZGM3MWVj
NzBdIFtjMDAxYWM4MF0gcHJlcGFyZV9mdHJhY2VfcmV0dXJuKzB4NzQvMHhiMDxicj4KClvCoMKg
IDcwLjUyMTIyM10gW2RjNzFlY2EwXSBbYzAwMTc2ZTRdIGZ0cmFjZV9ncmFwaF9jYWxsZXIrMHgx
MC8weDU0PGJyPlvCoMKgIDcwLjU5MjEwM10gW2RjNzFlY2QwXSBbYzAwMTc3MjhdIHJldHVybl90
b19oYW5kbGVyKzB4MC8weDM0ICh0cmFjZV9ncmFwaF9lbnRyeSsweGE0LzB4MTZjKTxicj5bwqDC
oCA3MC42OTIxNjhdIFtkYzcxZWNmMF0gW2MwMDFhYzgwXSBwcmVwYXJlX2Z0cmFjZV9yZXR1cm4r
MHg3NC8weGIwPGJyPgoKW8KgwqAgNzAuNzY1MTI2XSBbZGM3MWVkMjBdIFtjMDAxNzZlNF0gZnRy
YWNlX2dyYXBoX2NhbGxlcisweDEwLzB4NTQ8YnI+W8KgwqAgNzAuODM2MDAxXSBbZGM3MWVkNTBd
IFtjMDAxNzcyOF0gcmV0dXJuX3RvX2hhbmRsZXIrMHgwLzB4MzQgKHRyYWNlX2dyYXBoX2VudHJ5
KzB4YTQvMHgxNmMpPGJyPlvCoMKgIDcwLjkzNjA2NF0gW2RjNzFlZDcwXSBbYzAwMWFjODBdIHBy
ZXBhcmVfZnRyYWNlX3JldHVybisweDc0LzB4YjA8YnI+CgpbwqDCoCA3MS4wMDkwMjRdIFtkYzcx
ZWRhMF0gW2MwMDE3NmU0XSBmdHJhY2VfZ3JhcGhfY2FsbGVyKzB4MTAvMHg1NDxicj5bwqDCoCA3
MS4wNzk5MDRdIFtkYzcxZWRkMF0gW2MwMDE3NzI4XSByZXR1cm5fdG9faGFuZGxlcisweDAvMHgz
NCAodHJhY2VfZ3JhcGhfZW50cnkrMHhhNC8weDE2Yyk8YnI+W8KgwqAgNzEuMTc5OTY5XSBbZGM3
MWVkZjBdIFtjMDAxYWM4MF0gcHJlcGFyZV9mdHJhY2VfcmV0dXJuKzB4NzQvMHhiMDxicj4KClvC
oMKgIDcxLjI1MjkyN10gW2RjNzFlZTIwXSBbYzAwMTc2ZTRdIGZ0cmFjZV9ncmFwaF9jYWxsZXIr
MHgxMC8weDU0PGJyPlvCoMKgIDcxLjMyMzgwMl0gW2RjNzFlZTUwXSBbYzAwMTc3MjhdIHJldHVy
bl90b19oYW5kbGVyKzB4MC8weDM0ICh0cmFjZV9ncmFwaF9lbnRyeSsweGE0LzB4MTZjKTxicj5b
wqDCoCA3MS40MjM4NjVdIFtkYzcxZWU3MF0gW2MwMDFhYzgwXSBwcmVwYXJlX2Z0cmFjZV9yZXR1
cm4rMHg3NC8weGIwPGJyPgoKW8KgwqAgNzEuNDk2ODI1XSBbZGM3MWVlYTBdIFtjMDAxNzZlNF0g
ZnRyYWNlX2dyYXBoX2NhbGxlcisweDEwLzB4NTQ8YnI+W8KgwqAgNzEuNTY3NzA0XSBbZGM3MWVl
ZDBdIFtjMDAxNzcyOF0gcmV0dXJuX3RvX2hhbmRsZXIrMHgwLzB4MzQgKHRyYWNlX2dyYXBoX2Vu
dHJ5KzB4YTQvMHgxNmMpPGJyPlvCoMKgIDcxLjY2Nzc2OV0gW2RjNzFlZWYwXSBbYzAwMWFjODBd
IHByZXBhcmVfZnRyYWNlX3JldHVybisweDc0LzB4YjA8YnI+CgpbwqDCoCA3MS43NDA3MjhdIFtk
YzcxZWYyMF0gW2MwMDE3NmU0XSBmdHJhY2VfZ3JhcGhfY2FsbGVyKzB4MTAvMHg1NDxicj5bwqDC
oCA3MS44MTE2MDJdIFtkYzcxZWY1MF0gW2MwMDE3NzI4XSByZXR1cm5fdG9faGFuZGxlcisweDAv
MHgzNCAodHJhY2VfZ3JhcGhfZW50cnkrMHhhNC8weDE2Yyk8YnI+W8KgwqAgNzEuOTExNjY2XSBb
ZGM3MWVmNzBdIFtjMDAxYWM4MF0gcHJlcGFyZV9mdHJhY2VfcmV0dXJuKzB4NzQvMHhiMDxicj4K
ClvCoMKgIDcxLjk4NDYyNV0gW2RjNzFlZmEwXSBbYzAwMTc2ZTRdIGZ0cmFjZV9ncmFwaF9jYWxs
ZXIrMHgxMC8weDU0PGJyPlvCoMKgIDcyLjA1NTQ5OV0gW2RjNzFlZmQwXSBbYzAwMTc3MjhdIHJl
dHVybl90b19oYW5kbGVyKzB4MC8weDM0ICh0cmFjZV9ncmFwaF9lbnRyeSsweGE0LzB4MTZjKTxi
cj5bwqDCoCA3Mi4xNTU1NjRdIFtkYzcxZWZmMF0gW2MwMDFhYzgwXSBwcmVwYXJlX2Z0cmFjZV9y
ZXR1cm4rMHg3NC8weGIwPGJyPgoKW8KgwqAgNzIuMjI4NTIyXSBbZGM3MWYwMjBdIFtjMDAxNzZl
NF0gZnRyYWNlX2dyYXBoX2NhbGxlcisweDEwLzB4NTQ8YnI+W8KgwqAgNzIuMjk5Mzk3XSBbZGM3
MWYwNTBdIFtjMDAxNzcyOF0gcmV0dXJuX3RvX2hhbmRsZXIrMHgwLzB4MzQgKHRyYWNlX2dyYXBo
X2VudHJ5KzB4YTQvMHgxNmMpPGJyPlvCoMKgIDcyLjM5OTQ1Nl0gSW5zdHJ1Y3Rpb24gZHVtcDo8
YnI+W8KgwqAgNzIuNDM0OTExXSA0ZTgwMDAyMCA3YzA4MDJhNiA5MDAxMDAwNCA0YmY4YjJiZCA5
NDIxZmZjMCA3YzA4MDJhNiA5MDAxMDA0NCBiZWExMDAxNDxicj4KClvCoMKgIDcyLjUyNzc4Ml0g
N2MzZjBiNzggN2M3ZTFiNzggN2M5NjIzNzggNGJmZmMyMGQgJmx0OzJmODMwMDAwJmd0OyAzZjIw
YzA0MiAzYjM5MmQ5OCAzODE5MDAwODxicj5bwqDCoCA3Mi42MjI3NDJdIEktcGlwZSB0cmFjZXIg
bG9nICgxMDAgcG9pbnRzKTo8YnI+W8KgwqAgNzIuNjcyNzY2XcKgwqDCoMKgwqAgK2Z1bmPCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwIGlwaXBlX3RyYWNlX3BhbmljX2Zy
ZWV6ZSsweDggKG9vcHNfZW50ZXIrMHgyOCk8YnI+CgpbwqDCoCA3Mi43NzE5MjddwqDCoMKgwqDC
oCArZnVuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDAgb29wc19lbnRl
cisweDggKGRpZSsweDMwKTxicj5bwqDCoCA3Mi44NDkyMDBdwqDCoMKgwqDCoCArZnVuY8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDAgZGllKzB4OCAoX2V4Y2VwdGlvbisw
eGE0KTxicj5bwqDCoCA3Mi45MjY0NzNdwqDCoMKgwqDCoCArZnVuY8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIDAgX2V4Y2VwdGlvbisweDggKHByb2dyYW1fY2hlY2tfZXhj
ZXB0aW9uKzB4MWU4KTxicj4KClvCoMKgIDczLjAyNTYyN13CoCB8wqDCoCArZW5kwqDCoMKgwqAg
MHg4MDAwMDAwMMKgwqDCoMKgwqAgMCBfX2lwaXBlX3Vuc3RhbGxfcm9vdCsweGE4ICh2cHJpbnRr
KzB4MzQ4KTxicj5bwqDCoCA3My4xMTk1NjddwqAgfMKgwqAgI2Z1bmPCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwIGlwaXBlX2NoZWNrX2NvbnRleHQrMHg4IChfX2lwaXBl
X3Vuc3RhbGxfcm9vdCsweDNjKTxicj5bwqDCoCA3My4yMjM5MTZdwqAgfMKgwqAgI2JlZ2luwqDC
oCAweDgwMDAwMDAwwqDCoMKgwqDCoCAwIF9faXBpcGVfdW5zdGFsbF9yb290KzB4YmMgKHZwcmlu
dGsrMHgzNDgpPGJyPgoKW8KgwqAgNzMuMzE3ODQ4XcKgwqDCoMKgwqAgI2Z1bmPCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwIF9faXBpcGVfdW5zdGFsbF9yb290KzB4OCAo
dnByaW50aysweDM0OCk8YnI+W8KgwqAgNzMuNDEwNzQ1XcKgIHzCoMKgICNlbmTCoMKgwqDCoCAw
eDgwMDAwMDAxwqDCoMKgwqDCoCAwIGlwaXBlX2NoZWNrX2NvbnRleHQrMHhkYyAodnByaW50aysw
eDM0NCk8YnI+W8KgwqAgNzMuNTAzNjQzXcKgIHzCoMKgICNiZWdpbsKgwqAgMHg4MDAwMDAwMcKg
wqDCoMKgwqAgMCBpcGlwZV9jaGVja19jb250ZXh0KzB4ZjAgKHZwcmludGsrMHgzNDQpPGJyPgoK
W8KgwqAgNzMuNTk2NTM1XcKgwqDCoMKgwqAgI2Z1bmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAwIGlwaXBlX2NoZWNrX2NvbnRleHQrMHg4ICh2cHJpbnRrKzB4MzQ0KTxi
cj5bwqDCoCA3My42ODgzOTFdwqDCoMKgwqDCoCAjZnVuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIDAgX3Jhd19zcGluX3VubG9ja19pcnFyZXN0b3JlKzB4OCAocmVsZWFz
ZV9jb25zb2xlX3NlbSsweDExYyk8YnI+W8KgwqAgNzMuODAxMDc5XcKgwqDCoMKgwqAgI2Z1bmPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwIF9faXBpcGVfc3Bpbl91bmxv
Y2tfZGVidWcrMHg4IChyZWxlYXNlX2NvbnNvbGVfc2VtKzB4MTEwKTxicj4KClvCoMKgIDczLjkx
MTY5MV3CoMKgwqDCoMKgICNmdW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgMCBfcmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUrMHg4ICh1cCsweDY4KTxicj5bwqDCoCA3
NC4wMDU2MzZdwqDCoMKgwqDCoCAjZnVuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIDAgX19pcGlwZV9zcGluX3VubG9ja19kZWJ1ZysweDggKHVwKzB4NWMpPGJyPlvCoMKg
IDc0LjA5NzQ5Ml3CoCB8wqDCoCAjZW5kwqDCoMKgwqAgMHg4MDAwMDAwMcKgwqDCoMKgwqAgMCBf
X2lwaXBlX3Rlc3RfYW5kX3N0YWxsX3Jvb3QrMHhhOCAoX3Jhd19zcGluX2xvY2tfaXJxc2F2ZSsw
eDI4KTxicj4KClvCoMKgIDc0LjIxMzMxOF3CoCB8wqDCoCAjYmVnaW7CoMKgIDB4ODAwMDAwMDHC
oMKgwqDCoMKgIDAgX19pcGlwZV90ZXN0X2FuZF9zdGFsbF9yb290KzB4YjggKF9yYXdfc3Bpbl9s
b2NrX2lycXNhdmUrMHgyOCk8YnI+W8KgwqAgNzQuMzI5MTQ0XcKgwqDCoMKgwqAgI2Z1bmPCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwIF9faXBpcGVfdGVzdF9hbmRfc3Rh
bGxfcm9vdCsweDggKF9yYXdfc3Bpbl9sb2NrX2lycXNhdmUrMHgyOCk8YnI+CgpbwqDCoCA3NC40
NDM5MjJdwqDCoMKgwqDCoCAjZnVuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIDAgX3Jhd19zcGluX2xvY2tfaXJxc2F2ZSsweDggKHVwKzB4MjgpPGJyPlvCoMKgIDc0LjUz
MjY1M13CoMKgwqDCoMKgICNmdW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IC0xIHVwKzB4OCAocmVsZWFzZV9jb25zb2xlX3NlbSsweDEwOCk8YnI+W8KgwqAgNzQuNjE5MzAx
XcKgIHzCoMKgICNlbmTCoMKgwqDCoCAweDgwMDAwMDAxwqDCoMKgwqAgLTEgX19pcGlwZV90ZXN0
X2FuZF9zdGFsbF9yb290KzB4YTggKF9yYXdfc3Bpbl9sb2NrX2lycXNhdmUrMHgyOCk8YnI+Cgpb
wqDCoCA3NC43MzUxMjFdwqAgfMKgwqAgI2JlZ2luwqDCoCAweDgwMDAwMDAxwqDCoMKgwqAgLTEg
X19pcGlwZV90ZXN0X2FuZF9zdGFsbF9yb290KzB4YjggKF9yYXdfc3Bpbl9sb2NrX2lycXNhdmUr
MHgyOCk8YnI+W8KgwqAgNzQuODUwOTQwXcKgwqDCoMKgwqAgI2Z1bmPCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgLTEgX19pcGlwZV90ZXN0X2FuZF9zdGFsbF9yb290KzB4OCAo
X3Jhd19zcGluX2xvY2tfaXJxc2F2ZSsweDI4KTxicj4KClvCoMKgIDc0Ljk2NTcxOF3CoMKgwqDC
oMKgICNmdW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0xIF9yYXdfc3Bp
bl9sb2NrX2lycXNhdmUrMHg4IChyZWxlYXNlX2NvbnNvbGVfc2VtKzB4NjApPGJyPlvCoMKgIDc1
LjA3MjE1N13CoMKgwqDCoMKgICNmdW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIC0xIF9jYWxsX2NvbnNvbGVfZHJpdmVycysweDggKHJlbGVhc2VfY29uc29sZV9zZW0rMHhi
Yyk8YnI+W8KgwqAgNzUuMTc3NTUzXcKgwqDCoMKgwqAgI2Z1bmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgLTEgbWVtX3NlcmlhbF9vdXQrMHg4IChzZXJpYWw4MjUwX2NvbnNv
bGVfd3JpdGUrMHhmYyk8YnI+CgpbwqDCoCA3NS4yODA4ODBdwqDCoMKgwqDCoCAjZnVuY8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtMSBtZW1fc2VyaWFsX2luKzB4OCAod2Fp
dF9mb3JfeG1pdHIrMHg2NCk8YnI+W8KgwqAgNzUuMzcyNzM2XcKgwqDCoMKgwqAgI2Z1bmPCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLTEgbWVtX3NlcmlhbF9pbisweDggKHdh
aXRfZm9yX3htaXRyKzB4NjQpPGJyPlvCoMKgIDc1LjQ2NDU5M13CoMKgwqDCoMKgICNmdW5jwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0xIG1lbV9zZXJpYWxfaW4rMHg4ICh3
YWl0X2Zvcl94bWl0cisweDY0KTxicj4KClvCoMKgIDc1LjU1NjQ0OF3CoMKgwqDCoMKgICNmdW5j
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0xIG1lbV9zZXJpYWxfaW4rMHg4
ICh3YWl0X2Zvcl94bWl0cisweDY0KTxicj5bwqDCoCA3NS42NDgzMDRdwqDCoMKgwqDCoCAjZnVu
Y8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtMSBtZW1fc2VyaWFsX2luKzB4
OCAod2FpdF9mb3JfeG1pdHIrMHg2NCk8YnI+W8KgwqAgNzUuNzQwMTYxXcKgwqDCoMKgwqAgI2Z1
bmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLTEgbWVtX3NlcmlhbF9pbisw
eDggKHdhaXRfZm9yX3htaXRyKzB4NjQpPGJyPgoKW8KgwqAgNzUuODMyMDExXcKgwqDCoMKgwqAg
I2Z1bmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLTIgbWVtX3NlcmlhbF9p
bisweDggKHdhaXRfZm9yX3htaXRyKzB4NjQpPGJyPlvCoMKgIDc1LjkyMzg2Nl3CoMKgwqDCoMKg
ICNmdW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0yIG1lbV9zZXJpYWxf
aW4rMHg4ICh3YWl0X2Zvcl94bWl0cisweDY0KTxicj5bwqDCoCA3Ni4wMTU3MjJdwqDCoMKgwqDC
oCAjZnVuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtMiBtZW1fc2VyaWFs
X2luKzB4OCAod2FpdF9mb3JfeG1pdHIrMHg2NCk8YnI+CgpbwqDCoCA3Ni4xMDc1NzJdwqDCoMKg
wqDCoCAjZnVuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtMiBtZW1fc2Vy
aWFsX2luKzB4OCAod2FpdF9mb3JfeG1pdHIrMHg2NCk8YnI+W8KgwqAgNzYuMTk5NDI4XcKgwqDC
oMKgwqAgI2Z1bmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLTIgbWVtX3Nl
cmlhbF9pbisweDggKHdhaXRfZm9yX3htaXRyKzB4NjQpPGJyPlvCoMKgIDc2LjI5MTI4NF3CoMKg
wqDCoMKgICNmdW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0yIG1lbV9z
ZXJpYWxfaW4rMHg4ICh3YWl0X2Zvcl94bWl0cisweDY0KTxicj4KClvCoMKgIDc2LjM4MzEzNF3C
oMKgwqDCoMKgICNmdW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0yIG1l
bV9zZXJpYWxfaW4rMHg4ICh3YWl0X2Zvcl94bWl0cisweDY0KTxicj5bwqDCoCA3Ni40NzQ5ODld
wqDCoMKgwqDCoCAjZnVuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtMiBt
ZW1fc2VyaWFsX2luKzB4OCAod2FpdF9mb3JfeG1pdHIrMHg2NCk8YnI+W8KgwqAgNzYuNTY2ODQ2
XcKgwqDCoMKgwqAgI2Z1bmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLTMg
bWVtX3NlcmlhbF9pbisweDggKHdhaXRfZm9yX3htaXRyKzB4NjQpPGJyPgoKW8KgwqAgNzYuNjU4
NzAyXcKgwqDCoMKgwqAgI2Z1bmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
LTMgbWVtX3NlcmlhbF9pbisweDggKHdhaXRfZm9yX3htaXRyKzB4NjQpPGJyPlvCoMKgIDc2Ljc1
MDU1Ml3CoMKgwqDCoMKgICNmdW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IC0zIG1lbV9zZXJpYWxfaW4rMHg4ICh3YWl0X2Zvcl94bWl0cisweDY0KTxicj5bwqDCoCA3Ni44
NDI0MDddwqDCoMKgwqDCoCAjZnVuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAtMyBtZW1fc2VyaWFsX2luKzB4OCAod2FpdF9mb3JfeG1pdHIrMHg2NCk8YnI+CgpbwqDCoCA3
Ni45MzQyNjRdwqDCoMKgwqDCoCAjZnVuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAtMyBtZW1fc2VyaWFsX2luKzB4OCAod2FpdF9mb3JfeG1pdHIrMHg2NCk8YnI+W8KgwqAg
NzcuMDI2MTE0XcKgwqDCoMKgwqAgI2Z1bmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgLTMgbWVtX3NlcmlhbF9pbisweDggKHdhaXRfZm9yX3htaXRyKzB4NjQpPGJyPlvCoMKg
IDc3LjExNzk2OV3CoMKgwqDCoMKgICNmdW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIC0zIG1lbV9zZXJpYWxfaW4rMHg4ICh3YWl0X2Zvcl94bWl0cisweDY0KTxicj4KClvC
oMKgIDc3LjIwOTgyNV3CoMKgwqDCoMKgICNmdW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIC0zIG1lbV9zZXJpYWxfaW4rMHg4ICh3YWl0X2Zvcl94bWl0cisweDY0KTxicj5b
wqDCoCA3Ny4zMDE2ODJdwqDCoMKgwqDCoCAjZnVuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAtMyBtZW1fc2VyaWFsX2luKzB4OCAod2FpdF9mb3JfeG1pdHIrMHg2NCk8YnI+
W8KgwqAgNzcuMzkzNTMyXcKgwqDCoMKgwqAgI2Z1bmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgLTQgbWVtX3NlcmlhbF9pbisweDggKHdhaXRfZm9yX3htaXRyKzB4NjQpPGJy
PgoKW8KgwqAgNzcuNDg1Mzg3XcKgwqDCoMKgwqAgI2Z1bmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgLTQgbWVtX3NlcmlhbF9pbisweDggKHdhaXRfZm9yX3htaXRyKzB4NjQp
PGJyPlvCoMKgIDc3LjU3NzI0M13CoMKgwqDCoMKgICNmdW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC00IG1lbV9zZXJpYWxfaW4rMHg4ICh3YWl0X2Zvcl94bWl0cisweDY0
KTxicj5bwqDCoCA3Ny42NjkwOTRdwqDCoMKgwqDCoCAjZnVuY8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAtNCBtZW1fc2VyaWFsX2luKzB4OCAod2FpdF9mb3JfeG1pdHIrMHg2
NCk8YnI+CgpbwqDCoCA3Ny43NjA5NDldwqDCoMKgwqDCoCAjZnVuY8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAtNCBtZW1fc2VyaWFsX2luKzB4OCAod2FpdF9mb3JfeG1pdHIr
MHg2NCk8YnI+W8KgwqAgNzcuODUyODA1XcKgwqDCoMKgwqAgI2Z1bmPCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgLTQgbWVtX3NlcmlhbF9pbisweDggKHdhaXRfZm9yX3htaXRy
KzB4NjQpPGJyPlvCoMKgIDc3Ljk0NDY1NV3CoMKgwqDCoMKgICNmdW5jwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIC00IG1lbV9zZXJpYWxfaW4rMHg4ICh3YWl0X2Zvcl94bWl0
cisweDY0KTxicj4KClvCoMKgIDc4LjAzNjUxMV3CoMKgwqDCoMKgICNmdW5jwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC00IG1lbV9zZXJpYWxfaW4rMHg4ICh3YWl0X2Zvcl94
bWl0cisweDY0KTxicj5bwqDCoCA3OC4xMjgzNjddwqDCoMKgwqDCoCAjZnVuY8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtNCBtZW1fc2VyaWFsX2luKzB4OCAod2FpdF9mb3Jf
eG1pdHIrMHg2NCk8YnI+W8KgwqAgNzguMjIwMjE3XcKgwqDCoMKgwqAgI2Z1bmPCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLTUgbWVtX3NlcmlhbF9pbisweDggKHdhaXRfZm9y
X3htaXRyKzB4NjQpPGJyPgoKW8KgwqAgNzguMzEyMDcyXcKgwqDCoMKgwqAgI2Z1bmPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLTUgbWVtX3NlcmlhbF9pbisweDggKHdhaXRf
Zm9yX3htaXRyKzB4NjQpPGJyPlvCoMKgIDc4LjQwMzkyOV3CoMKgwqDCoMKgICNmdW5jwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC01IG1lbV9zZXJpYWxfaW4rMHg4ICh3YWl0
X2Zvcl94bWl0cisweDY0KTxicj5bwqDCoCA3OC40OTU3ODVdwqDCoMKgwqDCoCAjZnVuY8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtNSBtZW1fc2VyaWFsX2luKzB4OCAod2Fp
dF9mb3JfeG1pdHIrMHg2NCk8YnI+CgpbwqDCoCA3OC41ODc2NDFdwqDCoMKgwqDCoCAjZnVuY8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtNSBtZW1fc2VyaWFsX2luKzB4OCAo
d2FpdF9mb3JfeG1pdHIrMHg2NCk8YnI+W8KgwqAgNzguNjc5NDk3XcKgwqDCoMKgwqAgI2Z1bmPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLTUgbWVtX3NlcmlhbF9pbisweDgg
KHdhaXRfZm9yX3htaXRyKzB4NjQpPGJyPlvCoMKgIDc4Ljc3MTM0N13CoMKgwqDCoMKgICNmdW5j
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC01IG1lbV9zZXJpYWxfaW4rMHg4
ICh3YWl0X2Zvcl94bWl0cisweDY0KTxicj4KClvCoMKgIDc4Ljg2MzE5N13CoMKgwqDCoMKgICNm
dW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC01IG1lbV9zZXJpYWxfaW4r
MHg4ICh3YWl0X2Zvcl94bWl0cisweDY0KTxicj5bwqDCoCA3OC45NTUwNTJdwqDCoMKgwqDCoCAj
ZnVuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtNSBtZW1fc2VyaWFsX2lu
KzB4OCAod2FpdF9mb3JfeG1pdHIrMHg2NCk8YnI+W8KgwqAgNzkuMDQ2OTA4XcKgwqDCoMKgwqAg
I2Z1bmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLTYgbWVtX3NlcmlhbF9p
bisweDggKHdhaXRfZm9yX3htaXRyKzB4NjQpPGJyPgoKW8KgwqAgNzkuMTM4NzY1XcKgwqDCoMKg
wqAgI2Z1bmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLTYgbWVtX3Nlcmlh
bF9pbisweDggKHdhaXRfZm9yX3htaXRyKzB4NjQpPGJyPlvCoMKgIDc5LjIzMDYxNV3CoMKgwqDC
oMKgICNmdW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC02IG1lbV9zZXJp
YWxfaW4rMHg4ICh3YWl0X2Zvcl94bWl0cisweDY0KTxicj5bwqDCoCA3OS4zMjI0NzBdwqDCoMKg
wqDCoCAjZnVuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtNiBtZW1fc2Vy
aWFsX2luKzB4OCAod2FpdF9mb3JfeG1pdHIrMHg2NCk8YnI+CgpbwqDCoCA3OS40MTQzMjZdwqDC
oMKgwqDCoCAjZnVuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtNiBtZW1f
c2VyaWFsX2luKzB4OCAod2FpdF9mb3JfeG1pdHIrMHg2NCk8YnI+W8KgwqAgNzkuNTA2MTc2XcKg
wqDCoMKgwqAgI2Z1bmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLTYgbWVt
X3NlcmlhbF9pbisweDggKHdhaXRfZm9yX3htaXRyKzB4NjQpPGJyPlvCoMKgIDc5LjU5ODAzMl3C
oMKgwqDCoMKgICNmdW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC02IG1l
bV9zZXJpYWxfaW4rMHg4ICh3YWl0X2Zvcl94bWl0cisweDY0KTxicj4KClvCoMKgIDc5LjY4OTg4
Ml3CoMKgwqDCoMKgICNmdW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC02
IG1lbV9zZXJpYWxfaW4rMHg4ICh3YWl0X2Zvcl94bWl0cisweDY0KTxicj5bwqDCoCA3OS43ODE3
MzJdwqDCoMKgwqDCoCAjZnVuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAt
NiBtZW1fc2VyaWFsX2luKzB4OCAod2FpdF9mb3JfeG1pdHIrMHg2NCk8YnI+W8KgwqAgNzkuODcz
NTg3XcKgwqDCoMKgwqAgI2Z1bmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
LTcgbWVtX3NlcmlhbF9pbisweDggKHdhaXRfZm9yX3htaXRyKzB4NjQpPGJyPgoKW8KgwqAgNzku
OTY1NDM3XcKgwqDCoMKgwqAgI2Z1bmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLTcgbWVtX3NlcmlhbF9pbisweDggKHdhaXRfZm9yX3htaXRyKzB4NjQpPGJyPlvCoMKgIDgw
LjA1NzI4N13CoMKgwqDCoMKgICNmdW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIC03IG1lbV9zZXJpYWxfaW4rMHg4ICh3YWl0X2Zvcl94bWl0cisweDY0KTxicj5bwqDCoCA4
MC4xNDkxNDJdwqDCoMKgwqDCoCAjZnVuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAtNyBtZW1fc2VyaWFsX2luKzB4OCAod2FpdF9mb3JfeG1pdHIrMHg2NCk8YnI+CgpbwqDC
oCA4MC4yNDA5OTldwqDCoMKgwqDCoCAjZnVuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAtNyBtZW1fc2VyaWFsX2luKzB4OCAod2FpdF9mb3JfeG1pdHIrMHg2NCk8YnI+W8Kg
wqAgODAuMzMyODU1XcKgwqDCoMKgwqAgI2Z1bmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgLTcgbWVtX3NlcmlhbF9pbisweDggKHdhaXRfZm9yX3htaXRyKzB4NjQpPGJyPlvC
oMKgIDgwLjQyNDcwNV3CoMKgwqDCoMKgICNmdW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIC03IG1lbV9zZXJpYWxfaW4rMHg4ICh3YWl0X2Zvcl94bWl0cisweDY0KTxicj4K
ClvCoMKgIDgwLjUxNjU2MF3CoMKgwqDCoMKgICNmdW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIC03IG1lbV9zZXJpYWxfaW4rMHg4ICh3YWl0X2Zvcl94bWl0cisweDY0KTxi
cj5bwqDCoCA4MC42MDg0MTddwqDCoMKgwqDCoCAjZnVuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAtNyBtZW1fc2VyaWFsX2luKzB4OCAod2FpdF9mb3JfeG1pdHIrMHg2NCk8
YnI+W8KgwqAgODAuNzAwMjczXcKgwqDCoMKgwqAgI2Z1bmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgLTggbWVtX3NlcmlhbF9pbisweDggKHdhaXRfZm9yX3htaXRyKzB4NjQp
PGJyPgoKW8KgwqAgODAuNzkyMTIzXcKgwqDCoMKgwqAgI2Z1bmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgLTggbWVtX3NlcmlhbF9pbisweDggKHdhaXRfZm9yX3htaXRyKzB4
NjQpPGJyPlvCoMKgIDgwLjg4Mzk3OF3CoMKgwqDCoMKgICNmdW5jwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC04IG1lbV9zZXJpYWxfaW4rMHg4ICh3YWl0X2Zvcl94bWl0cisw
eDY0KTxicj5bwqDCoCA4MC45NzU4MzVdwqDCoMKgwqDCoCAjZnVuY8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAtOCBtZW1fc2VyaWFsX2luKzB4OCAod2FpdF9mb3JfeG1pdHIr
MHg2NCk8YnI+CgpbwqDCoCA4MS4wNjc2ODVdwqDCoMKgwqDCoCAjZnVuY8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtOCBtZW1fc2VyaWFsX2luKzB4OCAod2FpdF9mb3JfeG1p
dHIrMHg2NCk8YnI+W8KgwqAgODEuMTU5NTQwXcKgwqDCoMKgwqAgI2Z1bmPCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLTggbWVtX3NlcmlhbF9pbisweDggKHdhaXRfZm9yX3ht
aXRyKzB4NjQpPGJyPlvCoMKgIDgxLjI1MTM5Nl3CoMKgwqDCoMKgICNmdW5jwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC04IG1lbV9zZXJpYWxfaW4rMHg4ICh3YWl0X2Zvcl94
bWl0cisweDY0KTxicj4KClvCoMKgIDgxLjM0MzI0Nl3CoMKgwqDCoMKgICNmdW5jwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC04IG1lbV9zZXJpYWxfaW4rMHg4ICh3YWl0X2Zv
cl94bWl0cisweDY0KTxicj5bwqDCoCA4MS40MzUxMDFdwqDCoMKgwqDCoCAjZnVuY8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtOCBtZW1fc2VyaWFsX2luKzB4OCAod2FpdF9m
b3JfeG1pdHIrMHg2NCk8YnI+W8KgwqAgODEuNTI2OTU4XcKgwqDCoMKgwqAgI2Z1bmPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLTkgbWVtX3NlcmlhbF9pbisweDggKHdhaXRf
Zm9yX3htaXRyKzB4NjQpPGJyPgoKW8KgwqAgODEuNjE4ODE0XcKgwqDCoMKgwqAgI2Z1bmPCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLTkgbWVtX3NlcmlhbF9pbisweDggKHdh
aXRfZm9yX3htaXRyKzB4NjQpPGJyPlvCoMKgIDgxLjcxMDY2NF3CoMKgwqDCoMKgICNmdW5jwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC05IG1lbV9zZXJpYWxfaW4rMHg4ICh3
YWl0X2Zvcl94bWl0cisweDY0KTxicj5bwqDCoCA4MS44MDI1MjBdwqDCoMKgwqDCoCAjZnVuY8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtOSBtZW1fc2VyaWFsX2luKzB4OCAo
d2FpdF9mb3JfeG1pdHIrMHg2NCk8YnI+CgpbwqDCoCA4MS44OTQzNzZdwqDCoMKgwqDCoCAjZnVu
Y8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtOSBtZW1fc2VyaWFsX2luKzB4
OCAod2FpdF9mb3JfeG1pdHIrMHg2NCk8YnI+W8KgwqAgODEuOTg2MjI2XcKgwqDCoMKgwqAgI2Z1
bmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLTkgbWVtX3NlcmlhbF9pbisw
eDggKHdhaXRfZm9yX3htaXRyKzB4NjQpPGJyPlvCoMKgIDgyLjA3ODEwM10gS2VybmVsIHBhbmlj
IC0gbm90IHN5bmNpbmc6IEZhdGFsIGV4Y2VwdGlvbiBpbiBpbnRlcnJ1cHQ8YnI+CgpbwqDCoCA4
Mi4xNTQxNzJdIENhbGwgVHJhY2U6PGJyPlvCoMKgIDgyLjE4MzM2OV0gW2RjNzFlMjMwXSBbYzAw
MDlkM2NdIHNob3dfc3RhY2srMHgxMDgvMHgxYzAgKHVucmVsaWFibGUpPGJyPlvCoMKgIDgyLjI2
MDUyNF0gW2RjNzFlMjgwXSBbYzAzNDBhZjRdIGR1bXBfc3RhY2srMHgyYy8weDQ0PGJyPlvCoMKg
IDgyLjMyMjAzMF0gW2RjNzFlMjkwXSBbYzAzNDBiYzRdIHBhbmljKzB4YjgvMHgxMzg8YnI+Cgpb
wqDCoCA4Mi4zNzkzNjNdIFtkYzcxZTJlMF0gW2MwMDExMTg0XSBkaWUrMHgxM2MvMHgxZmM8YnI+
W8KgwqAgODIuNDM1NjU1XSBbZGM3MWUzMTBdIFtjMDAxMTM1NF0gX2V4Y2VwdGlvbisweGE0LzB4
MTE4PGJyPlvCoMKgIDgyLjQ5ODE5N10gW2RjNzFlNDAwXSBbYzAwMTI5ZThdIHByb2dyYW1fY2hl
Y2tfZXhjZXB0aW9uKzB4MWU4LzB4Nzc0PGJyPlvCoMKgIDgyLjU3NTMyOV0gW2RjNzFlNDUwXSBb
YzAwMTc3MjhdIHJldHVybl90b19oYW5kbGVyKzB4MC8weDM0IChyZXRfZnJvbV9leGNlcHRfZnVs
bCsweDAvMHg0Yyk8YnI+CgpbwqDCoCA4Mi42NzY0NDVdIC0tLSBFeGNlcHRpb246IDcwMCBhdCBf
X2lwaXBlX2Rpc3BhdGNoX3dpcmVkX25vY2hlY2srMHgyYy8weDI2Yzxicj5bwqDCoCA4Mi42NzY0
NjJdwqDCoMKgwqAgTFIgPSBfX2lwaXBlX2Rpc3BhdGNoX3dpcmVkX25vY2hlY2srMHgyYy8weDI2
Yzxicj5bwqDCoCA4Mi44Mjk2MjNdIFtkYzcxZTU1MF0gW2MwMDE3NzI4XSByZXR1cm5fdG9faGFu
ZGxlcisweDAvMHgzNCAoX19pcGlwZV9ncmFiX3RpbWVyKzB4MTM4LzB4MWEwKTxicj4KClvCoMKg
IDgyLjkzMTc3Nl0gW2RjNzFlNTgwXSBbYzAwMTc3MjhdIHJldHVybl90b19oYW5kbGVyKzB4MC8w
eDM0IChfX2lwaXBlX3JldF9mcm9tX2V4Y2VwdCsweDAvMHhjKTxicj5bwqDCoCA4My4wMzQ5NzZd
IC0tLSBFeGNlcHRpb246IDkwMSBhdCBfX2lwaXBlX3Vuc3RhbGxfcm9vdCsweGFjLzB4MTAwPGJy
PlvCoMKgIDgzLjAzNDk5MV3CoMKgwqDCoCBMUiA9IF9faXBpcGVfdW5zdGFsbF9yb290KzB4YTgv
MHgxMDA8YnI+CgpbwqDCoCA4My4xNjczMTZdIFtkYzcxZTY2MF0gW2MwMDE3NzI4XSByZXR1cm5f
dG9faGFuZGxlcisweDAvMHgzNCAodHJhY2VfZ3JhcGhfcmV0dXJuKzB4YmMvMHhkNCk8YnI+W8Kg
wqAgODMuMjY3Mzg2XSBbZGM3MWU2ODBdIFtjMDBhNWY2NF0gZnRyYWNlX3JldHVybl90b19oYW5k
bGVyKzB4NzQvMHhkNDxicj5bwqDCoCA4My4zNDM0ODNdIFtkYzcxZTZiMF0gW2MwMDE3NzQwXSBy
ZXR1cm5fdG9faGFuZGxlcisweDE4LzB4MzQ8YnI+CgpbwqDCoCA4My40MTIyODZdIFtkYzcxZTZk
MF0gW2MwMDE3NzI4XSByZXR1cm5fdG9faGFuZGxlcisweDAvMHgzNCAodHJhY2VfZ3JhcGhfZW50
cnkrMHgxNDQvMHgxNmMpPGJyPlvCoMKgIDgzLjUxMzM5OV0gW2RjNzFlNmYwXSBbYzAwMWFjODBd
IHByZXBhcmVfZnRyYWNlX3JldHVybisweDc0LzB4YjA8YnI+W8KgwqAgODMuNTg2MzcxXSBbZGM3
MWU3MjBdIFtjMDAxNzZlNF0gZnRyYWNlX2dyYXBoX2NhbGxlcisweDEwLzB4NTQ8YnI+CgpbwqDC
oCA4My42NTcyNThdIFtkYzcxZTc1MF0gW2MwMDE3NzI4XSByZXR1cm5fdG9faGFuZGxlcisweDAv
MHgzNCAodHJhY2VfZ3JhcGhfZW50cnkrMHhhNC8weDE2Yyk8YnI+W8KgwqAgODMuNzU3MzI5XSBb
ZGM3MWU3NzBdIFtjMDAxYWM4MF0gcHJlcGFyZV9mdHJhY2VfcmV0dXJuKzB4NzQvMHhiMDxicj5b
wqDCoCA4My44MzAzMDFdIFtkYzcxZTdhMF0gW2MwMDE3NmU0XSBmdHJhY2VfZ3JhcGhfY2FsbGVy
KzB4MTAvMHg1NDxicj4KClvCoMKgIDgzLjkwMTE4OF0gW2RjNzFlN2QwXSBbYzAwMTc3MjhdIHJl
dHVybl90b19oYW5kbGVyKzB4MC8weDM0ICh0cmFjZV9ncmFwaF9lbnRyeSsweGE0LzB4MTZjKTxi
cj5bwqDCoCA4NC4wMDEyNjVdIFtkYzcxZTdmMF0gW2MwMDFhYzgwXSBwcmVwYXJlX2Z0cmFjZV9y
ZXR1cm4rMHg3NC8weGIwPGJyPlvCoMKgIDg0LjA3NDIzMF0gW2RjNzFlODIwXSBbYzAwMTc2ZTRd
IGZ0cmFjZV9ncmFwaF9jYWxsZXIrMHgxMC8weDU0PGJyPgoKW8KgwqAgODQuMTQ1MTE4XSBbZGM3
MWU4NTBdIFtjMDAxNzcyOF0gcmV0dXJuX3RvX2hhbmRsZXIrMHgwLzB4MzQgKHRyYWNlX2dyYXBo
X2VudHJ5KzB4YTQvMHgxNmMpPGJyPlvCoMKgIDg0LjI0NTE5NV0gW2RjNzFlODcwXSBbYzAwMWFj
ODBdIHByZXBhcmVfZnRyYWNlX3JldHVybisweDc0LzB4YjA8YnI+W8KgwqAgODQuMzE4MTU5XSBb
ZGM3MWU4YTBdIFtjMDAxNzZlNF0gZnRyYWNlX2dyYXBoX2NhbGxlcisweDEwLzB4NTQ8YnI+Cgpb
wqDCoCA4NC4zODkwMzNdIFtkYzcxZThkMF0gW2MwMDE3NzI4XSByZXR1cm5fdG9faGFuZGxlcisw
eDAvMHgzNCAodHJhY2VfZ3JhcGhfZW50cnkrMHhhNC8weDE2Yyk8YnI+W8KgwqAgODQuNDg5MDk4
XSBbZGM3MWU4ZjBdIFtjMDAxYWM4MF0gcHJlcGFyZV9mdHJhY2VfcmV0dXJuKzB4NzQvMHhiMDxi
cj5bwqDCoCA4NC41NjIwNjRdIFtkYzcxZTkyMF0gW2MwMDE3NmU0XSBmdHJhY2VfZ3JhcGhfY2Fs
bGVyKzB4MTAvMHg1NDxicj4KClvCoMKgIDg0LjYzMjk1MV0gW2RjNzFlOTUwXSBbYzAwMTc3Mjhd
IHJldHVybl90b19oYW5kbGVyKzB4MC8weDM0ICh0cmFjZV9ncmFwaF9lbnRyeSsweGE0LzB4MTZj
KTxicj5bwqDCoCA4NC43MzMwMjJdIFtkYzcxZTk3MF0gW2MwMDFhYzgwXSBwcmVwYXJlX2Z0cmFj
ZV9yZXR1cm4rMHg3NC8weGIwPGJyPlvCoMKgIDg0LjgwNTk5M10gW2RjNzFlOWEwXSBbYzAwMTc2
ZTRdIGZ0cmFjZV9ncmFwaF9jYWxsZXIrMHgxMC8weDU0PGJyPgoKW8KgwqAgODQuODc2ODgwXSBb
ZGM3MWU5ZDBdIFtjMDAxNzcyOF0gcmV0dXJuX3RvX2hhbmRsZXIrMHgwLzB4MzQgKHRyYWNlX2dy
YXBoX2VudHJ5KzB4YTQvMHgxNmMpPGJyPlvCoMKgIDg0Ljk3Njk1MV0gW2RjNzFlOWYwXSBbYzAw
MWFjODBdIHByZXBhcmVfZnRyYWNlX3JldHVybisweDc0LzB4YjA8YnI+W8KgwqAgODUuMDQ5OTE2
XSBbZGM3MWVhMjBdIFtjMDAxNzZlNF0gZnRyYWNlX2dyYXBoX2NhbGxlcisweDEwLzB4NTQ8YnI+
CgpbwqDCoCA4NS4xMjA3OTBdIFtkYzcxZWE1MF0gW2MwMDE3NzI4XSByZXR1cm5fdG9faGFuZGxl
cisweDAvMHgzNCAodHJhY2VfZ3JhcGhfZW50cnkrMHhhNC8weDE2Yyk8YnI+W8KgwqAgODUuMjIw
ODU1XSBbZGM3MWVhNzBdIFtjMDAxYWM4MF0gcHJlcGFyZV9mdHJhY2VfcmV0dXJuKzB4NzQvMHhi
MDxicj5bwqDCoCA4NS4yOTM4MjBdIFtkYzcxZWFhMF0gW2MwMDE3NmU0XSBmdHJhY2VfZ3JhcGhf
Y2FsbGVyKzB4MTAvMHg1NDxicj4KClvCoMKgIDg1LjM2NDcwN10gW2RjNzFlYWQwXSBbYzAwMTc3
MjhdIHJldHVybl90b19oYW5kbGVyKzB4MC8weDM0ICh0cmFjZV9ncmFwaF9lbnRyeSsweGE0LzB4
MTZjKTxicj5bwqDCoCA4NS40NjQ3NzhdIFtkYzcxZWFmMF0gW2MwMDFhYzgwXSBwcmVwYXJlX2Z0
cmFjZV9yZXR1cm4rMHg3NC8weGIwPGJyPlvCoMKgIDg1LjUzNzc0Ml0gW2RjNzFlYjIwXSBbYzAw
MTc2ZTRdIGZ0cmFjZV9ncmFwaF9jYWxsZXIrMHgxMC8weDU0PGJyPgoKW8KgwqAgODUuNjA4NjE3
XSBbZGM3MWViNTBdIFtjMDAxNzcyOF0gcmV0dXJuX3RvX2hhbmRsZXIrMHgwLzB4MzQgKHRyYWNl
X2dyYXBoX2VudHJ5KzB4YTQvMHgxNmMpPGJyPlvCoMKgIDg1LjcwODY4MV0gW2RjNzFlYjcwXSBb
YzAwMWFjODBdIHByZXBhcmVfZnRyYWNlX3JldHVybisweDc0LzB4YjA8YnI+W8KgwqAgODUuNzgx
NjQ3XSBbZGM3MWViYTBdIFtjMDAxNzZlNF0gZnRyYWNlX2dyYXBoX2NhbGxlcisweDEwLzB4NTQ8
YnI+CgpbwqDCoCA4NS44NTI1MzRdIFtkYzcxZWJkMF0gW2MwMDE3NzI4XSByZXR1cm5fdG9faGFu
ZGxlcisweDAvMHgzNCAodHJhY2VfZ3JhcGhfZW50cnkrMHhhNC8weDE2Yyk8YnI+W8KgwqAgODUu
OTUyNjA1XSBbZGM3MWViZjBdIFtjMDAxYWM4MF0gcHJlcGFyZV9mdHJhY2VfcmV0dXJuKzB4NzQv
MHhiMDxicj5bwqDCoCA4Ni4wMjU1NzddIFtkYzcxZWMyMF0gW2MwMDE3NmU0XSBmdHJhY2VfZ3Jh
cGhfY2FsbGVyKzB4MTAvMHg1NDxicj4KClvCoMKgIDg2LjA5NjQ2NF0gW2RjNzFlYzUwXSBbYzAw
MTc3MjhdIHJldHVybl90b19oYW5kbGVyKzB4MC8weDM0ICh0cmFjZV9ncmFwaF9lbnRyeSsweGE0
LzB4MTZjKTxicj5bwqDCoCA4Ni4xOTY1MzVdIFtkYzcxZWM3MF0gW2MwMDFhYzgwXSBwcmVwYXJl
X2Z0cmFjZV9yZXR1cm4rMHg3NC8weGIwPGJyPlvCoMKgIDg2LjI2OTUwNl0gW2RjNzFlY2EwXSBb
YzAwMTc2ZTRdIGZ0cmFjZV9ncmFwaF9jYWxsZXIrMHgxMC8weDU0PGJyPgoKW8KgwqAgODYuMzQw
Mzk0XSBbZGM3MWVjZDBdIFtjMDAxNzcyOF0gcmV0dXJuX3RvX2hhbmRsZXIrMHgwLzB4MzQgKHRy
YWNlX2dyYXBoX2VudHJ5KzB4YTQvMHgxNmMpPGJyPlvCoMKgIDg2LjQ0MDQ2NF0gW2RjNzFlY2Yw
XSBbYzAwMWFjODBdIHByZXBhcmVfZnRyYWNlX3JldHVybisweDc0LzB4YjA8YnI+W8KgwqAgODYu
NTEzNDI5XSBbZGM3MWVkMjBdIFtjMDAxNzZlNF0gZnRyYWNlX2dyYXBoX2NhbGxlcisweDEwLzB4
NTQ8YnI+CgpbwqDCoCA4Ni41ODQzMDNdIFtkYzcxZWQ1MF0gW2MwMDE3NzI4XSByZXR1cm5fdG9f
aGFuZGxlcisweDAvMHgzNCAodHJhY2VfZ3JhcGhfZW50cnkrMHhhNC8weDE2Yyk8YnI+W8KgwqAg
ODYuNjg0MzY4XSBbZGM3MWVkNzBdIFtjMDAxYWM4MF0gcHJlcGFyZV9mdHJhY2VfcmV0dXJuKzB4
NzQvMHhiMDxicj5bwqDCoCA4Ni43NTczMzNdIFtkYzcxZWRhMF0gW2MwMDE3NmU0XSBmdHJhY2Vf
Z3JhcGhfY2FsbGVyKzB4MTAvMHg1NDxicj4KClvCoMKgIDg2LjgyODIyMF0gW2RjNzFlZGQwXSBb
YzAwMTc3MjhdIHJldHVybl90b19oYW5kbGVyKzB4MC8weDM0ICh0cmFjZV9ncmFwaF9lbnRyeSsw
eGE0LzB4MTZjKTxicj5bwqDCoCA4Ni45MjgyOTFdIFtkYzcxZWRmMF0gW2MwMDFhYzgwXSBwcmVw
YXJlX2Z0cmFjZV9yZXR1cm4rMHg3NC8weGIwPGJyPlvCoMKgIDg3LjAwMTI1N10gW2RjNzFlZTIw
XSBbYzAwMTc2ZTRdIGZ0cmFjZV9ncmFwaF9jYWxsZXIrMHgxMC8weDU0PGJyPgoKW8KgwqAgODcu
MDcyMTM3XSBbZGM3MWVlNTBdIFtjMDAxNzcyOF0gcmV0dXJuX3RvX2hhbmRsZXIrMHgwLzB4MzQg
KHRyYWNlX2dyYXBoX2VudHJ5KzB4YTQvMHgxNmMpPGJyPlvCoMKgIDg3LjE3MjIxNV0gW2RjNzFl
ZTcwXSBbYzAwMWFjODBdIHByZXBhcmVfZnRyYWNlX3JldHVybisweDc0LzB4YjA8YnI+W8KgwqAg
ODcuMjQ1MTc5XSBbZGM3MWVlYTBdIFtjMDAxNzZlNF0gZnRyYWNlX2dyYXBoX2NhbGxlcisweDEw
LzB4NTQ8YnI+CgpbwqDCoCA4Ny4zMTYwNjBdIFtkYzcxZWVkMF0gW2MwMDE3NzI4XSByZXR1cm5f
dG9faGFuZGxlcisweDAvMHgzNCAodHJhY2VfZ3JhcGhfZW50cnkrMHhhNC8weDE2Yyk8YnI+W8Kg
wqAgODcuNDE2MTI0XSBbZGM3MWVlZjBdIFtjMDAxYWM4MF0gcHJlcGFyZV9mdHJhY2VfcmV0dXJu
KzB4NzQvMHhiMDxicj5bwqDCoCA4Ny40ODkwOTBdIFtkYzcxZWYyMF0gW2MwMDE3NmU0XSBmdHJh
Y2VfZ3JhcGhfY2FsbGVyKzB4MTAvMHg1NDxicj4KClvCoMKgIDg3LjU1OTk5NF0gUmVib290aW5n
IGluIDMwIHNlY29uZHMuLjxicj5bwqAgMTAwLjEzOTc5MF0gS2VybmVsIHN0YWNrIG92ZXJmbG93
IGluIHByb2Nlc3MgZGM2YjhlNzAsIHIxPWRjNzFlMjYwPGJyPlvCoCAxMDAuMjE1ODY5XSBOSVA6
IGMwMDBmZWQ0IExSOiBjMDAzYzlhOCBDVFI6IGMwMDNjOTEmbHQ7MSZndDtbwqAgMTAwLjI3MDcz
OFVuYWJsZSB0byBoYW5kbGUga2VybmVsIHBhZ2luZyByZXF1ZXN0IGZvciB1bmtub3duIGZhdWx0
PGJyPgoKW8KgIDEwMC4yNzI5OTBdIFVuYWJsZSB0byBoYW5kbGUga2VybmVsIHBhZ2luZyByZXF1
ZXN0IGZvciBpbnN0cnVjdGlvbiBmZXRjaDxicj5bwqAgMTAwLjI3MzI4N10gVW5hYmxlIHRvIGhh
bmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgZm9yIHVua25vd24gZmF1bHQ8YnI+W8KgIDEwMC4y
NzUzOTJdIEZhdWx0aW5nIGluc3RydWN0aW9uIGFkZHJlc3M6IDB4YzAyMzE2MjA8YnI+W8KgIDEw
MC4yNzcyNTFdIE9vcHM6IEtlcm5lbCBhY2Nlc3Mgb2YgYmFkIGFyZWEsIHNpZzogMTEgWyMyXTxi
cj4KClvCoCAxMDAuMjc5MDgzXSBTTVAgTlJfQ1BVUz0yIFAyMDIwIEdNRUc8YnI+W8KgIDEwMC4y
ODA2NjhdIGxhc3Qgc3lzZnMgZmlsZTogL3N5cy9jbGFzcy9pMmMtZGV2L2kyYy0xL2Rldjxicj5b
wqAgMTAwLjI4MjU3NF0gTW9kdWxlcyBsaW5rZWQgaW46PGJyPlvCoCAxMDAuMjg0MDEyXSBOSVA6
IGMwMjMxNjIwIExSOiBjMDIzMTYwOCBDVFI6IGMwMDBiOGU0PGJyPlvCoCAxMDAuMjg1NzQ3XSBS
RUdTOiBjMDQ0MTZmMCBUUkFQOiBjMDQ0MTdiMMKgwqAgVGFpbnRlZDogR8KgwqDCoMKgwqAgRCBX
wqDCoMKgICgyLjYuMzUuMTEpPGJyPgoKW8KgIDEwMC4yODgwOTddIE1TUjogMDAwMjEwMDAgJmx0
O01FLENFJmd0O8KgIENSOiAyNDA0MjA4MsKgIFhFUjogMjAwMDAwMDA8YnI+W8KgIDEwMC4yOTEy
OTVdIFRBU0sgPSBjMDQyYTNhMFswXSAmIzM5O3N3YXBwZXImIzM5OyBUSFJFQUQ6IGMwNDQwMDAw
IENQVTogMDxicj5bwqAgMTAwLjI5MzU0N10gR1BSMDA6IDAwMDAyNzBmIGMwNDQxN2EwIGMwNDJh
M2EwIDAwMDAwMDAwIDAwMDAwMDE0IDAwMDAwMDE0IDAwMDAwMDAwIDAwMDEwMDAwPGJyPgoKW8Kg
IDEwMC4yOTgyMDRdIEdQUjA4OiBjMDQ0NmVjYyAwMDAwMDAwMCAwMDAwMDAwMCBjMDQ0MTdhMCAy
NDA0MjA4NCAxMDBhYTkzMCBjMDM4ZGRmYyBjMDQ0MWI5MDxicj5bwqAgMTAwLjMwMjg2MV0gR1BS
MTY6IGMwNDQxYjkwIGMwMDE3NmU0IDI4NDQ0NjI0IDAwMDAwMjAxIGMwNDQxYzAwIDAwMDAwMDAx
IDAwMDAwMDBmIGMwNDQxZWFmPGJyPlvCoCAxMDAuMzA3NTE4XSBHUFIyNDogYzA0NDFlYWYgMDAw
MDgwMDAgYzAzOGZlNjQgYzA0NWE3NTAgYzA0NDE3YjAgMDAwMDAwMDAgYzA0NDE4NTQgMDAwMDAw
MDE8YnI+CgpbwqAgMTAwLjMxMjU1NF0gTklQIFtjMDIzMTYyMF0gd2FpdF9mb3JfeG1pdHIrMHg1
MC8weDEyMDxicj5bwqAgMTAwLjMxNDM4OV0gTFIgW2MwMjMxNjA4XSB3YWl0X2Zvcl94bWl0cisw
eDM4LzB4MTIwPGJyPlvCoCAxMDAuMzE2MDk3XSBDYWxsIFRyYWNlOjxicj5bwqAgMTAwLjMxNzI0
MV0gW2MwNDQxN2EwXSBbYzAyMzE2MzRdIHdhaXRfZm9yX3htaXRyKzB4NjQvMHgxMjAgKHVucmVs
aWFibGUpPGJyPgoKW8KgIDEwMC4zMTk5ODhdIEluc3RydWN0aW9uIGR1bXA6PGJyPlvCoCAxMDAu
MzIxNDI0XSA4MDAzMDAwYyA3YzljMjM3OCAzODgwMDAwNSA3YzA5MDNhNiA3YzdlMWI3OCA0ZTgw
MDQyMSA4ODFlMDBjNyA1NDY5MDZmYzxicj5bwqAgMTAwLjMyNjMwM10gN2QyMDAzNzggOTgxZTAw
YzcgMzgwMDI3MGYgN2M3ZDFiNzggJmx0OzkwMWYwMDA4Jmd0OyA0ODAwMDAzNCA4MDFlMDAwYyA3
YzA5MDNhNjxicj4KClvCoCAxMDAuMzMxNDU1XSBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzog
RmF0YWwgZXhjZXB0aW9uIGluIGludGVycnVwdDxicj5bwqAgMTAwLjMzMzYwOF0gQ2FsbCBUcmFj
ZTo8YnI+W8KgIDEwMC4zMzQ3NTJdIFtjMDQ0MTVlMF0gW2MwMDA5ZDNjXSBzaG93X3N0YWNrKzB4
MTA4LzB4MWMwICh1bnJlbGlhYmxlKTxicj5bwqAgMTAwLjMzNzU1Ml0gW2MwNDQxNjMwXSBbYzAz
NDBhZjRdIGR1bXBfc3RhY2srMHgyYy8weDQ0PGJyPgoKW8KgIDEwMC4zMzk3MzNdIFtjMDQ0MTY0
MF0gW2MwMzQwYmM0XSBwYW5pYysweGI4LzB4MTM4PGJyPlvCoCAxMDAuMzQxODE1XSBbYzA0NDE2
OTBdIFtjMDAxMTE4NF0gZGllKzB4MTNjLzB4MWZjPGJyPlvCoCAxMDAuMzQzODc0XSBbYzA0NDE2
YzBdIFtjMDAxYmQwY10gYmFkX3BhZ2VfZmF1bHQrMHg5MC8weGUwPGJyPlvCoCAxMDAuMzQ2MTU1
XSBbYzA0NDE2ZTBdIFtjMDAxNmRmOF0gaGFuZGxlX3BhZ2VfZmF1bHQrMHg3Yy8weDgwPGJyPgoK
W8KgIDEwMC4zNDg2MTNdIC0tLSBFeGNlcHRpb246IGMwNDQxN2IwIGF0IHdhaXRfZm9yX3htaXRy
KzB4NTAvMHgxMjA8YnI+W8KgIDEwMC4zNTAzNjldwqDCoMKgwqAgTFIgPSB3YWl0X2Zvcl94bWl0
cisweDM4LzB4MTIwPGJyPlvCoCAxMDAuMzUyMDgxXSBbYzA0NDE3YTBdIFtjMDIzMTYzNF0gd2Fp
dF9mb3JfeG1pdHIrMHg2NC8weDEyMCAodW5yZWxpYWJsZSk8YnI+W8KgIDEwMC4zNTU2NzNdIFJl
Ym9vdGluZyBpbiAzMCBzZWNvbmRzLi48YnI+CgpbwqAgMTAyLjY1MjM0MF0gRmF1bHRpbmcgaW5z
dHJ1Y3Rpb24gYWRkcmVzczogMHgwMDAwMDAwMDxicj5bwqAgMTAyLjcxMzgzNV0gT29wczogS2Vy
bmVsIGFjY2VzcyBvZiBiYWQgYXJlYSwgc2lnOiAxMSBbIzNdPGJyPlvCoCAxMDIuNzc4NDQzXSBT
TVAgTlJfQ1BVUz0yIFAyMDIwIEdNRUc8YnI+W8KgIDEwMi44MjExOTVdIGxhc3Qgc3lzZnMgZmls
ZTogL3N5cy9jbGFzcy9pMmMtZGV2L2kyYy0xL2Rldjxicj4KClvCoCAxMDIuODg1ODA3XSBNb2R1
bGVzIGxpbmtlZCBpbjo8YnI+W8KgIDEwMi45MjIzMDNdIE5JUDogMDAwMDAwMDAgTFI6IDAwMDAw
MDAwIENUUjogYzAzNDAzOTQ8YnI+W8KgIDEwMi45ODE3MDddIFJFR1M6IGMwNDQxYTgwIFRSQVA6
IDA0MDDCoMKgIFRhaW50ZWQ6IEfCoMKgwqDCoMKgIEQgV8KgwqDCoCAoMi42LjM1LjExKTxicj5b
wqAgMTAzLjA2NDAyNF0gTVNSOiAwMDAyOTAwMCAmbHQ7RUUsTUUsQ0UmZ3Q7wqAgQ1I6IDI4NDQ0
NjgywqAgWEVSOiAwMDAwMDAwMDxicj4KClvCoCAxMDMuMTM3MDQ3XSBUQVNLID0gZGM2YjhlNzBb
MTg0XSAmIzM5O2Jhc2gmIzM5OyBUSFJFQUQ6IGRjNzFlMDAwIENQVTogMTxicj5bwqAgMTAzLjIw
NTgzOF0gR1BSMDA6IDAwMDAwMDAwIGMwNDQxYjMwIGRjNmI4ZTcwIDAwMDAwMDQwIGMwNDQxYjM4
IGMwMzhkZGZjIGMwNDQxYzM4IGMwNDQ2YmI4PGJyPlvCoCAxMDMuMzA2MDIwXSBHUFIwODogMDAw
MDAwMDEgYzAzOGRlM2MgMDAwMDAwMDAgYzA0NDFiMzAgMjg0NDQ2MjIgMTAwZjlkMjQgMDAwMDAw
MGYgYzA0NDFlYWY8YnI+CgpbwqAgMTAzLjQwNjE5Nl0gR1BSMTY6IGMwNDQxZWFmIDAwMDAwMDAw
IGMwMzhmZTY0IDEwNjI0ZGQzIGMwMzhkZGZjIGMwMzUwZWM4IDAwMDAwMDI1IGMwMzUwMDAwPGJy
PlvCoCAxMDMuNTA2MzcyXSBHUFIyNDogYzA0NGIxMGMgMDAwMDAwMjAgYzAzNTBlODAgYzA0NDFj
MzggYzA0NGI1MGMgYzA0MmMxNTggMjQwNDIwODAgYzA0NDFiNjA8YnI+W8KgIDEwMy42MDg2NDVd
IE5JUCBbMDAwMDAwMDBdIChudWxsKTxicj4KClvCoCAxMDMuNjQ4MjUyXSBMUiBbMDAwMDAwMDBd
IChudWxsKTxicj5bwqAgMTAzLjY4NjgxNl0gQ2FsbCBUcmFjZTo8YnI+W8KgIDEwMy43MTYwMDFd
IEluc3RydWN0aW9uIGR1bXA6PGJyPlvCoCAxMDMuNzUxNDU1XSBYWFhYWFhYWCBYWFhYWFhYWCBY
WFhYWFhYWCBYWFhYWFhYWCBYWFhYWFhYWCBYWFhYWFhYWCBYWFhYWFhYWCBYWFhYWFhYWDxicj5b
wqAgMTAzLjg0NDMzM10gWFhYWFhYWFggWFhYWFhYWFggWFhYWFhYWFggWFhYWFhYWFggWFhYWFhY
WFggWFhYWFhYWFggWFhYWFhYWFggWFhYWFhYWFg8YnI+CgpbwqAgMTAzLjkzNzIwOV0gS2VybmVs
IHBhbmljIC0gbm90IHN5bmNpbmc6IEZhdGFsIGV4Y2VwdGlvbiBpbiBpbnRlcnJ1cHQ8YnI+PGJy
PjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj4yMDExLzkvMjMgSmVhbi1NaWNoZWwgSGF1dGJvaXMg
PHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86amhhdXRib2lzQGdtYWlsLmNvbSI+
amhhdXRib2lzQGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPjxicj4KCjxibG9ja3F1b3RlIGNsYXNz
PSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAj
Y2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXg7Ij5ZZXMsIGlwaXBlIHRyYWNpbmcgd29ya3MuPGJy
PldoZW4gaXQgaXMgdGhlIGNhc2UsIEJUVywgSGVyZSBpcyB0aGUgcmVzdWx0IG9mIGVjaG9pbmcg
YSBuZXcgdHJhY2VyIDo8YnI+PGJyPiQmZ3Q7Y2F0IG1heDxkaXY+Cgo8ZGl2PjwvZGl2PjxkaXYg
Y2xhc3M9Img1Ij48YnI+SS1waXBlIHdvcnN0LWNhc2UgdHJhY2luZyBzZXJ2aWNlIG9uIDxhIGhy
ZWY9Imh0dHA6Ly8yLjYuMzUuMTEvaXBpcGUtMi4xMi0wMSIgdGFyZ2V0PSJfYmxhbmsiPjIuNi4z
NS4xMS9pcGlwZS0yLjEyLTAxPC9hPjxicj4KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
PGRpdj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+Q1BVOiAwLCBCZWdpbjogMjU5
MzYwNTU1NiBjeWNsZXMsIFRyYWNlIFBvaW50czogMTIgKC0xMC8rNSksIExlbmd0aDogMjY4MTY2
IHVzPGJyPgpDYWxpYnJhdGVkIG1pbmltdW0gdHJhY2UtcG9pbnQgb3ZlcmhlYWQ6IDAuMDIzIHVz
PGJyPjxicj7CoCstLS0tLSBIYXJkIElSUXMgKCYjMzk7fCYjMzk7OiBsb2NrZWQpPGJyPsKgfCst
LS0tICZsdDt1bnVzZWQmZ3Q7PGJyPsKgfHwrLS0tICZsdDt1bnVzZWQmZ3Q7PGJyPsKgfHx8Ky0t
IFhlbm9tYWk8YnI+wqB8fHx8Ky0gTGludXggKCYjMzk7KiYjMzk7OiBkb21haW4gc3RhbGxlZCwg
JiMzOTsrJiMzOTs6IGN1cnJlbnQsICYjMzk7IyYjMzk7OiBjdXJyZW50K3N0YWxsZWQpPGJyPgoK
CgrCoHx8fHx8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAr
LS0tLS0tLS0tLSBEZWxheSBmbGFnICgmIzM5OysmIzM5OzogJmd0OyAxIHVzLCAmIzM5OyEmIzM5
OzogJmd0OyAxMCB1cyk8YnI+wqB8fHx8fMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgICstIE5NSSBub2lzZSAoJiMzOTtOJiMzOTsp
PGJyPsKgfHx8fHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgwqDCoMKgwqDCoCB8PGJyPsKgwqDCoMKgwqAgVHlwZcKgwqDCoCBVc2VyIFZhbC7CoMKg
IFRpbWXCoMKgwqAgRGVsYXnCoCBGdW5jdGlvbiAoUGFyZW50KTxicj4KCgoKwqDCoMKgwqAgI2Z1
bmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMMKgwqDCoCAwLjAzOcKgIGlw
aXBlX2NoZWNrX2NvbnRleHQrMHg4ICh0aWNrX25vaHpfc3RvcF9zY2hlZF90aWNrKzB4MzFjKTxi
cj7CoHzCoMKgICNiZWdpbsKgwqAgMHg4MDAwMDAwMcKgwqDCoMKgIDDCoMKgwqAgMC4wNTHCoCBp
cGlwZV9jaGVja19jb250ZXh0KzB4ZjAgKHRpY2tfbm9oel9zdG9wX3NjaGVkX3RpY2srMHgzMWMp
PGJyPsKgfMKgwqAgI2VuZMKgwqDCoMKgIDB4ODAwMDAwMDHCoMKgwqDCoCAwwqDCoMKgIDAuMDM5
wqAgaXBpcGVfY2hlY2tfY29udGV4dCsweGRjICh0aWNrX25vaHpfc3RvcF9zY2hlZF90aWNrKzB4
MzFjKTxicj4KCgoKwqDCoMKgwqAgI2Z1bmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgMMKgwqDCoCAwLjAzOcKgIF9faXBpcGVfdW5zdGFsbF9yb290KzB4OCAodGlja19ub2h6
X3N0b3Bfc2NoZWRfdGljaysweDMyMCk8YnI+wqB8wqDCoCAjYmVnaW7CoMKgIDB4ODAwMDAwMDDC
oMKgwqDCoCAwwqDCoMKgIDAuMDQzwqAgX19pcGlwZV91bnN0YWxsX3Jvb3QrMHhiYyAodGlja19u
b2h6X3N0b3Bfc2NoZWRfdGljaysweDMyMCk8YnI+wqB8wqDCoCAjZnVuY8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwwqDCoMKgIDAuMDU4wqAgaXBpcGVfY2hlY2tfY29udGV4
dCsweDggKF9faXBpcGVfdW5zdGFsbF9yb290KzB4M2MpPGJyPgoKCgrCoHzCoMKgICtlbmTCoMKg
wqDCoCAweDgwMDAwMDAwwqDCoMKgwqAgMMKgwqDCoCAwLjA0NsKgIF9faXBpcGVfdW5zdGFsbF9y
b290KzB4YTggKHRpY2tfbm9oel9zdG9wX3NjaGVkX3RpY2srMHgzMjApPGJyPsKgwqDCoMKgICtm
dW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDDCoMKgwqAgMC4wNDHCoCBp
cGlwZV9zdXNwZW5kX2RvbWFpbisweDggKGNwdV9pZGxlKzB4YjApPGJyPsKgfMKgwqAgK2JlZ2lu
wqDCoCAweDgwMDAwMDAxwqDCoMKgwqAgMMKgwqDCoCAwLjA2MMKgIGlwaXBlX3N1c3BlbmRfZG9t
YWluKzB4MWUwIChjcHVfaWRsZSsweGIwKTxicj4KCgoKwqB8wqDCoCArZW5kwqDCoMKgwqAgMHg4
MDAwMDAwMcKgwqDCoMKgIDDCoMKgwqAgMC4wNDPCoCBpcGlwZV9zdXNwZW5kX2RvbWFpbisweDIy
MCAoY3B1X2lkbGUrMHhiMCk8YnI+Jmd0O3zCoMKgICtiZWdpbsKgwqAgMHg4MDAwMDAwMMKgwqDC
oMKgIDAhIDIxNDYuNTI0wqAgY3B1X2lkbGUrMHhlOCAocmVzdF9pbml0KzB4OTQpPGJyPjp8wqDC
oCArZnVuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMjY4MTY2wqDCoMKgIDAuMDQ1wqAg
X19pcGlwZV9ncmFiX3RpbWVyKzB4OCAoX19pcGlwZV9yZXRfZnJvbV9leGNlcHQrMHgwKTxicj4K
CgoKOnzCoMKgICtiZWdpbsKgwqAgMHgwMDAwMDIwMCAyNjgxNjbCoMKgwqAgMC4wNDbCoCBfX2lw
aXBlX2dyYWJfdGltZXIrMHg4NCAoX19pcGlwZV9yZXRfZnJvbV9leGNlcHQrMHgwKTxicj46fMKg
wqAgK2Z1bmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDI2ODE2NsKgwqDCoCAwLjA2MMKg
IF9faXBpcGVfZGlzcGF0Y2hfd2lyZWRfbm9jaGVjaysweDggKF9faXBpcGVfZ3JhYl90aW1lcisw
eDEzOCk8YnI+OnzCoCAjIGZ1bmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDI2ODE2NsKg
wqDCoCAwLjA1NMKgIHhuaW50cl9jbG9ja19oYW5kbGVyKzB4OCAoX19pcGlwZV9kaXNwYXRjaF93
aXJlZF9ub2NoZWNrKzB4MTA0KTxicj4KCgoKOnzCoCAjIGZ1bmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIDI2ODE2NsKgwqDCoCAwLjA1MMKgIHhudGltZXJfdGlja19hcGVyaW9kaWMrMHg4
ICh4bmludHJfY2xvY2tfaGFuZGxlcisweGQwKTxicj46fMKgICMgZnVuY8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgMjY4MTY2wqDCoMKgIDAuMDYwwqAgeG50aW1lcl9uZXh0X2xvY2FsX3No
b3QrMHg4ICh4bnRpbWVyX3RpY2tfYXBlcmlvZGljKzB4MzA0KTxicj46fMKgICMgZnVuY8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMjY4MTY2wqDCoMKgIDAuMDQ5wqAgeG5pbnRyX2hvc3Rf
dGljaysweDggKHhuaW50cl9jbG9ja19oYW5kbGVyKzB4MWY0KTxicj4KCgoKOnzCoCAjIGZ1bmPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDI2ODE2NsKgwqDCoCAwLjA4NcKgIF9faXBpcGVf
c2V0X2lycV9wZW5kaW5nKzB4OCAoeG5pbnRyX2hvc3RfdGljaysweDk0KTxicj46fMKgwqAgK2Z1
bmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDI2ODE2NsKgwqDCoCAwLjA2NcKgIF9faXBp
cGVfd2Fsa19waXBlbGluZSsweDggKF9faXBpcGVfZGlzcGF0Y2hfd2lyZWRfbm9jaGVjaysweDE0
OCk8YnI+OnzCoMKgICtmdW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAyNjgxNjbCoMKg
wqAgMC4wNjHCoCBfX2lwaXBlX3N5bmNfc3RhZ2UrMHg4IChfX2lwaXBlX3dhbGtfcGlwZWxpbmUr
MHgxYTgpPGJyPgoKCgombHQ7fMKgwqAgI2VuZMKgwqDCoMKgIDB4ODAwMDAwMDAgMjY4MTY2wqDC
oMKgIDAuMDQywqAgX19pcGlwZV9zeW5jX3N0YWdlKzB4MjM4IChfX2lwaXBlX3dhbGtfcGlwZWxp
bmUrMHgxYTgpPGJyPsKgwqDCoMKgICNmdW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAy
NjgxNjbCoMKgwqAgMC4wNDLCoCBpcnFfZW50ZXIrMHg4IChfX2lwaXBlX3N5bmNfc3RhZ2UrMHgy
NjApPGJyPsKgwqDCoMKgICNmdW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAyNjgxNjbC
oMKgwqAgMC4wNDbCoCByY3VfaXJxX2VudGVyKzB4OCAoaXJxX2VudGVyKzB4MzgpPGJyPgoKCgrC
oMKgwqDCoCAjZnVuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMjY4MTY3wqDCoMKgIDAu
MDQzwqAgaWRsZV9jcHUrMHg4IChpcnFfZW50ZXIrMHg0NCk8YnI+wqDCoMKgwqAgI2Z1bmPCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDI2ODE2N8KgwqDCoCAwLjAzOcKgIGlwaXBlX2NoZWNr
X2NvbnRleHQrMHg4IChpcnFfZW50ZXIrMHg4NCk8YnI+wqB8wqDCoCAjYmVnaW7CoMKgIDB4ODAw
MDAwMDEgMjY4MTY3wqDCoMKgIDAuMDAwwqAgaXBpcGVfY2hlY2tfY29udGV4dCsweGYwIChpcnFf
ZW50ZXIrMHg4NCk8L2Rpdj4KCgo8YnI+PGJyPjwvZGl2PjwvZGl2PjxkaXYgY2xhc3M9ImltIj4k
Jmd0O2VjaG8gZnVuY3Rpb25fZ3JhcGggJmd0OyBjdXJyZW50X3RyYWNlcjxicj48L2Rpdj5bwqAg
Mjc1LjY5ODY2NF0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tPGJyPlvCoCAy
NzUuNzU1MjUwXSAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS08YnI+W8KgIDI3
NS44MTA1NDddIEtlcm5lbCBzdGFjayBvdmVyZmxvdyBpbiBwcm9jZXNzIGRjNmJmMDIwLCByMT1k
YzgzODI1MDxicj4KCgpbwqAgMjc1Ljg5NjI3Nl0gS2VybmVsIHBhbmljIC0gbm90IHN5bmNpbmc6
IGtlcm5lbCBzdGFjayBvdmVyZmxvdzxicj5bwqAgMjc1Ljk2NTIwMF0gUmVib290aW5nIGluIDMw
IHNlY29uZHMuLjxicj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgY2xhc3M9Imlt
Ij4yMDExLzkvMjMgR2lsbGVzIENoYW50ZXBlcmRyaXggPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBo
cmVmPSJtYWlsdG86Z2lsbGVzLmNoYW50ZXBlcmRyaXhAeGVub21haS5vcmciIHRhcmdldD0iX2Js
YW5rIj5naWxsZXMuY2hhbnRlcGVyZHJpeEB4ZW5vbWFpLm9yZzwvYT4mZ3Q7PC9zcGFuPjxicj4K
Cgo8L2Rpdj48ZGl2PjxkaXY+PC9kaXY+PGRpdiBjbGFzcz0iaDUiPjxibG9ja3F1b3RlIGNsYXNz
PSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAj
Y2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxkaXY+PGRpdj48L2Rpdj48ZGl2Pk9uIDA5LzIz
LzIwMTEgMDk6NTggQU0sIEplYW4tTWljaGVsIEhhdXRib2lzIHdyb3RlOjxicj4KJmd0OyBIaSBM
aXN0LDxicj4KJmd0Ozxicj4KJmd0OyBJIGFtIHRyeWluZyB0byB1c2UgZnRyYWNlIG9uIGEgUDIw
MjAgYm9hcmQsIHVzaW5nIHRoZSBmb2xsb3dpbmcgOjxicj4KJmd0OyAtIExpbnV4IDIuNi4zNS0x
MTxicj4KJmd0OyAtIFhlbm9tYWkgMi41LjUuMSAob3IgMi41LjYsIHNhbWUgcHJvYmxlbSk8YnI+
CiZndDsgLSBpcGlwZSAyLjEyLTAxPGJyPgomZ3Q7PGJyPgomZ3Q7IEkgbGF1bmNoIGl0IHVzaW5n
IDo8YnI+CiZndDsgJCZndDsgbWtkaXIgL3RtcC9kZWJ1Zzxicj4KJmd0OyAkJmd0OyBtb3VudCAt
dCBkZWJ1Z2ZzIG5vZGV2IC90bXAvZGVidWc8YnI+CiZndDsgJCZndDsgY2QgL3RtcC9kZWJ1Zy90
cmFjaW5nPGJyPgomZ3Q7ICQmZ3Q7IGVjaG8gZnVuY3Rpb25fZ3JhcGggJmd0OyBjdXJyZW50X3Ry
YWNlcjxicj4KJmd0Ozxicj4KJmd0OyBUaGUgbGFzdCBvbmUgZmFpbHMgKGl0IGhhbmdzIHRoZSBD
UFUsIEkgY2Fubm90IGRvIGFueXRoaW5nIHRoYW4gaGFyZCByZXNldCkuPGJyPgomZ3Q7IERvIHlv
dSBrbm93IHdoYXQgY291bGQgY2F1c2UgdGhhdCA/PGJyPgomZ3Q7IEFzIEkgY2FuJiMzOTt0IGhh
dmUgYW55IHRyYWNlLCBJIGRvbiYjMzk7dCByZWFsbHkga25vdyBob3cgdG8gZ28gZnVydGhlciwg
YW5kIGJlZm9yZTxicj4KJmd0OyB1c2luZyBhIEJESSBJIHdvdWxkIGxpa2UgdG8ga25vdyBpZiBp
dCBpcyBhIGtub3duIGlzc3VlLCBhcyBJIGNvdWxkIG5vdCBmaW5kPGJyPgomZ3Q7IGFueXRoaW5n
IHJlbGF0ZWQgdG8gdGhpcyBpbiB0aGUgcmVjZW50IGNoYW5nZXMuLi48YnI+CiZndDs8YnI+CiZn
dDsgVGhhbmtzIGluIGFkdmFuY2UgZm9yIHlvdXIgaGVscCw8YnI+CiZndDsgUmVnYXJkcyw8YnI+
CiZndDsgSk08YnI+Cjxicj4KPC9kaXY+PC9kaXY+RG9lcyB0aGUgSS1waXBlIHRyYWNlciB3b3Jr
Pzxicj4KU2VlOjxicj4KPGEgaHJlZj0iaHR0cDovL3d3dy54ZW5vbWFpLm9yZy9pbmRleC5waHAv
SS1waXBlOlRyYWNlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly93d3cueGVub21haS5vcmcvaW5k
ZXgucGhwL0ktcGlwZTpUcmFjZXI8L2E+PGJyPgo8Zm9udCBjb2xvcj0iIzg4ODg4OCI+PGJyPgo8
YnI+Ci0tPGJyPgogwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBHaWxsZXMuPGJyPgo8L2ZvbnQ+PC9ibG9ja3F1b3RlPjwvZGl2
PjwvZGl2PjwvZGl2Pjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pjxicj4K
--20cf30025e5a96be5204ad98b92e--

