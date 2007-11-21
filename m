Date: Wed, 21 Nov 2007 14:33:33 -0800 (PST)
From: DENNIS NGUYEN <dennisnguy@domain.hid>
In-Reply-To: <2ff1a98a0711210140x39088655idf0339a49522fa73@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-480501778-1195684413=:79799"
Content-Transfer-Encoding: 8bit
Message-ID: <822923.79799.qm@domain.hid>
Subject: Re: [Xenomai-help] xnintr_shirq_handler: IRQ11 not handled. Disable
	IRQ line.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--0-480501778-1195684413=:79799
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello Gilles,

Thanks for the advice.
Yes, I have problem with sharing the IRQ 11.
my questions are:
How can I set the rteth0 to a known not sharing IRQ in the system?
How can I pass a known IRQ from RTnet to the Xenomai xnintr_shirq_handler?
I tried to fix the IRQ from "network configuration" but it didn't help.  I also tried to set up the system BIOS but it did not have IRQ configuration.
The Realtek NICs are using PCI bus.

Thanks,
Dennis



Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote: On Nov 20, 2007 11:42 PM, Dennis Nguyen  wrote:
> Hello,
>
> I'm using linux kernel 2.6.22.12, xenomai 2.4-rc6, and rtnet trunk 1140
> date 11/15/2007. There are 2 8139 RealTek nics in the system
>
> I got the disable IRQ messages when loading RTnet modules:
> Xenomai: xnintr_shirq_handler: IRQ11 not handled. Disable IRQ line.
> Xenomai: xnintr_shirq_handler: IRQ10 not handled. Disable IRQ line.
>
> one nic using IRQ 11 and the other using IRQ 10
> These cause the rteth0 and rteth1 not receive any packages.
>
> How can I enable the interrupts? or control so that the
> xnintr_shirq_handler not disable the interrupts?

There are several reasons why this can happen. One reason is a bug in
the drivers interrupt handler, which returns RTDM_IRQ_NONE whereas it
should not. Another reason is that the IRQs 10 and 11 are shared
between the ethernet driver and non real-time drivers. This can not
work.


-- 
                                               Gilles Chanteperdrix


--0-480501778-1195684413=:79799
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello Gilles,<br><br>Thanks for the advice.<br>Yes, I have problem with sharing the IRQ 11.<br>my questions are:<br>How can I set the rteth0 to a known not sharing IRQ in the system?<br>How can I pass a known IRQ from RTnet to the Xenomai xnintr_shirq_handler?<br>I tried to fix the IRQ from "network configuration" but it didn't help.&nbsp; I also tried to set up the system BIOS but it did not have IRQ configuration.<br>The Realtek NICs are using PCI bus.<br><br>Thanks,<br>Dennis<br><br><br><br><b><i>Gilles Chanteperdrix &lt;gilles.chanteperdrix@xenomai.org&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> On Nov 20, 2007 11:42 PM, Dennis Nguyen <dennisnguy@domain.hid> wrote:<br>&gt; Hello,<br>&gt;<br>&gt; I'm using linux kernel 2.6.22.12, xenomai 2.4-rc6, and rtnet trunk 1140<br>&gt; date 11/15/2007. There are 2 8139 RealTek nics in the system<br>&gt;<br>&gt; I got the disable IRQ messages
 when loading RTnet modules:<br>&gt; Xenomai: xnintr_shirq_handler: IRQ11 not handled. Disable IRQ line.<br>&gt; Xenomai: xnintr_shirq_handler: IRQ10 not handled. Disable IRQ line.<br>&gt;<br>&gt; one nic using IRQ 11 and the other using IRQ 10<br>&gt; These cause the rteth0 and rteth1 not receive any packages.<br>&gt;<br>&gt; How can I enable the interrupts? or control so that the<br>&gt; xnintr_shirq_handler not disable the interrupts?<br><br>There are several reasons why this can happen. One reason is a bug in<br>the drivers interrupt handler, which returns RTDM_IRQ_NONE whereas it<br>should not. Another reason is that the IRQs 10 and 11 are shared<br>between the ethernet driver and non real-time drivers. This can not<br>work.<br><br><br>-- <br>                                               Gilles Chanteperdrix<br></dennisnguy@domain.hid></blockquote><br>
--0-480501778-1195684413=:79799--

