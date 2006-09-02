Message-ID: <b647ffbd0609020538q3dcdc018ufa96f5c895345d55@domain.hid>
Date: Sat, 2 Sep 2006 14:38:03 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] Question about interrupt propagation to Linux
In-Reply-To: <20060902114916.GB4486@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_68640_12318334.1157200683967"
References: <20060902114916.GB4486@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, Bernhard Walle <bernhard.walle@domain.hid>

------=_Part_68640_12318334.1157200683967
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Bernhard,


I have a question about interrupt propagation to Linux with the
> XN_ISR_PROPAGATE return value in the real-time interrupt handler.
>
> My question is: is the particular IRQ (not other IRQs) that is handled
> by this ISR re-enabled after the *RT* ISR finished or is it re-enabled
> after the *Linux* ISR has finished. In my understanding the interrupt
> cannot be enabled after the RT-ISR because then the RT-ISR handler
> would be called again and the Linux ISR would never have a chance to
> run.


You are right. The IRQ line is not re-enabled upon getting XN_ISR_PROPAGATE.
It will be re-enabled by linux domain at some point later when the former
one eventually gets control (i.e. when there are no activities in the
primary domain).
That said, the interrupts from a device being controlled by the RT driver
(ISR in the primary domain) can't be seen in the mean time. Hence, there are
no more deterministic guarantees for RT device handling.

The alternative approach is as described here :

https://mail.gna.org/public/xenomai-core/2005-11/msg00012.html

It's possible to apply some optimisation :

1) speedo_suspend_interrupt() should return an indication whether it's
interested in this IRQ (i.e. whether it was rised by a dedicated device) ;

2) arti_irq_trampoline()  should set "shared" up only when one of the
suspend_handler() (like e.g. == speedo_suspend_interrupt() ) have denoted
its interest;

3) this way, the IRQ is not propagated down to the linux domain when nobody
there is interested.

The patch addresses RTAI and 2.4 kernel but it's easily applicable to recent
Xenomai.



Thanks.
>
>
> Regards,
>   Bernhard
> --
> At least Microsoft offers updates to keep your selection of bugs fresh.
>         -- Alan Shutko, hating Corel even more, in asr
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>
>
>


-- 
Best regards,
Dmitry Adamushko

------=_Part_68640_12318334.1157200683967
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>
<div><span class="gmail_quote">Hello Bernhard<b class="gmail_sendername"><span style="font-weight: bold;"></span>,</b></span><br>
<div><br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I have a question about interrupt propagation to Linux with the<br>XN_ISR_PROPAGATE return value in the real-time interrupt handler.
<br><br>My question is: is the particular IRQ (not other IRQs) that is handled<br>by this ISR re-enabled after the *RT* ISR finished or is it re-enabled<br>after the *Linux* ISR has finished. In my understanding the interrupt
<br>cannot be enabled after the RT-ISR because then the RT-ISR handler<br>would be called again and the Linux ISR would never have a chance to<br>run.</blockquote><div><br>
You are right. The IRQ line is not re-enabled upon getting XN_ISR_PROPAGATE.<br>
It will be re-enabled by linux domain at some point later when the
former one eventually gets control (i.e. when there are no activities
in the primary domain).<br>
That said, the interrupts from a device being controlled by the RT
driver (ISR in the primary domain) can't be seen in the mean time.
Hence, there are no more deterministic guarantees for RT device
handling.<br>
<br>The alternative approach is as described here :<br>
<br><a href="https://mail.gna.org/public/xenomai-core/2005-11/msg00012.html">https://mail.gna.org/public/xenomai-core/2005-11/msg00012.html</a><br>
<br>
It's possible to apply some optimisation :<br>
<br>
1) speedo_suspend_interrupt() should return an indication whether it's
interested in this IRQ (i.e. whether it was rised by a dedicated
device) ;<br>
<br>
2) arti_irq_trampoline()&nbsp; should set &quot;shared&quot; up only when one of
the suspend_handler() (like e.g. == speedo_suspend_interrupt() ) have
denoted its interest;<br>
<br>
3) this way, the IRQ is not propagated down to the linux domain when nobody there is interested.<br>
</div><br>
The patch addresses RTAI and 2.4 kernel but it's easily applicable to recent Xenomai.<br>
<br>
<br>
<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Thanks.<br><br><br>Regards,<br>&nbsp;&nbsp;Bernhard<br>--<br>At least Microsoft offers updates to keep your selection of bugs fresh.
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-- Alan Shutko, hating Corel even more, in asr<br><br><br>_______________________________________________<br>Xenomai-help mailing list<br><a href="mailto:Xenomai-help@domain.hid" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
Xenomai-help@domain.hid</a><br><a href="https://mail.gna.org/listinfo/xenomai-help" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
https://mail.gna.org/listinfo/xenomai-help</a><br><br><br><br></blockquote></div><br><br clear="all"><br>-- <br>Best regards,<br>Dmitry Adamushko


------=_Part_68640_12318334.1157200683967--

