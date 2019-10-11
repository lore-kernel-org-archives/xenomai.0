MIME-Version: 1.0
References: <CAFLxGvx8ggvQmKSMVJ+JtMFzkQd0UB=fU7QRPoreEmzU_3fcoQ@mail.gmail.com>
 <36ffcc1d-7559-51e1-7610-2a92549438ef@siemens.com>
In-Reply-To: <36ffcc1d-7559-51e1-7610-2a92549438ef@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 11 Oct 2019 09:06:54 +0200
Message-ID: <CAFLxGvy8KXTtQkTNneE-rk73RjNxw5JWK1vET7cRD=hpn224rA@mail.gmail.com>
Subject: Re: ipipe_trap_hook() with IRQs off?
Content-Type: text/plain; charset="UTF-8"
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

Jan,

On Fri, Oct 11, 2019 at 8:50 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >          if (likely(p->coflags & __IPIPE_TRAP_E)) {
> >                  p->coflags |= __IPIPE_TRAP_R;
> >                  hard_local_irq_restore(flags);
> >                  data.exception = exception;
> >                  data.regs = regs;
> >                  ret = ipipe_trap_hook(&data);
> >                  flags = hard_local_irq_save();
> >                  p->coflags &= ~__IPIPE_TRAP_R;
> >          }
> >
> > Why do you restore interrupts before calling ipipe_trap_hook?
> > So depending in the saved state, IRQs could be enabled again?
> >
>
> This heavily depends on the type of exception. Some of them enter their
> low-level handler with interrupts off, and those will keep them off for
> ipipe_trap_hook. Others start with interrupts enabled (there are many
> "harmless" synchronous faults), and this is what we preserve here for
> the callback. Seems the description is out of sync though.

Yeah, the description indicates that ipipe guarantees that IRQs are off
but you leave them as-is and just disable them for a short time to deal with
p->coflags.

Thanks a lot for the clarification!

---
Thanks,
//richard

