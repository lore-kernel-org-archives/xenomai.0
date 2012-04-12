MIME-Version: 1.0
In-Reply-To: <4F8689BD.4050508@domain.hid>
References: <CAGq8jPhOy=v8Lccb+hddH9W_u8p-Ayi+XfEcFC+rHVzsSp-ghg@domain.hid>
	<4F7555F7.6010102@domain.hid>
	<CAGq8jPioLnu+ehj+LA5dL6OWUpxQnUH+Nh01kB088FtsLsSrGA@mail.gmail.com>
	<CAGq8jPi4S4TTBy9dLYYnWuWQdX_awhXxu0C93okgFO5vWv_20A@mail.gmail.com>
	<4F75B5BF.8030401@domain.hid>
	<CAGq8jPgY6fTw0ufdj=pvc+Q1jrrQkYptSHTzFOQK=qSiJJU32Q@mail.gmail.com>
	<4F75C7D1.4020808@domain.hid>
	<CAGq8jPhqv16jgPQh631x8S2MmDhm1F4HtnrQA0xsGPe4bTo6eA@mail.gmail.com>
	<4F79D5EA.3010501@domain.hid>
	<CAGq8jPjq79CdBbNys1=ccV-CKSyNfG9nX-1L31Ar6WShuNE=HQ@mail.gmail.com>
	<4F7D7A43.4060502@domain.hid>
	<CAGq8jPhqRN0WTKHC1uJXbHyecX_tKOB6zFnDJ4=DbKtzU3mmcA@mail.gmail.com>
	<CAGq8jPgON96yy7_wOCSs83QwxVrfSsTn-fe1P+EBZ8-KLMfj0A@mail.gmail.com>
	<4F8592F3.6070907@domain.hid> <4F85B7BE.9080706@domain.hid>
	<4F85B869.2060102@domain.hid> <4F85D505.6080002@domain.hid>
	<CAGq8jPj4dNaukTMZXo6+C=UA-TfpP5h9FOU07FUTnX0TTDsqCA@mail.gmail.com>
	<4F8689BD.4050508@domain.hid>
Date: Thu, 12 Apr 2012 10:51:03 +0200
Message-ID: <CAGq8jPgV3aQrz6-Y0LqrjT1HA2udHG887o1EFd4bS5eFvp6gkw@domain.hid>
From: Minh GIANG <giang.hminh@domain.hid>
Content-Type: multipart/alternative; boundary=20cf3040eb5cae27f704bd777413
Subject: Re: [Xenomai-help] Cross-link.c ---RTSER_RTIOC_WAIT_EVENT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

--20cf3040eb5cae27f704bd777413
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hello sir,

Here is the message after doing your command:

giang@domain.hid$
make XENO=3D/usr/xenomai/bin
--xeno-cflags is deprecated, use --skin=3Dname --cflags instead
--xeno-ldflags is deprecated, use --skin=3Dname --ldflags instead
gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall
-Werror-implicit-function-declaration -pipe -D__XENO__   -L/usr/xenomai/lib
-lxenomai -lpthread -lrt  -lnative -lrtdm -Xlinker -rpath -Xlinker
/usr/xenomai/lib  cross-link.c   -o cross-link
cross-link.c: In function =91write_task_proc=92:
cross-link.c:167: warning: format =91%d=92 expects type =91int=92, but argu=
ment 2
has type =91ssize_t=92
cross-link.c:167: warning: format =91%d=92 expects type =91int=92, but argu=
ment 3
has type =91ssize_t=92
cross-link.c: In function =91read_task_proc=92:
cross-link.c:227: warning: format =91%d=92 expects type =91int=92, but argu=
ment 2
has type =91ssize_t=92
cross-link.c:227: warning: format =91%d=92 expects type =91int=92, but argu=
ment 3
has type =91ssize_t=92
giang@domain.hid$
./cross-link
Xenomai: binding failed: Operation not permitted.
giang@domain.hid$ su
Mot de passe :
root@domain.hid=
rial#
./cross-link
main : write-file opened
main : write-config written
main : read-file opened
main : read-config written
main : write-task created
main : read-task created
main : starting write-task
main : starting read-task
 Nr |   write->irq    |    irq->read    |   write->read   |
-----------------------------------------------------------
  0 |          104495 |          617720 |          722215
  1 |          104649 |          617061 |          721710
  2 |          104360 |          617820 |          722180
  3 |          104906 |          617050 |          721956
  4 |          105794 |          617188 |          722982
  5 |          103504 |          618103 |          721607
  6 |          104643 |          617084 |          721727
  7 |          106633 |          617767 |          724400

oh, it seems to work perfectly, i don't know why it works in this case when
i lauched it in the terminal linux, i copied exactly the program in Eclipse
C++ and it doesn't work. Ah the only thing i have changed (otherwise my
program don't compile in Eclipse), is

