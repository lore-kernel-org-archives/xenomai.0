MIME-Version: 1.0
In-Reply-To: <AANLkTimp5_OXSo_EGkn6O0mexR1Oxb_m9SJEfPmrSf0M@mail.gmail.com>
References: <AANLkTinN+KBK2B77opSCwDvb9bneObxL1+FTmmwpQGup@domain.hid>
	<4CC20AD2.4060501@domain.hid>
	<AANLkTimyj5TRgan5nE5ey6h8-WO_-na=U66si-e9Xx9F@mail.gmail.com>
	<4CC44C02.4050003@domain.hid>
	<AANLkTinjUHYvNJwcuEd2RQuQLWL3WvGx-jFb5iG88f0c@domain.hid>
	<AANLkTikGFw6dxQHC1ukWHsTP-QoHzpbDzeMdLj=jZRP5@domain.hid>
	<AANLkTimsGjmPNE1GOzmyF4pHQe6m4RmFphuhGqdTrs1D@mail.gmail.com>
	<4CC5603E.1090707@domain.hid> <4CC566A2.2000702@domain.hid>
	<AANLkTik76N-mL6ogtzFJ_vX4NF=7oDc_zdCA_y33z+Jh@domain.hid>
	<AANLkTimp5_OXSo_EGkn6O0mexR1Oxb_m9SJEfPmrSf0M@mail.gmail.com>
Date: Mon, 25 Oct 2010 11:04:48 -0700
Message-ID: <AANLkTi=Ne35gXZ=BRo09eXRjEtvPaXnkp6ix9tMWUwvn@domain.hid>
From: Peter Pastor <peter.pastor@domain.hid>
Content-Type: multipart/alternative; boundary=0016363b9056f63982049374d3a2
Subject: Re: [Xenomai-help] Slow hard drive access in xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Noulard <eric.noulard@domain.hid>
Cc: xenomai@xenomai.org

--0016363b9056f63982049374d3a2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hey Eric,

Thanks for your prompt response. However, I do not have the "FLAT_MEMORY"
option available. I can only select the sparse memory model.

I have upgraded to 2.6.35 and so far the problem has not occured. However, =
I
haven't used the system much. Again, it seems that a specific event trigger=
s
the problem.

Also, can someone tell me whether the ubuntu kernel patch is recommended to
use with Xenomai ? If so, can someone tell me how to get the patch for my
particular kernel version 2.6.35 ? ( I am sorry if this is the wrong mailin=
g
list to ask this question )

THANKS,
 peter


On Mon, Oct 25, 2010 at 9:24 AM, Eric Noulard <eric.noulard@domain.hid>wrote=
:

> 2010/10/25 Peter Pastor <peter.pastor@domain.hid>:
> > Hey guys,
> >
>
> [...]
>
> > @Eric:
> > I still haven't managed to disable SPARSEMEM. From what I understand, i=
n
> > order to disable SPARSEMEM I have to disable options that "selects:
> > SPARSEMEM". MEMORY_HOTPLUG_SPARSE depends on SPARSEMEM,
> disabling/enabling
> > it does not get me closer to be able to disable SPARSEMEM, does it ?
>
> The MEMORY_HOTPLUG_SPARSE dependency was just an example.
> You may have several other options depending on it (I don't know the
> full list of them).
>
> In the "Memory model" section of kernel configuration
> if you chose "FLAT" memory model it should disable any "SPARSEMEM_xx"
> option alltogether.
>
> However as stated by Jan, your problem does not seem to be in this area
> may be you should first upgrade to 2.6.35 and then tweak more kernel
> options if the problem persist.
>
> --
> Erk
> Membre de l'April - =AB promouvoir et d=E9fendre le logiciel libre =BB -
> http://www.april.org
>

--0016363b9056f63982049374d3a2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hey Eric,<br><br>Thanks for your prompt response. However, I do not have th=
e &quot;FLAT_MEMORY&quot; option available. I can only select the sparse me=
mory model.<br><br>I have upgraded to 2.6.35 and so far the problem has not=
 occured. However, I haven&#39;t used the system much. Again, it seems that=
 a specific event triggers the problem.<br>
<br>Also, can someone tell me whether the ubuntu kernel patch is recommende=
d to use with Xenomai ? If so, can someone tell me how to get the patch for=
 my particular kernel version 2.6.35 ? ( I am sorry if this is the wrong ma=
iling list to ask this question )<br>
<br>THANKS,<br>=A0peter<br><br><br><div class=3D"gmail_quote">On Mon, Oct 2=
5, 2010 at 9:24 AM, Eric Noulard <span dir=3D"ltr">&lt;<a href=3D"mailto:er=
ic.noulard@domain.hid">eric.noulard@domain.hid</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-lef=
t: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
2010/10/25 Peter Pastor &lt;<a href=3D"mailto:peter.pastor@domain.hid">peter=
.pastor@domain.hid</a>&gt;:<br>
&gt; Hey guys,<br>
&gt;<br>
<br>
[...]<br>
<div class=3D"im"><br>
&gt; @Eric:<br>
&gt; I still haven&#39;t managed to disable SPARSEMEM. From what I understa=
nd, in<br>
&gt; order to disable SPARSEMEM I have to disable options that &quot;select=
s:<br>
&gt; SPARSEMEM&quot;. MEMORY_HOTPLUG_SPARSE depends on SPARSEMEM, disabling=
/enabling<br>
&gt; it does not get me closer to be able to disable SPARSEMEM, does it ?<b=
r>
<br>
</div>The MEMORY_HOTPLUG_SPARSE dependency was just an example.<br>
You may have several other options depending on it (I don&#39;t know the<br=
>
full list of them).<br>
<br>
In the &quot;Memory model&quot; section of kernel configuration<br>
if you chose &quot;FLAT&quot; memory model it should disable any &quot;SPAR=
SEMEM_xx&quot;<br>
option alltogether.<br>
<br>
However as stated by Jan, your problem does not seem to be in this area<br>
may be you should first upgrade to 2.6.35 and then tweak more kernel<br>
options if the problem persist.<br>
<div><div></div><div class=3D"h5"><br>
--<br>
Erk<br>
Membre de l&#39;April - =AB promouvoir et d=E9fendre le logiciel libre =BB =
-<br>
<a href=3D"http://www.april.org" target=3D"_blank">http://www.april.org</a>=
<br>
</div></div></blockquote></div><br>

--0016363b9056f63982049374d3a2--

