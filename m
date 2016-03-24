References: <1457983382.28082.11.camel@henry-ThinkCentre-M93p>
 <56E71CC1.5070600@xenomai.org>
 <1457990656.28082.20.camel@henry-ThinkCentre-M93p>
 <56E90784.7080702@xenomai.org>
 <1458260422.4930.2.camel@henry-ThinkCentre-M93p>
 <1458666633.2713.2.camel@henry-ThinkCentre-M93p>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56F3C088.1030000@xenomai.org>
Date: Thu, 24 Mar 2016 11:25:12 +0100
MIME-Version: 1.0
In-Reply-To: <1458666633.2713.2.camel@henry-ThinkCentre-M93p>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Reentrant Interrupts on Freescale LS1021A
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henry Bausley <hbausley@deltatau.com>, xenomai@xenomai.org

On 03/22/2016 06:10 PM, Henry Bausley wrote:
> What we are seeing is if we are in the intr->isr(intr) and another H/W
> interrupt occurs it is replayed after the current intr->isr(intr) is
> finished.  
> 
> What we are trying to accomplish is when a second H/W interrupt occurs
> the current intr->isr(intr) is stopped and a second call to
> intr->isr(intr) gets processed then when finished the original
> intr->isr(intr) .  
> 
> 
> Is there a way to accomplish what we are trying to do?
> 

You need to fixup the virtual interrupt state for the head domain to
match the hardware IRQ state change. There are pipeline helpers
combining both operations the proper way. e.g. in your handler:

ipipe_unstall_head(); /* enable IRQs (hw-wise and virtually) */
...
ipipe_stall_head(); /* disable IRQs for the head domain */

-- 
Philippe.

