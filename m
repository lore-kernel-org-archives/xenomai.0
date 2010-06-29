Message-ID: <4C2A078E.80009@domain.hid>
Date: Tue, 29 Jun 2010 16:47:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <8EA2C2C4116BF44AB370468FBF85A777016574B413@domain.hid>
In-Reply-To: <8EA2C2C4116BF44AB370468FBF85A777016574B413@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] machine hangs running oprofile on xenomai kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Sydir, Jerry" <jerry.sydir@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Sydir, Jerry wrote:
> Hello,
> 
> I am having trouble running oprofile on a xenomai kernel. I am running the 2.5.3 version of xenomai built into a 2.6.32.11 version of the kernel running on an Intel Core 2 duo. I have tried both the 0.9.3 and 0.9.6 versions of oprofile. When I try to start collection ("opcontrol -start") the machine hangs. Oprofile runs without trouble on a clean version of the 2.6.32.11 kernel built using the same configuration as the xenomai version.
> 
> Is this a know limitation? Are there any configuration settings that I need to use?

Could you try if loading oprofile with module parameter timer=1 helps?
It will not profile Xenomai code anymore, but may point to the NMI path.

But oprofile might have its own problems. This is what I got testing it
on 2.6.34 (opcontrol --dump in a profiling session):

[  667.539673] =======================================================
[  667.540063] [ INFO: possible circular locking dependency detected ]
[  667.540063] 2.6.34-xeno_64 #24
[  667.540063] -------------------------------------------------------
[  667.540063] oprofiled/6497 is trying to acquire lock:
[  667.540063]  (&mm->mmap_sem){++++++}, at: [<ffffffff8111fd9b>] might_fault+0x68/0xb5
[  667.540063]
[  667.540063] but task is already holding lock:
[  667.540063]  (dcookie_mutex){+.+.+.}, at: [<ffffffff81190980>] sys_lookup_dcookie+0x44/0x182
[  667.540063]
[  667.540063] which lock already depends on the new lock.
[  667.540063]
[  667.540063]
[  667.540063] the existing dependency chain (in reverse order) is:
[  667.540063]
[  667.540063] -> #1 (dcookie_mutex){+.+.+.}:
[  667.540063]        [<ffffffff81065f0e>] __lock_acquire+0x150b/0x1862
[  667.540063]        [<ffffffff8106635d>] lock_acquire+0xf8/0x122
[  667.540063]        [<ffffffff8132ed77>] mutex_lock_nested+0x69/0x336
[  667.540063]        [<ffffffff81190aed>] get_dcookie+0x2f/0x13e
[  667.540063]        [<ffffffffa02d4fbb>] sync_buffer+0x1a9/0x413 [oprofile]
[  667.540063]        [<ffffffffa02d523b>] task_exit_notify+0x16/0x1a [oprofile]
[  667.540063]        [<ffffffff81334813>] notifier_call_chain+0x38/0x60
[  667.540063]        [<ffffffff810569c6>] __blocking_notifier_call_chain+0x52/0x6f
[  667.540063]        [<ffffffff810569f7>] blocking_notifier_call_chain+0x14/0x16
[  667.540063]        [<ffffffff810599ed>] profile_task_exit+0x1a/0x1c
[  667.540063]        [<ffffffff81039e37>] do_exit+0x2a/0x705
[  667.540063]        [<ffffffff8103a58a>] do_group_exit+0x78/0xa1
[  667.540063]        [<ffffffff8103a5ca>] sys_exit_group+0x17/0x1b
[  667.540063]        [<ffffffff81002b7f>] system_call_fastpath+0x16/0x1b
[  667.540063]
[  667.540063] -> #0 (&mm->mmap_sem){++++++}:
[  667.540063]        [<ffffffff81065c33>] __lock_acquire+0x1230/0x1862
[  667.540063]        [<ffffffff8106635d>] lock_acquire+0xf8/0x122
[  667.540063]        [<ffffffff8111fdc8>] might_fault+0x95/0xb5
[  667.540063]        [<ffffffff81190a76>] sys_lookup_dcookie+0x13a/0x182
[  667.540063]        [<ffffffff81002b7f>] system_call_fastpath+0x16/0x1b
[  667.540063]
[  667.540063] other info that might help us debug this:
[  667.540063]
[  667.540063] 1 lock held by oprofiled/6497:
[  667.540063]  #0:  (dcookie_mutex){+.+.+.}, at: [<ffffffff81190980>] sys_lookup_dcookie+0x44/0x182
[  667.540063]
[  667.540063] stack backtrace:
[  667.540063] Pid: 6497, comm: oprofiled Not tainted 2.6.34-xeno_64 #24
[  667.540063] Call Trace:
[  667.540063]  [<ffffffff810644a7>] print_circular_bug+0xb3/0xc2
[  667.540063]  [<ffffffff81065c33>] __lock_acquire+0x1230/0x1862
[  667.540063]  [<ffffffff8106635d>] lock_acquire+0xf8/0x122
[  667.540063]  [<ffffffff8111fd9b>] ? might_fault+0x68/0xb5
[  667.540063]  [<ffffffff8111fdc8>] might_fault+0x95/0xb5
[  667.540063]  [<ffffffff8111fd9b>] ? might_fault+0x68/0xb5
[  667.540063]  [<ffffffff81190a76>] sys_lookup_dcookie+0x13a/0x182
[  667.540063]  [<ffffffff81002b7f>] system_call_fastpath+0x16/0x1b

Maybe perf works, maybe it also has issues when using NMIs. I haven't
tried this yet over Xenomai.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

