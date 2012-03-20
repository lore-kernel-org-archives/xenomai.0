MIME-Version: 1.0
In-Reply-To: <623784B6C75D274389918D358E89E8BB0B78F111@domain.hid>
References: <623784B6C75D274389918D358E89E8BB0B78F111@domain.hid>
From: =?ISO-8859-1?Q?Mustafa_=C7AMURLI?= <mustafacamurli@domain.hid>
Date: Tue, 20 Mar 2012 16:31:26 +0200
Message-ID: <CABaqoOMY_R7rzPB6-6CvPYBebXMATK7E9n60y0-vw0kntDEx+A@mail.gmail.com>
Content-Type: multipart/alternative; boundary=14dae934040be1a03a04bbad8817
Subject: Re: [Xenomai-help] How do I increase CPU time limit.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Chris Stone <chris.stone@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

--14dae934040be1a03a04bbad8817
Content-Type: text/plain; charset=ISO-8859-1

make sure that "cpu time" is unlimited. You can check and change it with
"ulimit" util. Use  "limit -a" to list all about limitations.


On Tue, Mar 20, 2012 at 4:09 PM, Chris Stone <chris.stone@domain.hid>wrote:

>  I have a thread which uses a lot of CPU and it is receiving a SIGXCPU:
> Cpu time limit exceeded. Does this message really mean I have exceeded some
> CPU time limit? If so, how do I increase or disable the CPU time limit? The
> code that I am running has been working for quite some time under regular
> Linux and I have just ported it to Xenomai, so I doubt there are any
> infinite loops in it.****
>
> ** **
>
> *Chris Stone*
>
> Senior Software Engineer****
>
> Optelian****
>
> 1 Brewer Hunt Way****
>
> Ottawa, Ontario K2K 2B5****
>
> ** **
>
> Phone: 613-287-2000 x2106****
>
> ** **
>
> *www.optelian.com*****
>
> ** **
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>


-- 
MC

--14dae934040be1a03a04bbad8817
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

make sure that &quot;cpu time&quot; is unlimited. You can check and change =
it with &quot;ulimit&quot; util. Use=A0
&quot;limit -a&quot; to=A0list all about limitations.<br><br><div class=3D"=
gmail_quote"><br></div><div class=3D"gmail_quote">On Tue, Mar 20, 2012 at 4=
:09 PM, Chris Stone <span dir=3D"ltr">&lt;<a href=3D"mailto:chris.stone@domain.hid=
elian.com">chris.stone@domain.hid</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">





<div lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div>
<p class=3D"MsoNormal">I have a thread which uses a lot of CPU and it is re=
ceiving a SIGXCPU: Cpu time limit exceeded. Does this message really mean I=
 have exceeded some CPU time limit? If so, how do I increase or disable the=
 CPU time limit? The code that I am
 running has been working for quite some time under regular Linux and I hav=
e just ported it to Xenomai, so I doubt there are any infinite loops in it.=
<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=A0<u></u></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Verdana&quot;,&quot;sans-serif&quot;;color:#00568d">Chris Stone<u></u><u><=
/u></span></b></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ver=
dana&quot;,&quot;sans-serif&quot;">Senior Software Engineer<u></u><u></u></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ver=
dana&quot;,&quot;sans-serif&quot;">Optelian<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ver=
dana&quot;,&quot;sans-serif&quot;">1 Brewer Hunt Way<u></u><u></u></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ver=
dana&quot;,&quot;sans-serif&quot;">Ottawa, Ontario K2K 2B5<u></u><u></u></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ver=
dana&quot;,&quot;sans-serif&quot;"><u></u>=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ver=
dana&quot;,&quot;sans-serif&quot;">Phone: <a href=3D"tel:613-287-2000%20x21=
06" value=3D"+16132872000" target=3D"_blank">613-287-2000 x2106</a><u></u><=
u></u></span></p>


<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ver=
dana&quot;,&quot;sans-serif&quot;"><u></u>=A0<u></u></span></p>
<p class=3D"MsoNormal"><u><span style=3D"font-size:8.0pt;font-family:&quot;=
Verdana&quot;,&quot;sans-serif&quot;;color:#00568d"><a href=3D"http://www.o=
ptelian.com" target=3D"_blank"><span style=3D"color:blue">www.optelian.com<=
/span></a></span></u><u></u><u></u></p>


<p class=3D"MsoNormal"><u></u>=A0<u></u></p>
</div>
</div>

<br>_______________________________________________<br>
Xenomai-help mailing list<br>
<a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-help</a><br>
<br></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>MC<br>

--14dae934040be1a03a04bbad8817--

