Message-ID: <444C89F4.3040302@domain.hid>
Date: Mon, 24 Apr 2006 10:19:00 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <b647ffbd0604120138p5088006aqf074c711a0478487@domain.hid>	
	<44416943.4070702@domain.hid>
	<b647ffbd0604220254l154fcc7dh462c7d45bcd2c441@domain.hid>
In-Reply-To: <b647ffbd0604220254l154fcc7dh462c7d45bcd2c441@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [REQUEST] eliminate the
	rthal_critical_enter/exit() from rthal_irq_request()
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
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:
> Hi,
> 
> I haven't had access to my laptop during this week so the patches
> follow only now.
>

Merged, thanks.

> Yet another issue remains that may lead to a deadlock under some circumstances:
> 
> - rt_intr_delete() calls xnintr_detach() while holding the "nklock".
>
> - xnintr_detach() (with CONFIG_SMP) spins in xnintr_shirq_spin()
> when a corresponding ISR is currently running.
> 
> - now this ISR calls any function that uses "nklock" (everything make
> use of it) ... Bum!
> 
> I first thought about moving xnintr_detach() out of the locked section
> in rt_intr_delete() but it somewhat breaks interface consistency ---
> e.g. xeno_mark_delete() is called before the object is completely
> destroyed.
>

That's not a problem, the deletion marker will never be anything else 
than a pure magic word stored in some object's descriptor, so we could 
indeed first mark the object as deleted, then release the lock before 
proceeding to the actual deletion.

> Another approach would be to introduce a service like
> xnintr_synchronize() and enfource the upper interfaces (e.g. skins) to
> make use of it in their _delete() methods.

That would be useful too for solving the "concurrent ISR while deleting 
issue", but would not enforce single deletion in the SMP case, I guess.

> 
> The problem here is that the xnintr_shirq - interface is not complete
> and safe without xnintr_shirq_spin() on detaching step and it becomes
> somewhat blured with the enforcement like "on SMP systems one should
> always call xnintr_synchronize() right after calling xnintr_detach()".
> 
> So I'm still thinking how to fix it better...
> 
> 
> --
> Best regards,
> Dmitry Adamushko


-- 

Philippe.

