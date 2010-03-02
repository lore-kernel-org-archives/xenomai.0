MIME-Version: 1.0
In-Reply-To: <8b216e9e1002151034n362f83afwfd6b9355ec071540@domain.hid>
References: <8b216e9e1002100327h3aa332ddl13ec590fcb81f0b7@domain.hid>
	<8b216e9e1002121023qa0f4d6n33c773110cfc78fd@domain.hid>
	<4B759DF9.9040800@domain.hid> <4B759F35.3050704@domain.hid>
	<8b216e9e1002131157k6f1a7ccbiba5e67b8855c77b2@domain.hid>
	<4B770554.3080809@domain.hid>
	<8b216e9e1002131225v16024e66p521d7eaad376441d@domain.hid>
	<8b216e9e1002150919p250b5270tab0bf5f242e87a25@domain.hid>
	<4B799016.2040305@domain.hid>
	<8b216e9e1002151034n362f83afwfd6b9355ec071540@domain.hid>
Date: Tue, 2 Mar 2010 12:29:28 -0300
Message-ID: <8b216e9e1003020729t58db73fdv88d9927695baae75@domain.hid>
From: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Content-Type: multipart/alternative; boundary=001636e1f99616fb840480d308b3
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

--001636e1f99616fb840480d308b3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2010/2/15 Felipe Brand=E3o Cavalcanti <cavalkaf@domain.hid>

>
>
> 2010/2/15 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>
>   Felipe Brand=E3o Cavalcanti wrote:
>> > 2010/2/13 Felipe Brand=E3o Cavalcanti <cavalkaf@domain.hid>
>> >
>> >>
>> >> 2010/2/13 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>> >>
>> >> Felipe Brand=E3o Cavalcanti wrote:
>> >>>> OK - I did apply the patch to 2.6.30.10, with some very minor
>> >>> modifications
>> >>>> in the sound system and in the headers (MACH_TYPE_IGEP0020 wasn't
>> >>> defined).
>> >>>> I also applied the latest Adeos Ipipe patch.
>> >>>>
>> >>>> However, the compiled kernel doesn't boot - it actually just sits
>> there,
>> >>>> doing nothing:
>> >>>>
>> >>>> Bytes transferred =3D 2555616 (26fee0 hex)
>> >>>> ## Booting kernel from Legacy Image at 80000000 ...
>> >>>>    Image Name:   Linux-2.6.30.10
>> >>>>    Image Type:   ARM Linux Kernel Image (uncompressed)
>> >>>>    Data Size:    2555552 Bytes =3D  2.4 MB
>> >>>>    Load Address: 80008000
>> >>>>    Entry Point:  80008000
>> >>>>    Verifying Checksum ... OK
>> >>>>    Loading Kernel Image ... OK
>> >>>> OK
>> >>>>
>> >>>> Starting kernel ...
>> >>>>
>> >>>> Uncompressing
>> >>>>
>> >>>
>> Linux...................................................................=
...........................................................................=
....................
>> >>>> done, booting the kernel.
>> >>>>
>> >>>> My guess is that Linux is simply not sending anything through my
>> serial
>> >>>> (i.e., debug) port. Should I attempt to port over the serial driver=
,
>> or
>> >>> is
>> >>>> this something else?
>> >>>> I am also downloading kernel 2.6.32 to see if I can make it boot on
>> my
>> >>> IGEP.
>> >>>
>> >>> Do you pass the proper "console=3D" argument to the kernel? Is the
>> support
>> >>> for serial driver enabled in the kernel?
>> >>>
>> >>> If yes, then apply trick #1 from the "Tips and tricks" section in th=
e
>> >>> "porting I-pipe to a new board" HOWTO on Xenomai website.
>> >>>
>> >>>
>> >> Yeah, I called it with the console=3D argument, and support is enable=
d.
>> Just
>> >> tested 2.6.32 - working fine in my board!
>> >>
>> >> I will try 2.6.30 again, but this time with no I-pipe patch, as well =
as
>> >> enabling the low-level debug options.
>> >>
>> >>
>> >
>> > OK - so I compiled the kernel with a series of kernel debug options, t=
o
>> find
>> > out what was going on. However, the kernel is stuck in a very strange
>> > position - just after starting the network!
>>
>> The NET message is not really related to starting the network (it is
>> only a network protocol which tells you that it suceeeded in registering
>> to the socket infrastructure), to know where the bug happens, you have
>> to add printks to see what happens. The main difference between the
>> latest I-pipe patch and previous releases is in the GPIO demux handling.
>>
>> Since I have an IGEPv2 on my office, would you mind letting me work on
>> this, say, next week, and give you a status when done?
>
>
So, any updates in this issue? I would love to get this working this
month... do you have any tips on how to proceed to do the low-level
debugging? I really have no clue on where the system is getting stuck.

