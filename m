Message-ID: <b647ffbd0602140007l2c8b25bj@domain.hid>
Date: Tue, 14 Feb 2006 10:07:12 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] Re: [shirq] first test results
In-Reply-To: <43F0D374.7010801@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_15381_24587923.1139904432106"
References: <43ECD570.5000704@domain.hid>
	<b647ffbd0602110331i400d7ff5k@domain.hid>
	<43EDDF9E.4030309@domain.hid>
	<b647ffbd0602111058v3e8c6790w@domain.hid>
	<43F0D374.7010801@domain.hid>
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

------=_Part_15381_24587923.1139904432106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 13/02/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Dmitry Adamushko wrote:
> > On 11/02/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> >> Dmitry Adamushko wrote:
> >>> And as an additional option,
> >>> it could be interesting to print out to the log if not all "counter"
> >> values
> >>> then min,max,average (the same like for the latency :) per second or
> per
> >>> 1000 interrupts; so to see whether tweaking the MAX_EDGEIRQ_COUNTER
> may
> >> make
> >>> the things better.
> >> Yes, maybe it's too small. But this also depends on the absolute time
> >> required for so many loops, something we should see in the traces then=
.
> >> I'm afraid that we will finally have to move the UART's read-from-fifo
> >> to task context to reduce the time spent in IRQ context.
> >
> > Good. Keep me informed as before.
> >
>
> We got it working. :)


Great!


> Anyway, this works now. But we also found a bug, as usual, a clean-up
> bug: You released the IRQ line based on the wrong test, see attached
> patch.


Ah... it worked for my test cases since it depended on the order of
xnintr_detach() calls. Thanks.


With this fix applied and the IRQ flags as well as the
> /proc/xenomai/irq output cleaned up, I would say you great work is ready
> for merge!


So I'll create the final patch and submit it to Philippe for merging.
One more thing is making all this stuff optional; XENO_OPT_SHIRQ and
XENO_OPT_SHIRQ_EDGE or something like this.


Thanks,
> Jan
>
>

--
Best regards,
Dmitry Adamushko

------=_Part_15381_24587923.1139904432106
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><div><span class=3D"gmail_quote">On 13/02/06, <b class=3D"gmail_sendern=
ame">Jan Kiszka</b> &lt;<a href=3D"mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid=
.de</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-=
left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left=
: 1ex;">
Dmitry Adamushko wrote:<br>&gt; On 11/02/06, Jan Kiszka &lt;<a href=3D"mail=
to:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:<br>&gt;&gt; Dmitry A=
damushko wrote:<br>&gt;&gt;&gt; And as an additional option,<br>&gt;&gt;&gt=
; it could be interesting to print out to the log if not all &quot;counter&=
quot;
<br>&gt;&gt; values<br>&gt;&gt;&gt; then min,max,average (the same like for=
 the latency :) per second or per<br>&gt;&gt;&gt; 1000 interrupts; so to se=
e whether tweaking the MAX_EDGEIRQ_COUNTER may<br>&gt;&gt; make<br>&gt;&gt;=
&gt; the things better.
<br>&gt;&gt; Yes, maybe it's too small. But this also depends on the absolu=
te time<br>&gt;&gt; required for so many loops, something we should see in =
the traces then.<br>&gt;&gt; I'm afraid that we will finally have to move t=
he UART's read-from-fifo
<br>&gt;&gt; to task context to reduce the time spent in IRQ context.<br>&g=
t;<br>&gt; Good. Keep me informed as before.<br>&gt;<br><br>We got it worki=
ng. :)</blockquote><div><br>
Great! <br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>Any=
way, this works now. But we also found a bug, as usual, a clean-up<br>bug: =
You released the IRQ line based on the wrong test, see attached
<br>patch.</blockquote><div><br>
Ah... it worked for my test cases since it depended on the order of xnintr_=
detach() calls. Thanks.<br>
</div><br>
<br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(2=
04, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"> With this fi=
x applied and the IRQ flags as well as the<br>/proc/xenomai/irq output clea=
ned up, I would say you great work is ready
<br>for merge!</blockquote><div><br>
So I'll create the final patch and submit it to Philippe for merging.<br>
One more thing is making all this stuff optional; XENO_OPT_SHIRQ and XENO_O=
PT_SHIRQ_EDGE or something like this.<br>
&nbsp;</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px=
 solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">T=
hanks,<br>Jan<br><br></blockquote></div><br clear=3D"all"><br>-- <br>Best r=
egards,
<br>Dmitry Adamushko

------=_Part_15381_24587923.1139904432106--

