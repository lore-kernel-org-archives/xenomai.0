From: "A.s. Dong" <aisheng.dong@nxp.com>
Date: Mon, 27 Aug 2018 12:40:53 +0000
Message-ID: <AM0PR04MB4211273F120B170AAEBBA391800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] IPIPE issue causes kernel warning when
 CONFIG_DEBUG_MUTEXES enabled
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Xenomai Experts,

We met the following kernel warning on a MX6Q SDB board with Xenomai enable=
d 4.9 kernel.
(CONFIG_DEBUG_MUTEXES is enabled).

After some debug, I found it seems to be caused by IPIPE calling sleepable =
function in interrupt context.
arch/arm/kernel/ipipe_tsc.c:
int cpufreq_transition_handler()
{
       ...
       smp_call_function_single(freqs->cpu, update_timer_freq, &freq, 1);
}

Where update_timer_freq is not allowed to be sleep. But it will finally cal=
l clk_get_rate
In twd_refresh_freq which has a mutex and then trigger the following warnin=
g.

My questions is:
Does Xenomai support CONFIG_DEBUG_MUTEXES?
Should we disable it to avoid such issue?

[    4.594173] ------------[ cut here ]------------
[    4.600010] WARNING: CPU: 0 PID: 0 at kernel/locking/mutex.c:873 mutex_t=
rylock+0x1a0/0x214
[    4.610409] DEBUG_LOCKS_WARN_ON(in_interrupt())[    4.615892] Modules li=
nked in:
[    4.619753] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.9.35-ipipe #1
[    4.627856] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    4.636067] I-pipe domain: Linux
[    4.640130] Backtrace:
[    4.643241] [<c010c3f4>] (dump_backtrace) from [<c010c66c>] (show_stack+=
0x18/0x1c)
[    4.652769]  r7:c0e20b1c r6:ffffffff r5:00000080 r4:00000000
[    4.659902] [<c010c654>] (show_stack) from [<c03f2918>] (dump_stack+0x98=
/0xbc)
[    4.668999] [<c03f2880>] (dump_stack) from [<c0125e60>] (__warn+0xd8/0x1=
04)
[    4.677763]  r9:c0918614 r8:00000369 r7:00000009 r6:c0bf8ab4 r5:00000000=
 r4:c0e01dd8
[    4.687509] [<c0125d88>] (__warn) from [<c0125ec8>] (warn_slowpath_fmt+0=
x3c/0x44)
[    4.696929]  r9:ef79bcb0 r8:ef05798c r7:c0d06414 r6:00000000 r5:c0e6d624=
 r4:c0bf864c
[    4.706677] [<c0125e90>] (warn_slowpath_fmt) from [<c0918614>] (mutex_tr=
ylock+0x1a0/0x214)
[    4.717073]  r3:c0bf8aa4 r2:c0bf864c
[    4.721573]  r4:c0e2331c
[    4.724774] [<c0918474>] (mutex_trylock) from [<c046ee34>] (clk_prepare_=
lock+0x14/0xf4)
[    4.734846]  r7:c0d06414 r6:00000000 r5:1daee080 r4:ef010080
[    4.741974] [<c046ee20>] (clk_prepare_lock) from [<c04707e8>] (clk_core_=
get_rate+0x14/0x68)
[    4.752480]  r5:1daee080 r4:ef010080
[    4.756986] [<c04707d4>] (clk_core_get_rate) from [<c0470858>] (clk_get_=
rate+0x1c/0x20)
[    4.767055]  r5:1daee080 r4:ef796230
[    4.771566] [<c047083c>] (clk_get_rate) from [<c01108e0>] (twd_refresh_f=
req+0x18/0x20)
[    4.781537] [<c01108c8>] (twd_refresh_freq) from [<c01aba50>] (__ipipe_t=
imer_refresh_freq+0x40/0x84)
[    4.793036] [<c01aba10>] (__ipipe_timer_refresh_freq) from [<c0d06428>] =
(update_timer_freq+0x14/0x18)
[    4.804635]  r6:00000000 r5:00000000 r4:ef057950
[    4.810458] [<c0d06414>] (update_timer_freq) from [<c0197550>] (flush_sm=
p_call_function_queue+0xac/0x1ac)
[    4.822501] [<c01974a4>] (flush_smp_call_function_queue) from [<c0198390=
>] (generic_smp_call_function_single_interrupt+0x14/0x18)
[    4.837160]  r9:ef79bcb0 r8:00000000 r7:c0e042c8 r6:00000003 r5:00000000=
 r4:c0d7d710