Thanks for the help,
     -Felipe Brand=E3o Cavalcanti


>  Actually, I am running this without I-pipe, so I guess the problem is in
> the basic Linux support.
> And I am in no hurry - I would actually be really glad if you could take =
a
> look at the board and send me some info when you have some time!
>
> In the meantime, the almost-working version 2.6.28 should be fine for our
> first tests. I am also willing to help out in anything you need, but I
> really don't have that much experience in the low-level Linux stuff - but=
 I
> would like to learn!
>
> Once again, thanks very much for the help,
>     -Felipe Brand=E3o Cavalcanti
>
>
>>  --
>>
>> Gilles Chanteperdrix, Free Electrons
>> Kernel, drivers, real-time and embedded Linux
>> development, consulting, training and support.
>> http://free-electrons.com
>>
>
>
>
> --
>       -Felipe Brand=E3o Cavalcanti
>       LARA - Robotics and Automation Laboratory
>       Department of Electrical Engineering
>       UnB - University of Bras=EDlia, Brazil
>       http://www.lara.unb.br/~fbcavalcanti/
>



--=20
      -Felipe Brand=E3o Cavalcanti
      LARA - Robotics and Automation Laboratory
      Department of Electrical Engineering
      UnB - University of Bras=EDlia, Brazil
      http://www.lara.unb.br/~fbcavalcanti/

--001636e1f99616fb840480d308b3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br>
<div class=3D"gmail_quote">2010/2/15 Felipe Brand=E3o Cavalcanti <span dir=
=3D"ltr">&lt;<a href=3D"mailto:cavalkaf@domain.hid">cavalkaf@domain.hid</a>&g=
t;</span><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><br><br>
<div class=3D"gmail_quote">2010/2/15 Gilles Chanteperdrix <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org" target=3D"_=
blank">gilles.chanteperdrix@xenomai.org</a>&gt;</span>=20
<div>
<div></div>
<div class=3D"h5"><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0=
pt 0pt 0.8ex; BORDER-LEFT: rgb(204,204,204) 1px solid">
<div>
<div></div>
<div>Felipe Brand=E3o Cavalcanti wrote:<br>&gt; 2010/2/13 Felipe Brand=E3o =
Cavalcanti &lt;<a href=3D"mailto:cavalkaf@domain.hid" target=3D"_blank">cava=
lkaf@domain.hid</a>&gt;<br>&gt;<br>&gt;&gt;<br>&gt;&gt; 2010/2/13 Gilles Cha=
nteperdrix &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org" target=
=3D"_blank">gilles.chanteperdrix@xenomai.org</a>&gt;<br>
&gt;&gt;<br>&gt;&gt; Felipe Brand=E3o Cavalcanti wrote:<br>&gt;&gt;&gt;&gt;=
 OK - I did apply the patch to 2.6.30.10, with some very minor<br>&gt;&gt;&=
gt; modifications<br>&gt;&gt;&gt;&gt; in the sound system and in the header=
s (MACH_TYPE_IGEP0020 wasn&#39;t<br>
&gt;&gt;&gt; defined).<br>&gt;&gt;&gt;&gt; I also applied the latest Adeos =
Ipipe patch.<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt; However, the compiled =
kernel doesn&#39;t boot - it actually just sits there,<br>&gt;&gt;&gt;&gt; =
doing nothing:<br>
&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt; Bytes transferred =3D 2555616 (26fee0 =
hex)<br>&gt;&gt;&gt;&gt; ## Booting kernel from Legacy Image at 80000000 ..=
.<br>&gt;&gt;&gt;&gt; =A0 =A0Image Name: =A0 Linux-2.6.30.10<br>&gt;&gt;&gt=
;&gt; =A0 =A0Image Type: =A0 ARM Linux Kernel Image (uncompressed)<br>
&gt;&gt;&gt;&gt; =A0 =A0Data Size: =A0 =A02555552 Bytes =3D =A02.4 MB<br>&g=
t;&gt;&gt;&gt; =A0 =A0Load Address: 80008000<br>&gt;&gt;&gt;&gt; =A0 =A0Ent=
ry Point: =A080008000<br>&gt;&gt;&gt;&gt; =A0 =A0Verifying Checksum ... OK<=
br>&gt;&gt;&gt;&gt; =A0 =A0Loading Kernel Image ... OK<br>
&gt;&gt;&gt;&gt; OK<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt; Starting kernel=
 ...<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt; Uncompressing<br>&gt;&gt;&gt;&=
