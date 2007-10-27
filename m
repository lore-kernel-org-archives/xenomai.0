Message-ID: <e4ef24880710271217y2e0f6712t331bfcaac0e2a691@domain.hid>
Date: Sat, 27 Oct 2007 12:17:45 -0700
From: "Robert Gubler" <rgubler@domain.hid>
In-Reply-To: <47238BD7.1040501@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_7354_17173406.1193512665567"
References: <e4ef24880710261838l4d1961a5s8117d116be499cee@domain.hid>
	<e4ef24880710262040r718b58f7xa2e5f89156d9024b@domain.hid>
	<e4ef24880710262126g658f3f7ci534ca13df32b2e0e@domain.hid>
	<4723118D.9060807@domain.hid> <472326E6.9080103@domain.hid>
	<47232A0C.60705@domain.hid> <47234083.4000602@domain.hid>
	<e4ef24880710271153qb9c0b27y937f3d87e16f0922@domain.hid>
	<47238BD7.1040501@domain.hid>
Subject: Re: [Xenomai-help] [RTnet-users] RTNet in non-TDMA mode?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid, Jan Kiszka <jan.kiszka@domain.hid>

------=_Part_7354_17173406.1193512665567
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 10/27/07, Roland Tollenaar <rwatollenaar@domain.hid> wrote:
>
> Hi Rob,
>
> Thanks for this response.
>
> >     But my question remains -purely out of interest- why non-rt devices
> and
> >     rt devices can _fundamentally_ not share an IRQ?
> >
> >
> >
> > My understanding is adeos-ipipe/xenomai provide an interrupt abstraction
> > layer underneath Linux.  If there is more than one consumer of an
> > interrupt it has to be copied/forwarded to all those that need it.  If
> > an IRQ is shared with an RT application, and the Linux kernel I would
> > imagine this would create some level of indeterministic RT software.


IRQs are incoming (to the kernel/CPU) signals IIUC. I imagine that at
> the end of these incoming IRQ's sit ISRs just waiting for IRQ and ready
> to respond to it in whatever manner they usually do. If this
> understanding is correct (which it probably is not) then I would not be
> able to conceive of a reason why the IRQ could not be passed on to the
> NON RT interrupt service routine after it has been handled by the
> RT-ISR. But I reiterate that my understanding of these things is as
> sketchy as my interest to improve the sketchiness is big. :)


I think the problem is once the RT-ISR passes it to the NON-RT ISR  there
are no real guarantees for how long Linux (its device driver, most likely)
will hold on to the interrupt.  This is problematic if it is causing
scheduling deadlines to be missed.   Its probably not an issue with shared
interrupts between multiple RT applications because (1) the RT apps using it
are (hopefully) written with understanding it is in a real-time context;
this is good peace of mind.  And (2) there is probably some fancy interrupt
masking or priority going on between RT-shared interrupts that make it more
deterministic.

And now for the obligatory I-don't-really-know-what-I'm-talking-about
disclaimer again:

I am new to these packages, so hopefully I am not providing misinformation
on its functionality.

:)

-Rob

------=_Part_7354_17173406.1193512665567
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 10/27/07, <b class="gmail_sendername">Roland Tollenaar</b> &lt;<a href="mailto:rwatollenaar@domain.hid">rwatollenaar@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Rob,<br><br>Thanks for this response.<br><br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; But my question remains -purely out of interest- why non-rt devices and<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; rt devices can _fundamentally_ not share an IRQ?<br>&gt;<br>&gt;<br>&gt;<br>&gt; My understanding is adeos-ipipe/xenomai provide an interrupt abstraction
<br>&gt; layer underneath Linux.&nbsp;&nbsp;If there is more than one consumer of an<br>&gt; interrupt it has to be copied/forwarded to all those that need it.&nbsp;&nbsp;If<br>&gt; an IRQ is shared with an RT application, and the Linux kernel I would
<br>&gt; imagine this would create some level of indeterministic RT software.</blockquote><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
IRQs are incoming (to the kernel/CPU) signals IIUC. I imagine that at<br>the end of these incoming IRQ&#39;s sit ISRs just waiting for IRQ and ready<br>to respond to it in whatever manner they usually do. If this<br>understanding is correct (which it probably is not) then I would not be
<br>able to conceive of a reason why the IRQ could not be passed on to the<br>NON RT interrupt service routine after it has been handled by the<br>RT-ISR. But I reiterate that my understanding of these things is as<br>sketchy as my interest to improve the sketchiness is big. :)
</blockquote><div><br>I think the problem is once the RT-ISR passes it to the NON-RT ISR&nbsp; there are no real guarantees for how long Linux (its device driver, most likely) will hold on to the interrupt.&nbsp; This is problematic if it is causing scheduling deadlines to be missed.&nbsp;&nbsp; Its probably not an issue with shared interrupts between multiple RT applications because (1) the RT apps using it are (hopefully) written with understanding it is in a real-time context; this is good peace of mind.&nbsp; And (2) there is probably some fancy interrupt masking or priority going on between RT-shared interrupts that make it more deterministic.
<br><br>And now for the obligatory I-don&#39;t-really-know-what-I&#39;m-talking-about disclaimer again:<br><br>I am new to these packages, so hopefully I am not providing misinformation on its functionality. <br><br>:) <br>
<br>-Rob<br><br>&nbsp;<br></div></div><br>

------=_Part_7354_17173406.1193512665567--

