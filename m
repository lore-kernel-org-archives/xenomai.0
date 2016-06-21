Date: Tue, 21 Jun 2016 11:29:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160621092933.GC18662@hermes.click-hack.org>
References: <f4f9f773-e9d1-0239-235c-a14cad91877f@peak-system.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4f9f773-e9d1-0239-235c-a14cad91877f@peak-system.com>
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
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: xenomai@xenomai.org

On Tue, Jun 21, 2016 at 11:22:37AM +0200, Stephane Grosjean wrote:
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
> I was not aware about these Linux kernel driver requirements...

These are Xenomai requirements, not Linux kernel driver requirements.

> On the 
> contrary, regarding linux-can drivers (for example), the IRQ is 
> requested when the device is opened only, not when it is probed. An it 
> is freed when the device is closed.

the ->open_rt and ->close_rt callbacks in RTDM drivers have not been
used in in-tree RTDM drivers for some time in 2.x. In 3.x, this is
official, you can no longer implement primary mode open/close, see:
https://xenomai.org/migrating-from-xenomai-2-x-to-3-x/#Updated_device_operation_descriptor

So, open and close can be considered initialization/cleanup context.

>  In my mind, this was a good choice 
> because it avoids useless chained ISRs during the times the devices are 
> not opened. So, the above assumption is a little rough, IMHO...
> 
> Anyway, this is how new things are... Any advice for us not to change 
> the whole architecture of our driver will be welcome.

I believe you do not need to change the whole architecture of your
driver.

-- 
					    Gilles.
https://click-hack.org

