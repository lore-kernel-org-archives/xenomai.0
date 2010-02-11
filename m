MIME-Version: 1.0
In-Reply-To: <4B746FFE.20204@domain.hid>
References: <8b216e9e1002100327h3aa332ddl13ec590fcb81f0b7@domain.hid> 
	<8b216e9e1002101128t1246a5deh28ca13229f1d688d@domain.hid> 
	<8b216e9e1002111005h6b432bcby17d4127d3b9d385a@domain.hid> 
	<4B7447AD.5050401@domain.hid>
	<8b216e9e1002111024h7c87d0c1n9f36a91602e52cd6@domain.hid> 
	<4B744ED4.2000200@domain.hid>
	<8b216e9e1002111053gf6b4b2mf605e8c3b9f1c235@domain.hid> 
	<4B745CAB.5000404@domain.hid>
	<8b216e9e1002111215h1c1dac81w1a1ca1d19a37378c@domain.hid> 
	<4B746FFE.20204@domain.hid>
From: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Date: Thu, 11 Feb 2010 23:30:27 +0100
Message-ID: <8b216e9e1002111430h5687cb9udfad3e08da08d83a@domain.hid>
Content-Type: multipart/mixed; boundary=001636e0b756cb9904047f5ab3d5
Subject: Re: [Xenomai-help] Problems when cross-compiling Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

--001636e0b756cb9904047f5ab3d5
Content-Type: multipart/alternative; boundary=001636e0b756cb98f7047f5ab3d3

--001636e0b756cb98f7047f5ab3d3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2010/2/11 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Felipe Brand=E3o Cavalcanti wrote:
> > 2010/2/11 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org=
>
> >
> >> Felipe Brand=E3o Cavalcanti wrote:
> >>> 2010/2/11 Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org>
> >>>
> >>>> Felipe Brand=E3o Cavalcanti wrote:
> >>>>> Sending the boot log and the xeno-test output as attachments.
> >>>> [    0.000000] OMAP clockevent source: GPTIMER12 at 32768 Hz
> >>>>
> >>>> Definitely not OK. We do not want this unprecise clockevent source.
> >>>> Disable it in the kernel configuration (option CONFIG_OMAP_32K_TIMER=
).
> >>>>
> >>>>
> >>> This is very interesting - this option doesnt seem to be set in my
> >> current
> >>> kernel config. Ive attached my .config.
> >> Selecting GPTIMER 1 should work. But if you get lockups or thing like
> >> that, please try with a vanilla 2.6.30 to see if you get them.
> >>
> >>
> > Great - changing GPTIMER to 1 did the trick! Gilles, thank you very muc=
h!
> >
> > Here are the results of the first latency test, under 100% load:
> >
> > RTT|  00:08:46  (periodic user-mode task, 1000 us period, priority 99)
> > RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--l=
at
> > worst
> > RTD|     12.999|     13.769|     18.846|       0|     0|     12.538|
> > 44.692
> > RTD|     13.076|     13.769|     20.692|       0|     0|     12.538|
> > 44.692
> > RTD|     12.923|     13.769|     18.076|       0|     0|     12.538|
> > 44.692
> > RTD|     12.846|     13.769|     20.153|       0|     0|     12.538|
> > 44.692
> > RTD|     12.999|     13.769|     18.692|       0|     0|     12.538|
> > 44.692
> > RTD|     12.999|     13.769|     19.230|       0|     0|     12.538|
> > 44.692
> > RTD|     13.076|     13.769|     18.769|       0|     0|     12.538|
> > 44.692
> > RTD|     13.076|     13.769|     19.153|       0|     0|     12.538|
> > 44.692
> > RTD|     12.846|     13.769|     19.999|       0|     0|     12.538|
> > 44.692
> >
> > BTW, the system does seem a lot more stable now - no random errors. I
> will
> > run some more tests, and will send in the results later - I will docume=
nt
> > the procedure and post it online once we get Xenomai running well in th=
e
> > IGEPv2.
>
> Ok. Good news. I would have liked to find out what was this building
> issue of yours, at least to be able to use your rootfs build system
> instead of building xenomai manually.
>
>
In the end, I did get it to work with my build system (bitbake, running on
the standard IGEP virtual machine) - I modified the configuration files so
the
ASNEEDED =3D "-Wl,--as-needed"
became
ASNEEDED =3D ""

Xenomai builds cleanly afterwards, even with the modified optimization
flags.
I am attaching the bitbake file I used for reference.

The challenge is getting the IGEP running cleanly now - if the network is
connected, the systems becomes unstable and crashes randomly, and MMC/SDIO
(and therefore, Wifi) support is disabled. I am attempting to get the
patches individually from the folks at ISEE (the makers of the IGEP board)
so I can get a clean system running. I need a rock-solid system for this
project - our lab is building a small UAV, and the IGEP with Xenomai is
going to be the central controller.