static const struct rtser_config read_config =3D {
0xFFFF,
115200,
RTSER_DEF_PARITY,
RTSER_DEF_BITS,
RTSER_DEF_STOPB,
RTSER_DEF_HAND,
RTSER_DEF_FIFO_DEPTH,
RTSER_DEF_TIMEOUT,
RTSER_DEF_TIMEOUT,
1000000000, /* 1 s */
RTSER_RX_TIMESTAMP_HISTORY,
RTSER_EVENT_RXPEND,
};

static const struct rtser_config write_config =3D {
RTSER_SET_BAUD | RTSER_SET_TIMESTAMP_HISTORY,
115200,
RTSER_DEF_TIMESTAMP_HISTORY,
/* the rest implicitely remains default */
};

maybe, i don't compile with good parameters in Eclipse?
my version Xenomai 2.6.0


On Thu, Apr 12, 2012 at 9:52 AM, Wolfgang Grandegger <wg@domain.hid>wro=
te:

> On 04/11/2012 10:51 PM, Minh GIANG wrote:
> > ok for CC, i was afraid of spam everyone by my mail. I answer your
> > questions.
> >
> > - non, i didn't modify cross-link program  (even if i used to modify th=
is
> > program to make it run, but it worked the same way)
> >
> > - Xenomai 2.6
>
> What version (cat /proc/xenomai/version)?
>
> >
> > - Linux 2.6.38 and patch Adeos 2.6.38 of course
> >
> > - i build the program in Eclipse C++ so my command in setting
> configuration
> > is
> >
> > command :   g++
> > All options:   -l/usr/xenomai/include -O3 -wall -c -fmessage-length=3D0
>
> That bogous! Please try the image created as shown below:
>
>  $ cd <xenomai-2.6-path>/examples/rtdm/profiles/serial
>  $ make XENO=3D/usr/xenomai/bin
>
> Wolfgang.
>

--20cf3040eb5cae27f704bd777413
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hello sir,<div><br></div><div>Here is the message after doing your command:=
</div><div><br></div><div><div>giang@domain.hid=
mples/rtdm/profiles/serial$ make XENO=3D/usr/xenomai/bin</div><div>--xeno-c=
flags is deprecated, use --skin=3Dname --cflags instead</div>
<div>--xeno-ldflags is deprecated, use --skin=3Dname --ldflags instead</div=
><div>gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -Werror-i=
mplicit-function-declaration -pipe -D__XENO__ =A0 -L/usr/xenomai/lib -lxeno=
mai -lpthread -lrt =A0-lnative -lrtdm -Xlinker -rpath -Xlinker /usr/xenomai=
/lib =A0cross-link.c =A0 -o cross-link</div>
<div>cross-link.c: In function =91write_task_proc=92:</div><div>cross-link.=
c:167: warning: format =91%d=92 expects type =91int=92, but argument 2 has =
type =91ssize_t=92</div><div>cross-link.c:167: warning: format =91%d=92 exp=
ects type =91int=92, but argument 3 has type =91ssize_t=92</div>
<div>cross-link.c: In function =91read_task_proc=92:</div><div>cross-link.c=
:227: warning: format =91%d=92 expects type =91int=92, but argument 2 has t=
ype =91ssize_t=92</div><div>cross-link.c:227: warning: format =91%d=92 expe=
cts type =91int=92, but argument 3 has type =91ssize_t=92</div>
<div>giang@domain.hid=
$ ./cross-link=A0</div><div>Xenomai: binding failed: Operation not permitte=
d.</div><div>giang@domain.hid=
s/serial$ su</div>
<div>Mot de passe :=A0</div><div>root@domain.hid=
i-2.6.0/examples/rtdm/profiles/serial# ./cross-link=A0</div><div>main : wri=
te-file opened</div><div>main : write-config written</div><div>main : read-=
file opened</div>
<div>main : read-config written</div><div>main : write-task created</div><d=
iv>main : read-task created</div><div>main : starting write-task</div><div>=
main : starting read-task</div><div>=A0Nr | =A0 write-&gt;irq =A0 =A0| =A0 =
=A0irq-&gt;read =A0 =A0| =A0 write-&gt;read =A0 |</div>
<div>-----------------------------------------------------------</div><div>=
=A0 0 | =A0 =A0 =A0 =A0 =A0104495 | =A0 =A0 =A0 =A0 =A0617720 | =A0 =A0 =A0=
 =A0 =A0722215</div><div>=A0 1 | =A0 =A0 =A0 =A0 =A0104649 | =A0 =A0 =A0 =
=A0 =A0617061 | =A0 =A0 =A0 =A0 =A0721710</div><div>=A0 2 | =A0 =A0 =A0 =A0=
 =A0104360 | =A0 =A0 =A0 =A0 =A0617820 | =A0 =A0 =A0 =A0 =A0722180</div>
