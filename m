MIME-Version: 1.0
In-Reply-To: <4B744CA8.6090201@domain.hid>
References: <8b216e9e1002100327h3aa332ddl13ec590fcb81f0b7@domain.hid> 
	<4B729B04.9010909@domain.hid>
	<8b216e9e1002100349y71f40d9ct9cbf496846f33f2e@domain.hid> 
	<8b216e9e1002100358u71d73d36xb851e59e23e069d1@domain.hid> 
	<4B72C18F.20903@domain.hid>
	<8b216e9e1002101128t1246a5deh28ca13229f1d688d@domain.hid> 
	<8b216e9e1002111005h6b432bcby17d4127d3b9d385a@domain.hid> 
	<4B744CA8.6090201@domain.hid>
From: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Date: Thu, 11 Feb 2010 16:39:17 -0200
Message-ID: <8b216e9e1002111039y6eea3ab6n9066a4338dac35f9@domain.hid>
Content-Type: multipart/mixed; boundary=000e0cd1500219c1a3047f5779c6
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

--000e0cd1500219c1a3047f5779c6
Content-Type: multipart/alternative; boundary=000e0cd1500219c19b047f5779c4

--000e0cd1500219c19b047f5779c4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2010/2/11 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Felipe Brand=E3o Cavalcanti wrote:
> > OK, so I did test it - the programs seem to run, but Xenomai doesn't se=
em
> to
> > be working.
> >
> > When I run the latency test, I get the following output:
> >
> > =3D=3D Sampling period: 1000 us
> > =3D=3D Test mode: periodic user-mode task
> > =3D=3D All results in microseconds
> > warming up...
> > latency: failed to set periodic, code -110
> >
> > Anyone has a clue on what's going on? I am tweaking the kernel options
> > hoping to make it work.
>
> Very likely, the current linux clockevent is not the one supported by
> Xenomai. cat /proc/timer_list will tell you which driver is used for
> clock events.
>
> The one supoprted by Xenomai is the one called:
> "gp timer"
>
> If it is not the one you have, then you have to disabled the
> configuration option corresponding to the timer used.
>
>
Well, my timer seems to be gp timer.. I've attached the output of the
/proc/timer_list.


>  --
> Gilles Chanteperdrix, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
>
>


--=20
      -Felipe Brand=E3o Cavalcanti
      LARA - Robotics and Automation Laboratory
      Department of Electrical Engineering
      UnB - University of Bras=EDlia, Brazil
      http://www.lara.unb.br/~fbcavalcanti/

--000e0cd1500219c19b047f5779c4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote">2010/2/11 Gilles Chanteperdrix <span dir=3D"=
ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.=
chanteperdrix@domain.hid</a>&gt;</span><br><blockquote class=3D"gma=
il_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0=
pt 0pt 0.8ex; padding-left: 1ex;">

<div class=3D"im">Felipe Brand=E3o Cavalcanti wrote:<br>
&gt; OK, so I did test it - the programs seem to run, but Xenomai doesn&#39=
;t seem to<br>
&gt; be working.<br>
&gt;<br>
&gt; When I run the latency test, I get the following output:<br>
&gt;<br>
&gt; =3D=3D Sampling period: 1000 us<br>
&gt; =3D=3D Test mode: periodic user-mode task<br>
&gt; =3D=3D All results in microseconds<br>
&gt; warming up...<br>
&gt; latency: failed to set periodic, code -110<br>
&gt;<br>
&gt; Anyone has a clue on what&#39;s going on? I am tweaking the kernel opt=
ions<br>
&gt; hoping to make it work.<br>
<br>
</div>Very likely, the current linux clockevent is not the one supported by=
<br>
Xenomai. cat /proc/timer_list will tell you which driver is used for<br>
clock events.<br>
<br>
The one supoprted by Xenomai is the one called:<br>
&quot;gp timer&quot;<br>
<br>
If it is not the one you have, then you have to disabled the<br>
configuration option corresponding to the timer used.<br>
<font color=3D"#888888"><br></font></blockquote><div><br>Well, my timer see=
ms to be gp timer.. I&#39;ve attached the output of the /proc/timer_list.<b=
r>=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px soli=
d rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<font color=3D"#888888">
--<br>
</font><div><div></div><div class=3D"h5">Gilles Chanteperdrix, Free Electro=
ns<br>
Kernel, drivers, real-time and embedded Linux<br>
development, consulting, training and support.<br>
<a href=3D"http://free-electrons.com" target=3D"_blank">http://free-electro=
ns.com</a><br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br> =A0 =A0 =
=A0 -Felipe Brand=E3o Cavalcanti<br> =A0 =A0 =A0 LARA - Robotics and Automa=
tion Laboratory<br> =A0 =A0 =A0 Department of Electrical Engineering<br> =
=A0 =A0 =A0 UnB - University of Bras=EDlia, Brazil<br>

 =A0 =A0 =A0 <a href=3D"http://www.lara.unb.br/~fbcavalcanti/">http://www.l=
ara.unb.br/~fbcavalcanti/</a><br>

--000e0cd1500219c19b047f5779c4--

--000e0cd1500219c1a3047f5779c6
Content-Type: application/octet-stream; name=timer_list_log
Content-Disposition: attachment; filename=timer_list_log
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5jw8fvb0

