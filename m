References: <7df40972.9ec7.15b003569a0.Coremail.13824125580@163.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <08aefb15-4754-43e2-0dd3-42e002d14426@xenomai.org>
Date: Sun, 26 Mar 2017 16:41:43 +0200
MIME-Version: 1.0
In-Reply-To: <7df40972.9ec7.15b003569a0.Coremail.13824125580@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] about "xnshadow_harden" puzzle,
 when and where the "rthal_current_domain" became head domain?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5pu55a2Q6b6Z?= <13824125580@163.com>, xenomai@xenomai.org

On 03/24/2017 01:05 PM, 曹子龙 wrote:
> i encounter a problem when reading the xenomai 2.6.5 code about the "xnshaode_harden" implement ion,  when a thread running in root domain migrate to the head domain, usually by calling "xnshadow_harden" interface to do this.
> 
> the the operation completed by wakeup the "gatekeeper_thread" and then call the "xnpod_schedule", finally, the shadow thread comeback from "schedule". 
> 
> 
> look at the red worlds below, it seems it was surely that the current domain is head, but, during these operation, i did not see anywhere  change the current domain from root to  head,  so did i miss something about the flow? any one can help me, thanks for your kindly help.
> int xnshadow_harden(void)
> {
> 
> 
>        ................................
> sched->gktarget = curr;
> xnthread_set_info(curr, XNATOMIC);
> set_current_state(TASK_INTERRUPTIBLE | TASK_ATOMICSWITCH);
> 
> 
> wake_up_process(sched->gatekeeper);
> 
> 
> schedule();
>       ...........................
> if (rthal_current_domain == rthal_root_domain) {
>                           // exceptions, rarely happen.
>        }

This is too complex to explain only in a few words and time is a scarce
resource, so you will have to figure out the details by yourself, but
basically:

- the gatekeeper calls xnpod_schedule(), which notices that the root
domain is current, therefore escalates the request to the primary domain
via a pseudo IRQ.

- the interrupt pipeline dispatches the pseudo IRQ back to the Xenomai
core (xnpod_schedule_handler()), after a switch to the head domain. See
dispatch_irq_head() from kernel/ipipe/core.c.

-- 
Philippe.

