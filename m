MIME-Version: 1.0
In-Reply-To: <AANLkTimUrZpJMzbMWN=T3rEr=FmxbiVbHYfzviXy08CF@mail.gmail.com>
References: <AANLkTikTyH5R8oMS-f-1jcJqryAwT-DKfzxNf1YROALK@mail.gmail.com>
	<AANLkTinvhF72tWwCEy85jT3Kk2cQZwRyCtBZNcSZk-yA@mail.gmail.com>
	<4C51223A.2070700@domain.hid>
	<AANLkTikib3KYn-m7owo83LKUUMdfPP3=p_g7BPqgb-Gh@domain.hid>
	<4C517FF1.1040902@domain.hid>
	<AANLkTim4HheofHzPvJkMaCtYp49egWmJAzWLM2o3AXJo@domain.hid>
	<4C5198A5.6010002@domain.hid>
	<AANLkTi=s+24Sravpy=r91M9bRoNdKzafopTcngV7rLLv@domain.hid>
	<4C51D317.9020103@domain.hid> <4C51E361.8020102@domain.hid>
	<AANLkTikNB7c3E58Q1kxg99TPUVo3E_deojtzgDvW5asL@mail.gmail.com>
	<AANLkTiktuJ1G6-ELngAsd7kNAR+WtMC7XWcP=-0USZS1@domain.hid>
	<4C61A995.3030906@domain.hid>
	<AANLkTi=Xbz4jQp4hWz38f1rwA=LKJyqcaK=oqBhsYAMY@mail.gmail.com>
	<4C698A2E.7060300@domain.hid>
	<AANLkTimUrZpJMzbMWN=T3rEr=FmxbiVbHYfzviXy08CF@mail.gmail.com>
Date: Thu, 2 Sep 2010 08:29:07 -0300
Message-ID: <AANLkTimzdzPQkPV7FvXwtQ_FBBLVaHmo2oN8mgPnSm+L@mail.gmail.com>
From: Rodolfo Oliveira <rodolforomao@domain.hid>
Content-Type: multipart/alternative; boundary=0015175cdee24c7511048f451ffd
Subject: Re: [Xenomai-core] Bug - Can 2 devices.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>, xenomai@xenomai.org

--0015175cdee24c7511048f451ffd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Worlfgang,

Thank you for your help, I discovered that the problem was in my SOCK
application in user space, not in the kernel. You were very thoughtful,
thank you.

Rodolfo Romao.
Computer Engineer
MBA - IT Governance

2010/8/16 Rodolfo Oliveira <rodolforomao@domain.hid>

> hmm... it's really... ok !
>
> thnks
>
> 2010/8/16 Wolfgang Grandegger <wg@domain.hid>
>
>  On 08/16/2010 08:32 PM, Rodolfo Oliveira wrote:
>> > Hi Wolfgang!
>> > I ran the rtcanrecv but this showing the following message:
>> > #. / Rtcanrecv
>> > / Home / testing / can.libs / lt-rtcanrecv: error while loading shared
>> > libraries: libnative.so.0: can not open shared object file: No such fi=
le
>> or
>> > directory
>> > # Find. Z grep rtcanrecv
>> > . / Can / .svn / text-base / base rtcanrecv.c.svn
>> > . / Can / .deps / rtcanrecv.Po
>> > . / Can / .libs / rtcanrecv
>> > . / Can / .libs / lt-rtcanrecv
>> > . / Can / rtcanrecv
>> > . / Can / rtcanrecv.c
>> > . / Can / rtcanrecv.o
>> >
>> > You know what means this?
>>
>> I did already answer this question. See below.
>>
>> Wolfgang.
>>
>> > 2010/8/10 Wolfgang Grandegger <wg@domain.hid>
>> >
>> >> On 08/10/2010 08:22 PM, Rodolfo Oliveira wrote:
>> >>> Hello Wolf,
>> >>>
>> >>> When trying to run the program rtcanrecv is the following message:
>> >>> . / Rtcanrecv
>> >>> / Home / test / can /. / Libs / lt-rtcanrecv: error while loading
>> shared
>> >>> libraries: libnative.so.0: can not open shared object file: No such
>> file
>> >> or
>> >>> directory.
>> >>>
>> >>> Can you help me?
>> >>
>> >> Either set LD_LIBRARY_PATH pointing to the Xenomai libraries or
>> properly
>> >> install the utilities as described in README.INSTALL.
>> >>
>> >> Wolfgang.
>> >>
>> >
>> >
>> >
>>
>>
>
>
> --
>
> []=B4s
>
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Rodolfo R. de O. Neto, Eng. , MBA
> Engenheiro de computa=E7=E3o
> MBA - Governan=E7a em TI
> E-mail: rodolforomao@domain.hid
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>


--=20

[]=B4s



=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Rodolfo R. de O. Neto, Eng. , MBA
Engenheiro de computa=E7=E3o
MBA - Governan=E7a em TI
E-mail: rodolforomao@domain.hid
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--0015175cdee24c7511048f451ffd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<span style=3D"BACKGROUND-COLOR: #e6ecf9; COLOR: #000" title=3D"">Hello Wor=
lfgang,<br><br></span><span style=3D"BACKGROUND-COLOR: #fff" title=3D"">Tha=
nk you for your help, I discovered that the problem was in my SOCK applicat=
ion in user space, not in the kernel. </span><span title=3D"">You were very=
 thoughtful, thank you.<br>