<div>=A0 3 | =A0 =A0 =A0 =A0 =A0104906 | =A0 =A0 =A0 =A0 =A0617050 | =A0 =
=A0 =A0 =A0 =A0721956</div><div>=A0 4 | =A0 =A0 =A0 =A0 =A0105794 | =A0 =A0=
 =A0 =A0 =A0617188 | =A0 =A0 =A0 =A0 =A0722982</div><div>=A0 5 | =A0 =A0 =
=A0 =A0 =A0103504 | =A0 =A0 =A0 =A0 =A0618103 | =A0 =A0 =A0 =A0 =A0721607</=
div><div>=A0 6 | =A0 =A0 =A0 =A0 =A0104643 | =A0 =A0 =A0 =A0 =A0617084 | =
=A0 =A0 =A0 =A0 =A0721727</div>
<div>=A0 7 | =A0 =A0 =A0 =A0 =A0106633 | =A0 =A0 =A0 =A0 =A0617767 | =A0 =
=A0 =A0 =A0 =A0724400</div><div><br></div><div>oh, it seems to work perfect=
ly, i don&#39;t know why it works in this case when i lauched it in the ter=
minal linux, i copied exactly the program in Eclipse C++ and it doesn&#39;t=
 work. Ah the only thing i have changed (otherwise my program don&#39;t com=
pile in Eclipse), is=A0</div>
</div><div><br></div><div><div>static const struct rtser_config read_config=
 =3D {</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0xFFFF,</div><div><span class=3D"Apple-tab-span" style=3D"white-spac=
e:pre">	</span>115200,</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>RTSER=
_DEF_PARITY,</div><div><span class=3D"Apple-tab-span" style=3D"white-space:=
pre">	</span>RTSER_DEF_BITS,</div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>RTSER_DEF_STOPB,</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>RTSER=
_DEF_HAND,</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pr=
e">	</span>RTSER_DEF_FIFO_DEPTH,</div><div><span class=3D"Apple-tab-span" s=
tyle=3D"white-space:pre">	</span>RTSER_DEF_TIMEOUT,</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>RTSER=
_DEF_TIMEOUT,</div><div><span class=3D"Apple-tab-span" style=3D"white-space=
:pre">	</span>1000000000, /* 1 s */</div><div><span class=3D"Apple-tab-span=
" style=3D"white-space:pre">	</span>RTSER_RX_TIMESTAMP_HISTORY,</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>RTSER=
_EVENT_RXPEND,</div><div>};</div><div><br></div><div>static const struct rt=
ser_config write_config =3D {</div><div><span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">	</span>RTSER_SET_BAUD | RTSER_SET_TIMESTAMP_HISTORY,=
</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>11520=
0,</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</sp=
an>RTSER_DEF_TIMESTAMP_HISTORY,</div><div><span class=3D"Apple-tab-span" st=
yle=3D"white-space:pre">	</span>/* the rest implicitely remains default */<=
/div>
<div>};</div></div><div><br></div><div>maybe, i don&#39;t compile with good=
 parameters in Eclipse?</div><div>my version Xenomai 2.6.0</div><div><br></=
div><div><br><div class=3D"gmail_quote">On Thu, Apr 12, 2012 at 9:52 AM, Wo=
lfgang Grandegger <span dir=3D"ltr">&lt;<a href=3D"mailto:wg@domain.hid=
">wg@domain.hid</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On 04/11/2012 10:51 PM, Mi=
nh GIANG wrote:<br>
&gt; ok for CC, i was afraid of spam everyone by my mail. I answer your<br>
&gt; questions.<br>
&gt;<br>
&gt; - non, i didn&#39;t modify cross-link program =A0(even if i used to mo=
dify this<br>
&gt; program to make it run, but it worked the same way)<br>
&gt;<br>
&gt; - Xenomai 2.6<br>
<br>
</div>What version (cat /proc/xenomai/version)?<br>
<div class=3D"im"><br>
&gt;<br>
&gt; - Linux 2.6.38 and patch Adeos 2.6.38 of course<br>
&gt;<br>
&gt; - i build the program in Eclipse C++ so my command in setting configur=
ation<br>
&gt; is<br>
&gt;<br>
&gt; command : =A0 g++<br>
&gt; All options: =A0 -l/usr/xenomai/include -O3 -wall -c -fmessage-length=
=3D0<br>
<br>
</div>That bogous! Please try the image created as shown below:<br>
<br>
 =A0$ cd &lt;xenomai-2.6-path&gt;/examples/rtdm/profiles/serial<br>
 =A0$ make XENO=3D/usr/xenomai/bin<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Wolfgang.<br>
</font></span></blockquote></div><br></div>

--20cf3040eb5cae27f704bd777413--

