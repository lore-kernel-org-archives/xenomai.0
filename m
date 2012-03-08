MIME-Version: 1.0
Sender: hadrienstegosaure@domain.hid
In-Reply-To: <CA+eKTkacCZwnKRE6kyAVY=a89mwsFO7Qjaeyq5eqDop+ZngiyA@mail.gmail.com>
References: <CA+eKTkacCZwnKRE6kyAVY=a89mwsFO7Qjaeyq5eqDop+ZngiyA@mail.gmail.com>
Date: Thu, 8 Mar 2012 16:01:31 +0100
Message-ID: <CA+eKTkYgnbBYZXPGpzZNNMbyUR=S974YFs30UMv8zFS9aKOBqA@mail.gmail.com>
From: Hadrien Caron <hadrien.caron@domain.hid>
Content-Type: multipart/alternative; boundary=00248c71178529d76b04babc8d09
Subject: Re: [Xenomai-help] a4l_sync_dio information
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--00248c71178529d76b04babc8d09
Content-Type: text/plain; charset=ISO-8859-1

Sorry for the disturbance, I found that I needed to add a a4l_config_subd
before the a4l_sync_dio.
Now it works fine !
Have a good day,

Hadrien

On Wed, Mar 7, 2012 at 10:45 AM, Hadrien Caron <hadrien.caron@domain.hid>wrote:

> Hello to all, I am using xenomai-2.6.0 on an ubuntu 10.10 with linux
> kernel 2.6.38.8 on a x86 platform.
> I am trying to make the digital input/output work but can't manage to do
> so.
> To do this, I use the a4l_sync_dio<http://group__sync2__lib.html#gada79039a312c5cab36653c9edda98a3c> function,
> but I am not sure I understand well
> what it's arguments should be (attached is an example program).
>
> My program is supposed to change the value of the DO channels to 1
> and then set it back to 0, but when I launch my program, it returns
> without any error
> but doesn't change anything on the channels (I check them with an
> oscilloscope)
>
> Could someone give me an advice ?
>
> Thanks in advance !
>
> Hadrien
>
>

--00248c71178529d76b04babc8d09
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sorry for the disturbance, I found that I needed to add a a4l_config_subd b=
efore the a4l_sync_dio.<br>Now it works fine !<br>Have a good day,<br><br>H=
adrien<br><br><div class=3D"gmail_quote">On Wed, Mar 7, 2012 at 10:45 AM, H=
adrien Caron <span dir=3D"ltr">&lt;<a href=3D"mailto:hadrien.caron@domain.hid=
m">hadrien.caron@domain.hid</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Hello to all, I am using =
xenomai-2.6.0 on an ubuntu 10.10 with linux kernel=A02.6.38.8 on a x86 plat=
form.<div>
I am trying to make the digital input/output work but can&#39;t manage to d=
o so.</div><div>To do this, I use the=A0<span style=3D"font-family:&#39;Luc=
ida Grande&#39;,Verdana,Geneva,Arial,sans-serif;font-size:12px"><a href=3D"=
http://group__sync2__lib.html#gada79039a312c5cab36653c9edda98a3c" style=3D"=
color:rgb(70,101,162);font-weight:bold;text-decoration:none" target=3D"_bla=
nk">a4l_sync_dio</a>=A0function, but I am not sure I understand well</span>=
</div>

<div><span style=3D"font-family:&#39;Lucida Grande&#39;,Verdana,Geneva,Aria=
l,sans-serif;font-size:12px">what it&#39;s arguments should be (attached is=
 an example program).</span></div><div><span style=3D"font-family:&#39;Luci=
da Grande&#39;,Verdana,Geneva,Arial,sans-serif;font-size:12px"><br>

</span></div><div><span style=3D"font-family:&#39;Lucida Grande&#39;,Verdan=
a,Geneva,Arial,sans-serif;font-size:12px">My program is supposed to change =
the value of the DO channels to 1</span></div><div>
<span style=3D"font-family:&#39;Lucida Grande&#39;,Verdana,Geneva,Arial,san=
s-serif;font-size:12px">and then set it back to 0, but w</span><span style=
=3D"font-family:&#39;Lucida Grande&#39;,Verdana,Geneva,Arial,sans-serif;fon=
t-size:12px">hen I launch my program, it returns without any error</span></=
div>

<div><span style=3D"font-family:&#39;Lucida Grande&#39;,Verdana,Geneva,Aria=
l,sans-serif;font-size:12px">but doesn&#39;t change anything on the channel=
s (I check them with an oscilloscope)</span></div>
<div><span style=3D"font-family:&#39;Lucida Grande&#39;,Verdana,Geneva,Aria=
l,sans-serif;font-size:12px"><br></span></div><div><span style=3D"font-fami=
ly:&#39;Lucida Grande&#39;,Verdana,Geneva,Arial,sans-serif;font-size:12px">=
Could someone give me an advice ?</span></div>

<div><span style=3D"font-family:&#39;Lucida Grande&#39;,Verdana,Geneva,Aria=
l,sans-serif;font-size:12px"><br></span></div><div><span style=3D"font-fami=
ly:&#39;Lucida Grande&#39;,Verdana,Geneva,Arial,sans-serif;font-size:12px">=
Thanks in advance !</span></div>

<div><span style=3D"font-family:&#39;Lucida Grande&#39;,Verdana,Geneva,Aria=
l,sans-serif;font-size:12px"><br></span></div><font color=3D"#888888"><div>=
<span style=3D"font-family:&#39;Lucida Grande&#39;,Verdana,Geneva,Arial,san=
s-serif;font-size:12px">Hadrien</span></div>

<div><span style=3D"font-family:&#39;Lucida Grande&#39;,Verdana,Geneva,Aria=
l,sans-serif;font-size:12px"><br></span></div>
</font></blockquote></div><br>

--00248c71178529d76b04babc8d09--

