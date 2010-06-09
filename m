Message-ID: <4C0F58C7.1060700@domain.hid>
Date: Wed, 09 Jun 2010 11:03:03 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <20100609084823.99850@domain.hid>
In-Reply-To: <20100609084823.99850@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xeno_can_mem driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nils Armbruster <nils-a@domain.hid>
Cc: xenomai@xenomai.org

On 06/09/2010 10:48 AM, Nils Armbruster wrote:
> Thank you for your reply !
> 
>>>  I'm currently trying to get the can-interfaces of an Samsung S3C2440
>>>   based board working (NetDCU10). The used Linux kernel version is 
>>> 2.6.19,
>>>   because this was deliverd in the BSP. I patched this kernel with 
>>> Xenomai
>>>   2.4.0., as this was the newest Version I managed the Kernel to compile
>>>   with.
>>>
>>>  The standard driver delivered with the board (lincan 0.3.3) mappes the
>>>   can devices to 10000000-10000007 : onboard-can
>>>  10000008-1000000f :
>>>  onboard-can
>>
>> Hmm, the SJA1000 has 32 registers, not just 8.
>>
> 
> This is strange, cause the original driver just maps these 8 registers.

How does the read/write register access function look like in your
lincan driver?

> 
>>>  So I tried to use the driver xeno_can_mem.
>>>
>>>  I use
>>>  modprobe xen_can_mem mem=0x10000000 irq=17 clock=48000000

Where did you get irq=17 from? From /proc/interrups?

> Sorry for my stupid question, but how can I find out where the registers are mapped?
> In the original driver the base address is defined as 0x10000000.
> Port size ist defined as 4 and when the memory region is requested twice of the port size is requested:
> request_mem_region(mem_addr, nx_can->if_portsize * 2, "onboard-can")
> 
> Do you have any suggestions how I should proceed?

I assume that the lincan driver source code is under the GPL. Feel free
to post it here so we can have a closer look.

Wolfgang.

