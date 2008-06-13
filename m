Message-ID: <2ff1a98a0806130803t19cc3a33v58225870224978be@domain.hid>
Date: Fri, 13 Jun 2008 17:03:01 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <3380.62.39.72.60.1213367793.squirrel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid>
	<5871.81.252.86.91.1211789666.squirrel@domain.hid>
	<18491.29266.196753.611570@domain.hid>
	<2766.81.252.86.91.1211992159.squirrel@domain.hid>
	<2ff1a98a0805280931j611ae10er69b968ae8699d63d@domain.hid>
	<16273.81.252.86.91.1212060383.squirrel@domain.hid>
	<2ff1a98a0805290614w3d846e6by69b033204f912391@domain.hid>
	<13639.81.252.86.91.1212153659.squirrel@domain.hid>
	<18496.31292.674733.417262@domain.hid>
	<3380.62.39.72.60.1213367793.squirrel@domain.hid>
Subject: Re: [Xenomai-help] Problem with time-out ends
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fabien MAHOT <fabien.mahot@domain.hid>
Cc: xenomai@xenomai.org

On Fri, Jun 13, 2008 at 4:36 PM, Fabien MAHOT
<fabien.mahot@domain.hid> wrote:
> Hello,
> Here this is the kernel traces :
>
>       c70750f0 00000086 00300182 c70e1a20 ffffffff 00000001 c72ca800
> c0274fec
>       c7080650 c70e1090 00300182 c70e1a20 ffffffff 00000001 c014d9ca
> 00000200
>       c7080650 00000000 c70750f0 c7080650 c71e77e0 00000033 00000000
> c70e1150
> Call Trace:
>  [<c0274fec>] n_tty_receive_buf+0x51c/0x1270
>  [<c014d9ca>] rpi_push+0x6a/0x420
>  [<c01445a4>] xnpod_suspend_thread+0x424/0x4a0
>  [<c014df7c>] rpi_update+0x1fc/0x230
>  [<c014a1d7>] xnsynch_sleep_on+0x8e7/0xd10
>  [<c014d159>] ppd_lookup+0x19/0x30
>  [<c0153258>] pse51_mutex_timedlock_break+0x1f8/0x220
>  [<c0161b9e>] __pthread_mutex_lock+0x4e/0x60
>  [<c014f6d4>] losyscall_event+0xb4/0x170
>  [<c013c5b2>] __ipipe_dispatch_event+0xa2/0x180
>  [<c014f620>] losyscall_event+0x0/0x170
>  [<c010cac0>] __ipipe_syscall_root+0x40/0xf0
>  [<c0102eb9>] system_call+0x29/0x4a
>  =======================
> Xenomai: fatal: Hardened thread threadTimeOut[4698] running in Linux
> domain?! (status=0x300182, sig=1, prev=gatekeeper/0[148])
>  CPU  PID    PRI      TIMEOUT  STAT      NAME
>>  0  0       80      0        00500080  ROOT
>   0  4695     0      0        00300380  testTimer12_cor
>   0  4697    85      0        00300182  threadTimeOutEnd
>   0  4698    80      0        00300182  threadTimeOut
>   0  4699    80      0        00300b80  threadDisplay
> Master time base: clock=823018273704
>
>       c70c3ecc 00000000 00000000 00000001 c7080650 c0104256 00000000
> c0442211
>       0000125a c70e1dec c014e3fd c043c6a0 c70c4000 0000125a 00300182
> 00000001
>       c70752cc 00000094 c0584980 c013ce20 00000021 c013ce43 c013bb78
> 00000021
> Call Trace:
>  [<c0104256>] show_stack+0x36/0x50
>  [<c014e3fd>] schedule_event+0x39d/0x850
>  [<c013ce20>] rthal_apc_handler+0x0/0x30
>  [<c013ce43>] rthal_apc_handler+0x23/0x30
>  [<c013bb78>] __xirq_end+0x39/0x46
>  [<c0102f28>] restore_nocheck_notrace+0x0/0xe
>  [<c013ce20>] rthal_apc_handler+0x0/0x30
>  [<c0106fd1>] native_sched_clock+0x61/0xb0
>  [<c013c5b2>] __ipipe_dispatch_event+0xa2/0x180
>  [<c014e060>] schedule_event+0x0/0x850
>  [<c03dbeb6>] schedule+0x226/0x3b0
>  [<c014fe6d>] gatekeeper_thread+0xad/0x140
>  [<c03dbe48>] schedule+0x1b8/0x3b0
>  [<c0111a40>] default_wake_function+0x0/0x10
>  [<c014fdc0>] gatekeeper_thread+0x0/0x140
>  [<c0127f42>] kthread+0x42/0x70
>  [<c0127f00>] kthread+0x0/0x70
>  [<c01032d7>] kernel_thread_helper+0x7/0x10
>  =======================

Your stack traces are strange, to say the least. Could you enable
frame pointers and get another trace ?

-- 
 Gilles

