References: <f4f9f773-e9d1-0239-235c-a14cad91877f@peak-system.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <499d911c-c604-14b1-446b-33106c55b2c9@xenomai.org>
Date: Tue, 21 Jun 2016 12:11:09 +0200
MIME-Version: 1.0
In-Reply-To: <f4f9f773-e9d1-0239-235c-a14cad91877f@peak-system.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 3 vs 2.6: rtdm_irq_request() calling task
 context change
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stephane Grosjean <s.grosjean@peak-system.com>, xenomai@xenomai.org

On 06/21/2016 11:22 AM, Stephane Grosjean wrote:
> Hi,
> 
> https://xenomai.org/migrating-from-xenomai-2-x-to-3-x/ says:
> 
> "rtdm_irq_request/free() and rtdm_irq_enable/disable() call pairs must
> be called from a Linux task context, which is a restriction that did not
> exist previously with Xenomai 2.x."
> 
> and, a few lower lines:
> 
> "Since allocating, releasing, enabling or disabling real-time interrupts
> is most commonly done from driver initialization/cleanup context already,"
> 
> I was not aware about these Linux kernel driver requirements... On the

The mainline kernel does not have to deal with dual kernel issues, by
definition.

> contrary, regarding linux-can drivers (for example), the IRQ is
> requested when the device is opened only, not when it is probed. An it
> is freed when the device is closed. In my mind, this was a good choice
> because it avoids useless chained ISRs during the times the devices are
> not opened.

Your issue is about depending on open_rt() which is long gone, nothing
prevents you from hooking IRQs from the current open() handler. If you
expected IRQ hooking services to meet any sort of real-time requirement,
then you were wrong, they just can't. Hooking the IRQ from the open()
handler will just work.

> So, the above assumption is a little rough, IMHO...
> 

Xenomai relies on the linux kernel internals for IRQ
installation/cleanup duties, which can only be called from a plain Linux
context for common hardware such as chip controllers depending on the
PCI framework. Enabling/disabling IRQ channels have the same
requirement. Even more services we need during these specific phases
also have the very same requirement.

Some code may have been lucky enough to run IRQ installation/cleanup
calls from RT context without any issue, only due to the underlying
interrupt controller code not traversing regular Linux locking constructs.

In addition, there are cases when it is simply not possible to disable
an IRQ channel safely from a RT context.

All these issues have been identified over the years and discussed on
this mailing list several times, the related changes address them.

-- 
Philippe.

