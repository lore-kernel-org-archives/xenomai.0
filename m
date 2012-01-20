MIME-Version: 1.0
In-Reply-To: <4F197D0C.4060407@domain.hid>
References: <4F1080E8.6020408@domain.hid>
	<4F1082E5.8000501@domain.hid>
	<4F132A7E.4000000@domain.hid> <4F16F028.6020507@domain.hid>
	<4F16F401.2090308@domain.hid> <4F184E42.6060300@domain.hid>
	<4F19581A.8070300@domain.hid> <4F197D0C.4060407@domain.hid>
From: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Date: Fri, 20 Jan 2012 13:58:36 -0200
Message-ID: <CAAsfwtOz741xviMT1ONvjjE=uwaA4aNvjiGW2NzcQmwPwuq63A@mail.gmail.com>
Content-Type: multipart/alternative; boundary=00235429c8242471fd04b6f7c21c
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
To: Fabrice Gasnier <fabrice.gasnier@domain.hid>
Cc: xenomai@xenomai.org

--00235429c8242471fd04b6f7c21c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear All,

Any chance you guys could make a Gumstix Overo image with Xenomai and the
RTDM drivers working? I was actually going to start working on this very
issue (RTDM drivers for the OMAP) next week, but you seem to have had a
head start on that.

Many thanks!
       -Felipe Brand=E3o Cavalcanti
       LARA - Automation and Robotics Laboratory
       Department of Electrical Engineering
       UnB - University of Bras=EDlia, Brazil
       http://www.lara.unb.br/~fbcavalcanti/

On Fri, Jan 20, 2012 at 12:41 PM, Fabrice Gasnier <
fabrice.gasnier@domain.hid> wrote:

> Dear all, Manfred,
>
> Please find interleaved answers/questions.
>
> On 20/01/2012 13:03, Manfred wrote:
> > Hi All,
> >
> > I tested the patch on my omap3630 and I ran the cross-link test.
> > It works. I want to thank Fabrice Gasnier from my side.
> you're welcome.
> >
> > I have, however, the following suggestions/questions to the patch:
> > - If I got it right, the errata only affects the RX_fifo (not the
> tx_fifo), so I suggest to handle those cases separately and usually call
> the normal reg_in, and put the cases were we access RHR in "#ifdef
> omap"-clauses
> It also cares about tx fifo full condition: in rt_16550_reg_out():
> lsr =3D rt_16550_omap_raw_reg_in(io_mode, base, rshift, LSR);
> while (!(lsr & RTSER_LSR_THR_EMTPY)) {
>        /* Wait up to 10ms for the character(s) to be sent. */
>        if(--tmout =3D=3D 0)
>                break;
>        rtdm_task_sleep(1000);
>        lsr =3D rt_16550_omap_raw_reg_in(io_mode, base, rshift, LSR);
> }
>
> > - There is however another errata (or 'quirk') about the mdr1 register
> > http://www.ti.com/pdfs/wtbu/SWPZ017B_4460_Public_SE.pdf
> > but I don't think that this register is ever touched by the xeno_16550A
> driver. (If we would touch it in the future, one would have to add #ifdef
> clauses and use omapsafe_reg_out)
> > - in the mach-omap2/serial.c  in function "serial_out_override" there i=
s
> this 10ms timeout-value, which should probably be avoided at any cost (it
> will increase the latency). I actually don't see why we should wait for t=
he
> transmit_fifo to empty. Why is this necc.? Is there still another errata
> about the tx_fifo?
> I think you're right it adds latencies, but what can we do about this?
> e.g. I've made some testing without such a handling: trying to write "lot=
s
> of" bytes (I assume more than fifo size) freezes target. It has to be
> handled somehow. Maybe it's wrong to do this way?
> Maybe it would be better to write up to fifo full and then return...
> - an error ?
> - or just the number of written bytes with no error?
> This way responsibility would be let to the caller (writting to much byte=
s
> will cause a lantency in the end, no ?)
> I'm not sure of expected behavior on other platforms such as x86 ?
>
> >
> > So I suggest to usually call the normal reg_out (formerly
> omap_raw_reg_out) and only call the modified one when necc. (now renamed =
to
> omapsafe_reg_out)
> >
> > I have made the changes along these lines and attached them in a patch.
> (this patch is to be applied after the patch from Fabrice Gasnier)
> >
> > When I compare the timings between the original patch and with my lates=
t
> changes (using cross-link and creating load with dohell -s <wlanhost>) I
> get about 25% better timings under load. (I only ran each test once for
> 3min each, though). Without load, there is of course no big change in the
> latencies.
> >
> > @Fabrice: Can you check with cross-link.c on your platform? I get
> worst-case timings of 150micros with your patch, and 115micros with my
> additional changes. (I think these are round-trip timings, but I am not
> sure)
> I shall try these, but I own a PhyCARD-L that only has one serial port...
> Cannot run cross-link.
> >
> > Let me know, what you think.
> > Regards
> > Manfred
> >
> > On 1/19/12 6:09 PM, Fabrice Gasnier wrote:
> >> Finally, I find out that UART was in sleep mode.
> >> According to omap's reference manual, it enters this mode when
> conditions are met:
> >> rx line is idle,
> >> tx fifo and shift register are empty,
> >> rx fifo is empty
> >> no interrupts pending
> >>
> >> One solution that i've tested successfully is to disable sleep mode in
> rt_16550_open().
> >> TX interrupts are then being triggered as expected.
> >
> >>> other quirks, see:
> >>>
> >>> http://lxr.linux.no/#linux+v3.2.1/arch/arm/mach-omap2/serial.c#L742
> >> Thank you for this link! It helps handle the fifo full condition.
> >> However, I noticed a strange value regarding version register. My
> omap3530 reports 0x46?
> >> Linux serial driver assume this bug is present on revision>=3D 0x52 ..=
.
> >> But my target freeze when I send more than 16 chars at once (Fifo full
> without errata handling).
> >> It works when using errata handling.
> >
> >>
> >> You'll find attached a patch that works for me.
> >> Please advise. Maybe we can enhance it and push it?
> >>
> >> Thanks!
> >> Regards,
> >>
> >> Fabrice
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

