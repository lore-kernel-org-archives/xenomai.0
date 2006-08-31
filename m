Message-ID: <b647ffbd0608311302x45568da9wa3422d4444379877@domain.hid>
Date: Thu, 31 Aug 2006 22:02:16 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [patch, RFC] detect unhandled interrupts
In-Reply-To: <44F7346D.20602@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_46996_23769857.1157054536822"
References: <b647ffbd0608291228i58bfa3fex5e8f3e18dc0ecc0@domain.hid>
	<1157013092.4359.11.camel@domain.hid> <44F7346D.20602@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_46996_23769857.1157054536822
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 31/08/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
>
> Unless I'm currently doing something completely wrong, it looks like it
> doesn't work as it should. :(
>
> I attached a xeno_16550A to the Ethernet NIC's IRQ line and opened the
> serial port - lock-up.


(1)

Ok, and now I enabled shared IRQ support:
>
> kernel/xenomai/nucleus/intr.c: In function 'xnintr_irq_handler':
> kernel/xenomai/nucleus/intr.c:399: error: 'xnintr_t' has no member named
> 'unhandled'
> kernel/xenomai/nucleus/intr.c:404: error: 'xnintr_t' has no member named
> 'unhandled'


(2)


Looks like our patch review failed... :-/



I failed and "got my face in the soup" (as it's said in my country).

But as I can see Philippe's corrections fix only compilation issues, i.e.
(2). (1) still remains unclear. Can't see any explanation so far, if only
xeno_16550A sees some of interrupts as its own and returns HANDLED :)


Jan
>
>
>
>


-- 
Best regards,
Dmitry Adamushko

------=_Part_46996_23769857.1157054536822
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div><span class="gmail_quote">On 31/08/06, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>Unless I'm currently doing something completely wrong, it looks like it<br>doesn't work as it should. :(<br><br>I attached a xeno_16550A to the Ethernet NIC's IRQ line and opened the<br>serial port - lock-up.</blockquote>
<div><br>
(1) <br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Ok, and now I enabled shared IRQ support:<br><br>kernel/xenomai/nucleus/intr.c: In function 'xnintr_irq_handler':
<br>kernel/xenomai/nucleus/intr.c:399: error: 'xnintr_t' has no member named<br>'unhandled'<br>kernel/xenomai/nucleus/intr.c:404: error: 'xnintr_t' has no member named<br>'unhandled'</blockquote><div><br>
(2)<br>
&nbsp;<br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Looks like our patch review failed... :-/</blockquote><div><br>
<br>
I failed and &quot;got my face in the soup&quot; (as it's said in my country).<br>
<br>
But as I can see Philippe's corrections fix only compilation issues,
i.e. (2). (1) still remains unclear. Can't see any explanation so far,
if only xeno_16550A sees some of interrupts as its own and returns
HANDLED :)<br>
<br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan<br><br><br><br></blockquote></div><br><br clear="all"><br>-- <br>Best regards,
<br>Dmitry Adamushko

------=_Part_46996_23769857.1157054536822--

