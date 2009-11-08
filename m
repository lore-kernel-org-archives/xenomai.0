MIME-Version: 1.0
Sender: lcasassa@domain.hid
In-Reply-To: <4AF59B0F.1020300@domain.hid>
References: <47a3101a0911070704o5307a23dhef368d04cc25fc6@domain.hid> 
	<4AF59B0F.1020300@domain.hid>
From: Linus Casassa <linus@domain.hid>
Date: Sun, 8 Nov 2009 04:06:06 -0300
Message-ID: <47a3101a0911072306g42ddc0dfld0571e04fe1bf18b@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd14a9a22d4fc0477d6b748
Subject: Re: [Xenomai-help] Gumstix arm pxa
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

--000e0cd14a9a22d4fc0477d6b748
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I applied the patch but I don't see difference.

I realised that I wasn't checking the return error so the periodic wait
function returns without waiting and the system hangs setting and clearing
the GPIO. Obviously... :P

The error said that the period is less then /proc/xenomai/latency

cat /proc/xenomai/latency
9345

But when I use 200ms the period in ticks is 200 that is less then 9345. Thi=
s
confuses me because 200 works...

I tested with 50 ms and it works. Then I tested with 20 ms and it shows the
same error. All periods that in ticks are lesser than 10 return error.

So I remember that there is a tick argument for the skin. By default it is
1000 so I try with 40.

modprobe xeno_native tick_arg=3D40

And now for the same period I get a bigger number in ticks

I can get up to 1,3 ms!! :D

I steel don't understand the ticks on xenomai. Where can find info?
What is the disadvantage on a small tick_arg?

I made a graphic with the acquires measured from an oscilloscope.
http://alumnos.elo.utfsm.cl/~lcasassa/1.3ms_xenoTest_sin_carga.png

The X axis shows the number of periods
And the Y axis the accuracy of each period.
The line is the mean of all the data. That is 50us.

The part that I don't understand is that the data forms lines parallel the =
X
axis. But I thing that has to do with the tick_arg.

Nice work Xenomai!! it is a grate project!! :)

On Sat, Nov 7, 2009 at 1:06 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Linus Casassa wrote:
> > I am using xenomai 2.9.1 with kernel 2.6.24.
> >
> > Any suggestions?
>
> See:
> https://mail.gna.org/public/xenomai-core/2009-08/msg00021.html
>
> --
>                                             Gilles.
>



--=20
Linus Casassa
Estudiante Ingenier=EDa Civil Electr=F3nica
Fono: 56-9-97776941

--000e0cd14a9a22d4fc0477d6b748
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I applied the patch but I don&#39;t see difference.<br><br>I realised that =
I wasn&#39;t checking the return error so the periodic wait function return=
s without waiting and the system hangs setting and clearing the GPIO. Obvio=
usly... :P<br>

<br>The error said that the period is less then /proc/xenomai/latency<br><b=
r>cat /proc/xenomai/latency<br>9345<br><br>But when I use 200ms the period =
in ticks is 200 that is less then 9345. This confuses me because 200 works.=
..<br>

<br>I tested with 50 ms and it works. Then I tested with 20 ms and it shows=
 the same error. All periods that in ticks are lesser than 10 return error.=
<br><br>So I remember that there is a tick argument for the skin. By defaul=
t it is 1000 so I try with 40.<br>

<br>modprobe xeno_native tick_arg=3D40<br><br>And now for the same period I=
 get a bigger number in ticks <br><br>I can get up to 1,3 ms!! :D<br><br>I =
steel don&#39;t understand the ticks on xenomai. Where can find info?<br>

What is the disadvantage on a small tick_arg?<br><br>I made a graphic with =
the acquires measured from an oscilloscope.<br><a href=3D"http://alumnos.el=
o.utfsm.cl/~lcasassa/1.3ms_xenoTest_sin_carga.png">http://alumnos.elo.utfsm=
.cl/~lcasassa/1.3ms_xenoTest_sin_carga.png</a><br>

<br>The X axis shows the number of periods<br>And the Y axis the accuracy o=
f each period.<br>The line is the mean of all the data. That is 50us.<br><b=
r>The part that I don&#39;t understand is that the data forms lines paralle=
l the X axis. But I thing that has to do with the tick_arg.<br>

<br>Nice work Xenomai!! it is a grate project!! :)<br><br><div class=3D"gma=
il_quote">On Sat, Nov 7, 2009 at 1:06 PM, Gilles Chanteperdrix <span dir=3D=
"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org" target=3D"_bl=
ank">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div>Linus Casassa wrote:<br>
&gt; I am using xenomai 2.9.1 with kernel 2.6.24.<br>
&gt;<br>
&gt; Any suggestions?<br>
<br>
</div>See:<br>
<a href=3D"https://mail.gna.org/public/xenomai-core/2009-08/msg00021.html" =
target=3D"_blank">https://mail.gna.org/public/xenomai-core/2009-08/msg00021=
.html</a><br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Linus Casassa<br=
>Estudiante Ingenier=EDa Civil Electr=F3nica<br>Fono: 56-9-97776941<br>

--000e0cd14a9a22d4fc0477d6b748--

