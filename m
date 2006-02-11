Message-ID: <b647ffbd0602111058v3e8c6790w@domain.hid>
Date: Sat, 11 Feb 2006 20:58:51 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
In-Reply-To: <43EDDF9E.4030309@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_7313_7695940.1139684331117"
References: <43ECD570.5000704@domain.hid>
	<b647ffbd0602110331i400d7ff5k@domain.hid>
	<43EDDF9E.4030309@domain.hid>
Subject: [Xenomai-core] Re: [shirq] first test results
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

------=_Part_7313_7695940.1139684331117
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 11/02/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Dmitry Adamushko wrote:
> > And as an additional option,
> > it could be interesting to print out to the log if not all "counter"
> values
> > then min,max,average (the same like for the latency :) per second or pe=
r
> > 1000 interrupts; so to see whether tweaking the MAX_EDGEIRQ_COUNTER may
> make
> > the things better.
>
> Yes, maybe it's too small. But this also depends on the absolute time
> required for so many loops, something we should see in the traces then.
> I'm afraid that we will finally have to move the UART's read-from-fifo
> to task context to reduce the time spent in IRQ context.



Good. Keep me informed as before.

> Maybe we'd better go for 1, just in case somebody would like to know
> > the actual number of virq occuried. Although, I can imagine that only
> > for debugging reasons and of no avail for the normal users, so maybe 2
> :)
>
> I have no final opinion yet. Having some names also behind the virtual
> IRQs would be really nice for debugging, but it would also break another
> bulk of API calls. Just marking those IRQs virtual would render the
> related output of /proc/xenomai/irq not very useful in my eye - as long
> as you do not know what's behind it. Just dropping this information is
> then likely better.


Yep. Let's just avoid printing it.


>> Then I stumbled over the xnintr structure. Why do you keep a copy of the
> >> device name?
> >> A "const char *" should be enough, we just have to demand
> >> that it will remain valid as long as the xnintr structure itself (i.e.
> >> during the IRQ being attached). Saves a few bytes. :)
> >
> > Could be if all the users of it are initially kernel-mode entities.
> >
> > But e.g. there is a version of rt_intr_create() that may be called by
> > user-space
> > apps and I extended it to support the "name" parameter too :
> >
> > int rt_intr_create(RT_INTR *intr, const char *name, unsigned irq, int
> mode);
> >
> > In such a case, the kernel-side rt_intr_create() is called with the
> "name"
> > allocated on the stack in skins/native/syscall.c : __rt_intr_create())
> > so the initial copy of the name can not remain valid.
>
> But you could create buffer space for a copy of the name in the same
> block already allocated for RT_INTR. Should be straightforward.


RT_INTR does not have the "name" field any more. I have removed it after
adding the same field to the xnintr_t as it became redundant.

To access the "name", any code in native skin does "intr->intr_base.name"
(intr_base is of "xnintr_t" type).


Jan
>
>
>
>

--
Best regards,
Dmitry Adamushko

------=_Part_7313_7695940.1139684331117
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><div><span class=3D"gmail_quote">On 11/02/06, <b class=3D"gmail_sendern=
ame">Jan Kiszka</b> &lt;<a href=3D"mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid=
.de</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-=
left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left=
: 1ex;">
Dmitry Adamushko wrote:<br>&gt; And as an additional option,<br>&gt; it cou=
ld be interesting to print out to the log if not all &quot;counter&quot; va=
lues<br>&gt; then min,max,average (the same like for the latency :) per sec=
ond or per
<br>&gt; 1000 interrupts; so to see whether tweaking the MAX_EDGEIRQ_COUNTE=
R may make<br>&gt; the things better.<br><br>Yes, maybe it's too small. But=
 this also depends on the absolute time<br>required for so many loops, some=
thing we should see in the traces then.
<br>I'm afraid that we will finally have to move the UART's read-from-fifo<=
br>to task context to reduce the time spent in IRQ context.</blockquote><di=
v><br>
<br>
Good. Keep me informed as before. <br>
<br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; Maybe =
we'd better go for 1, just in case somebody would like to know<br>&gt; the =
actual number of virq occuried. Although, I can imagine that only
<br>&gt; for debugging reasons and of no avail for the normal users, so may=
be 2 :)<br><br>I have no final opinion yet. Having some names also behind t=
he virtual<br>IRQs would be really nice for debugging, but it would also br=
eak another
<br>bulk of API calls. Just marking those IRQs virtual would render the<br>=
related output of /proc/xenomai/irq not very useful in my eye - as long<br>=
as you do not know what's behind it. Just dropping this information is<br>
then likely better.</blockquote><div><br>
Yep. Let's just avoid printing it.<br>
&nbsp;</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px=
 solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&=
gt;&gt; Then I stumbled over the xnintr structure. Why do you keep a copy o=
f the
<br>&gt;&gt; device name?<br>&gt;&gt; A &quot;const char *&quot; should be =
enough, we just have to demand<br>&gt;&gt; that it will remain valid as lon=
g as the xnintr structure itself (i.e.<br>&gt;&gt; during the IRQ being att=
ached). Saves a few bytes. :)
<br>&gt;<br>&gt; Could be if all the users of it are initially kernel-mode =
entities.<br>&gt;<br>&gt; But e.g. there is a version of rt_intr_create() t=
hat may be called by<br>&gt; user-space<br>&gt; apps and I extended it to s=
upport the &quot;name&quot; parameter too :
<br>&gt;<br>&gt; int rt_intr_create(RT_INTR *intr, const char *name, unsign=
ed irq, int mode);<br>&gt;<br>&gt; In such a case, the kernel-side rt_intr_=
create() is called with the &quot;name&quot;<br>&gt; allocated on the stack=
 in skins/native/syscall.c : __rt_intr_create())
<br>&gt; so the initial copy of the name can not remain valid.<br><br>But y=
ou could create buffer space for a copy of the name in the same<br>block al=
ready allocated for RT_INTR. Should be straightforward.</blockquote><div>
<br>
RT_INTR does not have the &quot;name&quot; field any more. I have removed i=
t
after adding the same field to the xnintr_t as it became redundant.<br>
<br>
To access the &quot;name&quot;, any code in native skin does &quot;intr-&gt=
;intr_base.name&quot; (intr_base is of &quot;xnintr_t&quot; type).<br>
&nbsp;<br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan<br>=
<br><br><br></blockquote></div><br clear=3D"all"><br>-- <br>Best regards,<b=
r>
Dmitry Adamushko

------=_Part_7313_7695940.1139684331117--

