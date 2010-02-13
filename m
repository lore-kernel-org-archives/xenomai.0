MIME-Version: 1.0
In-Reply-To: <4B770554.3080809@domain.hid>
References: <8b216e9e1002100327h3aa332ddl13ec590fcb81f0b7@domain.hid> 
	<8b216e9e1002111215h1c1dac81w1a1ca1d19a37378c@domain.hid> 
	<4B746FFE.20204@domain.hid>
	<8b216e9e1002111430h5687cb9udfad3e08da08d83a@domain.hid> 
	<4B750157.6080000@domain.hid>
	<8b216e9e1002121023qa0f4d6n33c773110cfc78fd@domain.hid> 
	<4B759DF9.9040800@domain.hid> <4B759F35.3050704@domain.hid> 
	<8b216e9e1002131157k6f1a7ccbiba5e67b8855c77b2@domain.hid> 
	<4B770554.3080809@domain.hid>
From: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Date: Sat, 13 Feb 2010 18:25:47 -0200
Message-ID: <8b216e9e1002131225v16024e66p521d7eaad376441d@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd17c8aa2fc8f047f813153
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
Cc: xenomai@xenomai.org

--000e0cd17c8aa2fc8f047f813153
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2010/2/13 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Felipe Brand=E3o Cavalcanti wrote:
> > OK - I did apply the patch to 2.6.30.10, with some very minor
> modifications
> > in the sound system and in the headers (MACH_TYPE_IGEP0020 wasn't
> defined).
> > I also applied the latest Adeos Ipipe patch.
> >
> > However, the compiled kernel doesn't boot - it actually just sits there=
,
> > doing nothing:
> >
> > Bytes transferred =3D 2555616 (26fee0 hex)
> > ## Booting kernel from Legacy Image at 80000000 ...
> >    Image Name:   Linux-2.6.30.10
> >    Image Type:   ARM Linux Kernel Image (uncompressed)
> >    Data Size:    2555552 Bytes =3D  2.4 MB
> >    Load Address: 80008000
> >    Entry Point:  80008000
> >    Verifying Checksum ... OK
> >    Loading Kernel Image ... OK
> > OK
> >
> > Starting kernel ...
> >
> > Uncompressing
> >
> Linux....................................................................=
...........................................................................=
...................
> > done, booting the kernel.
> >
> > My guess is that Linux is simply not sending anything through my serial
> > (i.e., debug) port. Should I attempt to port over the serial driver, or
> is
> > this something else?
> > I am also downloading kernel 2.6.32 to see if I can make it boot on my
> IGEP.
>
> Do you pass the proper "console=3D" argument to the kernel? Is the suppor=
t
> for serial driver enabled in the kernel?
>
> If yes, then apply trick #1 from the "Tips and tricks" section in the
> "porting I-pipe to a new board" HOWTO on Xenomai website.
>
>
Yeah, I called it with the console=3D argument, and support is enabled. Jus=
t
tested 2.6.32 - working fine in my board!

I will try 2.6.30 again, but this time with no I-pipe patch, as well as
enabling the low-level debug options.


>
> --
>                                             Gilles.
>
>


--=20
      -Felipe Brand=E3o Cavalcanti
      LARA - Robotics and Automation Laboratory
      Department of Electrical Engineering
      UnB - University of Bras=EDlia, Brazil
      http://www.lara.unb.br/~fbcavalcanti/

--000e0cd17c8aa2fc8f047f813153
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2010/2/13 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.cha=
nteperdrix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" =
style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8=
ex; padding-left: 1ex;">

<div class=3D"im">Felipe Brand=E3o Cavalcanti wrote:<br>
&gt; OK - I did apply the patch to 2.6.30.10, with some very minor modifica=
tions<br>
&gt; in the sound system and in the headers (MACH_TYPE_IGEP0020 wasn&#39;t =
defined).<br>
&gt; I also applied the latest Adeos Ipipe patch.<br>
&gt;<br>
&gt; However, the compiled kernel doesn&#39;t boot - it actually just sits =
there,<br>
&gt; doing nothing:<br>
&gt;<br>
&gt; Bytes transferred =3D 2555616 (26fee0 hex)<br>
&gt; ## Booting kernel from Legacy Image at 80000000 ...<br>
&gt; =A0 =A0Image Name: =A0 Linux-2.6.30.10<br>
&gt; =A0 =A0Image Type: =A0 ARM Linux Kernel Image (uncompressed)<br>
&gt; =A0 =A0Data Size: =A0 =A02555552 Bytes =3D =A02.4 MB<br>
&gt; =A0 =A0Load Address: 80008000<br>
&gt; =A0 =A0Entry Point: =A080008000<br>
&gt; =A0 =A0Verifying Checksum ... OK<br>
&gt; =A0 =A0Loading Kernel Image ... OK<br>
&gt; OK<br>
&gt;<br>
&gt; Starting kernel ...<br>
&gt;<br>
&gt; Uncompressing<br>
&gt; Linux.................................................................=
...........................................................................=
......................<br>
&gt; done, booting the kernel.<br>
&gt;<br>
&gt; My guess is that Linux is simply not sending anything through my seria=
l<br>
&gt; (i.e., debug) port. Should I attempt to port over the serial driver, o=
r is<br>
&gt; this something else?<br>
&gt; I am also downloading kernel 2.6.32 to see if I can make it boot on my=
 IGEP.<br>
<br>
</div>Do you pass the proper &quot;console=3D&quot; argument to the kernel?=
 Is the support<br>
for serial driver enabled in the kernel?<br>
<br>
If yes, then apply trick #1 from the &quot;Tips and tricks&quot; section in=
 the<br>
&quot;porting I-pipe to a new board&quot; HOWTO on Xenomai website.<br>
<br></blockquote><div><br>Yeah, I called it with the console=3D argument, a=
nd support is enabled. Just tested 2.6.32 - working fine in my board!<br><b=
r>I will try 2.6.30 again, but this time with no I-pipe patch, as well as e=
nabling the low-level debug options.<br>

=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br> =A0 =A0 =A0 -Fe=
lipe Brand=E3o Cavalcanti<br> =A0 =A0 =A0 LARA - Robotics and Automation La=
boratory<br> =A0 =A0 =A0 Department of Electrical Engineering<br> =A0 =A0 =
=A0 UnB - University of Bras=EDlia, Brazil<br>

 =A0 =A0 =A0 <a href=3D"http://www.lara.unb.br/~fbcavalcanti/">http://www.l=
ara.unb.br/~fbcavalcanti/</a><br>

--000e0cd17c8aa2fc8f047f813153--

