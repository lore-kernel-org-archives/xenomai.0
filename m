Date: Fri, 15 Oct 2010 15:13:23 +0100 (BST)
From: edward.robbins@domain.hid
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_20101015151323000000_34691"
In-Reply-To: <4CB85C64.9040307@domain.hid>
References: <1281709057.650414331@domain.hid>
	<4C65583D.3030800@domain.hid> 
	<1281960823.030215299@domain.hid> <4C692FC3.5040802@domain.hid> 
	<1283531433.789315367@domain.hid>   
	<1283590285.1709.2153.camel@domain.hid>  
	<1287134519.029617765@domain.hid> 
	<1287143691.028416668@domain.hid> <4CB85C64.9040307@domain.hid>
Message-ID: <1287152003.579923730@domain.hid>
Subject: Re: [Xenomai-help] Very high latencies under stress testing
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

------=_20101015151323000000_34691
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Will do. Should I leave in Philippes patch? I will assume no for now...=0A=
=0AOn Friday, 15 October, 2010 2:51pm, "Gilles Chanteperdrix" <gilles.chant=
eperdrix@domain.hid> said:=0A=0A> edward.robbins@domain.hid =
wrote:=0A> > I am also finding that tasks are frequently hanging, causing=
=0A> > ipipetraces with "INFO: task xxx:xxx blocked for more than 120=0A> >=
 seconds". Ihave just had this with apt-get update, and was previously=0A> =
> getting itwith grub-install. Could this be related?=0A> =0A> Yes. There i=
s obviously an issue in your patched kernel, we need to find=0A> this first=
 before we draw any conclusion from any other behaviour.=0A> =0A> From the =
trace you sent, it looks like it happens in the MTRR code, but=0A> it could=
 also be an SMI, or some other bug. For debugging purposes,=0A> could you t=
ry disabling MTRRs in the kernel configuration?=0A> =0A> --=0A> =09=09=09=
=09=09    Gilles.=0A> =0A
------=_20101015151323000000_34691
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<font face=3D"arial" size=3D"2">Will do. Should I leave in Philippes patch?=
 I will assume no for now...<br><br>On Friday, 15 October, 2010 2:51pm, "Gi=
lles Chanteperdrix" &lt;gilles.chanteperdrix@xenomai.org&gt; said:<br><br>&=
gt; edward.robbins@domain.hid wrote:<br>&gt; &gt; I am also f=
inding that tasks are frequently hanging, causing<br>&gt; &gt; ipipetraces =
with "INFO: task xxx:xxx blocked for more than 120<br>&gt; &gt; seconds". I=
have just had this with apt-get update, and was previously<br>&gt; &gt; get=
ting itwith grub-install. Could this be related?<br>&gt; <br>&gt; Yes. Ther=
e is obviously an issue in your patched kernel, we need to find<br>&gt; thi=
s first before we draw any conclusion from any other behaviour.<br>&gt; <br=
>&gt; From the trace you sent, it looks like it happens in the MTRR code, b=
ut<br>&gt; it could also be an SMI, or some other bug. For debugging purpos=
es,<br>&gt; could you try disabling MTRRs in the kernel configuration?<br>&=
gt; <br>&gt; --<br>&gt; =09=09=09=09=09    Gilles.<br>&gt; <br></font>
------=_20101015151323000000_34691--


