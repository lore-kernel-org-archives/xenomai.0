Message-ID: <47D2CAC4.6000204@domain.hid>
Date: Sat, 08 Mar 2008 18:20:04 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E08F317@domain.hid>
In-Reply-To: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E08F317@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Error when exiting pSOS-task with return
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Markus Osterried <markus.osterried@domain.hid>
Cc: Xenomai-core@domain.hid

Markus Osterried wrote:
> Hello,
>  
> with Xenomai 2.4 on Linux 2.6.18 on PowerPC I have seen the following trace:
>  
> Feb 26 19:37:25 (none) user.err kernel: BUG: sleeping function called
> from invalid context at kernel/rwsem.c:20
> Feb 26 19:37:25 (none) user.warn kernel: in_atomic():0, irqs_disabled():1
> Feb 26 19:37:25 (none) user.warn kernel: Call Trace:
> Feb 26 19:37:25 (none) user.warn kernel: [C19BFE50] [C000C114]
> show_stack+0x58/0x188 (unreliable)
> Feb 26 19:37:25 (none) user.warn kernel: [C19BFEA0] [C00128B0]
> __might_sleep+0xdc/0xf0
> Feb 26 19:37:25 (none) user.warn kernel: [C19BFEC0] [C0032304]
> down_read+0x24/0x58
> Feb 26 19:37:25 (none) user.warn kernel: [C19BFED0] [C00192C8]
> exit_mm+0x34/0xec
> Feb 26 19:37:25 (none) user.warn kernel: [C19BFEF0] [C001B000]
> do_exit+0x21c/0x98c
> Feb 26 19:37:25 (none) user.warn kernel: [C19BFF30] [C001B810]
> complete_and_exit+0x0/0x28
> Feb 26 19:37:25 (none) user.warn kernel: [C19BFF40] [C00041A0]
> ret_from_syscall+0x0/0x38
>  
>  
> This happens (sometimes) when a pSOS-task exits by returning from its
> main function.
> I have changed the return statement into t_delete(0) and there was no
> error anymore, so this isn't a major issue.
>  
> But anyway I would like to know whether this is a xenomai bug or it
> isn't allowed to exit a pSOS-task by returning from main function.
> I have seen at end of psos_task_trampoline that there is a
> pthread_exit() instead of a t_delete().
>

It is allowed to exit the task body directly. Another possibility is a bug in
old Adeos/ppc patch for 2.6.18, that would trigger when the nucleus has to relax
the exiting thread. Anyway, this issue is queued for investigation here. Thanks.

PS: you may want to check whether forcing the task to secondary mode before
calling t_delete(0) does not cause the issue to trigger again.

> Thanks
> Markus
>  
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.

