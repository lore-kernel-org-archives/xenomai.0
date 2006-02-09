Message-ID: <b647ffbd0602090311x56dbc765x@domain.hid>
Date: Thu, 9 Feb 2006 13:11:31 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [Combo-PATCH] Shared interrupts (final)
In-Reply-To: <43EB1741.9080809@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_14349_7917942.1139483491640"
References: <b647ffbd0602070104s63275903q@domain.hid>
	<43E86F4D.4050400@domain.hid>
	<43E8DFC4.4010805@domain.hid> <43E9CE95.3070806@domain.hid>
	<43EAFD8B.7020400@domain.hid> <43EB1279.3040902@domain.hid>
	<43EB1741.9080809@domain.hid>
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

------=_Part_14349_7917942.1139483491640
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 09/02/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Philippe Gerum wrote:
> > Anders Blomdell wrote:
> >
> >> My distinct feeling is that the return value should be a scalar and
> >> not a set!
> >>
> >
> > To sum up, the valid return values are HANDLED, HANDLED | ENABLE (*),
> > HANDLED | CHAINED and CHAINED. It's currently a set because I once
> > thought that the "handled" indication (or lack of) could be a valuable
> > information to gather at nucleus level to detect unhandled RT
> > interrupts. Fact is that we currently don't use this information,
>
> But it is required for the edge-triggered case to detect when the IRQ
> line was at least shortly released. I guess Dmitry introduced that NOINT
> just because HANDLED equals 0 so far. As I would say HANDLED =3D=3D !NOIN=
T,
> we could avoid this new flag by just making HANDLED non-zero.


That's it.

I was about to make a comment on Philipe's list of possible return values,
but you outrun me.

HANDLED is 0 so we can not distinguish between HANDLED | CHAINED and CHAINE=
D
cases. NOINT denotes explicitly the handler's answer "this IRQ is rised not
by my hw!" and it's needed (at least) for implementing the edge-triggered
irq sharing.

It's not necessary in case HANDLED becomes non-zero and, actually, HANDLED
is not necessary with NOINT.

As I may see, Philipe's list can be mapped as follows :

HANDLED  ->  0
HANDLED | ENABLE  ->  ENABLE
HANDLED | CHAINED ->  CHAINED
CHAINED                   ->  CHAINED | NOINT

and

NOINT as a separete use case (?). Could be useful at least for the
edge-triggered stuff.


--
Best regards,
Dmitry Adamushko

------=_Part_14349_7917942.1139483491640
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><div><span class=3D"gmail_quote">On 09/02/06, <b class=3D"gmail_sendern=
ame">Jan Kiszka</b> &lt;<a href=3D"mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid=
.de</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-=
left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left=
: 1ex;">
Philippe Gerum wrote:<br>&gt; Anders Blomdell wrote:<br>&gt;<br>&gt;&gt; My=
 distinct feeling is that the return value should be a scalar and<br>&gt;&g=
t; not a set!<br>&gt;&gt;<br>&gt;<br>&gt; To sum up, the valid return value=
s are HANDLED, HANDLED | ENABLE (*),
<br>&gt; HANDLED | CHAINED and CHAINED. It's currently a set because I once=
<br>&gt; thought that the &quot;handled&quot; indication (or lack of) could=
 be a valuable<br>&gt; information to gather at nucleus level to detect unh=
andled RT
<br>&gt; interrupts. Fact is that we currently don't use this information,<=
br><br>But it is required for the edge-triggered case to detect when the IR=
Q<br>line was at least shortly released. I guess Dmitry introduced that NOI=
NT
<br>just because HANDLED equals 0 so far. As I would say HANDLED =3D=3D !NO=
INT,<br>we could avoid this new flag by just making HANDLED non-zero.</bloc=
kquote><div><br>
That's it.<br>
<br>
I was about to make a comment on Philipe's list of possible return values, =
but you outrun me.<br>
<br>
HANDLED is 0 so we can not distinguish between HANDLED | CHAINED and
CHAINED cases. NOINT denotes explicitly the handler's answer &quot;this IRQ
is rised not by my hw!&quot; and it's needed (at least) for implementing th=
e
edge-triggered irq sharing.<br>
<br>
It's not necessary in case HANDLED becomes non-zero and, actually, HANDLED =
is not necessary with NOINT.<br>
<br>
As I may see, Philipe's list can be mapped as follows :<br>
<br>
HANDLED&nbsp; -&gt;&nbsp; 0<br>
HANDLED | ENABLE&nbsp; -&gt;&nbsp; ENABLE<br>
HANDLED | CHAINED -&gt;&nbsp; CHAINED<br>
CHAINED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
-&gt;&nbsp; CHAINED | NOINT<br>
<br>
and <br>
<br>
NOINT as a separete use case (?). Could be useful at least for the edge-tri=
ggered stuff.<br>
<br>
</div></div><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_14349_7917942.1139483491640--

