Message-ID: <4C60FD37.20309@domain.hid>
Date: Tue, 10 Aug 2010 00:18:15 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
References: <307507.12667.qm@domain.hid>	
	<1281350069.1706.139.camel@domain.hid>
	<4C5FEB8C.200@domain.hid>	
	<1281361025.1706.143.camel@domain.hid>	
	<4C603899.5050402@domain.hid>	
	<1281418522.2986.21.camel@domain.hid>	
	<4C60F042.3000405@domain.hid>
	<1281422621.2986.39.camel@domain.hid>
In-Reply-To: <1281422621.2986.39.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Having trouble with a BeagleBoard GPIO interrupt
 pin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org



On 8/9/2010 11:43 PM, Philippe Gerum wrote:
... snipped...
>> Do you see any problem with me continuing with the above temp fix?
> No, because you only use request_irq() to set up the GPIO line properly,
> but you don't actually share the interrupt between linux and Xenomai,
> which is ok.
Great. I'll continue my debug.
>
>> It would also help if you could better describe the meaning of the
>> rtdm_irq_request() flags and whether the Linux request_irq() flags
>> have any implications to Adeos.
> They have none. The edge flag is purely Xenomai-related. When shared IRQ
> support is enabled, the EDGE flags passed to rtdm_irq_request() just
> gives a hint to the Xenomai interrupt dispatcher for dealing with edge
> interrupt handlers properly.
Then I should code the rtdm_irq_request() SHARE flag if I want to share 
an interrupt with another rtdm driver and, as you state below, rtdm IRQs 
must never be shared with Linux drivers.
Then IRQ37 [timer] must be a special case. It seems to be shared by both 
environments.

Then it would be best if I always code the EDGE flag for edge triggered 
interrupts (whether rising edge or falling edge). If the IRQ is shared, 
its a useful hint, and if the IRQ is not shared, the flag is ignored.
>> For example, I was quite surprised that both the request_irq() and
>> rtdm_irq_request() to the same IRQ succeeded even though neither
>> included a SHARE flag. This seems to require a rt driver to call both
>> routines to protect its xxxDetect registers.
> This is a current flaw in the Xenomai interrupt management routines;
> they should allow the IRQ trigger info to be defined when requesting an
> IRQ (via rtdm_irq_request) the same way request_irq() does on the linux
> side, but they do not support this yet.
Let me know when you have a proposed fix. I'm willing to test it on 
OMAP3 for you.
> request_irq and rtdm_irq_request are not supposed to work together; IRQ
> sharing between linux and Xenomai is not formally defined, because it is
> semantically wrong. Actually, a real-time interrupt hooked via
> rtdm_irq_request should not be grabbed via request_irq() at the same
> time for handling the IRQ. This would mean that both linux and the rt
> domain share that interrupt, which would introduce a flaw, since a
> dependency would exist between the non-rt linux handling and the rt
> handling of the same IRQ. Think of a level-triggered IRQ, requiring
> linux to handle it before it is unmasked anew. To prevent an interrupt
> storm, the rt domain would then have to wait for the non-rt one (i.e.
> linux) to unmask the interrupt channel (i.e. maybe a non-rt device is
> requiring attention), thus introducing an unbounded latency.
Thanks for your help.

Regards,
Bob Feretich


