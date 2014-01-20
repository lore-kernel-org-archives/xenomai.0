Message-ID: <52DD89AF.4090905@xenomai.org>
Date: Mon, 20 Jan 2014 21:40:15 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANKLDmv_hfbVcWzoxjerWOTEWqEWPnQzUu44GF=SbC0iSopDOg@mail.gmail.com>
 <52DCF0D1.4000307@xenomai.org>
 <CANKLDms3aXrSoov7Z9T2JBN6fpmuh43LCQ0RUEETrDAYr3=1dA@mail.gmail.com>
In-Reply-To: <CANKLDms3aXrSoov7Z9T2JBN6fpmuh43LCQ0RUEETrDAYr3=1dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xnarch_xchg infinite loop
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henri Roosen <henriroosen@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/20/2014 11:02 AM, Henri Roosen wrote:
> On Mon, Jan 20, 2014 at 10:48 AM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
>> On 01/20/2014 09:31 AM, Henri Roosen wrote:
>>> Hi all,
>>>
>>> We have the problem that (hot-)rebooting our Xenomai system fails every 1
>>> out of 10 times.
>>>
>>> The system is an ARM iMX6Solo (Cortex-A9) running Xenomai 2.6.2.1 and
>>> kernel 3.0 (freescale branch).
>>>
>>> When the system hangs at reboot, it is in an infinite loop in the Xenomai
>>> atomic exchange implementation, with STREX always returning 1:
>>>
>>> __xnarch_xchg
>>> S:0xC0094B2C : ADD      r3,r6,#0x890
>>> S:0xC0094B30 : LDREX    r2,[r3]
>>> S:0xC0094B34 : STREX    r1,r9,[r3]
>>> S:0xC0094B38 : TEQ      r1,#0
>>> S:0xC0094B3C : BNE      {pc}-0xc ; 0xc0094b30
>>>
>>> Does anyone know what is causing the STREX to always return 0 and why it
>>> might get into this state?
>>
>> Normally, strex fails if "something else" stores data in between ldrex
>> and strex. Do you have the full stack trace?
>>
> 
> Thank you for your reply Gilles. Please find the stacktrace below:
> 
> #0 __xnarch_xchg( size = 4, x = 3204479504, ptr = <Value optimised away by
> compiler> ) at atomic_asm.h:79
> #1 xnintr_irq_handler( irq = 260, cookie = (void*) 0xBF0079E8 ) at
> atomic_asm.h:93
> #2 __ipipe_sync_stage() at core.c:1301
> #3 ipipe_suspend_domain() at core.c:856
> #4 __ipipe_walk_pipeline( pos = (struct list_head*) 0xC0463884 ) at
> core.c:797
> #5 __ipipe_handle_irq( irq = 98, flags = 0 ) at ipipe.c:564
> #6 __ipipe_grab_irq( irq = <Value optimised away by compiler>, regs =
> (struct pt_regs*) 0xCC897DD8 ) at ipipe.c:618
> #7 [__irq_svc+0x40]

I do not really see what is going on. However, how come you have a
driver still running while rebooting? Do you not remove the drivers
before rebooting? Also, __irq_svc means you received an interrupt while
in svc mode, so, it would be interesting to know what is below
__irq_svc. I believe you can know that by adding a call to show_stack
(and preferably build the kernel with frame pointers). The trick will be
to avoid getting a show_stack on every interrupt.

Regards.

-- 
                                                                Gilles.

