Subject: Re: ipipe_trap_hook() with IRQs off?
References: <CAFLxGvx8ggvQmKSMVJ+JtMFzkQd0UB=fU7QRPoreEmzU_3fcoQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <36ffcc1d-7559-51e1-7610-2a92549438ef@siemens.com>
Date: Fri, 11 Oct 2019 08:50:28 +0200
MIME-Version: 1.0
In-Reply-To: <CAFLxGvx8ggvQmKSMVJ+JtMFzkQd0UB=fU7QRPoreEmzU_3fcoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard.weinberger@gmail.com>, xenomai@xenomai.org

On 10.10.19 22:37, Richard Weinberger via Xenomai wrote:
> I'm pretty sure I miss something obvious,but let's try.. :-)
> 
> Documentation/ipipe.rst says:
> The notification is issued by a call to :c:func:`__ipipe_notify_trap`
> which in turn invokes the :c:func:`ipipe_trap_hook` routine the
> real-time core should override for receiving those events (*__weak*
> binding). Interrupts are **disabled** in the CPU when
> :c:func:`ipipe_trap_hook` is called.::
> 
> But in __ipipe_notify_trap() I see:
>          if (likely(p->coflags & __IPIPE_TRAP_E)) {
>                  p->coflags |= __IPIPE_TRAP_R;
>                  hard_local_irq_restore(flags);
>                  data.exception = exception;
>                  data.regs = regs;
>                  ret = ipipe_trap_hook(&data);
>                  flags = hard_local_irq_save();
>                  p->coflags &= ~__IPIPE_TRAP_R;
>          }
> 
> Why do you restore interrupts before calling ipipe_trap_hook?
> So depending in the saved state, IRQs could be enabled again?
> 

This heavily depends on the type of exception. Some of them enter their 
low-level handler with interrupts off, and those will keep them off for 
ipipe_trap_hook. Others start with interrupts enabled (there are many 
"harmless" synchronous faults), and this is what we preserve here for 
the callback. Seems the description is out of sync though.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

