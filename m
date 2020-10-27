Date: Tue, 27 Oct 2020 14:44:26 +0800
From: Fino Meng <fino.meng@linux.intel.com>
Subject: Re: build scripts for the WIP xenomai porting to kernel 5.4
Message-ID: <20201027064425.GA20371@linux.intel.com>
References: <20201023090407.GA16088@linux.intel.com>
 <6ca34337-dd2f-3727-a014-f76d6721a647@siemens.com>
 <20201026081238.GA17437@linux.intel.com>
 <1b80d6cf-cf5a-dbb7-4e82-1958cd82b212@siemens.com>
 <20201026082656.GC17437@linux.intel.com>
 <d1e7422a-2bb9-b9d2-7b57-7a1965721f34@siemens.com>
 <20201026091520.GA17573@linux.intel.com>
 <55d22ab5-5c97-5fdb-b3eb-8dc19a7edb45@siemens.com>
 <20201027052334.GA26663@linux.intel.com>
 <c4d61fbd-b888-c9ea-78bd-5a5617af7a1e@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4d61fbd-b888-c9ea-78bd-5a5617af7a1e@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On Tue, Oct 27, 2020 at 07:01:34AM +0100, Jan Kiszka wrote:
> On 27.10.20 06:23, Fino Meng wrote:
> >>>>>>> I also tested hackbench:
> >>>>>>>
> >>>>>>> while true ; do sudo taskset -c 1 hackbench -s 512 -l 200 -g 20 -f 50 -P ; done
> >>>>>>>
> >>>>>>> it output errors, but the board is still alive. 
> >>>>>>>
> >>>>>>
> >>>>>> Will check. Was that with my FPU fixes in place already?
> >>>>>>
> >>>>>> Jan
> >>>>>
> >>>>> yes, without the FPU fixes, the board will hang after trigger
> >>>>> hackbench.
> >>>>
> >>>> How long did it run to trigger? Anything happening in parallel? How do
> >>>> the errors look like? Currently running, nothing happened so far.
> >>>>
> >>>> Maybe you can also retry with ipipe-x86-5.4.y.
> >>>>
> >>>> Jan
> >>>>
> >>>
> >>> sounds good, will pull latest code. my board's error print like this,
> >>> nothing parallel, only run a hackbench.
> >>>
> >>> [ 3711.348060] RIP: 0033:0x7f4a7edc9471
> >>> [ 3711.354108] Code: 00 00 75 05 48 83 c4 58 c3 e8 0b 4d ff ff 66 2e 0f 1f 84 00 00 00 00 00 90 8b 05 da ef 00 00 85 c0 75 16 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 57 c3 66 0f 1f 44 00 00 41 54 49 89 d4 55 48
> >>> [ 3711.377358] RSP: 002b:00007ffe59265888 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> >>> [ 3711.388126] RAX: ffffffffffffffda RBX: 0000000000000200 RCX: 00007f4a7edc9471
> >>> [ 3711.398415] RDX: 0000000000000200 RSI: 00007ffe59265890 RDI: 0000000000000014
> >>> [ 3711.408711] RBP: 00007ffe59265ae0 R08: 00007ffe592657e0 R09: 00007f4a7edd42f0
> >>> [ 3711.419019] R10: fffffffffffff8d7 R11: 0000000000000246 R12: 00007ffe59265890
> >>> [ 3711.429338] R13: 000000000000000c R14: 00005644c8742a20 R15: 0000000000000000
> >>> [ 3711.439678] hackbench       R  running task        0  2381    627 0x00000000
> >>> [ 3711.449928] Call Trace:
> >>> [ 3711.455031]  __schedule+0x34d/0x790
> >>> [ 3711.461305]  ? try_to_wake_up+0x8b/0x6b0
> >>> [ 3711.468067]  ? ___preempt_schedule+0x16/0x20
> >>> [ 3711.475219]  preempt_schedule_common+0x74/0x80
> >>> [ 3711.482568]  ___preempt_schedule+0x16/0x20
> >>> [ 3711.489531]  _raw_spin_unlock_irqrestore+0x36/0x40
> >>> [ 3711.497268]  __wake_up_common_lock+0x92/0xc0
> >>> [ 3711.504295]  sock_def_readable+0x41/0x80
> >>> [ 3711.510830]  unix_stream_sendmsg+0x231/0x3c0
> >>> [ 3711.517743]  sock_sendmsg+0x5b/0x60
> >>> [ 3711.523763]  sock_write_iter+0x97/0x100
> >>> [ 3711.530167]  new_sync_write+0x11b/0x1b0
> >>> [ 3711.536554]  vfs_write+0xa5/0x1a0
> >>> [ 3711.542337]  ksys_write+0x59/0xd0
> >>> [ 3711.548100]  do_syscall_64+0x66/0x180
> >>> [ 3711.554232]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >>> [ 3711.561932] RIP: 0033:0x7f4a7edc9471
> >>> [ 3711.567977] Code: 00 00 75 05 48 83 c4 58 c3 e8 0b 4d ff ff 66 2e 0f 1f 84 00 00 00 00 00 90 8b 05 da ef 00 00 85 c0 75 16 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 57 c3 66 0f 1f 44 00 00 41 54 49 89 d4 55 48
> >>> [ 3711.591216] RSP: 002b:00007ffe59265888 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> >>> [ 3711.601984] RAX: ffffffffffffffda RBX: 0000000000000200 RCX: 00007f4a7edc9471
> >>> [ 3711.612276] RDX: 0000000000000200 RSI: 00007ffe59265890 RDI: 000000000000001a
> >>> [ 3711.622577] RBP: 00007ffe59265ae0 R08: 00007ffe592657e0 R09: 00007f4a7edd42f0
> >>> [ 3711.632885] R10: fffffffffffff8d7 R11: 0000000000000246 R12: 00007ffe59265890
> >>> [ 3711.643206] R13: 0000000000000012 R14: 00005644c8742a20 R15: 0000000000000000
> >>> [ 3711.653541] hackbench       R  running task        0  2382    627 0x00000000
> >>> [ 3711.663797] Call Trace:
> >>> [ 3711.668897]  __schedule+0x34d/0x790
> >>> [ 3711.675165]  ? try_to_wake_up+0x8b/0x6b0
> >>> [ 3711.681924]  ? ___preempt_schedule+0x16/0x20
> >>> [ 3711.689085]  preempt_schedule_common+0x74/0x80
> >>> [ 3711.696427]  ___preempt_schedule+0x16/0x20
> >>> [ 3711.703377]  _raw_spin_unlock_irqrestore+0x36/0x40
> >>> [ 3711.710985]  __wake_up_common_lock+0x92/0xc0
> >>> [ 3711.717901]  sock_def_readable+0x41/0x80
> >>> [ 3711.724414]  unix_stream_sendmsg+0x231/0x3c0
> >>> [ 3711.731306]  sock_sendmsg+0x5b/0x60
> >>> [ 3711.737311]  sock_write_iter+0x97/0x100
> >>> [ 3711.743693]  new_sync_write+0x11b/0x1b0
> >>> [ 3711.750061]  vfs_write+0xa5/0x1a0
> >>> [ 3711.755829]  ksys_write+0x59/0xd0
> >>> [ 3711.761574]  do_syscall_64+0x66/0x180
> >>> [ 3711.767709]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >>> [ 3711.775409] RIP: 0033:0x7f4a7edc9471
> >>>
> >>>
> >>
> >> Could you send me your config if the issue persists with the latest version?
> >>
> >> TIA,
> >> Jan
> >>
> > 
> > latest ipipe-x86 + xenomai-next behaves much better than my previous
> > build, but still print similar error.
> > 
> > "hackbench -s 512 -l 200 -g 20 -f 50 -P" don't give error, which just
> > run once.
> > 
> > "while true; do taskset -c 1 hackbench -s 512 -l 200 -g 20 -f 50 -P;
> > done" will give error, it will keep folking and system pressure will bigger
> > and bigger; the way to stop it is keep pressing Ctrl-C. We use this
> > script as a torture method. 
> > 
> > the error appears in dmesg, after the script run for sometime. Test hardware
> > is UP Xtreme board (WHL8365UE).
> > 
> > I tested this script on Debian 10's original 4.19 kernel, no such error
> > appears in dmesg.
> 
> I'm also getting this, but first an OOM. I gave 4G to that machine, do
> you have more?
> 

I have 8G on board.

> Does the issue also happen with the same kernel when I-pipe is off?

well, I pop off ipipe and xenomai patches, build a vanilla 5.4.72
kernel, the scripts also print such error. So maybe the issue is not
within ipipe/xenomai code~

BR fino

> Turning on debugging knobs now.
> 
> Jan
> 
> -- 
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux

