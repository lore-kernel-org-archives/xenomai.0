From: Stephane Grosjean <s.grosjean@peak-system.com>
Message-ID: <f4f9f773-e9d1-0239-235c-a14cad91877f@peak-system.com>
Date: Tue, 21 Jun 2016 11:22:37 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] Xenomai 3 vs 2.6: rtdm_irq_request() calling task context
	change
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

https://xenomai.org/migrating-from-xenomai-2-x-to-3-x/ says:

"rtdm_irq_request/free() and rtdm_irq_enable/disable() call pairs must 
be called from a Linux task context, which is a restriction that did not 
exist previously with Xenomai 2.x."

and, a few lower lines:

"Since allocating, releasing, enabling or disabling real-time interrupts 
is most commonly done from driver initialization/cleanup context already,"

I was not aware about these Linux kernel driver requirements... On the 
contrary, regarding linux-can drivers (for example), the IRQ is 
requested when the device is opened only, not when it is probed. An it 
is freed when the device is closed. In my mind, this was a good choice 
because it avoids useless chained ISRs during the times the devices are 
not opened. So, the above assumption is a little rough, IMHO...

Anyway, this is how new things are... Any advice for us not to change 
the whole architecture of our driver will be welcome.

Stéphane


--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183 
Geschaeftsfuehrung: A.Gach, U.Wilhelm
--

