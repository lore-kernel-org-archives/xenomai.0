MIME-Version: 1.0
In-Reply-To: <4F1C5DB8.1080001@domain.hid>
References: <4F1080E8.6020408@domain.hid>
	<4F1082E5.8000501@domain.hid>
	<4F132A7E.4000000@domain.hid> <4F16F028.6020507@domain.hid>
	<4F16F401.2090308@domain.hid> <4F184E42.6060300@domain.hid>
	<4F19581A.8070300@domain.hid> <4F197D0C.4060407@domain.hid>
	<4F1C5DB8.1080001@domain.hid>
From: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Date: Thu, 23 Feb 2012 17:00:26 -0200
Message-ID: <CAAsfwtO7gLVwQyg5bX1QcmcMBd_wgg37T5RV-nsKkN3EX6BEAg@domain.hid>
Content-Type: multipart/alternative; boundary=002354470548fa433104b9a642bd
Subject: Re: [Xenomai-help] Omap3630, rtserial, xeno_16550A: crash on insmod
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Manfred <manfred@domain.hid>
Cc: xenomai@xenomai.org

--002354470548fa433104b9a642bd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear all,

On Sun, Jan 22, 2012 at 5:04 PM, Manfred <manfred@domain.hid> wrote:

>
> On 1/20/12 3:41 PM, Fabrice Gasnier wrote:
>
>> Dear all, Manfred,
>>
>> Please find interleaved answers/questions.
>>
>> On 20/01/2012 13:03, Manfred wrote:
>>
>>> Hi All,
>>>
>>> I tested the patch on my omap3630 and I ran the cross-link test.
>>> It works. I want to thank Fabrice Gasnier from my side.
>>>
>> you're welcome.
>>
>>>
>>>
With some help from Manfred, I also got cross-link to run on my OMAP3530
(latest patch from Fabrice, Jan. 26). Running Xenomai 2.6.0 on a 2.6.38
kernel in a Gumstix Overo Air and Water boards.