[    4.846909] [<c019837c>] (generic_smp_call_function_single_interrupt) fr=
om [<c010fd2c>] (handle_IPI+0x120/0x198)
[    4.859714] [<c010fc0c>] (handle_IPI) from [<c010fdd0>] (__ipipe_do_IPI+=
0x2c/0x38)
[    4.869241]  r10:c0ef5200 r9:ef799974 r8:00000000 r7:ef799974 r6:ef79997=
c r5:00000403
[    4.879092]  r4:c0d7ccb0 r3:c0e042c8
[    4.883599] [<c010fda4>] (__ipipe_do_IPI) from [<c01a9ebc>] (__ipipe_do_=
sync_stage+0x238/0x288)
[    4.894542]  r5:ef79996c r4:c0f052c0
[    4.899047] [<c01a9c84>] (__ipipe_do_sync_stage) from [<c01aa028>] (ipip=
e_unstall_root+0x48/0x58)
[    4.910214]  r10:c0d7e7f0 r9:c0e0a378 r8:ef79d7f8 r7:c0e0417c r6:0000000=
1 r5:c0e0412c
[    4.920063]  r4:c0d7a96c
[    4.923263] [<c01a9fe0>] (ipipe_unstall_root) from [<c0163240>] (cpu_sta=
rtup_entry+0x1ec/0x234)
[    4.934205]  r5:c0e0412c r4:c0e00000
[    4.938712] [<c0163054>] (cpu_startup_entry) from [<c0915514>] (rest_ini=
t+0x78/0x90)
[    4.948454]  r7:c0e04100 r4:00000002
[    4.952968] [<c091549c>] (rest_init) from [<c0d00cac>] (start_kernel+0x3=
28/0x398)
[    4.962383]  r5:ffffffff r4:c0e6b04c
[    4.966892] [<c0d00984>] (start_kernel) from [<1000807c>] (0x1000807c)
[    4.975111]  r10:00000000 r9:412fc09a r8:1000406a r7:c0e08c30 r6:c0d63a3=
4 r5:c0e04118
[    4.984960]  r4:c0e6b294
[    4.988155] ---[ end trace 2b1c1dd9872fc29b ]---
[    4.993987] clocksource: arm_global_timer: mask: 0xffffffffffffffff max_=
cycles: 0xe5b5472f21, max_idle_ns: 881590440277 ns
[    5.007934] clocksource: arm_global_timer: mask: 0xffffffffffffffff max_=
cycles: 0xe5b5472f21, max_idle_ns: 881590440277 ns
[    5.021875] clocksource: arm_global_timer: mask: 0xffffffffffffffff max_=
cycles: 0xe5b5472f21, max_idle_ns: 881590440277 ns
[    5.035911] Registering SWP/SWPB emulation handler
[    5.062097] imx_thermal 2000000.aips-bus:tempmon: Extended Commercial CP=
U temperature grade - max:105C critical:100C passive:95C
[    5.078685] input: gpio-keys as /devices/soc0/gpio-keys/input/input2
[    5.087393] snvs_rtc 20cc000.snvs:snvs-rtc-lp: setting system clock to 1=
970-01-01 00:00:32 UTC (32)
[    5.099482] usb_otg_vbus: disabling

Regards
Dong Aisheng
