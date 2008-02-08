Message-ID: <d6c8ef150802081121i8d96538l73ed596f46731d11@domain.hid>
Date: Fri, 8 Feb 2008 20:21:25 +0100
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
In-Reply-To: <178999.65515.qm@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_29410_33497794.1202498486040"
References: <178999.65515.qm@domain.hid>
Subject: Re: [Adeos-main] at91sam9260
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Michael Trimarchi <trimarchimichael@domain.hid>
Cc: adeos-main@gna.org

------=_Part_29410_33497794.1202498486040
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all!

Are there some conclusions or test reports regarding this discussion?

Thanx!

On Dec 26, 2007 12:10 PM, Michael Trimarchi <trimarchimichael@domain.hid>
wrote:

> Hi
> ----- Messaggio originale -----
> > Da: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> > A: Michael Trimarchi <trimarchimichael@domain.hid>
> > Cc: adeos-main@gna.org
> > Inviato: Mercoled=EC 26 dicembre 2007, 6:59:31
> > Oggetto: Re: [Adeos-main] at91sam9260
> >
> > On Dec 20, 2007 7:44 PM, Michael Trimarchi wrote:
> > > Hi,
> > >
> > > > Ok. Could you try something ? It will work with I-pipe only but wil=
l
> > > > break Xenomai, so do not try to run Xenomai over this modification.
> > > >
> > >
> > > I tried the adeos-2.6.20-arm-1.8-02 patch and linux 2.6.20 and I
> obtained the
> > > same results. When the system is not loaded I can't receive from the
> serial
> > > line using the adeos patch and null modem cable.
> > >
> > > AT91sam9260 8MB ram (using filesystem on ramdisk)
> > > I removed spi flash support, mmc support.
> > > I have only serial driver and using lrz for receiving file
> > >
> > > Can I do some tests for you using my board?
> >
> > in drivers/serial/atmel_serial.c, add the IRQF_DISABLED flag to
> request_irq.
> >
> > When linux is running without adeos, the AT91 serial driver interrupt
> > is shared with the timer interrupt, so it automatically gets this
> > flag. Adeos does not use the same hardware timer as linux, so, when
> > adeos is enabled the serial interrupt is no longer shared with the
> > timer interrupt and it no longer gets this flag.
> >
> I will try.
>
> Thank's
>
>
>      ___________________________________
> L'email della prossima generazione? Puoi averla con la nuova Yahoo! Mail:
> http://it.docs.yahoo.com/nowyoucan.html
>
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
>

------=_Part_29410_33497794.1202498486040
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all!<br><br>Are there some conclusions or test reports regarding this di=
scussion? <br><br>Thanx!<br><br><div class=3D"gmail_quote">On Dec 26, 2007 =
12:10 PM, Michael Trimarchi &lt;<a href=3D"mailto:trimarchimichael@domain.hid=
">trimarchimichael@domain.hid</a>&gt; wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi<br>----- Messa=
ggio originale -----<br>&gt; Da: Gilles Chanteperdrix &lt;<a href=3D"mailto=
:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;<br>
&gt; A: Michael Trimarchi &lt;<a href=3D"mailto:trimarchimichael@domain.hid">=
trimarchimichael@domain.hid</a>&gt;<br>&gt; Cc: <a href=3D"mailto:adeos-main@=
gna.org">adeos-main@gna.org</a><br>&gt; Inviato: Mercoled=EC 26 dicembre 20=
07, 6:59:31<br>
&gt; Oggetto: Re: [Adeos-main] at91sam9260<br><div class=3D"Ih2E3d">&gt;<br=
>&gt; On Dec 20, 2007 7:44 PM, Michael Trimarchi wrote:<br>&gt; &gt; Hi,<br=
>&gt; &gt;<br>&gt; &gt; &gt; Ok. Could you try something ? It will work wit=
h I-pipe only but will<br>
&gt; &gt; &gt; break Xenomai, so do not try to run Xenomai over this modifi=
cation.<br>&gt; &gt; &gt;<br>&gt; &gt;<br>&gt; &gt; I tried the adeos-2.6.2=
0-arm-1.8-02 patch and linux 2.6.20 and I obtained the<br>&gt; &gt; same re=
sults. When the system is not loaded I can&#39;t receive from the serial<br=
>
&gt; &gt; line using the adeos patch and null modem cable.<br>&gt; &gt;<br>=
&gt; &gt; AT91sam9260 8MB ram (using filesystem on ramdisk)<br>&gt; &gt; I =
removed spi flash support, mmc support.<br>&gt; &gt; I have only serial dri=
ver and using lrz for receiving file<br>
&gt; &gt;<br>&gt; &gt; Can I do some tests for you using my board?<br>&gt;<=
br>&gt; in drivers/serial/atmel_serial.c, add the IRQF_DISABLED flag to req=
uest_irq.<br>&gt;<br>&gt; When linux is running without adeos, the AT91 ser=
ial driver interrupt<br>
&gt; is shared with the timer interrupt, so it automatically gets this<br>&=
gt; flag. Adeos does not use the same hardware timer as linux, so, when<br>=
&gt; adeos is enabled the serial interrupt is no longer shared with the<br>
&gt; timer interrupt and it no longer gets this flag.<br>&gt;<br></div>I wi=
ll try.<br><br>Thank&#39;s<br><div class=3D"Ih2E3d"><br><br> &nbsp; &nbsp; =
&nbsp;___________________________________<br>L&#39;email della prossima gen=
erazione? Puoi averla con la nuova Yahoo! Mail:<br>
<a href=3D"http://it.docs.yahoo.com/nowyoucan.html" target=3D"_blank">http:=
//it.docs.yahoo.com/nowyoucan.html</a><br><br>_____________________________=
__________________<br></div><div><div></div><div class=3D"Wj3C7c">Adeos-mai=
n mailing list<br>
<a href=3D"mailto:Adeos-main@domain.hid">Adeos-main@domain.hid</a><br><a href=3D"=
https://mail.gna.org/listinfo/adeos-main" target=3D"_blank">https://mail.gn=
a.org/listinfo/adeos-main</a><br></div></div></blockquote></div><br>

------=_Part_29410_33497794.1202498486040--

