Message-ID: <530A77F9.9040407@xenomai.org>
Date: Sun, 23 Feb 2014 23:36:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAEbDrgkifqMcqqEqh5hKA90YzFzcyDxLHFC79F8CWvZi5heyWQ@mail.gmail.com>
 <530A69FD.9060708@xenomai.org>
 <CAEbDrg=PLtrwo3aDUDa6wOJzsj7P4kmYZ64irV8e+P7MiEzTig@mail.gmail.com>
In-Reply-To: <CAEbDrg=PLtrwo3aDUDa6wOJzsj7P4kmYZ64irV8e+P7MiEzTig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RaspberryPi kernel 3.8 issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gregory Dymarek <gregd72002@gmail.com>
Cc: xenomai@xenomai.org

On 02/23/2014 11:18 PM, Gregory Dymarek wrote:
> Thank you for such quick response!
> 
> Actually yes, this is a warning. Sorry.
> 
> That's the content:
> irqreturn_t handle_irq_event_percpu(struct irq_desc *desc, struct irqaction
> *action)
> ...
>  if (WARN_ONCE(!irqs_disabled(),"irq %u handler %pF enabled interrupts\n",
> irq, action->handler))
>       local_irq_disable();
> 
> 
> Should the IRQs be 'not disabled' at the first place?

irqs_disabled() does not really test if irqs are disabled when running
over I-pipe, it tests if the linux domain is "stalled", i.e. if irqs are
disabled, but "virtually".

Anyway, I believe the problem is that handle_IRQ is called, normally a
call to ipipe_do_irq should be inserted, so, the normal interposition of
the I-pipe seems missing.

Could you try to disable stack unwinding to see if we have a different
trace?

-- 
                                                                Gilles.

