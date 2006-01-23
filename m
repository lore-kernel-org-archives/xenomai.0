Message-ID: <b647ffbd0601230841o51fbc5d2o@domain.hid>
Date: Mon, 23 Jan 2006 18:41:52 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
In-Reply-To: <43D41364.6000300@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_38025_20017524.1138034512415"
References: <b647ffbd0601180617v38c990f0w@domain.hid>
	<43D41364.6000300@domain.hid>
Subject: [Xenomai-core] Re: [PATCH] Shared irqs v.5
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

------=_Part_38025_20017524.1138034512415
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 23/01/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Dmitry Adamushko wrote:
> > Hello Jan,
> >
> > as I promised earlier today, here is the patch.
>
> I finally had a look at your patch (not yet a try), and it looks really
> nice and light-weight.


I have another version here at hand. The only difference is that
xnintr_irq_handler() handles all interrupts and destinguished the timer
interrupt via "irq == XNARCH_TIMER_IRQ" to handle it appropriately. This
way, the i-cache is, hopefully, used a bit more effectively. But it doesn't
make a big difference in other parts of code so you may start testing with
the one I posted earlier.


Now I only have two topics on my wish list:
>
o Handling of edge-triggered IRQs (ISA-cards...). As I tried to explain,
>   in this case we have to run the IRQ handler list as long as the full
>   list completed without any handler reporting XN_ISR_ENABLE back. Then
>   and only then we are safe to not stall the IRQ line. See e.g.
>   serial8250_interrupt() in linux/drivers/serial/8250.c for a per-driver
>   solution and [1] for some discussion on sharing IRQs (be warned, it's
>   from the evil side ;) ).


Ok. e.g. we may introduce another flag to handle such a special case.
Something along XN_ISR_EDGETIRQ and maybe a separate
xnintr_etshirq_handler() (xnintr_attach() will set it up properly) so to
avoid interfering with another code. No big overhead I guess.
serial8250_interrupt() defines a maximum number of iterations so we should
do the same (?) to avoid brain-damaged cases.

  On our systems we already have two of those use-cases: the xeno_16550A
>   handling up to 4 devices on the same IRQ on an ISA card (I don't want
>   to know what worst-case latency can be caused here...) and our
>   SJA-1000 CAN driver for PC/104 ISA card with 2 controllers on the same
>   interrupt line. So a common solution would reduce the code size and
>   potential bug sources.
>
> o Store and display (/proc) the driver name(s) registered on an IRQ line
>   somewhere (ipipe?). This is just a nice-to-have. I introduced the RTDM
>   API with the required argument in place, would be great if we can use
>   this some day.


Yes, the proper /proc extension should be avalable. Actually, the "native"
skin can't be extended to support the shared interrupts only by adding a new
flag. The "problem" is the way the /proc/xenomai/registry/interrupts is
implemented there (and I assume any other skin follows the same way). The
rt_registry object is created per each RT_INTR structure and, hence, per
each xnintr_t.

I'd see the following scheme :

either

/proc/xenomai/interrupts lists all interrupts objects registered on the
nucleus layer (xnintr_t should have a "name" field).

IRQN      drivers

3              driver1
...
5              driver2, driver3

and the skin presents per-object information as

ll /proc/xenomai/registry/interrupts

driver1
driver2
driver3

each of those files contains the same information as now.

To achieve this,

1) xnintr_t should be extended with a "name" field;

2) rt_intr_create() should contain a "name" argument and not use
auto-generation (as "irqN") any more.

or

ll /proc/xenomai/registry/interrupts

3
5

Those are directories and e.g.

ll /proc/xenomai/registry/interrupts/5

driver2
driver3

Those are "files" and contain the same information as now.

This is harder to implement since the registry interface should be extended
(for each skin).


> ...

> Jan
>
>
> PS: Still at home?


Yes. This week I'm going to Belgium to attend a few meeting with some
customers of my potential employer. So my next step for the nearest future
will be finally determined there :)


How many degrees Centigrade? I guess our current -9°C
> here in Hannover must appear ridiculous, almost subtropical warm to you.
> ;)


Hey, I'm not from Syberia :o) This is a kind of common delusion I guess as
the whole former USSR is assotiated with cold winters, bears, eak.. KGB etc.
:o)

from wikipedia.com (about Belarus) :

"The climate <http://en.wikipedia.org/wiki/Climate> ranges from harsh
winters <http://en.wikipedia.org/wiki/Winter> (average January temperatures
are in the range −8 °C to −2 °C) to cool and moist
summers<http://en.wikipedia.org/wiki/Summer>(average temperature 15 °C
to 20 °C)."

Actually, last days it was very cooooold - even about -30C. This happens
from time to time but very rare (once in a few years or so) and it's not
considered as something normal here. e.g. schools were closed a few last
days when the temperature was below -25. Actually, the weather is getting
crazy last years and not only here :)

[1] http://www.microsoft.com/whdc/system/sysperf/apic.mspx
>
>
>

--
Best regards,
Dmitry Adamushko