cm9vdEBpZ2VwMDAyMGI6L3Vzci94ZW5vbWFpL2JpbiMgY2F0IC9wcm9jL3RpbWVyX2xpc3QgClRp
bWVyIExpc3QgVmVyc2lvbjogdjAuNApIUlRJTUVSX01BWF9DTE9DS19CQVNFUzogMgpub3cgYXQg
MTM2NDE0ODk2NTA1MCBuc2VjcwoKY3B1OiAwCiBjbG9jayAwOgogIC5iYXNlOiAgICAgICBiMDRk
YzMwMAogIC5pbmRleDogICAgICAwCiAgLnJlc29sdXRpb246IDEgbnNlY3MKICAuZ2V0X3RpbWU6
ICAga3RpbWVfZ2V0X3JlYWwKICAub2Zmc2V0OiAgICAgOTQ2Njg0Nzk2NzY5NDg0NDczIG5zZWNz
CmFjdGl2ZSB0aW1lcnM6CiBjbG9jayAxOgogIC5iYXNlOiAgICAgICBiMDRkYzMzMAogIC5pbmRl
eDogICAgICAxCiAgLnJlc29sdXRpb246IDEgbnNlY3MKICAuZ2V0X3RpbWU6ICAga3RpbWVfZ2V0
CiAgLm9mZnNldDogICAgIDAgbnNlY3MKYWN0aXZlIHRpbWVyczoKICMwOiA8YjA1NDg5NjA+LCB0
aWNrX3NjaGVkX3RpbWVyLCBTOjAxLCB0aWNrX25vaHpfcmVzdGFydF9zY2hlZF90aWNrLCBzd2Fw
cGVyLzAKICMgZXhwaXJlcyBhdCAxMzY0MTUwMDAwMDAwLTEzNjQxNTAwMDAwMDAgbnNlY3MgW2lu
IDEwMzQ5NTAgdG8gMTAzNDk1MCBuc2Vjc10KICMxOiA8Y2Y4MjNhYTg+LCBocnRpbWVyX3dha2V1
cCwgUzowMSwgc2NoZWR1bGVfaHJ0aW1lb3V0X3JhbmdlLCBpbml0LzEKICMgZXhwaXJlcyBhdCAx
MzY1MjYzNTMyMjc3LTEzNjUyNjg1MzIyNzMgbnNlY3MgW2luIDExMTQ1NjcyMjcgdG8gMTExOTU2
NzIyMyBuc2Vjc10KICMyOiA8Y2VjNTVhYTg+LCBocnRpbWVyX3dha2V1cCwgUzowMSwgc2NoZWR1
bGVfaHJ0aW1lb3V0X3JhbmdlLCBkcm9wYmVhci8xMTA2CiAjIGV4cGlyZXMgYXQgMTQxMTM0OTAy
MTIwMy0xNDExNDA5MDIxMTk5IG5zZWNzIFtpbiA0NzIwMDA1NjE1MyB0byA0NzI2MDA1NjE0OSBu
c2Vjc10KICAuZXhwaXJlc19uZXh0ICAgOiAxMzY0MTUwMDAwMDAwIG5zZWNzCiAgLmhyZXNfYWN0
aXZlICAgIDogMQogIC5ucl9ldmVudHMgICAgICA6IDcxMzA5OAogIC5ub2h6X21vZGUgICAgICA6
IDIKICAuaWRsZV90aWNrICAgICAgOiAxMzYzNDAwMDAwMDAwIG5zZWNzCiAgLnRpY2tfc3RvcHBl
ZCAgIDogMAogIC5pZGxlX2ppZmZpZXMgICA6IDEwNjM0MAogIC5pZGxlX2NhbGxzICAgICA6IDY1
Nzc2NTkKICAuaWRsZV9zbGVlcHMgICAgOiA2MjUzMzQwCiAgLmlkbGVfZW50cnl0aW1lIDogMTM2
Mzc0MTk1MDk3OCBuc2VjcwogIC5pZGxlX3dha2V0aW1lICA6IDEzNjQxNDMwMTY1ODggbnNlY3MK
ICAuaWRsZV9leGl0dGltZSAgOiAxMzY0MTQzMDkyNzQyIG5zZWNzCiAgLmlkbGVfc2xlZXB0aW1l
IDogOTE5NTk5MzQ0MDA0IG5zZWNzCiAgLmxhc3RfamlmZmllcyAgIDogMTA2Mzc0CiAgLm5leHRf
amlmZmllcyAgIDogMTA2Mzc1CiAgLmlkbGVfZXhwaXJlcyAgIDogMTM2Mzc1MDAwMDAwMCBuc2Vj
cwpqaWZmaWVzOiAxMDY0MTQKCgpUaWNrIERldmljZTogbW9kZTogICAgIDEKUGVyIENQVSBkZXZp
Y2U6IDAKQ2xvY2sgRXZlbnQgRGV2aWNlOiBncCB0aW1lcgogbWF4X2RlbHRhX25zOiAgIDQyOTQ5
NjcyOTUKIG1pbl9kZWx0YV9uczogICA5MTU1MwogbXVsdDogICAgICAgICAgIDEKIHNoaWZ0OiAg
ICAgICAgICAwCiBtb2RlOiAgICAgICAgICAgMwogbmV4dF9ldmVudDogICAgIDEzNjQxNTAwMDAw
MDAgbnNlY3MKIHNldF9uZXh0X2V2ZW50OiB4bmFyY2hfbmV4dF9odGlja19zaG90CiBzZXRfbW9k
ZTogICAgICAgeG5hcmNoX3N3aXRjaF9odGlja19tb2RlCiBldmVudF9oYW5kbGVyOiAgaHJ0aW1l
cl9pbnRlcnJ1cHQKCg==
--000e0cd1500219c1a3047f5779c6--

