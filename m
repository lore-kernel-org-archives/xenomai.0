Message-ID: <50780104-0374-2f3e-ba1c-a7b8295a3991@siemens.com>
Date: Tue, 3 May 2022 07:52:34 +0200
MIME-Version: 1.0
Subject: Re: Interrupt handler illicit call
Content-Language: en-US
References: <CA+K1mPF--SuW4W3Gh_4j8pk=YbX+E2R-aYRxXxh4T8HHbSfLMw@mail.gmail.com>
 <CAFLxGvwS4v_y74uwUfRg5NOFPZ-uXFoanrKVkPuXxap99KGn4Q@mail.gmail.com>
 <0d32fb5d-5eb8-b367-df21-53f8e32f78bd@siemens.com>
 <CA+K1mPFY9y2s37Y=k8xwJorgXzoYWTEDihMYeej_OhZPYQ+5sA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CA+K1mPFY9y2s37Y=k8xwJorgXzoYWTEDihMYeej_OhZPYQ+5sA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: C Smith <csmithquestions@gmail.com>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, Xenomai List <xenomai@xenomai.org>

On 02.05.22 20:08, C Smith wrote:
> On Sun, May 1, 2022 at 11:25 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 29.04.22 21:01, Richard Weinberger via Xenomai wrote:
>>> On Fri, Apr 29, 2022 at 9:04 AM C Smith via Xenomai <xenomai@xenomai.org> wrote:
>>>> int Lp_port_handler(rtdm_irq_t *irq_handle_p)
>>>> {
>>>>    static int err;
>>>>    unsigned long next;
>>>>    rtdm_irq_t *handle_p;
>>>>
>>>>    handle_p = rtdm_irq_get_arg(irq_handle_p, rtdm_irq_t);
>>>>
>>>>    next = rtdm_clock_read();
>>>>    // do some timing calculations with 'next' var here ...
>>>>    err = rtdm_irq_enable(handle_p);   //re-enable this for subsequent interrupts
>>>
>>> You don't need this.
>>> Unconditionally enabling the interrupt line will confuse the IRQ subsystem.
>>>
>>
>> ...and it was never supported in primary mode. If it worked, then by
>> chance and by disabling related checks. Enable/disable are no masking APIs.
>>
>> Jan
>>
>>>>   return 0;
>>>
>>> Please use RTDM_IRQ_HANDLED here instead of raw values.
>>>
>>>> }
>>>
>>> Thanks,
>>> //richard
> 
> I was thinking the rtdm_irq_enable() was like an STI, but that was a
> mistake.  I looked at the 16550A and CAN drivers for examples of
> interrupt handlers, and indeed I found I must return RTDM_IRQ_HANDLED
> too like Richard says, or Xenomai de-registers the interrupt since no
> one appears to handle it. There doesn't seem to be an interrupt
> example in Xenomai 3.1 or Xeno3.2 sources. Perhaps I should submit a
> demo interrupt handler module as a patch?

Well, we have quite a few real drivers in the codebase. Maybe rather
enable one to serve a reference, e.g. by adding a document that
describes the relevant bits a bit more verbose? The UART drivers my
serve as input here as they do not come with an own core.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

