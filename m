MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 10 Oct 2019 22:37:44 +0200
Message-ID: <CAFLxGvx8ggvQmKSMVJ+JtMFzkQd0UB=fU7QRPoreEmzU_3fcoQ@mail.gmail.com>
Subject: ipipe_trap_hook() with IRQs off?
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I'm pretty sure I miss something obvious,but let's try.. :-)

Documentation/ipipe.rst says:
The notification is issued by a call to :c:func:`__ipipe_notify_trap`
which in turn invokes the :c:func:`ipipe_trap_hook` routine the
real-time core should override for receiving those events (*__weak*
binding). Interrupts are **disabled** in the CPU when
:c:func:`ipipe_trap_hook` is called.::

But in __ipipe_notify_trap() I see:
        if (likely(p->coflags & __IPIPE_TRAP_E)) {
                p->coflags |= __IPIPE_TRAP_R;
                hard_local_irq_restore(flags);
                data.exception = exception;
                data.regs = regs;
                ret = ipipe_trap_hook(&data);
                flags = hard_local_irq_save();
                p->coflags &= ~__IPIPE_TRAP_R;
        }

Why do you restore interrupts before calling ipipe_trap_hook?
So depending in the saved state, IRQs could be enabled again?

-- 
Thanks,
//richard