>  I have, however, the following suggestions/questions to the patch:
>>> - If I got it right, the errata only affects the RX_fifo (not the
>>> tx_fifo),
>>> so I suggest to handle those cases separately and usually call the
>>> normal reg_in,
>>>
>> >> and put the cases were we access RHR in "#ifdef omap"-clauses
>
>> It also cares about tx fifo full condition: in rt_16550_reg_out():
>> lsr =3D rt_16550_omap_raw_reg_in(io_**mode, base, rshift, LSR);
>> while (!(lsr&  RTSER_LSR_THR_EMTPY)) {
>>
>>        /* Wait up to 10ms for the character(s) to be sent. */
>>        if(--tmout =3D=3D 0)
>>                break;
>>        rtdm_task_sleep(1000);
>>        lsr =3D rt_16550_omap_raw_reg_in(io_**mode, base, rshift, LSR);
>> }
>>
>>
>
> Ok, I could reproduce the tx fifo full condition (I could not find the
> precise errata, but it is indeed mentioned in the omap-serial.c )
> Nevertheless, I would prefer any solution that avoids timeouts and keeps
> the if-statements to a minimum in these performance-critical parts.
>
> For the tx_fifo full errata I would suggest the following:
> (The idea is to read the current tx_fifo_level before writing, and make
> sure we don't fill it)
> --------
>
> static inline void rt_16550_tx_interrupt(struct rt_16550_context *ctx)
> {
>        int c;
>        int count;
>
>        unsigned long base =3D ctx->base_addr;
>        unsigned char regshift =3D ctx->regshift;
>        int mode =3D rt_16550_io_mode_from_ctx(ctx)**;
>
>        unsigned char tx_fifo_level=3D0;
> #if defined (CONFIG_ARCH_OMAP3) || \
> defined (CONFIG_ARCH_OMAP4)
>        /*Make sure we don't overrun the txfifo*/
>     tx_fifo_level=3Drt_16550_reg_in(**io_mode,base,rshift,TXFIFO_**LVL_RE=
G);
> #endif
>
> /*      if (uart->modem & MSR_CTS)*/
>        {
>                for (count =3D ctx->tx_fifo-tx_fifo_level;
>
>                     (count > 0) && (ctx->out_npend > 0);
>                     count--, ctx->out_npend--) {
>                        c =3D ctx->out_buf[ctx->out_head++];
>                        rt_16550_reg_out(mode, base, regshift, THR, c);
>
>                        ctx->out_head &=3D (OUT_BUFFER_SIZE - 1);
>                }
>        }
> }
> -------
>
> I tested the code with long writes on my platform (250 bytes) (fifo is 64=
)
> at 9600Baud (slow on purpose) with the periodic task at 10Hz (standard) a=
nd
> it seems to work.


Works well here as well, but mine crashed after 9500 or so iterations. No
abnormal behavior before the crash.


>

I have however some more issues (which appear also with your original
> patch):
> - when I try to push the cross-link.c example to the limit , by increasin=
g
> the frequency of the periodic tasks to 500Hz (was 10Hz). I get corrupt da=
ta
> after some 1000 iterations. (The timestamp suddenly jumps from 70000 to a
> very high value). If I interrupt the code then and want to start it again=
,
> the machine freezes (If I first unload and reload the kernel module, the
> machine does not freeze). So my guess is, that the write function is bein=
g
> interrupted by a read-interrupt before finishing the write. But somehow
> this seems not to be catched by the corresponding error-handler (number o=
f
> bytes written <size)
>

I have the exact same behavior on my setup, even with the new patch. Tested
at 1kHz, 115200 baud.


>
> - Is there a debug-tool for xenomai to see where the code has been
> interrupted, or which interrupts have been handled recently. Or can I
> prevent the write-routine from being interrupted?
>
> - Has anyone tried to push the cross-link example on a different platform
> to the limit, and seen similar effects?
>
> - I would also like to enable parity bits on the serial link, but if I se=
t
> the config_flags (for write and read device) like this:
> .parity            =3D RTSER_ODD_PARITY,
> cross-link hangs before the first read ... and freezes the machine..
> Has anyone tried using Parity bits with xeno_16550A ? Do I have to change
> other flags to make it work?
>
> Regards,
> Manfred
>
>
Hope this can help we figure out the issue! I can try to run more tests if
they are needed.

Many thanks,

       -Felipe Brand=E3o Cavalcanti
       LARA - Automation and Robotics Laboratory
       Department of Electrical Engineering
       UnB - University of Bras=EDlia, Brazil
       http://www.lara.unb.br/~fbcavalcanti/


>
>
>
>
> ______________________________**_________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/**xenomai-help<https://mail.gna.org/listinf=
o/xenomai-help>
>

--002354470548fa433104b9a642bd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear all,<br><br><div class=3D"gmail_quote">On Sun, Jan 22, 2012 at 5:04 PM=
, Manfred <span dir=3D"ltr">&lt;<a href=3D"mailto:manfred@domain.hid">=
manfred@domain.hid</a>&gt;</span> wrote:<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">

<div class=3D"im"><br>
On 1/20/12 3:41 PM, Fabrice Gasnier wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Dear all, Manfred,<br>
<br>
Please find interleaved answers/questions.<br>
<br>
On 20/01/2012 13:03, Manfred wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi All,<br>
<br>
I tested the patch on my omap3630 and I ran the cross-link test.<br>
It works. I want to thank Fabrice Gasnier from my side.<br>
</blockquote>
you&#39;re welcome.<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br></blockquote></blockquote></div></blockquote><div><br></div><div>With s=
ome help from Manfred, I also got cross-link to run on my OMAP3530 (latest =
patch from Fabrice, Jan. 26). Running Xenomai 2.6.0 on a 2.6.38 kernel in a=
 Gumstix Overo Air and Water boards.</div>

<div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><div class=3D"im"><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
I have, however, the following suggestions/questions to the patch:<br>
- If I got it right, the errata only affects the RX_fifo (not the tx_fifo),=
<br>
so I suggest to handle those cases separately and usually call the normal r=
eg_in,<br>
</blockquote></blockquote>
&gt;&gt; and put the cases were we access RHR in &quot;#ifdef omap&quot;-cl=
auses<br>
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><div class=3D"im">
It also cares about tx fifo full condition: in rt_16550_reg_out():<br>
lsr =3D rt_16550_omap_raw_reg_in(io_<u></u>mode, base, rshift, LSR);<br></d=
iv>
while (!(lsr&amp; =A0RTSER_LSR_THR_EMTPY)) {<div class=3D"im"><br>
 =A0 =A0 =A0 =A0/* Wait up to 10ms for the character(s) to be sent. */<br>
 =A0 =A0 =A0 =A0if(--tmout =3D=3D 0)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;<br>
 =A0 =A0 =A0 =A0rtdm_task_sleep(1000);<br>
 =A0 =A0 =A0 =A0lsr =3D rt_16550_omap_raw_reg_in(io_<u></u>mode, base, rshi=
ft, LSR);<br>
}<br>
<br>
</div></blockquote>
<br>
<br>
Ok, I could reproduce the tx fifo full condition (I could not find the prec=
ise errata, but it is indeed mentioned in the omap-serial.c )<br>
Nevertheless, I would prefer any solution that avoids timeouts and keeps th=
e if-statements to a minimum in these performance-critical parts.<br>
<br>
For the tx_fifo full errata I would suggest the following:<br>
(The idea is to read the current tx_fifo_level before writing, and make sur=
e we don&#39;t fill it)<br>
--------<br>
<br>
static inline void rt_16550_tx_interrupt(struct rt_16550_context *ctx)<br>
{<br>
 =A0 =A0 =A0 =A0int c;<br>
 =A0 =A0 =A0 =A0int count;<div class=3D"im"><br>
 =A0 =A0 =A0 =A0unsigned long base =3D ctx-&gt;base_addr;<br></div>
 =A0 =A0 =A0 =A0unsigned char regshift =3D ctx-&gt;regshift;<br>
 =A0 =A0 =A0 =A0int mode =3D rt_16550_io_mode_from_ctx(ctx)<u></u>;<br>
<br>
 =A0 =A0 =A0 =A0unsigned char tx_fifo_level=3D0;<br>
#if defined (CONFIG_ARCH_OMAP3) || \<br>
defined (CONFIG_ARCH_OMAP4)<br>
 =A0 =A0 =A0 =A0/*Make sure we don&#39;t overrun the txfifo*/<br>
 =A0 =A0 tx_fifo_level=3Drt_16550_reg_in(<u></u>io_mode,base,rshift,TXFIFO_=
<u></u>LVL_REG);<br>
#endif<br>
<br>
/* =A0 =A0 =A0if (uart-&gt;modem &amp; MSR_CTS)*/<br>
 =A0 =A0 =A0 =A0{<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (count =3D ctx-&gt;tx_fifo-tx_fifo_leve=
l;<div class=3D"im"><br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (count &gt; 0) &amp;&amp; (ctx-&gt=
;out_npend &gt; 0);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count--, ctx-&gt;out_npend--) {<br=
>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0c =3D ctx-&gt;out_buf[ctx-&=
gt;out_head++];<br></div>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rt_16550_reg_out(mode, base=
, regshift, THR, c);<div class=3D"im"><br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctx-&gt;out_head &amp;=3D (=
OUT_BUFFER_SIZE - 1);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}<br>
 =A0 =A0 =A0 =A0}<br>
}<br></div>
-------<br>
<br>
I tested the code with long writes on my platform (250 bytes) (fifo is 64) =
at 9600Baud (slow on purpose) with the periodic task at 10Hz (standard) and=
 it seems to work.</blockquote><div><br></div><div>Works well here as well,=
 but mine crashed after 9500 or so iterations. No abnormal behavior before =
the crash.</div>

<div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">=A0</blockquote><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">


I have however some more issues (which appear also with your original patch=
):<br>
- when I try to push the cross-link.c example to the limit , by increasing =
the frequency of the periodic tasks to 500Hz (was 10Hz). I get corrupt data=
 after some 1000 iterations. (The timestamp suddenly jumps from 70000 to a =
very high value). If I interrupt the code then and want to start it again, =
the machine freezes (If I first unload and reload the kernel module, the ma=
chine does not freeze). So my guess is, that the write function is being in=
terrupted by a read-interrupt before finishing the write. But somehow this =
seems not to be catched by the corresponding error-handler (number of bytes=
 written &lt;size)<br>

</blockquote><div><br></div><div>I have the exact same behavior on my setup=
, even with the new patch. Tested at 1kHz, 115200 baud.</div><div>=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">


<br>
- Is there a debug-tool for xenomai to see where the code has been interrup=
ted, or which interrupts have been handled recently. Or can I prevent the w=
rite-routine from being interrupted?<br>
<br>
- Has anyone tried to push the cross-link example on a different platform t=
o the limit, and seen similar effects?<br>
<br>
- I would also like to enable parity bits on the serial link, but if I set =
the config_flags (for write and read device) like this:<br>
.parity =A0 =A0 =A0 =A0 =A0 =A0=3D RTSER_ODD_PARITY,<br>
cross-link hangs before the first read ... and freezes the machine..<br>
Has anyone tried using Parity bits with xeno_16550A ? Do I have to change o=
ther flags to make it work?<br>
<br>
Regards,<br>
Manfred<div class=3D"HOEnZb"><div class=3D"h5"><br></div></div></blockquote=
><div><br></div><div>Hope this can help we figure out the issue! I can try =
to run more tests if they are needed.</div><div><br></div><div>Many thanks,=
</div>

<div><br></div><div>=A0 =A0 =A0 =A0-Felipe Brand=E3o Cavalcanti<div>=A0 =A0=
 =A0 =A0LARA - Automation and Robotics Laboratory</div><div>=A0 =A0 =A0 =A0=
Department of Electrical Engineering<br>=A0 =A0 =A0=A0 UnB - University of =
Bras=EDlia, Brazil<br>=A0 =A0 =A0=A0=A0<a href=3D"http://www.lara.unb.br/~f=
bcavalcanti/" target=3D"_blank">http://www.lara.unb.br/~fbcavalcanti/</a></=
div>

</div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><d=
iv class=3D"h5">
<br>
<br>
<br>
<br>
______________________________<u></u>_________________<br>
Xenomai-help mailing list<br>
<a href=3D"mailto:Xenomai-help@domain.hid" target=3D"_blank">Xenomai-help@domain.hid.=
org</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/<u></u>xenomai-help</a></div></div></blockquote=
></div>

--002354470548fa433104b9a642bd--