gt;<br>&gt;&gt;&gt; Linux..................................................=
...........................................................................=
.....................................<br>
&gt;&gt;&gt;&gt; done, booting the kernel.<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&=
gt;&gt; My guess is that Linux is simply not sending anything through my se=
rial<br>&gt;&gt;&gt;&gt; (i.e., debug) port. Should I attempt to port over =
the serial driver, or<br>
&gt;&gt;&gt; is<br>&gt;&gt;&gt;&gt; this something else?<br>&gt;&gt;&gt;&gt=
; I am also downloading kernel 2.6.32 to see if I can make it boot on my<br=
>&gt;&gt;&gt; IGEP.<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Do you pass the proper =
&quot;console=3D&quot; argument to the kernel? Is the support<br>
&gt;&gt;&gt; for serial driver enabled in the kernel?<br>&gt;&gt;&gt;<br>&g=
t;&gt;&gt; If yes, then apply trick #1 from the &quot;Tips and tricks&quot;=
 section in the<br>&gt;&gt;&gt; &quot;porting I-pipe to a new board&quot; H=
OWTO on Xenomai website.<br>
&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt; Yeah, I called it with the console=
=3D argument, and support is enabled. Just<br>&gt;&gt; tested 2.6.32 - work=
ing fine in my board!<br>&gt;&gt;<br>&gt;&gt; I will try 2.6.30 again, but =
this time with no I-pipe patch, as well as<br>
&gt;&gt; enabling the low-level debug options.<br>&gt;&gt;<br>&gt;&gt;<br>&=
gt;<br>&gt; OK - so I compiled the kernel with a series of kernel debug opt=
ions, to find<br>&gt; out what was going on. However, the kernel is stuck i=
n a very strange<br>
&gt; position - just after starting the network!<br><br></div></div>The NET=
 message is not really related to starting the network (it is<br>only a net=
work protocol which tells you that it suceeeded in registering<br>to the so=
cket infrastructure), to know where the bug happens, you have<br>
to add printks to see what happens. The main difference between the<br>late=
st I-pipe patch and previous releases is in the GPIO demux handling.<br><br=
>Since I have an IGEPv2 on my office, would you mind letting me work on<br>
this, say, next week, and give you a status when done?</blockquote></div></=
div></div></blockquote>
<div>=A0</div>
<div>So, any updates in this issue? I would love to get this working this m=
onth... do you have any tips on how to proceed to do the low-level debuggin=
g? I really have no clue on where the system is getting stuck.</div>
<div>=A0</div>
<div>Thanks for the help,</div>
<div>=A0=A0=A0=A0 -Felipe Brand=E3o Cavalcanti</div>
<div>=A0</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"gmail_quote">
<div>Actually, I am running this without I-pipe, so I guess the problem is =
in the basic Linux support.<br>And I am in no hurry - I would actually be r=
eally glad if you could take a look at the board and send me some info when=
 you have some time!<br>
<br>In the meantime, the almost-working version 2.6.28 should be fine for o=
ur first tests. I am also willing to help out in anything you need, but I r=
eally don&#39;t have that much experience in the low-level Linux stuff - bu=
t I would like to learn!<br>
<br>Once again, thanks very much for the help,<br>=A0=A0=A0 -Felipe Brand=
=E3o Cavalcanti<br>=A0</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0=
pt 0pt 0.8ex; BORDER-LEFT: rgb(204,204,204) 1px solid">
<div>
<div>--=20
<div class=3D"im"><br>Gilles Chanteperdrix, Free Electrons<br>Kernel, drive=
rs, real-time and embedded Linux<br>development, consulting, training and s=
upport.<br><a href=3D"http://free-electrons.com/" target=3D"_blank">http://=
free-electrons.com</a><br>
</div></div></div></blockquote></div><br><br clear=3D"all">
<div>
<div></div>
<div class=3D"h5"><br>-- <br>=A0 =A0 =A0 -Felipe Brand=E3o Cavalcanti<br>=
=A0 =A0 =A0 LARA - Robotics and Automation Laboratory<br>=A0 =A0 =A0 Depart=
ment of Electrical Engineering<br>=A0 =A0 =A0 UnB - University of Bras=EDli=
a, Brazil<br>=A0 =A0 =A0 <a href=3D"http://www.lara.unb.br/~fbcavalcanti/" =
target=3D"_blank">http://www.lara.unb.br/~fbcavalcanti/</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>=A0 =A0 =A0=
 -Felipe Brand=E3o Cavalcanti<br>=A0 =A0 =A0 LARA - Robotics and Automation=
 Laboratory<br>=A0 =A0 =A0 Department of Electrical Engineering<br>=A0 =A0 =
=A0 UnB - University of Bras=EDlia, Brazil<br>
=A0 =A0 =A0 <a href=3D"http://www.lara.unb.br/~fbcavalcanti/">http://www.la=
ra.unb.br/~fbcavalcanti/</a><br>

--001636e1f99616fb840480d308b3--

