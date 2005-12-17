Message-ID: <b647ffbd0512170211l4a0894b8g@domain.hid>
Date: Sat, 17 Dec 2005 12:11:35 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] [testsuite/latency] intervals are much > than 1
	second
In-Reply-To: <43A2BB1F.1070707@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_4072_7289128.1134814295807"
References: <b647ffbd0512160453w6baa9d4g@domain.hid>
	<43A2BB1F.1070707@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_4072_7289128.1134814295807
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> > Hello all,
> >
> > I have been out of xeno-scope for a while so maybe I successufy missed
> > something important
> > that might be the explanation of a problem described below.
> >
> > The problem is as follows:
> >
> > x86-ipipe-1.0.10 && xenomai-2.1 (CVS: ~ November, 21)
> >
> > testsuite/letency is used as it is by defaulty (nsamples =3D 1 billion =
(1
> > second) / sample (e.g.100000 us))
> >
> > I am used to getting data with ~1-second-interval on the screen when
> > "latency" is running and so expected to observe the same behaviour now.
> >
> > Nevertheless, the interval (with all parameters by default) is ~ 4
> > seconds, and it gets up to 16-17 seconds when -p 1000 (sampling period
> > =3D=3D 1 ms.) is used.
> >
> > e.g. it took 1 minute and 30 seconds to get 21 lines of statistics on
> > the screen (-p 100) but should have been ~22-23 seconds.
> >
> > And the latency thread really reported the presence of collected data 2=
1
> > times (through rt_sem_v()) .
> >
> > So have I missed something important? any ideas are wellcome.
> >
>
> Dunno yet, but this reminds me of a trap I've been into recently that
> caused a massive slowdown of the latency test (v2.0.x) whilst the
> reported real-time activity seemed to be ok. Weird enough, actually. The
> explanation was that I mistakenly left the full ACPI support and SUSPEND
> active in my kernel config (Asus box with ICH6 chipset). Shutting them
> down solved the issue. I've not investigated further which one of the
> ACPI options or SUSPEND caused that trouble yet.


Thanks for a hint. I have mistakenly used an improper .config as a base for
the recently built xeno-aware kernel. ACPI support was on.

Yep, it seemed the flow of time was ~4 times slower than normally but no
overruns were encountered.

>
> --
>
> Philippe.
>

--
Best regards,
Dmitry Adamushko

------=_Part_4072_7289128.1134814295807
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; Hel=
lo all,<br>&gt;<br>&gt; I have been out of xeno-scope for a while so maybe =
I successufy missed
<br>&gt; something important<br>&gt; that might be the explanation of a pro=
blem described below.<br>&gt;<br>&gt; The problem is as follows:<br>&gt;<br=
>&gt; x86-ipipe-1.0.10 &amp;&amp; xenomai-2.1 (CVS: ~ November, 21)<br>
&gt;<br>&gt; testsuite/letency is used as it is by defaulty (nsamples =3D 1=
 billion (1<br>&gt; second) / sample (e.g.100000 us))<br>&gt;<br>&gt; I am =
used to getting data with ~1-second-interval on the screen when<br>&gt; &qu=
ot;latency&quot; is running and so expected to observe the same behaviour n=
ow.
<br>&gt;<br>&gt; Nevertheless, the interval (with all parameters by default=
) is ~ 4<br>&gt; seconds, and it gets up to 16-17 seconds when -p 1000 (sam=
pling period<br>&gt; =3D=3D 1 ms.) is used.<br>&gt;<br>&gt; e.g. it took 1 =
minute and 30 seconds to get 21 lines of statistics on
<br>&gt; the screen (-p 100) but should have been ~22-23 seconds.<br>&gt;<b=
r>&gt; And the latency thread really reported the presence of collected dat=
a 21<br>&gt; times (through rt_sem_v()) .<br>&gt;<br>&gt; So have I missed =
something important? any ideas are wellcome.
<br>&gt;<br><br>Dunno yet, but this reminds me of a trap I've been into rec=
ently that<br>caused a massive slowdown of the latency test (v2.0.x) whilst=
 the<br>reported real-time activity seemed to be ok. Weird enough, actually=
. The
<br>explanation was that I mistakenly left the full ACPI support and SUSPEN=
D<br>active in my kernel config (Asus box with ICH6 chipset). Shutting them=
<br>down solved the issue. I've not investigated further which one of the
<br>ACPI options or SUSPEND caused that trouble yet.</blockquote><div><br>
Thanks for a hint. I have mistakenly used an improper .config as a base
for the recently built xeno-aware kernel. ACPI support was on.<br>
</div><br>
Yep, it seemed the flow of time was ~4 times slower than normally but no ov=
erruns were encountered.<br>
<br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(2=
04, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt;<br>--<br=
><br>Philippe.<br></blockquote></div><br>-- <br>Best regards,<br>Dmitry Ada=
mushko
<br>
<br>


------=_Part_4072_7289128.1134814295807--

