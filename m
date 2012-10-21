Message-ID: <50844242.7010107@xenomai.org>
Date: Sun, 21 Oct 2012 20:43:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50812949.5040403@openwide.fr> <50814532.5090408@xenomai.org>
	<5082CD5C.1040409@openwide.fr> <5082DED2.1050405@xenomai.org>
	<50835162.5020401@openwide.fr>
In-Reply-To: <50835162.5020401@openwide.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] s3c24xx with clocksource/clockevent (kernel 3.2.21)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Romain Naour <romain.naour@openwide.fr>
Cc: xenomai@xenomai.org

On 10/21/2012 03:35 AM, Romain Naour wrote:

>> You mean the patch for the UART ? I can not take that patch. You have to
>> understand what goes wrong in the I-pipe core, or irq chip callbacks
>> implementation for this processor, and fix it there, not in the irq
>> handler for the serial interrupt.
> I think there is a problem when Linux unmask an IRQ line with 
> irq_enable() and when there is an IRQ pending behind.
> I made some comments on the ipipe-tracer log 
> (UART-samsung-bug-ipipe-tracer.txt)


Ok: first comment: thanks to this patch:
http://git.xenomai.org/?p=ipipe-gch.git;a=commitdiff;h=352ee07368a89133df74948f3dd71ae657c519a0;hp=5e7413789eb3d1ca1613e986cbeb6c979082a217

We know that irq_state_clr_masked is called when unmask_irq is called.

Second, to know why cond_unmask_irq does not unmask the irq, you can use
ipipe_trace_special to print the value of the various conditions.

It would have been better to include the relevant parts of the trace in
the mail body, this would have made answering simpler.

-- 
                                                                Gilles.

