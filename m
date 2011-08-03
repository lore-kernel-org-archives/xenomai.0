From: Sambasiva Rao Manchili <sambasiva.manchili@domain.hid>
Date: Wed, 3 Aug 2011 16:30:26 +0200
Message-ID: <509DA52866E38F47878413CF102D751FD4207794FB@poseidon.nexus-ag.com>
References: <509DA52866E38F47878413CF102D751FD4207794F0@domain.hid>
	<1312370844.2135.10.camel@domain.hid>
	<509DA52866E38F47878413CF102D751FD4207794F2@domain.hid>
	<4E394A78.7040408@domain.hid>
	<509DA52866E38F47878413CF102D751FD4207794F8@domain.hid>
	<1312379588.2135.12.camel@domain.hid>
In-Reply-To: <1312379588.2135.12.camel@domain.hid>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_509DA52866E38F47878413CF102D751FD4207794FBposeidonnexus_"
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai VxWorks Skin--->semTake
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Antonio Gambin <antonio.gambin@domain.hid>, "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

--_000_509DA52866E38F47878413CF102D751FD4207794FBposeidonnexus_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,
Why do you say that I try to grab the mutex from non-xenomai thread context=
 ?
During porting we had written main() only this main function does pthread_c=
reate to call the very first function of VxWorks code which inturn does tas=
kSpawn. All the taskSpawns has to go through Xenomai thread context right ?

Samba.


-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org]
Sent: Wednesday, 03. August, 2011 15:53
To: Sambasiva Rao Manchili
Cc: Gilles Chanteperdrix; Antonio Gambin; Xenomai-help@domain.hid
Subject: RE: [Xenomai-help] Xenomai VxWorks Skin--->semTake

On Wed, 2011-08-03 at 15:31 +0200, Sambasiva Rao Manchili wrote:
> Hi Gilles,
> I had seen the code  in src\skins\vxworks\semLib.c it returns ERROR which=
 is -1.
>
> The value that I sent earlier is the value that I got out of the followin=
g statement.
> serrLog( serrErr,
>              "resu_getonline_1_svc: semTake for restab_access_smp failed!=
!<%s>",
>               strerror(errnoGet()));
>
> Is it right ?
>
>
> Now again I tried with
>  serrLog( serrErr,
>              "resu_getonline_1_svc: semTake for restab_access_smp failed!=
!<%s> <%d>",
>               strerror(errnoGet()), errno);
>
> Here I get value 1 for errno.

You are trying to grab the mutex from a non-Xenomai thread context. This is=
 invalid.

>
> Samba.
> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Wednesday, 03. August, 2011 15:18
> To: Sambasiva Rao Manchili
> Cc: Philippe Gerum; Antonio Gambin; Xenomai-help@domain.hid
> Subject: Re: [Xenomai-help] Xenomai VxWorks Skin--->semTake
>
> On 08/03/2011 02:44 PM, Sambasiva Rao Manchili wrote:
> > Hi Philppe,
> > Failed and return with error code is  <Unknown error 4294967295> and co=
ntinues. I do not know the granularity of time  here, if it is returning im=
mediately or not.
> > We have about 15 tasks spawned in this whole system. Done very very min=
imal changes to our VxWorks code to run on Linux over Xenomai version 2.5.6=
.   Board does not crash.
> > CPU Platform is Intel x86 Arch 32 Bit.
>
> semTake does not return error code directly, it returns ERROR (which is -=
1, or 4294967295 if you cast to unsigned), and the real error is in the err=
no variable.
>
> --
>                                             Gilles.
>
>
> This email and any attachment may contain confidential information which =
is intended for use only by the addressee(s) named above. If you received t=
his email by mistake, please notify the sender immediately, and delete the =
email from your system. You are prohibited from copying, disseminating or o=
therwise using the email or any attachment.
>

--
Philippe.





  ________________________________
This email and any attachment may contain confidential information which is=
 intended for use only by the addressee(s) named above. If you received thi=
s email by mistake, please notify the sender immediately, and delete the em=
ail from your system. You are prohibited from copying, disseminating or oth=
erwise using the email or any attachment.

--_000_509DA52866E38F47878413CF102D751FD4207794FBposeidonnexus_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial, sans-serif" size=3D"2">
<div>Hi Philippe,</div>
<div>Why do you say that I try to grab the mutex from non-xenomai thread co=
ntext ?</div>
<div>During porting we had written main() only this main function does pthr=
ead_create to <u>call the very first function of VxWorks </u>code which int=
urn <font face=3D"Arial, sans-serif">does taskSpawn. All the taskSpawns has=
 to go through Xenomai thread context
