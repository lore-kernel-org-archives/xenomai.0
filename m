Message-ID: <b647ffbd0603010001i58a7d8a5m@domain.hid>
Date: Wed, 1 Mar 2006 10:01:04 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] 16550 compile err: ?RTDM_IRQ_ENABLE? undeclared
	(first use in this function)
In-Reply-To: <4404B22D.5000906@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_11796_2842333.1141200064302"
References: <4404AE22.3050600@domain.hid> <4404B22D.5000906@domain.hid>
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

------=_Part_11796_2842333.1141200064302
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 28/02/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Jim Cromie wrote:
> >  LD      drivers/xenomai/16550A/built-in.o
> >  CC [M]  drivers/xenomai/16550A/16550A.o
> > /mnt/dilbert/jimc/dilbert/lxbuild/linux-2.6.15.1-ipipe-121
> /drivers/xenomai/16550A/16550A.c:
> > In function ?rt_16550_interrupt?:
> > /mnt/dilbert/jimc/dilbert/lxbuild/linux-2.6.15.1-ipipe-121
> /drivers/xenomai/16550A/16550A.c:269:
> > error: ?RTDM_IRQ_ENABLE? undeclared (first use in this function)
> > /mnt/dilbert/jimc/dilbert/lxbuild/linux-2.6.15.1-ipipe-121
> /drivers/xenomai/16550A/16550A.c:269:
> > error: (Each undeclared identifier is reported only once
> > /mnt/dilbert/jimc/dilbert/lxbuild/linux-2.6.15.1-ipipe-121
> /drivers/xenomai/16550A/16550A.c:269:
> > error: for each function it appears in.)
> > make[4]: *** [drivers/xenomai/16550A/16550A.o] Error 1
> > make[3]: *** [drivers/xenomai/16550A] Error 2
> > make[2]: *** [drivers/xenomai] Error 2
> > make[1]: *** [drivers] Error 2
> > make: *** [_all] Error 2
> >
> >
> > I de-configured 16550, it built fine, so I suspect some recent change
> > missed this item.
> >
> > that said, I havent tried _NOENABLE, since im guessing blind.
> >
>
> Yeah, I'm on it. Here is half of the patch I'm currently preparing:
>
> --- ../ksrc/drivers/16550A/16550A.c     (Revision 624)
> +++ ../ksrc/drivers/16550A/16550A.c     (Arbeitskopie)
> @@ -238,7 +238,7 @@
>      int                     rbytes =3D 0;
>      int                     events =3D 0;
>      int                     modem;
> -    int                     ret =3D RTDM_IRQ_PROPAGATE;
> +    int                     ret =3D RTDM_IRQ_NONE;
>
>
>      ctx =3D rtdm_irq_get_arg(irq_context, struct rt_16550_context);
> @@ -266,7 +266,7 @@
>                  events |=3D RTSER_EVENT_MODEMLO;
>          }
>
> -        ret =3D RTDM_IRQ_ENABLE | RTDM_IRQ_HANDLED;
> +        ret =3D RTDM_IRQ_HANDLED;
>      }
>
>      if (ctx->in_nwait > 0) {



My fault, sorry. I should have fixed that but overlooked again.


Jan
>


--
Best regards,
Dmitry Adamushko

------=_Part_11796_2842333.1141200064302
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br><div><span class=3D"gmail_quote">On 28/02/06, <b class=3D"gmail_sen=
dername">Jan Kiszka</b> &lt;<a href=3D"mailto:jan.kiszka@domain.hid">jan.kiszka=
@web.de</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"bor=
der-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-=
left: 1ex;">
Jim Cromie wrote:<br>&gt;&nbsp;&nbsp;LD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
drivers/xenomai/16550A/built-in.o<br>&gt;&nbsp;&nbsp;CC [M]&nbsp;&nbsp;driv=
ers/xenomai/16550A/16550A.o<br>&gt; /mnt/dilbert/jimc/dilbert/lxbuild/linux=
-2.6.15.1-ipipe-121/drivers/xenomai/16550A/16550A.c:<br>
&gt; In function ?rt_16550_interrupt?:<br>&gt; /mnt/dilbert/jimc/dilbert/lx=
build/linux-2.6.15.1-ipipe-121/drivers/xenomai/16550A/16550A.c:269:<br>&gt;=
 error: ?RTDM_IRQ_ENABLE? undeclared (first use in this function)<br>&gt; /=
mnt/dilbert/jimc/dilbert/lxbuild/linux-
2.6.15.1-ipipe-121/drivers/xenomai/16550A/16550A.c:269:<br>&gt; error: (Eac=
h undeclared identifier is reported only once<br>&gt; /mnt/dilbert/jimc/dil=
bert/lxbuild/linux-2.6.15.1-ipipe-121/drivers/xenomai/16550A/16550A.c:269:
<br>&gt; error: for each function it appears in.)<br>&gt; make[4]: *** [dri=
vers/xenomai/16550A/16550A.o] Error 1<br>&gt; make[3]: *** [drivers/xenomai=
/16550A] Error 2<br>&gt; make[2]: *** [drivers/xenomai] Error 2<br>&gt; mak=
e[1]: *** [drivers] Error 2
<br>&gt; make: *** [_all] Error 2<br>&gt;<br>&gt;<br>&gt; I de-configured 1=
6550, it built fine, so I suspect some recent change<br>&gt; missed this it=
em.<br>&gt;<br>&gt; that said, I havent tried _NOENABLE, since im guessing =
blind.
<br>&gt;<br><br>Yeah, I'm on it. Here is half of the patch I'm currently pr=
eparing:<br><br>--- ../ksrc/drivers/16550A/16550A.c&nbsp;&nbsp;&nbsp;&nbsp;=
 (Revision 624)<br>+++ ../ksrc/drivers/16550A/16550A.c&nbsp;&nbsp;&nbsp;&nb=
sp; (Arbeitskopie)<br>@@ -238,7 +238,7 @@
<br>&nbsp;&nbsp;&nbsp;&nbsp;
int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
rbytes =3D 0;<br>&nbsp;&nbsp;&nbsp;&nbsp;
int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
events =3D 0;<br>&nbsp;&nbsp;&nbsp;&nbsp;
int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
modem;<br>-&nbsp;&nbsp;&nbsp;&nbsp;int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
ret =3D RTDM_IRQ_PROPAGATE;<br>+&nbsp;&nbsp;&nbsp;&nbsp;int&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
ret =3D RTDM_IRQ_NONE;<br><br><br>&nbsp;&nbsp;&nbsp;&nbsp; ctx =3D rtdm_irq=
_get_arg(irq_context, struct rt_16550_context);<br>@@ -266,7 +266,7 @@<br>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; events |=3D RTSER_EVENT_MODEMLO;<br>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br><br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;ret =3D RTDM_IRQ_ENABLE | RTDM_IRQ_HANDLED;
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D RTDM_IRQ_HANDL=
ED;<br>&nbsp;&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp;&nbsp; if (ctx-&=
gt;in_nwait &gt; 0) {</blockquote><div><br>
<br>
My fault, sorry. I should have fixed that but overlooked again.<br>
&nbsp;<br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan<br>=
</blockquote></div><br clear=3D"all"><br>-- <br>Best regards,<br>Dmitry Ada=
mushko

------=_Part_11796_2842333.1141200064302--