--00235429c8242471fd04b6f7c21c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear All,<div><br></div><div>Any chance you guys could make a Gumstix Overo=
 image with Xenomai and the RTDM drivers working? I was actually going to s=
tart working on this very issue (RTDM drivers for the OMAP) next week, but =
you seem to have had a head start on that.</div>

<div><br></div><div>Many thanks!</div><div>=A0 =A0 =A0=A0 -Felipe Brand=E3o=
 Cavalcanti<div>=A0 =A0 =A0 =A0LARA - Automation and Robotics Laboratory</d=
iv><div>=A0 =A0 =A0 =A0Department of Electrical Engineering<br>=A0 =A0 =A0=
=A0 UnB - University of Bras=EDlia, Brazil<br>

=A0 =A0 =A0=A0=A0<a href=3D"http://www.lara.unb.br/~fbcavalcanti/" target=
=3D"_blank">http://www.lara.unb.br/~fbcavalcanti/</a></div><br><div class=
=3D"gmail_quote">On Fri, Jan 20, 2012 at 12:41 PM, Fabrice Gasnier <span di=
r=3D"ltr">&lt;<a href=3D"mailto:fabrice.gasnier@domain.hid">fabrice.gasnie=
r@domain.hid</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Dear all, Manfred,<br>
<br>
Please find interleaved answers/questions.<br>
<div class=3D"im"><br>
On 20/01/2012 13:03, Manfred wrote:<br>
&gt; Hi All,<br>
&gt;<br>
&gt; I tested the patch on my omap3630 and I ran the cross-link test.<br>
&gt; It works. I want to thank Fabrice Gasnier from my side.<br>
</div>you&#39;re welcome.<br>
<div class=3D"im">&gt;<br>
&gt; I have, however, the following suggestions/questions to the patch:<br>
&gt; - If I got it right, the errata only affects the RX_fifo (not the tx_f=
ifo), so I suggest to handle those cases separately and usually call the no=
rmal reg_in, and put the cases were we access RHR in &quot;#ifdef omap&quot=
;-clauses<br>