Once again, thank you very much for the help - I am not very experienced
with embedded/real-time Linux, and I probably would still be stuck without
your help.

      -Felipe Brand=E3o Cavalcanti
      LARA - Robotics and Automation Laboratory
      Department of Electrical Engineering
      UnB - University of Bras=EDlia, Brazil
      http://www.lara.unb.br/~fbcavalcanti/


>  --
> Gilles Chanteperdrix, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
>
>


--

--001636e0b756cb98f7047f5ab3d3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2010/2/11 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gil=
les.chanteperdrix@domain.hid</a>&gt;</span><br><blockquote class=3D=
"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0=
pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<div><div></div><div class=3D"h5">Felipe Brand=E3o Cavalcanti wrote:<br>
&gt; 2010/2/11 Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.chanteperd=
rix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;<br>
&gt;<br>
&gt;&gt; Felipe Brand=E3o Cavalcanti wrote:<br>
&gt;&gt;&gt; 2010/2/11 Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.ch=
anteperdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>=
&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Felipe Brand=E3o Cavalcanti wrote:<br>
&gt;&gt;&gt;&gt;&gt; Sending the boot log and the xeno-test output as attac=
hments.<br>
&gt;&gt;&gt;&gt; [ =A0 =A00.000000] OMAP clockevent source: GPTIMER12 at 32=
768 Hz<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Definitely not OK. We do not want this unprecise clockeven=
t source.<br>
&gt;&gt;&gt;&gt; Disable it in the kernel configuration (option CONFIG_OMAP=
_32K_TIMER).<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; This is very interesting - this option doesnt seem to be set i=
n my<br>
&gt;&gt; current<br>
&gt;&gt;&gt; kernel config. Ive attached my .config.<br>
&gt;&gt; Selecting GPTIMER 1 should work. But if you get lockups or thing l=
ike<br>
&gt;&gt; that, please try with a vanilla 2.6.30 to see if you get them.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; Great - changing GPTIMER to 1 did the trick! Gilles, thank you very mu=
ch!<br>
&gt;<br>
&gt; Here are the results of the first latency test, under 100% load:<br>
&gt;<br>
&gt; RTT| =A000:08:46 =A0(periodic user-mode task, 1000 us period, priority=
 99)<br>
&gt; RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--=
lat<br>
&gt; worst<br>
&gt; RTD| =A0 =A0 12.999| =A0 =A0 13.769| =A0 =A0 18.846| =A0 =A0 =A0 0| =
=A0 =A0 0| =A0 =A0 12.538|<br>
&gt; 44.692<br>
&gt; RTD| =A0 =A0 13.076| =A0 =A0 13.769| =A0 =A0 20.692| =A0 =A0 =A0 0| =
=A0 =A0 0| =A0 =A0 12.538|<br>
&gt; 44.692<br>
&gt; RTD| =A0 =A0 12.923| =A0 =A0 13.769| =A0 =A0 18.076| =A0 =A0 =A0 0| =
=A0 =A0 0| =A0 =A0 12.538|<br>
&gt; 44.692<br>
&gt; RTD| =A0 =A0 12.846| =A0 =A0 13.769| =A0 =A0 20.153| =A0 =A0 =A0 0| =
=A0 =A0 0| =A0 =A0 12.538|<br>
&gt; 44.692<br>
&gt; RTD| =A0 =A0 12.999| =A0 =A0 13.769| =A0 =A0 18.692| =A0 =A0 =A0 0| =
=A0 =A0 0| =A0 =A0 12.538|<br>
&gt; 44.692<br>
&gt; RTD| =A0 =A0 12.999| =A0 =A0 13.769| =A0 =A0 19.230| =A0 =A0 =A0 0| =
=A0 =A0 0| =A0 =A0 12.538|<br>
&gt; 44.692<br>
&gt; RTD| =A0 =A0 13.076| =A0 =A0 13.769| =A0 =A0 18.769| =A0 =A0 =A0 0| =
=A0 =A0 0| =A0 =A0 12.538|<br>
&gt; 44.692<br>
&gt; RTD| =A0 =A0 13.076| =A0 =A0 13.769| =A0 =A0 19.153| =A0 =A0 =A0 0| =
=A0 =A0 0| =A0 =A0 12.538|<br>
&gt; 44.692<br>
&gt; RTD| =A0 =A0 12.846| =A0 =A0 13.769| =A0 =A0 19.999| =A0 =A0 =A0 0| =
=A0 =A0 0| =A0 =A0 12.538|<br>
&gt; 44.692<br>
&gt;<br>
&gt; BTW, the system does seem a lot more stable now - no random errors. I =
will<br>
&gt; run some more tests, and will send in the results later - I will docum=
ent<br>
&gt; the procedure and post it online once we get Xenomai running well in t=
he<br>
&gt; IGEPv2.<br>
<br>
</div></div>Ok. Good news. I would have liked to find out what was this bui=
lding<br>
issue of yours, at least to be able to use your rootfs build system<br>
instead of building xenomai manually.<br>
<br></blockquote><div><br>In the end, I did get it to work with my build sy=
stem (bitbake, running on the standard IGEP virtual machine) - I modified t=
he configuration files so the<br>ASNEEDED =3D &quot;-Wl,--as-needed&quot;<b=
r>

