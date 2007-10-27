Message-ID: <472396E1.6030800@domain.hid>
Date: Sat, 27 Oct 2007 21:52:01 +0200
MIME-Version: 1.0
References: <e4ef24880710261838l4d1961a5s8117d116be499cee@domain.hid>	
	<e4ef24880710262040r718b58f7xa2e5f89156d9024b@domain.hid>	
	<e4ef24880710262126g658f3f7ci534ca13df32b2e0e@domain.hid>	
	<4723118D.9060807@domain.hid> <472326E6.9080103@domain.hid>	
	<47232A0C.60705@domain.hid> <47234083.4000602@domain.hid>	
	<e4ef24880710271153qb9c0b27y937f3d87e16f0922@domain.hid>	
	<47238BD7.1040501@domain.hid>
	<e4ef24880710271217y2e0f6712t331bfcaac0e2a691@domain.hid>
In-Reply-To: <e4ef24880710271217y2e0f6712t331bfcaac0e2a691@domain.hid>
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

>     IRQs are incoming (to the kernel/CPU) signals IIUC. I imagine that at
>     the end of these incoming IRQ's sit ISRs just waiting for IRQ and ready
>     to respond to it in whatever manner they usually do. If this
>     understanding is correct (which it probably is not) then I would not be
>     able to conceive of a reason why the IRQ could not be passed on to the
>     NON RT interrupt service routine after it has been handled by the
>     RT-ISR. But I reiterate that my understanding of these things is as
>     sketchy as my interest to improve the sketchiness is big. :) 
> 
> 
> I think the problem is once the RT-ISR passes it to the NON-RT ISR  
> there are no real guarantees for how long Linux (its device driver, most 
> likely) will hold on to the interrupt.  This is problematic if it is 
This corresponds to what I have understood of what happens when a 
rt-thread makes an excursion to the the non-RT world. So there may be 
truth in what you say. Only, what I then don't understand is this: There 
is no problem with the non-RT-ISR doing its thing under normal (read no 
IRQ sharing) circumstances. So I would not see why passing the IRQ to 
the non-RT-ISR once the RT-ISR has done its job would be any different 
to the situation where there is no sharing. The situation is IMHO not 
analogous to the "excursion" of a RT thread into non-rt world as would 
be the case for example if a rt-thread called a non-rt-safe driver. IOW 
passing on an IRQ does not imply that a rt-thread steps into non-rt 
world. Rather it jsut gives the non-RT world the opportunity to respond 
to its devices as it would have naturally done without a problem when it 
gets its IRQ outside xenomai's realm. I assume (due to the fact that the 
rt-monitored IRQ's can be found in /proc/xenomai/irq IIRC) that the rest 
of the IRQ's are not filtered/censured through adeos.

Maybe the explanation is as follows: There is no problem to the point 
where the nonRT-ISR gets and responds to the IRQ. But what happens if 
,during the execution of the non-RT-ISR after it has been passed the 
IRQ, the RTdevice evokes another IRQ? Then adeos must give this IRQ to 
the RT-ISR and give it precedence over the Non-RT-ISR. If the non-RT-ISR 
is atomic or non-pre-emptible (not sure that is not the same thing or 
that I am not talking out of my hat here) this might be a problem. But 
again  I would not see why this is then not a problem  under the 
aforementioned "normal" circumstances. So I remain confused.

Roland.

> And now for the obligatory I-don't-really-know-what-I'm-talking-about 
> disclaimer again:



> 
> I am new to these packages, so hopefully I am not providing 
> misinformation on its functionality.
> 
> :)
> 
> -Rob
> 
>  
> 

