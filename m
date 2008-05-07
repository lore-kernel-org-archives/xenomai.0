Message-ID: <4821E5BF.4040101@domain.hid>
Date: Wed, 07 May 2008 19:24:15 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F7E@afsexc01.aurora.aero>
In-Reply-To: <51B669A8A7D2914E9AB2B3F40AC6553E646F7E@afsexc01.aurora.aero>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] rt_task_send / receive problems various issues
 and	bug trace
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Karch, Joshua" <jkarch@domain.hid>
Cc: xenomai@xenomai.org

Karch, Joshua wrote:
> 
> Hello,
> 
> I'm using rt_task_send from a talker task and rt_task_receive/reply from
> a listener task.  When I launch the two tasks in the following order:
> listener task,  talker task,  everything runs normally.
> 
> However, when I launch the talker task first, and then the listener task
> second, I receive rt_task_send error -22 and after a bit of time the
> listener task starts up.

-EINVAL is not on the error list for rt_task_send(). Could you confirm this result?

 I know this is logical and to be expected,

No, it's not. rt_task_send() does wait for the receiver to listen to, unless you
 asked for a non blocking call using TM_NONBLOCK as a timeout.

> however, it appears that issuing the rt_task_send command to a task that
> hasn't been started occasionally locks up sufficient resources to
> prevent the listener task from starting. 

Any chance your code enters a tight loop due to rt_task_send() failing repeatedly?

 By controlling task startup
> order, I was able to circumvent this issue.  Both tasks have similar
> priorities (50, 51).
> 
> Additionally, I am unable to use rt_task_send with TM_NONBLOCK
> len = rt_task_send(listen_task,&talk_send,&talk_reply,TM_NONBLOCK);
> 
> I get a bug failure and have to reset the machine-- see below:
> 

Please disassemble your "vmlinux" kernel image, the exact one that causes a bug:
$ objdump -d vmlinux > foo.txt.
In that large file, search for the "__rt_task_receive" symbol (notice the double
underscore prefix, we also have the "rt_task_receive" symbol, but we don't need
this code at the moment), then paste&copy the disassembly code for that
function. I'll have a look.

Step #2 is to send a simple piece of code that exhibits the problem. This will
speed up the debugging and fixing process.

> The reason I want to use TM_NONBLOCK is so that I can send a trigger
> message from the producer task to the consumer task without requiring a
> reply to trigger the consumer task to act on the data received. I am
> using the rt_task_send trigger message to gate and synchronize the
> consumer task. Is a reply required for all rt_task_send? 
> 
> It seems if I don't send a reply when rt_task_send has a timeout
> specified the sending task locks up and the listening task runs rampant,
> i.e. rt_task_receive no longer blocks and the loop runs with no delay
> and essentially locks up the machine, since I don't use
> rt_set_task_periodic on the listening task.
> 
> Here is the trace, and it requires a reboot.  I also can attach the
> code- it is written in c++ with two separate classes as a model of the
> application I am building.
> 
> Thank you,
> 
> Joshua Karch
> 
> talker task started
> rt_task_send error
> len=-22, opcode=0
> listener task stBUG: unable to handle kernel NULL pointer dereferencearted
> rt_task_s at virtual address 0000020c
> end error
> len=-printing eip: c014f014 110, opcode=0
> *pde = 00000000
> Oops: 0000 [#1] PREEMPT
> Modules linked in: xeno_timerbench nfs ipv6 nfsd lockd nfs_acl sunrpc
> exportfs dm_snapshot dm_mirror dm_mod loop pcmcia firmware_class
> serio_raw psmouse yenta_socket rsrc_nonstatic pcmcia_core cs5535_gpio
> joydev evdev ext3 jbd mbcache usbhid ide_disk generic ohci_hcd ehci_hcd
> amd74xx usbcore ide_core e100 mii
> 
> Pid: 1973, comm: listen_task Not tainted (2.6.24.4 #12)
> EIP: 0060:[<c014f014>] EFLAGS: 00010093 CPU: 0
> EIP is at rt_task_receive+0x113/0x18b
> EAX: cdc71f28 EBX: fffffd98 ECX: c03c5500 EDX: cd820acc
> ESI: ffffff97 EDI: cd820610 EBP: cdc71edc ESP: cdc71ec4
>  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
> Process listen_task (pid: 1973, ti=cdc70000 task=cdc6d320
> task.ti=cdc70000)<0>
> I-pipe domain Linux
> Stack: 00000000 cdc71f28 00000000 cdc71ee8 cdc6d320 cdc71fb8 cdc71f4c
> c01515bf
>        b7d083ea cdc71f00 c0102cb1 ce46bc70 c03c7e90 cd820620 cdc6d620
> cd80ff44
>        c029f55b cdc71f34 00000082 b91264ee 0000002e cdc6d320 b9127ee2
> 0000002e
> Call Trace:
>  [<c01045f1>] show_trace_log_lvl+0x1a/0x2f
>  [<c01046a3>] show_stack_log_lvl+0x9d/0xa5
>  [<c0104769>] show_registers+0xbe/0x1fd
>  [<c01049c1>] die+0x119/0x20a
>  [<c010ef52>] do_page_fault+0x480/0x57e
>  [<c010ca34>] __ipipe_handle_exception+0x11e/0x166
>  [<c02a0e7f>] error_code+0x6f/0x80
>  [<c01515bf>] __rt_task_receive+0xbe/0x113
>  [<c0149b0d>] losyscall_event+0x99/0x13d
>  [<c013f05b>] __ipipe_dispatch_event+0xac/0x16c
>  [<c010c8b1>] __ipipe_syscall_root+0x6a/0xcf
>  [<c0103e89>] system_call+0x29/0x4a
>  =======================
> Code: 00 00 8d 87 bc 04 00 00 39 c2 0f 95 c0 0f b6 c0 f7 d8 21 d0 31 db
> 3d 58 02 00 00 74 06 8d 98 98 fd ff ff 8b 45 ec be 97 ff ff ff <8b> 93
> 74 04 00 00 3b 50 0c 77 23 85 d2 74 19 89 d1 8b b3 70 04
> EIP: [<c014f014>] rt_task_receive+0x113/0x18b SS:ESP 0068:cdc71ec4
> ---[ end trace 523bcd2b73b75979 ]---
> 
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

