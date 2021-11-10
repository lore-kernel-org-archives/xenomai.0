References: <AM6PR08MB3416216AD62539EF2AC88688B2939@AM6PR08MB3416.eurprd08.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Regarding the development of an OOB compatible driver
Date: Wed, 10 Nov 2021 12:15:57 +0100
In-reply-to: <AM6PR08MB3416216AD62539EF2AC88688B2939@AM6PR08MB3416.eurprd08.prod.outlook.com>
Message-ID: <87r1bo8bne.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Godbille, Clement" <Clement.Godbille2@leoni.com>
Cc: xenomai@xenomai.org


"Godbille, Clement via Xenomai" <xenomai@xenomai.org> writes:

> Dear support team members,
>
> I successfully installed the EVL core (v5.10.59) on a Raspberry pi 4 with a 64 bits OS, along the EVL library. EVL tests ran smoothly and I was able to use its timers and witness improvements in my application for clocks and cyclic time.
>
> I am now trying to turn an existing driver (amba UART pl011) into an OOB capable driver for the same application. In the open method associated with this driver,  I called the evl_open_file, evl_init_wait and evl_init_poll_head methods to initialize my oob-related structure following what is done in the GPIO OOB capable driver provided by EVL.
>
> For  now I am just trying to add to its interruption the IRQF_OOB flag. It seems that my interruption actually becomes out-of-band compatible as the "oob" flag appears when I look into the /proc/interrupts file.
>
> However I don't know what I am missing in my driver initialization, for as soon as the driver must handle an interrupt the OS blocks indefinitely. It also blocks when I remove all code in the IRQ handler with return IRQ_HANDLED, but not when I return IRQ_NONE. In that case the kernel returns the message "out-of-band irq: stuck or unexpected", which is an expected behaviour.
>
> I didn't change much in the original driver so far, I didn't even create oob_read, oob_write or oob_ioctl methods yet, as I suppose those steps come afterwards. I only created an oob_poll method which would deal with events received in my interruption.
>
> I am asking you if it seems to you that I am not correctly using EVL. I must also admit that this is my very first experience with kernel development so I may also make inappropriate changes to my driver unrelated to EVL.
>

If you tell the interrupt pipeline to deliver the interrupt to the oob
stage to an empty handler, it won't run any code acknowledging the event
device-wise, which usually ends up badly as one would expect. If the
original in-band code is executed by such handler over the oob stage,
things will go south as well.

Once the pipeline is enabled in the kernel, you may consider that any
device IRQ is a NMI in disguise, and we cannot run common services over
NMI context because the event might preempt almost anywhere, regardless
of locks and irq-free sections. There is a way to prevent this locally,
but this is the idea.

irq_post_inband(<irq>) [1] can be used to mark some <irq> as pending in
the in-band log, so that the attached handler in called from the in-band
stage at some point later.

e.g. say that the following handler is attached to some irq, which your
code requests with IRQF_OOB set:

static irqreturn_t irq_handler(int irq, void *data)
{
        if (running_oob()) { /* called first from the oob stage because of IRQF_OOB */
             irq_post_inband(irq); /* now, schedule a call from in-band */
        } else {
           /* getting there as a result of earlier irq_post_inband() */
        }
}

In a nutshell, all IRQs which are not marked IRQF_OOB get posted to the
in-band stage and always run from there. This context is synchronized
with the rest of the common kernel activities, so it is ok to call the
in-band kernel infrastructure for handling the event.

IRQs which bear the IRQF_OOB flag are first delivered over the oob stage
to the very same handler, not serialized with these common
activities. Next, that handler might decide to propagate this event to
the lower stage (using irq_post_inband()) if need be.

This is usually not wanted, with the device-related handling performed
on the oob stage directly, typically using some service from the EVL
kernel API. This said, in some device-specific cases like dealing with
multiple DMAs channels with different latency requirements, one may have
to deal with events selectively either from the in-band or oob context,
depending on their actual source [2].

bottom-line: the code which is currently used by the PL011 driver to
deal with interrupts cannot be traversed from the oob context "as
is". Accessing the hw from either stages is ok, but calling the common
in-band services is not. A typical example is the code path framed by
CONFIG_RAW_PRINTK in the amba driver you mentioned, which is part of the
Dovetail code. That code is fine to run over oob or in-band context
indifferently, because it serializes appropriately for this, and makes
sure not to tread on unsafe paths.

A good starting point is reading [3][4] if you did not already.

[1] https://evlproject.org/dovetail/pipeline/pipeline_inject/
[2] https://evlproject.org/core/oob-drivers/dma/
[3] https://evlproject.org/dovetail/pipeline/
[4] https://evlproject.org/dovetail/porting/irqflow/

-- 
Philippe.

