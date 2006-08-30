Message-ID: <b647ffbd0608301010m52b024fbibc444e10f4a42958@domain.hid>
Date: Wed, 30 Aug 2006 19:10:46 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <44F592AD.2000900@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_27352_17982047.1156957846653"
References: <b647ffbd0608291228i58bfa3fex5e8f3e18dc0ecc0@domain.hid>
	<44F49A6C.5050603@domain.hid>
	<b647ffbd0608291334u4182e78bub6d874e252abbbc9@domain.hid>
	<44F592AD.2000900@domain.hid>
Subject: [Xenomai-core] Re: [patch, RFC] detect unhandled interrupts
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_27352_17982047.1156957846653
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 30/08/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
>
> Mmh, considering this and also the existing code I wonder if we could
> optimise this a bit. I'm only looking at xnintr_irq_handler now (sharing
> is slow anyway): currently the intr object is touched both before
> (naturally...) and after the call to the ISR handler. Maybe we can push
> all accesses before the handler for the fast path. E.g.:
>
> int unhandled = intr->unhandled;
>
intr->unhandled = 0;
> ++intr->hits;
> s = intr->isr(...);
>
> if (s == XN_ISR_NONE) {
>         intr->unhandled = ++unhandled;
>         if (unhandled == XNINTR_MAX_UNHANDLED)
>                 ALARM!
> }


so the idea is that we touch all intr members while they are hopefully in
the same cache line (if it's 128 bits long) as the cache may be disturbed by
ISR afterwards.

But OTOH, we do an additional write "int unhandled = intr->unhandled;"

(write-through cache) ---> put in cache + syncing with memory immediately

(write-back cache) ---> put in cache + delay syncing (but will it still
happen?)

So while we avoid one possible read from the main memory into the cache when
intr->unhandled and ->hits (ok, this one can be moved for sure) are called
after ISR (and they are not in the cache), we introduce another one (at
least for write-through it's 100%) that takes place before ISR and that's
actually a "+" component to the IRQ latency.

or I can be wrong though.

(cache line == 128 bits) let's say cacheline[4]

int a = 1;   // e.g. &a == 0xabcd0004

this part of memory is currently not in the cache. So :

1) [0xabcd0000, 0xabcd0010] == 128 bits is loaded from memory into
cacheline.

2) then 1 is loaded into cacheline[1]

3) [ write-through ] ---> sync with memory
or
    [ write-back ] ---> delay synching

 ?


Jan
>
>
>

-- 
Best regards,
Dmitry Adamushko

------=_Part_27352_17982047.1156957846653
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div><span class="gmail_quote">On 30/08/06, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>Mmh, considering this and also the existing code I wonder if we could<br>optimise this a bit. I'm only looking at xnintr_irq_handler now (sharing<br>is slow anyway): currently the intr object is touched both before<br>
(naturally...) and after the call to the ISR handler. Maybe we can push<br>all accesses before the handler for the fast path. E.g.:<br><br>int unhandled = intr-&gt;unhandled; <br>
</blockquote><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">intr-&gt;unhandled = 0;<br>++intr-&gt;hits;<br>s = intr-&gt;isr(...);<br><br>if (s == XN_ISR_NONE) {
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;intr-&gt;unhandled = ++unhandled;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (unhandled == XNINTR_MAX_UNHANDLED)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ALARM!<br>}</blockquote><div><br>
so the idea is that we touch all intr members while they are hopefully
in the same cache line (if it's 128 bits long) as the cache may be
disturbed by ISR afterwards.<br>
<br>
But OTOH, we do an additional write &quot;int unhandled = intr-&gt;unhandled;&quot;<br>
<br>
(write-through cache) ---&gt; put in cache + syncing with memory immediately<br>
<br>
(write-back cache) ---&gt; put in cache + delay syncing (but will it still happen?)<br>
<br>
So while we avoid one possible read from the main memory into the cache
when intr-&gt;unhandled and -&gt;hits (ok, this one can be moved for
sure) are called after ISR (and they are not in the cache), we
introduce another one (at least for write-through it's 100%) that takes
place before ISR and that's actually a &quot;+&quot; component to the IRQ latency.<br>
<br>
or I can be wrong though.<br>
<br>
(cache line == 128 bits) let's say cacheline[4]<br>
<br>
int a = 1;&nbsp;&nbsp; // e.g. &amp;a == 0xabcd0004<br>
<br>
this part of memory is currently not in the cache. So :<br>
<br>
1) [0xabcd0000, 0xabcd0010] == 128 bits is loaded from memory into cacheline.<br>
<br>
2) then 1 is loaded into cacheline[1]<br>
<br>
3) [ write-through ] ---&gt; sync with memory<br>
or<br>
&nbsp; &nbsp; [ write-back ] ---&gt; delay synching<br>
<br>
&nbsp;?</div><br>
<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan<br><br><br>
</blockquote></div><br clear="all"><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_27352_17982047.1156957846653--