became<br>ASNEEDED =3D &quot;&quot;<br><br>Xenomai builds cleanly afterward=
s, even with the modified optimization flags.<br>I am attaching the bitbake=
 file I used for reference.<br><br>The challenge is getting the IGEP runnin=
g cleanly now - if the network is connected, the systems becomes unstable a=
nd crashes randomly, and MMC/SDIO (and therefore, Wifi) support is disabled=
. I am attempting to get the patches individually from the folks at ISEE (t=
he makers of the IGEP board) so I can get a clean system running. I need a =
rock-solid system for this project - our lab is building a small UAV, and t=
he IGEP with Xenomai is going to be the central controller.<br>

<br>Once again, thank you very much for the help - I am not very experience=
d with embedded/real-time Linux, and I probably would still be stuck withou=
t your help.<br><br>=A0 =A0 =A0 -Felipe Brand=E3o Cavalcanti<br> =A0 =A0 =
=A0 LARA - Robotics and Automation Laboratory<br>

 =A0 =A0 =A0 Department of Electrical Engineering<br> =A0 =A0 =A0 UnB - Uni=
versity of Bras=EDlia, Brazil<br> =A0 =A0 =A0 <a href=3D"http://www.lara.un=
b.br/~fbcavalcanti/">http://www.lara.unb.br/~fbcavalcanti/</a><br>=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<font color=3D"#888888">
--<br>
</font><div><div></div><div class=3D"h5">Gilles Chanteperdrix, Free Electro=
ns<br>
Kernel, drivers, real-time and embedded Linux<br>
development, consulting, training and support.<br>
<a href=3D"http://free-electrons.com" target=3D"_blank">http://free-electro=
ns.com</a><br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br> <br>

--001636e0b756cb98f7047f5ab3d3--

--001636e0b756cb9904047f5ab3d5
Content-Type: application/octet-stream; name="xenomai.bb"
Content-Disposition: attachment; filename="xenomai.bb"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5k43o0v0

U0VDVElPTiA9ICJiYXNlIgpERVNDUklQVElPTiA9ICJ4ZW5vbWFpIgpMSUNFTlNFID0gInhlbm9t
YWkiClBOID0gInhlbm9tYWkiClBWID0gIjIuNS4xIgoKaW5oZXJpdCBhdXRvdG9vbHMKClNSQ19V
UkkgPSAiaHR0cDovL2Rvd25sb2FkLmduYS5vcmcveGVub21haS9zdGFibGUveGVub21haS0ke1BW
fS50YXIuYnoyIgoKUyA9ICIke1dPUktESVJ9L3hlbm9tYWktMi41LjEiCgpkb19jb25maWd1cmUo
KSB7CgkuL2NvbmZpZ3VyZSAtLXByZWZpeD0vdXNyIC0taW5jbHVkZWRpcj0vdXNyL2luY2x1ZGUv
eGVub21haSAtLWVuYWJsZS1hcm0tbWFjaD1vbWFwMyAtLWVuYWJsZS1hcm0tZWFiaSAtLWVuYWJs
ZS1hcm0tdHNjIC0tZGlzYWJsZS1kb3gtZG9jIC0tZGlzYWJsZS1kYnggLS1ob3N0PWFybS1ub25l
LWxpbnV4LWdudWVhYmkKfQoKZG9fY29tcGlsZSgpIHsKCW9lX3J1bm1ha2UKfQoKZG9faW5zdGFs
bCgpIHsKICAgIG9lX3J1bm1ha2UgJ0RFU1RESVI9JHtEfScgJ1NVRE89L2Jpbi90cnVlJyBpbnN0
YWxsCn0KClBBQ0tBR0VTID0gIiR7UE59IgpGSUxFU18ke1BOfSA9ICIvZGV2LyogL3Vzci9iaW4v
KiAvdXNyL2xpYi8qIgoK
--001636e0b756cb9904047f5ab3d5--

