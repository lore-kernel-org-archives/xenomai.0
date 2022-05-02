Message-ID: <0d32fb5d-5eb8-b367-df21-53f8e32f78bd@siemens.com>
Date: Mon, 2 May 2022 08:25:38 +0200
MIME-Version: 1.0
Subject: Re: Interrupt handler illicit call
Content-Language: en-US
References: <CA+K1mPF--SuW4W3Gh_4j8pk=YbX+E2R-aYRxXxh4T8HHbSfLMw@mail.gmail.com>
 <CAFLxGvwS4v_y74uwUfRg5NOFPZ-uXFoanrKVkPuXxap99KGn4Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAFLxGvwS4v_y74uwUfRg5NOFPZ-uXFoanrKVkPuXxap99KGn4Q@mail.gmail.com>
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
To: Richard Weinberger <richard.weinberger@gmail.com>, C Smith <csmithquestions@gmail.com>
Cc: Xenomai List <xenomai@xenomai.org>

On 29.04.22 21:01, Richard Weinberger via Xenomai wrote:
> On Fri, Apr 29, 2022 at 9:04 AM C Smith via Xenomai <xenomai@xenomai.org> wrote:
>> int Lp_port_handler(rtdm_irq_t *irq_handle_p)
>> {
>>    static int err;
>>    unsigned long next;
>>    rtdm_irq_t *handle_p;
>>
>>    handle_p = rtdm_irq_get_arg(irq_handle_p, rtdm_irq_t);
>>
>>    next = rtdm_clock_read();
>>    // do some timing calculations with 'next' var here ...
>>    err = rtdm_irq_enable(handle_p);   //re-enable this for subsequent interrupts
> 
> You don't need this.
> Unconditionally enabling the interrupt line will confuse the IRQ subsystem.
> 

...and it was never supported in primary mode. If it worked, then by
chance and by disabling related checks. Enable/disable are no masking APIs.

Jan

>>   return 0;
> 
> Please use RTDM_IRQ_HANDLED here instead of raw values.
> 
>> }
> 
> Thanks,
> //richard
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux

