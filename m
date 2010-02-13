MIME-Version: 1.0
In-Reply-To: <4B759F35.3050704@domain.hid>
References: <8b216e9e1002100327h3aa332ddl13ec590fcb81f0b7@domain.hid> 
	<8b216e9e1002111053gf6b4b2mf605e8c3b9f1c235@domain.hid> 
	<4B745CAB.5000404@domain.hid>
	<8b216e9e1002111215h1c1dac81w1a1ca1d19a37378c@domain.hid> 
	<4B746FFE.20204@domain.hid>
	<8b216e9e1002111430h5687cb9udfad3e08da08d83a@domain.hid> 
	<4B750157.6080000@domain.hid>
	<8b216e9e1002121023qa0f4d6n33c773110cfc78fd@domain.hid> 
	<4B759DF9.9040800@domain.hid> <4B759F35.3050704@domain.hid>
From: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Date: Sat, 13 Feb 2010 17:57:45 -0200
Message-ID: <8b216e9e1002131157k6f1a7ccbiba5e67b8855c77b2@domain.hid>
Content-Type: multipart/alternative; boundary=00504501803b62cd9d047f80cd18
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
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

--00504501803b62cd9d047f80cd18
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

OK - I did apply the patch to 2.6.30.10, with some very minor modifications
in the sound system and in the headers (MACH_TYPE_IGEP0020 wasn't defined).
I also applied the latest Adeos Ipipe patch.

However, the compiled kernel doesn't boot - it actually just sits there,
doing nothing:

Bytes transferred =3D 2555616 (26fee0 hex)
## Booting kernel from Legacy Image at 80000000 ...
   Image Name:   Linux-2.6.30.10
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2555552 Bytes =3D  2.4 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing
Linux......................................................................=
...........................................................................=
.................
done, booting the kernel.

My guess is that Linux is simply not sending anything through my serial
(i.e., debug) port. Should I attempt to port over the serial driver, or is
this something else?
I am also downloading kernel 2.6.32 to see if I can make it boot on my IGEP=
.

Again, thanks for the help,
        -Felipe Brand=E3o Cavalcanti

On Fri, Feb 12, 2010 at 4:34 PM, Stefan Kisdaroczi <kisda@domain.hid> wrote=
:

> Am 12.02.2010 19:29, schrieb Gilles Chanteperdrix:
> > Felipe Brand=E3o Cavalcanti wrote:
> >> Pardon my ignorance, but how do you apply the kernel patch?
> >>
> >> Ive tried using the patch -p0 <
> /home/jdoe/Desktop/vanilla-igep-initial.diff
> >> command in the directory of the vanilla 2.6.30 kernel, but I get some
> >> errors:
> >
> > It is a patch for 2.6.32, so it is normal that it does not apply
> directly.
> >
>
> and use -p1, not -p0
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>


--=20
      -Felipe Brand=E3o Cavalcanti
      LARA - Robotics and Automation Laboratory
      Department of Electrical Engineering
      UnB - University of Bras=EDlia, Brazil
      http://www.lara.unb.br/~fbcavalcanti/

--00504501803b62cd9d047f80cd18
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

OK - I did apply the patch to 2.6.30.10, with some very minor modifications=
 in the sound system and in the headers (MACH_TYPE_IGEP0020 wasn&#39;t defi=
ned). I also applied the latest Adeos Ipipe patch.<br><br>However, the comp=
iled kernel doesn&#39;t boot - it actually just sits there, doing nothing:<=
br>

<br>Bytes transferred =3D 2555616 (26fee0 hex)<br>## Booting kernel from Le=
gacy Image at 80000000 ...<br>=A0=A0 Image Name:=A0=A0 Linux-2.6.30.10<br>=
=A0=A0 Image Type:=A0=A0 ARM Linux Kernel Image (uncompressed)<br>=A0=A0 Da=
ta Size:=A0=A0=A0 2555552 Bytes =3D=A0 2.4 MB<br>

=A0=A0 Load Address: 80008000<br>=A0=A0 Entry Point:=A0 80008000<br>=A0=A0 =
Verifying Checksum ... OK<br>=A0=A0 Loading Kernel Image ... OK<br>OK<br><b=
r>Starting kernel ...<br><br>Uncompressing Linux...........................=
...........................................................................=
............................................................ done, booting =
the kernel.<br>

<br>My guess is that Linux is simply not sending anything through my serial=
 (i.e., debug) port. Should I attempt to port over the serial driver, or is=
 this something else?<br>I am also downloading kernel 2.6.32 to see if I ca=
n make it boot on my IGEP.<br>

<br>Again, thanks for the help,<br>=A0=A0=A0=A0=A0=A0=A0 -Felipe Brand=E3o =
Cavalcanti<br><br><div class=3D"gmail_quote">On Fri, Feb 12, 2010 at 4:34 P=
M, Stefan Kisdaroczi <span dir=3D"ltr">&lt;<a href=3D"mailto:kisda@domain.hid.=
ch">kisda@domain.hid</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Am 12.02.2010 19:=
29, schrieb Gilles Chanteperdrix:<br>
<div class=3D"im">&gt; Felipe Brand=E3o Cavalcanti wrote:<br>
&gt;&gt; Pardon my ignorance, but how do you apply the kernel patch?<br>
&gt;&gt;<br>
&gt;&gt; Ive tried using the patch -p0 &lt; /home/jdoe/Desktop/vanilla-igep=
-initial.diff<br>
&gt;&gt; command in the directory of the vanilla 2.6.30 kernel, but I get s=
ome<br>
&gt;&gt; errors:<br>
&gt;<br>
&gt; It is a patch for 2.6.32, so it is normal that it does not apply direc=
tly.<br>
&gt;<br>
<br>
</div>and use -p1, not -p0<br>
<br>
<br>_______________________________________________<br>
Xenomai-help mailing list<br>
<a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-help</a><br>
<br></blockquote></div><br><br clear=3D"all"><br>-- <br> =A0 =A0 =A0 -Felip=
e Brand=E3o Cavalcanti<br> =A0 =A0 =A0 LARA - Robotics and Automation Labor=
atory<br> =A0 =A0 =A0 Department of Electrical Engineering<br> =A0 =A0 =A0 =
UnB - University of Bras=EDlia, Brazil<br>

 =A0 =A0 =A0 <a href=3D"http://www.lara.unb.br/~fbcavalcanti/">http://www.l=
ara.unb.br/~fbcavalcanti/</a><br>

--00504501803b62cd9d047f80cd18--

