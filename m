MIME-Version: 1.0
References: <CA+K1mPF--SuW4W3Gh_4j8pk=YbX+E2R-aYRxXxh4T8HHbSfLMw@mail.gmail.com>
In-Reply-To: <CA+K1mPF--SuW4W3Gh_4j8pk=YbX+E2R-aYRxXxh4T8HHbSfLMw@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 29 Apr 2022 21:01:33 +0200
Message-ID: <CAFLxGvwS4v_y74uwUfRg5NOFPZ-uXFoanrKVkPuXxap99KGn4Q@mail.gmail.com>
Subject: Re: Interrupt handler illicit call
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: C Smith <csmithquestions@gmail.com>
Cc: Xenomai List <xenomai@xenomai.org>

On Fri, Apr 29, 2022 at 9:04 AM C Smith via Xenomai <xenomai@xenomai.org> wrote:
> int Lp_port_handler(rtdm_irq_t *irq_handle_p)
> {
>    static int err;
>    unsigned long next;
>    rtdm_irq_t *handle_p;
>
>    handle_p = rtdm_irq_get_arg(irq_handle_p, rtdm_irq_t);
>
>    next = rtdm_clock_read();
>    // do some timing calculations with 'next' var here ...
>    err = rtdm_irq_enable(handle_p);   //re-enable this for subsequent interrupts

You don't need this.
Unconditionally enabling the interrupt line will confuse the IRQ subsystem.

>   return 0;

Please use RTDM_IRQ_HANDLED here instead of raw values.

> }

Thanks,
//richard

