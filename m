MIME-Version: 1.0
In-Reply-To: <4E5B76E2.1090803@domain.hid>
References: <CAHoMn5qyUPgGBk+gKQsLweYb1UixJKVk6si9P4YLiOAstL_2XQ@mail.gmail.com>
	<4E5B76E2.1090803@domain.hid>
Date: Mon, 29 Aug 2011 20:09:54 +0800
Message-ID: <CAHoMn5oX=cJ080BEbC9DCYN4rreTE5+m=Lh=N80Xi4qsiZFfbg@domain.hid>
From: yi zheng <yizheng23@domain.hid>
Content-Type: multipart/alternative; boundary=001636c926a0de4cdb04aba3c5d0
Subject: Re: [Xenomai-help] how to use rt_io_get_region function on
 AT91SAM9263 in user space
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

--001636c926a0de4cdb04aba3c5d0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

>
> >>    Hi,all
> >>      I want to write a Xenomai application running in user space that
> can
> >> access the
> >> GPIO pins of my AT91SAM9263 ARM. To get the memory
> >> region I found the function rt_misc_get_io_region(). Unfortunately
> >> there is no discription of this function in the API documentation.
> >> Does this function work like request_mem_region()?
>
> >Yes, it allows user-space access to request_mem_region. So, in addition
> >to this, you should do the usual mmap(/dev/mem) dance. However, it is
> >you get mutual exclusion between>probably better to write an RTDM driver
> using linux gpiolib. This way,

> linux and xenomai.

   Do you mean I just access io memory like standard linux with following
steps:
   fd =3D open("/dev/mem", O_RDWR | O_SYNC)) =3D=3D -1);
    map_base =3D mmap((void *)target, nSize, PROT_READ | PROT_WRITE,
MAP_SHARED,fd, target)
   or there is something wrong with my understanding.If this is not the
correct way please give me a simple example=A3=ACthank you.

> >--
> >                                                               Gilles.
>
 regards
 yizheng

--001636c926a0de4cdb04aba3c5d0
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;"><div class=3D"im=
">&gt;&gt; &nbsp; &nbsp;Hi,all<br>&gt;&gt; &nbsp; &nbsp; &nbsp;I want to wr=
ite a Xenomai application running in user space that can<br>
&gt;&gt; access the<br>
&gt;&gt; GPIO pins of my AT91SAM9263 ARM. To get the memory<br>
&gt;&gt; region I found the function rt_misc_get_io_region(). Unfortunately=
<br>
&gt;&gt; there is no discription of this function in the API documentation.=
<br>&gt;&gt; Does this function work like request_mem_region()?<br>
<br>
</div>&gt;Yes, it allows user-space access to request_mem_region. So, in ad=
dition<br>&gt;to this, you should do the usual mmap(/dev/mem) dance. Howeve=
r, it is<br>&gt;you get mutual exclusion between&gt;probably better to writ=
e an RTDM driver using linux gpiolib. This way,&nbsp;</blockquote>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">&gt; linux and xenomai.</blockquote><div>&n=
bsp; &nbsp;Do you mean I just access io memory like standard linux with fol=
lowing steps:</div>
<div>&nbsp; &nbsp;<span class=3D"Apple-style-span" style=3D"font-family: mo=
nospace; white-space: pre; background-color: rgb(255, 255, 255); font-size:=
 medium; ">fd =3D open(&quot;/dev/mem&quot;, O_RDWR | O_SYNC)) =3D=3D -1);<=
/span></div><div>
&nbsp; &nbsp;&nbsp;<span class=3D"Apple-style-span" style=3D"font-family: m=
onospace; white-space: pre; background-color: rgb(255, 255, 255); font-size=
: medium; ">map_base =3D mmap((void *)target, nSize, PROT_READ | PROT_WRITE=
, MAP_SHARED,</span><span class=3D"Apple-style-span" style=3D"font-family: =
monospace; white-space: pre; background-color: rgb(255, 255, 255); font-siz=
e: medium; ">fd, target)</span></div>
<div>&nbsp; &nbsp;or there is something wrong with my understanding.If this=
 is not the correct way please give me a simple example=A3=ACthank you.</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex;">
&gt;--<br>
<font color=3D"#888888">&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; Gilles.<br></font></blockquote><div>&nbsp;regards&nbsp=
;</div><div>&nbsp;yizheng</div><div><br></div><div>&nbsp; &nbsp;&nbsp;</div=
><div>&nbsp; &nbsp;</div><div>&nbsp;</div></div>
<br>

--001636c926a0de4cdb04aba3c5d0--

