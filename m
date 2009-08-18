MIME-Version: 1.0
In-Reply-To: <4A8AAB92.6050901@domain.hid>
References: <7a15153d0908180547s1d542689r30992d62662c4710@domain.hid>
	<4A8AAB92.6050901@domain.hid>
Date: Tue, 18 Aug 2009 11:43:40 -0300
Message-ID: <7a15153d0908180743x412490bfne1f42c80fd836012@domain.hid>
From: felipe felipe <felipecpc1@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6db2d225b462a04716b8b86
Subject: Re: [Xenomai-core] Xenomai and PXA
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--0016e6db2d225b462a04716b8b86
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

For sure! i'll glad to share the drivers, but in fact i have to study a
little bit more.
Perhaps i'll need to implement this driver but i don't have experience with,
and this will increase my project time significantly.
Anyway , thanks for your quickly answer, and sorry for my english ... :P
Felipe
On Tue, Aug 18, 2009 at 10:24 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> felipe felipe wrote:
> > Hi all ,
> > I'm starting with xenomai, i tried to get a realtime linux embedded for
> > a medical device.
> > I run some examples, but I'm a little bit lost.
> > I tried to run the cross-link example , tha uses the module xeno_16550A
> > but it seems that this module is not compatible with PXA serial driver
> > right?
>
> Dunno. You should be the one who knows if the serial driver you use is
> 16550 or not. In any case, if you implement another serial driver, we
> would be happy to include it in future releases of Xenomai.
>
> > There are some driver to get a serial driver working with PXA (Toradex
> > colobri) SOM ?
> > Another issue is about GPIO. I need to read some GPIO's , there are some
> > example , driver or something like that ?
>
> Nope. But again, if you implement a framework for GPIOs, we would be
> happy to include it in Xenomai.
>
> --
>                                           Gilles
>
>

--0016e6db2d225b462a04716b8b86
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>For sure! i&#39;ll glad to share the drivers, but in fact i have to st=
udy a little bit more.=A0</div><div>Perhaps i&#39;ll need to implement this=
 driver but i don&#39;t have experience with, and this will increase my pro=
ject time significantly.</div>
<div class=3D"gmail_quote"></div><div class=3D"gmail_quote">Anyway , thanks=
 for your quickly answer, and sorry for my english ... :P</div><div class=
=3D"gmail_quote"></div><div class=3D"gmail_quote">Felipe</div><div class=3D=
"gmail_quote">
</div><div class=3D"gmail_quote">On Tue, Aug 18, 2009 at 10:24 AM, Gilles C=
hanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
enomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex;">
<div class=3D"im">felipe felipe wrote:<br>
&gt; Hi all ,<br>
&gt; I&#39;m starting with xenomai, i tried to get a realtime linux embedde=
d for<br>
&gt; a medical device.<br>
&gt; I run some examples, but I&#39;m a little bit lost.<br>
&gt; I tried to run the cross-link example , tha uses the module xeno_16550=
A<br>
&gt; but it seems that this module is not compatible with PXA serial driver=
<br>
&gt; right?<br>
<br>
</div>Dunno. You should be the one who knows if the serial driver you use i=
s<br>
16550 or not. In any case, if you implement another serial driver, we<br>
would be happy to include it in future releases of Xenomai.<br>
<div class=3D"im"><br>
&gt; There are some driver to get a serial driver working with PXA (Toradex=
<br>
&gt; colobri) SOM ?<br>
&gt; Another issue is about GPIO. I need to read some GPIO&#39;s , there ar=
e some<br>
&gt; example , driver or something like that ?<br>
<br>
</div>Nope. But again, if you implement a framework for GPIOs, we would be<=
br>
happy to include it in Xenomai.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles<br>
<br>
</font></blockquote></div><br>

--0016e6db2d225b462a04716b8b86--

