Message-ID: <b647ffbd0608211522j21f870bfg9e8e7bc3a612be70@domain.hid>
Date: Tue, 22 Aug 2006 00:22:00 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] rtdm_irq_request
In-Reply-To: <44E98E12.3030406@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_38195_1057514.1156198920853"
References: <E443EE6E95070D46896C24F5C44EA7F53A1624@domain.hid>
	<44E98E12.3030406@domain.hid>
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

------=_Part_38195_1057514.1156198920853
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 21/08/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> > I' am having some problems with using the rtdm_irq_request() function. I
> > disabled my local APIC support in the kernel (2.6.17, xenomai 2.2.0). My
> > device (USB-HOST controller) shares his IRQ with the Ethernet
> > card(e1000). After calling rtdm_irq_request() my system hangs. I tried
> > to unload the e1000 module first and it seems to work fine. Can I share
> > non-realtime interrupts whit real-time interrupts. If yes, what went
> > wrong.
>
> Nope you can't share. The e1000 driver could otherwise cause priority
> inversions when an Ethernet-related IRQ is pending, the IRQ line will
> get disabled therefore, and thus succeeding RT-USB-originated IRQs will
> be shadowed until Linux gets a chance to run again.
>
> That the system hangs is due to the ungraceful way we currently handle
> such exceptions. [@Dmitry: This is one example of the frequent problems
> I was referring to...]


confirm. ok, I thought that the inter-domain irq sharing is not that
frequently required (any % of potential users out there? :) and it is not
worth adding a general support wrt some additional complexity it will likely
add.

Are all these cases really caused by the lack of free interrupt lines,
meaning that the conflicting devices can't even be re-configured so to
provide a separate line for the "real-time" - handled device?

Anyway, this system hang is definitely something unacceptable. So should be
fixed
[@ Jan : your second mail is still pending as well as some related code
reading as, honestly, I don't have a clue at the moment. should be handled
asap :]


Jan
>
>

-- 
Best regards,
Dmitry Adamushko

------=_Part_38195_1057514.1156198920853
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>
<div><span class="gmail_quote">On 21/08/06, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
&gt; I' am having some problems with using the rtdm_irq_request() function. I<br>&gt; disabled my local APIC support in the kernel (2.6.17, xenomai 2.2.0). My<br>&gt; device (USB-HOST controller) shares his IRQ with the Ethernet
<br>&gt; card(e1000). After calling rtdm_irq_request() my system hangs. I tried<br>&gt; to unload the e1000 module first and it seems to work fine. Can I share<br>&gt; non-realtime interrupts whit real-time interrupts. If yes, what went
<br>&gt; wrong.<br><br>Nope you can't share. The e1000 driver could otherwise cause priority<br>inversions when an Ethernet-related IRQ is pending, the IRQ line will<br>get disabled therefore, and thus succeeding RT-USB-originated IRQs will
<br>be shadowed until Linux gets a chance to run again.<br><br>That the system hangs is due to the ungraceful way we currently handle<br>such exceptions. [@Dmitry: This is one example of the frequent problems<br>I was referring to...]
</blockquote><div><br>
confirm. ok, I thought that the inter-domain irq sharing is not that
frequently required (any % of potential users out there? :) and it is
not worth adding a general support wrt some additional complexity it
will likely add.<br>
<br>
Are all these cases really caused by the lack of free interrupt lines,
meaning that the conflicting devices can't even be re-configured so to
provide a separate line for the &quot;real-time&quot; - handled device?<br>
<br>
Anyway, this system hang is definitely something unacceptable. So should be fixed<br>
[@ Jan : your second mail is still pending as well as some related code
reading as, honestly, I don't have a clue at the moment. should be
handled asap :]<br>
</div><br>
<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan<br><br></blockquote></div><br><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_38195_1057514.1156198920853--