right ?</font></div>
<div><font face=3D"Arial, sans-serif">&nbsp;</font></div>
<div><font face=3D"Arial, sans-serif">Samba.</font></div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>-----Original Message-----</div>
<div>From: Philippe Gerum [<a href=3D"mailto:rpm@xenomai.org"><font color=
=3D"#0000FF"><u>mailto:rpm@xenomai.org</u></font></a>] </div>
<div>Sent: Wednesday, 03. August, 2011 15:53</div>
<div>To: Sambasiva Rao Manchili</div>
<div>Cc: Gilles Chanteperdrix; Antonio Gambin; Xenomai-help@domain.hid</div>
<div>Subject: RE: [Xenomai-help] Xenomai VxWorks Skin---&gt;semTake</div>
<div>&nbsp;</div>
<div>On Wed, 2011-08-03 at 15:31 &#43;0200, Sambasiva Rao Manchili wrote:</=
div>
<div>&gt; Hi Gilles,</div>
<div>&gt; I had seen the code&nbsp; in src\skins\vxworks\semLib.c it return=
s ERROR which is -1.</div>
<div>&gt; </div>
<div>&gt; The value that I sent earlier is the value that I got out of the =
following statement.</div>
<div>&gt; serrLog( serrErr,</div>
<div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &quot;resu_getonline_1_svc: semTake for restab_access_smp fail=
ed!!&lt;%s&gt;&quot;,</div>
<div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; strerror(errnoGet()));</div>
<div>&gt; </div>
<div>&gt; Is it right ?</div>
<div>&gt; </div>
<div>&gt; </div>
<div>&gt; Now again I tried with</div>
<div>&gt;&nbsp; serrLog( serrErr,</div>
<div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &quot;resu_getonline_1_svc: semTake for restab_access_smp fail=
ed!!&lt;%s&gt; &lt;%d&gt;&quot;,</div>
<div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; strerror(errnoGet()), errno);</div>
<div>&gt; </div>
<div>&gt; Here I get value 1 for errno.</div>
<div>&nbsp;</div>
<div>You are trying to grab the mutex from a non-Xenomai thread context. Th=
is is invalid.</div>
<div>&nbsp;</div>
<div>&gt; </div>
<div>&gt; Samba.</div>
<div>&gt; -----Original Message-----</div>
<div>&gt; From: Gilles Chanteperdrix [<a href=3D"mailto:gilles.chanteperdri=
x@domain.hid"><font color=3D"#0000FF"><u>mailto:gilles.chanteperdrix@xenomai.org=
ai.org</u></font></a>]</div>
<div>&gt; Sent: Wednesday, 03. August, 2011 15:18</div>
<div>&gt; To: Sambasiva Rao Manchili</div>
<div>&gt; Cc: Philippe Gerum; Antonio Gambin; Xenomai-help@domain.hid</div>
<div>&gt; Subject: Re: [Xenomai-help] Xenomai VxWorks Skin---&gt;semTake</d=
iv>
<div>&gt; </div>
<div>&gt; On 08/03/2011 02:44 PM, Sambasiva Rao Manchili wrote:</div>
<div>&gt; &gt; Hi Philppe,</div>
<div>&gt; &gt; Failed and return with error code is&nbsp; &lt;Unknown error=
 4294967295&gt; and continues. I do not know the granularity of time&nbsp; =
here, if it is returning immediately or not.</div>
<div>&gt; &gt; We have about 15 tasks spawned in this whole system. Done ve=
ry very minimal changes to our VxWorks code to run on Linux over Xenomai ve=
rsion 2.5.6.&nbsp;&nbsp; Board does not crash.</div>
<div>&gt; &gt; CPU Platform is Intel x86 Arch 32 Bit.</div>
<div>&gt; </div>
<div>&gt; semTake does not return error code directly, it returns ERROR (wh=
ich is -1, or 4294967295 if you cast to unsigned), and the real error is in=
 the errno variable.</div>
<div>&gt; </div>
<div>&gt; --</div>
<div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gilles.</div>
<div>&gt; </div>
<div>&gt; </div>
<div>&gt; This email and any attachment may contain confidential informatio=
n which is intended for use only by the addressee(s) named above. If you re=
ceived this email by mistake, please notify the sender immediately, and del=
ete the email from your system. You
are prohibited from copying, disseminating or otherwise using the email or =
any attachment.</div>
<div>&gt; </div>
<div>&nbsp;</div>
<div>--</div>
<div>Philippe.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div><font size=3D"3"><br>

</font></div>
<div><font size=3D"3" color=3D"#0000FF"><u>&nbsp; _________________________=
_______ &nbsp;</u></font></div>
<div><font face=3D"Arial, sans-serif" size=3D"1" color=3D"#808080">This ema=
il and any attachment may contain confidential information which is intende=
d for use only by the addressee(s) named above. If you received this email =
by mistake, please notify the sender immediately,
and delete the email from your system. You are prohibited from copying, dis=
seminating or otherwise using the email or any attachment.<br>

</font></div>
</font>
</body>
</html>

--_000_509DA52866E38F47878413CF102D751FD4207794FBposeidonnexus_--