<br></span><span style=3D"BACKGROUND-COLOR: #fff" title=3D"">Rodolfo Romao.=
<br></span><span title=3D"">Computer Engineer<br></span><span style=3D"BACK=
GROUND-COLOR: #fff" title=3D"">MBA - IT Governance</span><br><br>
<div class=3D"gmail_quote">2010/8/16 Rodolfo Oliveira <span dir=3D"ltr">&lt=
;<a href=3D"mailto:rodolforomao@domain.hid">rodolforomao@domain.hid</a>&gt;</=
span><br>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">hmm... it&#39;s really... ok !<b=
r><br>thnks<br><br>
<div class=3D"gmail_quote">2010/8/16 Wolfgang Grandegger <span dir=3D"ltr">=
&lt;<a href=3D"mailto:wg@domain.hid" target=3D"_blank">wg@domain.hid=
m</a>&gt;</span>=20
<div>
<div></div>
<div class=3D"h5"><br>
<blockquote style=3D"BORDER-LEFT: rgb(204,204,204) 1px solid; MARGIN: 0pt 0=
pt 0pt 0.8ex; PADDING-LEFT: 1ex" class=3D"gmail_quote">
<div>On 08/16/2010 08:32 PM, Rodolfo Oliveira wrote:<br>&gt; Hi Wolfgang!<b=
r>&gt; I ran the rtcanrecv but this showing the following message:<br>&gt; =
#. / Rtcanrecv<br>&gt; / Home / testing / can.libs / lt-rtcanrecv: error wh=
ile loading shared<br>
&gt; libraries: libnative.so.0: can not open shared object file: No such fi=
le or<br>&gt; directory<br>&gt; # Find. Z grep rtcanrecv<br>&gt; . / Can / =
.svn / text-base / base rtcanrecv.c.svn<br>&gt; . / Can / .deps / rtcanrecv=
.Po<br>
&gt; . / Can / .libs / rtcanrecv<br>&gt; . / Can / .libs / lt-rtcanrecv<br>=
&gt; . / Can / rtcanrecv<br>&gt; . / Can / rtcanrecv.c<br>&gt; . / Can / rt=
canrecv.o<br>&gt;<br>&gt; You know what means this?<br><br></div>I did alre=
ady answer this question. See below.<br>
<font color=3D"#888888"><br>Wolfgang.<br></font>
<div>
<div></div>
<div><br>&gt; 2010/8/10 Wolfgang Grandegger &lt;<a href=3D"mailto:wg@domain.hid=
gger.com" target=3D"_blank">wg@domain.hid</a>&gt;<br>&gt;<br>&gt;&gt; O=
n 08/10/2010 08:22 PM, Rodolfo Oliveira wrote:<br>&gt;&gt;&gt; Hello Wolf,<=
br>
&gt;&gt;&gt;<br>&gt;&gt;&gt; When trying to run the program rtcanrecv is th=
e following message:<br>&gt;&gt;&gt; . / Rtcanrecv<br>&gt;&gt;&gt; / Home /=
 test / can /. / Libs / lt-rtcanrecv: error while loading shared<br>&gt;&gt=
;&gt; libraries: libnative.so.0: can not open shared object file: No such f=
ile<br>
&gt;&gt; or<br>&gt;&gt;&gt; directory.<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Can =
you help me?<br>&gt;&gt;<br>&gt;&gt; Either set LD_LIBRARY_PATH pointing to=
 the Xenomai libraries or properly<br>&gt;&gt; install the utilities as des=
cribed in README.INSTALL.<br>
&gt;&gt;<br>&gt;&gt; Wolfgang.<br>&gt;&gt;<br>&gt;<br>&gt;<br>&gt;<br><br><=
/div></div></blockquote></div></div></div><br><br clear=3D"all">
<div>
<div></div>
<div class=3D"h5"><br>-- <br>
<p><span style=3D"COLOR: rgb(31,73,125); FONT-SIZE: 11pt">[]=B4s</span></p>
<p><span style=3D"COLOR: rgb(31,73,125); FONT-SIZE: 11pt"></span></p>
<p><span style=3D"COLOR: rgb(31,73,125); FONT-SIZE: 11pt">=A0</span></p>
<p><span style=3D"COLOR: rgb(31,73,125); FONT-SIZE: 10pt">=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br>Rodolfo R. de O. Neto, Eng. , MBA<br>Engenheiro de compu=
ta=E7=E3o<br>MBA - Governan=E7a em TI<br></span><span style=3D"COLOR: rgb(3=
1,73,125); FONT-SIZE: 10pt">E-mail: <a href=3D"mailto:rodolforomao@domain.hid=
m" target=3D"_blank">rodolforomao@domain.hid</a></span><br>
<span style=3D"COLOR: rgb(31,73,125); FONT-SIZE: 10pt">=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=A0=A0 </span></p><br></div></div></blockquote></div><br><br cl=
ear=3D"all"><br>-- <br>
<p><span style=3D"COLOR: rgb(31,73,125); FONT-SIZE: 11pt">[]=B4s</span></p>
<p><span style=3D"COLOR: rgb(31,73,125); FONT-SIZE: 11pt"></span></p>
<p><span style=3D"COLOR: rgb(31,73,125); FONT-SIZE: 11pt">=A0</span></p>
<p><span style=3D"COLOR: rgb(31,73,125); FONT-SIZE: 10pt">=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br>Rodolfo R. de O. Neto, Eng. , MBA<br>Engenheiro de compu=
ta=E7=E3o<br>MBA - Governan=E7a em TI<br></span><span style=3D"COLOR: rgb(3=
1,73,125); FONT-SIZE: 10pt">E-mail: <a href=3D"mailto:rodolforomao@domain.hid=
m" target=3D"_blank">rodolforomao@domain.hid</a></span><br>
<span style=3D"COLOR: rgb(31,73,125); FONT-SIZE: 10pt">=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=A0=A0 </span></p><br>

--0015175cdee24c7511048f451ffd--