------=_Part_38025_20017524.1138034512415
Content-Type: text/html; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div><span class="gmail_quote">On 23/01/06, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Dmitry Adamushko wrote:<br>&gt; Hello Jan,<br>&gt;<br>&gt; as I promised earlier today, here is the patch.<br><br>I finally had a look at your patch (not yet a try), and it looks really<br>nice and light-weight.</blockquote>
<div><br>
I have another version here at hand. The only difference is that&nbsp;
xnintr_irq_handler() handles all interrupts and destinguished the timer
interrupt via &quot;irq == XNARCH_TIMER_IRQ&quot; to handle it appropriately.
This way, the i-cache is, hopefully, used a bit more effectively. But
it doesn't make a big difference in other parts of code so you may
start testing with the one I posted earlier.<br>
<br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"> Now I only have two topics on my wish list:<br>
</blockquote><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">o Handling of edge-triggered IRQs (ISA-cards...). As I tried to explain,<br>&nbsp;&nbsp;in this case we have to run the IRQ handler list as long as the full
<br>&nbsp;&nbsp;list completed without any handler reporting XN_ISR_ENABLE back. Then<br>&nbsp;&nbsp;and only then we are safe to not stall the IRQ line. See e.g.<br>&nbsp;&nbsp;serial8250_interrupt() in linux/drivers/serial/8250.c for a per-driver<br>
&nbsp;&nbsp;solution and [1] for some discussion on sharing IRQs (be warned, it's<br>&nbsp;&nbsp;from the evil side ;) ).</blockquote><div><br>
Ok. e.g. we may introduce another flag to handle such a special case.
Something along XN_ISR_EDGETIRQ and maybe a separate
xnintr_etshirq_handler() (xnintr_attach() will set it up properly) so
to avoid interfering with another code. No big overhead I guess.<br>
serial8250_interrupt() defines a maximum number of iterations so we should do the same (?) to avoid brain-damaged cases.<br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&nbsp;&nbsp;On our systems we already have two of those use-cases: the xeno_16550A<br>&nbsp;&nbsp;handling up to 4 devices on the same IRQ on an ISA card (I don't want
<br>&nbsp;&nbsp;to know what worst-case latency can be caused here...) and our<br>&nbsp;&nbsp;SJA-1000 CAN driver for PC/104 ISA card with 2 controllers on the same<br>&nbsp;&nbsp;interrupt line. So a common solution would reduce the code size and<br>
&nbsp;&nbsp;potential bug sources.<br><br>o Store and display (/proc) the driver name(s) registered on an IRQ line<br>&nbsp;&nbsp;somewhere (ipipe?). This is just a nice-to-have. I introduced the RTDM<br>&nbsp;&nbsp;API with the required argument in place, would be great if we can use
<br>&nbsp;&nbsp;this some day.</blockquote><div><br>
Yes, the proper /proc extension should be avalable. Actually, the
&quot;native&quot; skin can't be extended to support the shared interrupts only
by adding a new flag. The &quot;problem&quot; is the way the
/proc/xenomai/registry/interrupts is implemented there (and I assume
any other skin follows the same way). The rt_registry object is created
per each RT_INTR structure and, hence, per each xnintr_t.<br>
<br>
I'd see the following scheme :<br>
<br>
either<br>
<br>
/proc/xenomai/interrupts lists all interrupts objects registered on the nucleus layer (xnintr_t should have a &quot;name&quot; field).<br>
<br>
IRQN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers<br>
<br>
3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; driver1<br>
...<br>
5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; driver2, driver3<br>
<br>
and the skin presents per-object information as<br>
<br>
ll /proc/xenomai/registry/interrupts<br>
<br>
driver1<br>
driver2<br>
driver3<br>
<br>
each of those files contains the same information as now.<br>
<br>
To achieve this, <br>
<br>
1) xnintr_t should be extended with a &quot;name&quot; field;<br>
<br>
2) rt_intr_create() should contain a &quot;name&quot; argument and not use auto-generation (as &quot;irqN&quot;) any more.<br>
<br>
or<br>
<br>
ll /proc/xenomai/registry/interrupts<br>
<br>
3<br>
5<br>
&nbsp;</div>Those are directories and e.g.<br>
<br>
ll /proc/xenomai/registry/interrupts/5<br>
<br>
driver2<br>
driver3<br>
<br>
Those are &quot;files&quot; and contain the same information as now.<br>
<br>
This is harder to implement since the registry interface should be extended (for each skin).<br>
<br>
<br>&gt; ...<div>&nbsp;<br>
</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan<br><br><br>PS: Still at home?</blockquote><div><br>
Yes. This week I'm going to Belgium to attend a few meeting with some
customers of my potential employer. So my next step for the nearest
future will be finally determined there :)<br>
&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"> How many degrees Centigrade? I guess our current -9°C<br>here in Hannover must appear ridiculous, almost subtropical warm to you. ;)
</blockquote><div><br>
Hey, I'm not from Syberia :o) This is a kind of common delusion I guess
as the whole former USSR is assotiated with cold winters, bears, eak..
KGB etc. :o)<br>
<br>
from <a href="http://wikipedia.com">wikipedia.com</a> (about Belarus) : <br>
<br>
&quot;The <a href="http://en.wikipedia.org/wiki/Climate" title="Climate">climate</a> ranges from harsh <a href="http://en.wikipedia.org/wiki/Winter" title="Winter">winters</a> (average January temperatures are in the range −8&nbsp;°C to −2&nbsp;°C) to cool and moist 
<a href="http://en.wikipedia.org/wiki/Summer" title="Summer">summers</a> (average temperature 15&nbsp;°C to 20&nbsp;°C).&quot;<br>
</div><br>
Actually, last days it was very cooooold - even about -30C. This
happens from time to time but very rare (once in a few years or so) and
it's not considered as something normal here. e.g. schools were closed
a few last days when the temperature was below -25. Actually, the
weather is getting crazy last years and not only here :)<br>
<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">[1] <a href="http://www.microsoft.com/whdc/system/sysperf/apic.mspx">http://www.microsoft.com/whdc/system/sysperf/apic.mspx
</a><br><br><br></blockquote></div><br><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_38025_20017524.1138034512415--

