Message-ID: <47238BD7.1040501@domain.hid>
Date: Sat, 27 Oct 2007 21:04:55 +0200
MIME-Version: 1.0
References: <e4ef24880710261838l4d1961a5s8117d116be499cee@domain.hid>	
	<e4ef24880710262040r718b58f7xa2e5f89156d9024b@domain.hid>	
	<e4ef24880710262126g658f3f7ci534ca13df32b2e0e@domain.hid>	
	<4723118D.9060807@domain.hid> <472326E6.9080103@domain.hid>	
	<47232A0C.60705@domain.hid> <47234083.4000602@domain.hid>
	<e4ef24880710271153qb9c0b27y937f3d87e16f0922@domain.hid>
In-Reply-To: <e4ef24880710271153qb9c0b27y937f3d87e16f0922@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: Re: [Xenomai-help] [RTnet-users] RTNet in non-TDMA mode?
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Robert Gubler <rgubler@domain.hid>
Cc: Xenomai-help@domain.hid, Jan Kiszka <jan.kiszka@domain.hid>

Hi Rob,

Thanks for this response.

>     But my question remains -purely out of interest- why non-rt devices and
>     rt devices can _fundamentally_ not share an IRQ?
> 
> 
> 
> My understanding is adeos-ipipe/xenomai provide an interrupt abstraction 
> layer underneath Linux.  If there is more than one consumer of an 
> interrupt it has to be copied/forwarded to all those that need it.  If 
> an IRQ is shared with an RT application, and the Linux kernel I would 
> imagine this would create some level of indeterministic RT software.
IRQs are incoming (to the kernel/CPU) signals IIUC. I imagine that at 
the end of these incoming IRQ's sit ISRs just waiting for IRQ and ready 
to respond to it in whatever manner they usually do. If this 
understanding is correct (which it probably is not) then I would not be 
able to conceive of a reason why the IRQ could not be passed on to the 
NON RT interrupt service routine after it has been handled by the 
RT-ISR. But I reiterate that my understanding of these things is as 
sketchy as my interest to improve the sketchiness is big. :)


> This is probably a good question for the xenomai, or adeos-ipipe mailing 
> list. 
Have already done so earlier. I was not aware initially that this thread 
was on the RTnet list. The duplicate and capitalised RTNet in the 
subject must have been mysteriously obscured by my client for a while. :)

Roland

> 
> -Rob

