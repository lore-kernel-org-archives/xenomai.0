Message-ID: <4950C326.4050003@domain.hid>
Date: Tue, 23 Dec 2008 10:53:26 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20081127175234.163sujmgcgcgs4gk@domain.hid>	<492EF786.4040303@domain.hid>	<20081128181906.mnv2mvjgo44wgoc0@domain.hid>	<49301B0B.9010208@domain.hid>	<20081128182944.qp8yhwpk6cw8cwss@domain.hid>	<49302630.4080104@domain.hid>	<D6B7B711-7E2F-466D-857F-53EB7A7C30DC@su.sabanciuniv.edu>	<B41FD0F2-09C0-4DB6-B36C-892B72A63875@domain.hid>	<C7714144-0328-4258-95BD-133AB45C72E9@domain.hid>	<494F6250.50707@domain.hid>
	<20081222133253.lscsfad40kswkwsc@domain.hid>
	<494F9007.5060600@domain.hid>
	<1B44D448-6E28-45CD-97E7-7230D3E44D61@domain.hid>
In-Reply-To: <1B44D448-6E28-45CD-97E7-7230D3E44D61@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Zombie user tasks
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alphan Ulusoy <alphan@domain.hid>
Cc: xenomai@xenomai.org

Alphan Ulusoy wrote:
> I've done the changes you suggested ( addition to sched.c file and  
> fram pointers) and left the tasks running last night. Below you can  
> find the dump. The hex numbers inside the brackets ( [0x00000001] )  
> are newly added. And as you said in your previous post "Actuator  
> Aperiodic Task" is the real-time task created and started in the  
> process called "actuatorTask" which turns into a zombie. The ps aux  
> output says:
> 
> root     28213  0.0  0.0      0     0 pts/0    Zl   04:21   0:02  
> [actuatorTask] <defunct>
> 
> 
> To give you a heads up, the actuator Aperiodic task is a simple  
> for(;;) loop which blocks on recvfrom() on a UDP socket at every  
> iteration until a packet is received. Then it writes the data it  
> contains to a shared variable acquiring and releasing a mutex. any  
> ideas?

If you mean that you have a sample code with which I would be able to
reproduce the problem without requiring special hardware, I am very
interested.

> 
> 
> regards,
> 
> alphan.
> 
> 
> 
> ------- Dump starts here ---------
> 
> 
> [33034.505238] SysRq : Show State
> [33034.505238]   task                PC stack   pid father
> (...)
> [33034.505238] gatekeeper/0  S [0x00000001] f7c87f78     0   150      2
> [33034.505238]        f7c87f94 00000046 00000046 f7c87f78 f7c88000  
> f7c88254 c0571f40 be53c9c0
> [33034.505238]        0000137d 00000000 f7c87f94 c0138047 f7d81a20  
> c057be60 c057be6c f7c87fcc
> [33034.505238]        c0158f77 00000003 f7c88000 f7c88254 00000000  
> 00000001 f7c88000 c011a4d0
> [33034.505238] Call Trace:
> [33034.505238]  [<c0138047>] ? up+0x57/0x90
> [33034.505238]  [<c0158f77>] gatekeeper_thread+0xa7/0x140
> [33034.505238]  [<c011a4d0>] ? default_wake_function+0x0/0x10
> [33034.505238]  [<c0158ed0>] ? gatekeeper_thread+0x0/0x140
> [33034.505238]  [<c01335a2>] kthread+0x42/0x70
> [33034.505238]  [<c0133560>] ? kthread+0x0/0x70
> [33034.505238]  [<c0103d43>] kernel_thread_helper+0x7/0x14

So, the gatekeeper is in TASK_INTERRUPTIBLE state, waiting for a thread
to call "wake_up_interruptible_sync" in xnshadow_harden.


> [33034.505239] actuatorTask  ? [0x00000040] 00000001     0 28213      1
> [33034.505239]        f760df54 00000046 c0198b26 00000001 f7ce48e0  
> f7ce4b34 f765a540 c6b973df
> [33034.505239]        0000137d 00000000 f7ce48d8 f7ce48e0 00000010  
> f7ce48e0 f760ddd8 f760df98
> [33034.505239]        c0122e14 c04ee300 00000000 f7ce51c0 00000001  
> f760df84 f7ce4a84 f7ce4ac8
> [33034.505239] Call Trace:
> [33034.505239]  [<c0198b26>] ? kfree+0xe6/0xf0
> [33034.505239]  [<c0122e14>] do_exit+0x494/0x710
> [33034.505239]  [<c01230be>] do_group_exit+0x2e/0xb0
> [33034.505239]  [<c012314f>] sys_exit_group+0xf/0x20
> [33034.505239]  [<c01030d5>] syscall_call+0x7/0xb

actuatorTask in TASK_DEAD state. So, it is officially dead.

> [33034.505239]  =======================
> [33034.505239] Actuator Aper S [0x00000201] f7f01f04     0 28214      1
> [33034.505239]        f7f01f28 00000086 c057be64 f7f01f04 f7ce51c0  
> f7ce5414 f7f01f28 ce2e19e5
> [33034.505239]        0000137c 00000000 00000001 00000200 f7d80620  
> f7ce51c0 c01586e0 f7f01f4c
> [33034.505239]        c0158576 f7f01f6c c015891a 00000000 f7f01ebc  
> 00000006 00000000 c01586e0
> [33034.505239] Call Trace:
> [33034.505239]  [<c01586e0>] ? losyscall_event+0x0/0x180
> [33034.505239]  [<c0158576>] xnshadow_harden+0x86/0x1f0
> [33034.505239]  [<c015891a>] ? hisyscall_event+0xba/0x290
> [33034.505239]  [<c01586e0>] ? losyscall_event+0x0/0x180
> [33034.505239]  [<c015876f>] losyscall_event+0x8f/0x180
> [33034.505239]  [<c01586e0>] ? losyscall_event+0x0/0x180
> [33034.505239]  [<c014c89c>] __ipipe_dispatch_event+0x9c/0x170
> [33034.505239]  [<c01122f2>] __ipipe_syscall_root+0x42/0x110
> [33034.505239]  [<c01030ad>] system_call+0x29/0x4a

So, "Actuator Aperiodic Task" is blocked inside xnshadow_harden, in
state TASK_INTERRUPTIBLE | TASK_ATOMICSWITCH. This state is
transitional, and, in fact, I think you should not even be able to
observe it. The fact you got it two traces would be impossible, so I
think the tasks are blocked in these states, and what we observe here is
the harden machinery being jamed. When this happens, could you try to
hit sysrq+T again to see if you get the same states ?


-- 
                                                 Gilles.