</div>It also cares about tx fifo full condition: in rt_16550_reg_out():<br=
>
lsr =3D rt_16550_omap_raw_reg_in(io_mode, base, rshift, LSR);<br>
while (!(lsr &amp; RTSER_LSR_THR_EMTPY)) {<br>
 =A0 =A0 =A0 =A0/* Wait up to 10ms for the character(s) to be sent. */<br>
 =A0 =A0 =A0 =A0if(--tmout =3D=3D 0)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;<br>
 =A0 =A0 =A0 =A0rtdm_task_sleep(1000);<br>
 =A0 =A0 =A0 =A0lsr =3D rt_16550_omap_raw_reg_in(io_mode, base, rshift, LSR=
);<br>
<div class=3D"im">}<br>
<br>
&gt; - There is however another errata (or &#39;quirk&#39;) about the mdr1 =
register<br>
&gt; <a href=3D"http://www.ti.com/pdfs/wtbu/SWPZ017B_4460_Public_SE.pdf" ta=
rget=3D"_blank">http://www.ti.com/pdfs/wtbu/SWPZ017B_4460_Public_SE.pdf</a>=
<br>
&gt; but I don&#39;t think that this register is ever touched by the xeno_1=
6550A driver. (If we would touch it in the future, one would have to add #i=
fdef clauses and use omapsafe_reg_out)<br>
&gt; - in the mach-omap2/serial.c =A0in function &quot;serial_out_override&=
quot; there is this 10ms timeout-value, which should probably be avoided at=
 any cost (it will increase the latency). I actually don&#39;t see why we s=
hould wait for the transmit_fifo to empty. Why is this necc.? Is there stil=
l another errata about the tx_fifo?<br>


</div>I think you&#39;re right it adds latencies, but what can we do about =
this?<br>
e.g. I&#39;ve made some testing without such a handling: trying to write &q=
uot;lots of&quot; bytes (I assume more than fifo size) freezes target. It h=
as to be handled somehow. Maybe it&#39;s wrong to do this way?<br>
Maybe it would be better to write up to fifo full and then return...<br>
- an error ?<br>
- or just the number of written bytes with no error?<br>
This way responsibility would be let to the caller (writting to much bytes =
will cause a lantency in the end, no ?)<br>
I&#39;m not sure of expected behavior on other platforms such as x86 ?<br>
<div class=3D"im"><br>
&gt;<br>
&gt; So I suggest to usually call the normal reg_out (formerly omap_raw_reg=
_out) and only call the modified one when necc. (now renamed to omapsafe_re=
g_out)<br>
&gt;<br>
&gt; I have made the changes along these lines and attached them in a patch=
. (this patch is to be applied after the patch from Fabrice Gasnier)<br>
&gt;<br>
&gt; When I compare the timings between the original patch and with my late=
st changes (using cross-link and creating load with dohell -s &lt;wlanhost&=
gt;) I get about 25% better timings under load. (I only ran each test once =
for 3min each, though). Without load, there is of course no big change in t=
he latencies.<br>


&gt;<br>
&gt; @Fabrice: Can you check with cross-link.c on your platform? I get wors=
t-case timings of 150micros with your patch, and 115micros with my addition=
al changes. (I think these are round-trip timings, but I am not sure)<br>


</div>I shall try these, but I own a PhyCARD-L that only has one serial por=
t... Cannot run cross-link.<br>
<div class=3D"im HOEnZb">&gt;<br>
&gt; Let me know, what you think.<br>
&gt; Regards<br>
&gt; Manfred<br>
&gt;<br>
&gt; On 1/19/12 6:09 PM, Fabrice Gasnier wrote:<br>
&gt;&gt; Finally, I find out that UART was in sleep mode.<br>
&gt;&gt; According to omap&#39;s reference manual, it enters this mode when=
 conditions are met:<br>
&gt;&gt; rx line is idle,<br>
&gt;&gt; tx fifo and shift register are empty,<br>
&gt;&gt; rx fifo is empty<br>
&gt;&gt; no interrupts pending<br>
&gt;&gt;<br>
&gt;&gt; One solution that i&#39;ve tested successfully is to disable sleep=
 mode in rt_16550_open().<br>
&gt;&gt; TX interrupts are then being triggered as expected.<br>
&gt;<br>
&gt;&gt;&gt; other quirks, see:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; <a href=3D"http://lxr.linux.no/#linux+v3.2.1/arch/arm/mach-oma=
p2/serial.c#L742" target=3D"_blank">http://lxr.linux.no/#linux+v3.2.1/arch/=
arm/mach-omap2/serial.c#L742</a><br>
&gt;&gt; Thank you for this link! It helps handle the fifo full condition.<=
br>
&gt;&gt; However, I noticed a strange value regarding version register. My =
omap3530 reports 0x46?<br>
&gt;&gt; Linux serial driver assume this bug is present on revision&gt;=3D =
0x52 ...<br>
&gt;&gt; But my target freeze when I send more than 16 chars at once (Fifo =
full without errata handling).<br>
&gt;&gt; It works when using errata handling.<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; You&#39;ll find attached a patch that works for me.<br>
&gt;&gt; Please advise. Maybe we can enhance it and push it?<br>
&gt;&gt;<br>
&gt;&gt; Thanks!<br>
&gt;&gt; Regards,<br>
&gt;&gt;<br>
&gt;&gt; Fabrice<br>
<br>
</div><div class=3D"HOEnZb"><div class=3D"h5">_____________________________=
__________________<br>
Xenomai-help mailing list<br>
<a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-help</a></div></div></blockquote></div>=
<br>
</div>

--00235429c8242471fd04b6f7c21c--

