From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <b647ffbd0609140055t328fec1fi3b5d86da178d790e@domain.hid>
References: <58168.129.217.4.64.1158067468.squirrel@domain.hid>
	<1158091876.5020.8.camel@domain.hid>
	<b647ffbd0609121358v5b5bff80o6e4e08c859eb110a@domain.hid>
	<450727D1.6060203@domain.hid> <4507C49A.5070909@domain.hid>
	<b647ffbd0609140055t328fec1fi3b5d86da178d790e@domain.hid>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 10:46:35 +0200
Message-Id: <1158223595.5040.16.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Xenomai-help] Bad EIP kernel-Oops
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Thu, 2006-09-14 at 09:55 +0200, Dmitry Adamushko wrote:
> 
> 
> On 13/09/06, Jan Kiszka <jan.kiszka@domain.hid> wrote: 
> 
>         It's the indirect call to the event handler.
>         
>            8b3:   8b 55 e4                mov    0xffffffe4(%ebp),%edx
>            8b6:   50                      push   %eax
>         -> 8b7:   ff 94 93 80 22 00 00    call   *0x2280(%ebx,%edx,4)
>            8be:   83 c4 0c                add    $0xc,%esp
>            8c1:   85 c0                   test   %eax,%eax
>         
>         In my case the kernel tries to access the address 0xd09bc5e5
>         which seems
>         like it used to be a valid one.
> 
> I suppose, you have <= 256 Mb on this machine? If so, 0xd09bc5e5
> belongs to vmalloc()'ed area (in the past). So that was likely some
> module (e.g. nucleus).
>  
> 
>         So this looks like we really need some mechanism to make sure
>         all CPUs
>         use the updated pointers after unhooking some event handler
>         and before 
>         proceeding with further cleanups.
> 
> It's more complicated, I'm afraid. We need to be sure the event
> handler function itself will not disappear in the mean time. Hence,
> module unloading should be delayed, iow something alike
> synchronize_rcu() that blocks a "cleanup caller" (which calls
> unregister_domain()) untill all the readers are done with their
> activities.
> 
> Maybe it's wrong. Some more code reading would be required.
> 

The proper fix is to synchronize ipipe_catch_event(..., NULL) with the
event dispatcher, so that any caller could legitimately assume that no
subsequent call to the former handler will happen on any CPU after this
service has returned. Since ipipe_unregister_domain() may already
legitimately assume that all event handlers have been cleared using
ipipe_catch_event() by the caller before proceeding, the issue would be
solved.

The difficult part is to refrain from masking the hw interrupts when
running the event handlers for the sake of keeping short latencies
(nothing would prevent those handlers to re-enable interrupts anyway).
IOW, using a big stick like the critical inter-CPU lock is not the
preferred option.

> 
>  
>         Jan
>         
> 
> -- 
> Best regards,
> Dmitry Adamushko
-- 
Philippe.



