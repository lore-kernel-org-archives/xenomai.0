From: Sebastian Smolorz <smolorz@domain.hid>
Date: Wed, 9 Jun 2010 11:10:01 +0200
References: <20100609084823.99850@domain.hid>
In-Reply-To: <20100609084823.99850@domain.hid>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201006091110.01783.smolorz@domain.hid>
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

Nils Armbruster wrote:
> >>  So I tried to use the driver xeno_can_mem.
> >>
> >>  I use
> >>  modprobe xen_can_mem mem=0x10000000 irq=17 clock=48000000
> >
> > Are you sure you give the right clock frequency? Seems to be too high.
> 
> I used this clock frequency because I noticed, that the frequency is
>  divided by 2. So I just tried it. The frequency I found in the original
>  driver is 24MHz.

You definitely have to define 24MHz here, not 48MHz.

> But even with clock=24000000 it appears "No such device".

Sure, this is another problem: The SJA1000 registers are not accessible (see 
below).

> >>  Does anybody have an hint for me, how to get the can driver working?
> >
> > First find out where the 32 registers of the SJA1000 are mapped and
> > also check the clock frequency.
> 
> Sorry for my stupid question, but how can I find out where the registers
>  are mapped? In the original driver the base address is defined as
>  0x10000000. Port size ist defined as 4 and when the memory region is
>  requested twice of the port size is requested:
>  request_mem_region(mem_addr, nx_can->if_portsize * 2, "onboard-can")
> 
> Do you have any suggestions how I should proceed?

Either you study the appropriate datasheet to learn how the SJA1000 
registers are accessible from your board, or you go through the code of your 
original driver and search for the way the SJA registers are read and write. 
For example, the SJA_CDR register is the last of the 32 registers.

-- 
Sebastian

