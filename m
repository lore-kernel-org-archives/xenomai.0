MIME-Version: 1.0
In-Reply-To: <76E258664B189C4CBEF125491CA11ECC945B6553D6@domain.hid>
References: <76E258664B189C4CBEF125491CA11ECC945B6553D4@domain.hid>
	<1284478817.2345.5.camel@domain.hid>
	<76E258664B189C4CBEF125491CA11ECC945B6553D5@domain.hid>
	<4C9092BE.4050206@domain.hid>
	<76E258664B189C4CBEF125491CA11ECC945B6553D6@domain.hid>
Date: Wed, 15 Sep 2010 13:02:05 +0200
Message-ID: <AANLkTinHWE01hmvM_zAEbcYX_ccyoVchB4YoUeAGYZAo@domain.hid>
From: Willy Lambert <lambert.willy@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6da7daa94160304904a42df
Subject: Re: [Xenomai-help] HELP: Xenomai: POSIX skin or
 CONFIG_XENO_OPT_PERVASIVE disabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Zafar Iqbal <Zafar.Iqbal2@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

--0016e6da7daa94160304904a42df
Content-Type: text/plain; charset=ISO-8859-1

As a suggestion this is what I use :


Power management and ACPI Options ---> disable all options, including  into
CPU Frequency scaly (disable the first line CPU Frequency Scaling)

Device Drivers -->  Input device support --> Miscellaneous devices (disable
PC Speaker support)


this should correct the 2 first warnings, for the last one I am not sure but
It is maybe because you did not choose the right processor in :

Processor Type and features->


2010/9/15 Zafar Iqbal <Zafar.Iqbal2@domain.hid>

> Thanks for your mail Stefan.
>
> Can you please suggest me what are the kernel option and how can I disable
> them.
>
>
> Thanks and regards,
> Zafar
> ________________________________________
> From: Stefan Kisdaroczi [kisda@domain.hid]
> Sent: Wednesday, September 15, 2010 3:02 PM
> To: Zafar Iqbal
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] HELP: Xenomai: POSIX skin or
> CONFIG_XENO_OPT_PERVASIVE disabled
>
> Hi,
>
> On 15.09.2010 10:46, Zafar Iqbal wrote:
> > Thanks for your mail Sir,
> >
> > I have a doubt over here That My Kernel is not getting patched correctly.
> >
> It looks correctly patched.
> > As per the Suggestion of ED Hoffman.
> >
> > I went to the Real-time-Subsystem  after invoking the make menuconfig.
> but I did not get any option over there.
> >
>
> Some standard kernel options cause troubles with a realtime kernel, so
> you need to disable them to be able to activate the realtime subsystem.
>
> The problematic options are listed on your 2nd screenshot. If you have
> disabled them, go back to the "real-time subsystem"-menu and instead of
> the warning you should see the realtime options.
>
> Regards Stefan
>
> > I am attaching the snapshots taken by me after selecting the
>  Real-time-Subsystem.
> > Kindly review it and please suggest is it ok,  unless what has to be
> done.
> >
> >
> > Thanks and Regards,
> > Zafar
> > ________________________________________
> > From: Edward Hoffman [quantalgo@domain.hid]
> > Sent: Tuesday, September 14, 2010 9:10 PM
> > To: Zafar Iqbal
> > Cc: Xenomai-help@domain.hid
> > Subject: Re: [Xenomai-help] HELP: Xenomai: POSIX skin or
> CONFIG_XENO_OPT_PERVASIVE disabled
> >
> > Zafar,
> >
> > Rebuild the kernel after selecting support for pervasive:
> >
> > Real-time subsystem --->
> >      [*]Pervasive real-time support in user space
> >
> > Regards,
> >
> > Ed
> >
> >
> >
> > On Tue, 2010-09-14 at 16:45 +0530, Zafar Iqbal wrote:
> >
> >> Dear Sir,
> >>
> >>
> >> I Installed the Xenomai Successfully in MY System with Ubuntu 10.04.
> >> Operationg System: Ubuntu 10.4
> >> Xenomai Version: 2.5.4.
> >> refrence for the installation:
> http://www.xenomai.org/index.php/Building_Debian_packages
> >>
> >>
> >>
> >> later I compiled the example code provided in the xenomai folder and i
> got compiled sucessfully but while running the executable I am getting the
> following different error:
> >>
> >> for POSIX Code:
> >> root@domain.hid# ./satch
> >> Xenomai: POSIX skin or CONFIG_XENO_OPT_PERVASIVE disabled.
> >> (modprobe xeno_posix?)
> >>
> >> for native code
> >>
> >> root@domain.hid# ./rtprint
> >> Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
> >> (modprobe xeno_native?)
> >> root@domain.hid#
> >>
> >>
> >> Please Suggest Me whats wrong here in the above code.
> >>
> >> Thanks and Regards
> >> Zafar
> >>
> >>
> >>
> >> _______________________________________________
> >> Xenomai-help mailing list
> >> Xenomai-help@domain.hid
> >> https://mail.gna.org/listinfo/xenomai-help
> >>
> >
> >
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> >
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

--0016e6da7daa94160304904a42df
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable





<p class=3D"MsoNoSpacing">As a suggestion this is what I use :<br></p><p cl=
ass=3D"MsoNoSpacing"><br></p><p class=3D"MsoNoSpacing">Power management and=
 ACPI Options ---&gt;<span style=3D""> disable all options, including=A0</s=
pan> into CPU Frequency scaly (disable the first line CPU Frequency Scaling=
)</p>


<p class=3D"MsoNoSpacing">Device Drivers --&gt;=A0 Input device support --&=
gt; Miscellaneous devices
(disable PC Speaker support)</p><p class=3D"MsoNoSpacing"><br></p><p class=
=3D"MsoNoSpacing">this should correct the 2 first warnings, for the last on=
e I am not sure but It is maybe because you did not choose the right proces=
sor in :</p>
<p class=3D"MsoNoSpacing"><span style=3D"font-size: 10pt; font-family: &quo=
t;Arial&quot;,&quot;sans-serif&quot;;">Processor Type and features-&gt; </s=
pan></p>

<br><br><div class=3D"gmail_quote">2010/9/15 Zafar Iqbal <span dir=3D"ltr">=
&lt;<a href=3D"mailto:Zafar.Iqbal2@domain.hid">Zafar.Iqbal2@domain.hid=
s.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin: =
0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left:=
 1ex;">
Thanks for your mail Stefan.<br>
<br>
Can you please suggest me what are the kernel option and how can I disable =
them.<br>
<br>
<br>
Thanks and regards,<br>
Zafar<br>
________________________________________<br>
From: Stefan Kisdaroczi [<a href=3D"mailto:kisda@domain.hid">kisda@domain.hid.=
ch</a>]<br>
Sent: Wednesday, September 15, 2010 3:02 PM<br>
<div><div></div><div class=3D"h5">To: Zafar Iqbal<br>
Cc: <a href=3D"mailto:xenomai@xenomai.org">xenomai@xenomai.org</a><br>
Subject: Re: [Xenomai-help] HELP: Xenomai: POSIX skin or CONFIG_XENO_OPT_PE=
RVASIVE disabled<br>
<br>
Hi,<br>
<br>
On 15.09.2010 10:46, Zafar Iqbal wrote:<br>
&gt; Thanks for your mail Sir,<br>
&gt;<br>
&gt; I have a doubt over here That My Kernel is not getting patched correct=
ly.<br>
&gt;<br>
It looks correctly patched.<br>
&gt; As per the Suggestion of ED Hoffman.<br>
&gt;<br>
&gt; I went to the Real-time-Subsystem =A0after invoking the make menuconfi=
g. but I did not get any option over there.<br>
&gt;<br>
<br>
Some standard kernel options cause troubles with a realtime kernel, so<br>
you need to disable them to be able to activate the realtime subsystem.<br>
<br>
The problematic options are listed on your 2nd screenshot. If you have<br>
disabled them, go back to the &quot;real-time subsystem&quot;-menu and inst=
ead of<br>
the warning you should see the realtime options.<br>
<br>
Regards Stefan<br>
<br>
&gt; I am attaching the snapshots taken by me after selecting the =A0Real-t=
ime-Subsystem.<br>
&gt; Kindly review it and please suggest is it ok, =A0unless what has to be=
 done.<br>
&gt;<br>
&gt;<br>
&gt; Thanks and Regards,<br>
&gt; Zafar<br>
&gt; ________________________________________<br>
&gt; From: Edward Hoffman [<a href=3D"mailto:quantalgo@domain.hid">quant=
algo@domain.hid</a>]<br>
&gt; Sent: Tuesday, September 14, 2010 9:10 PM<br>
&gt; To: Zafar Iqbal<br>
&gt; Cc: <a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><b=
r>
&gt; Subject: Re: [Xenomai-help] HELP: Xenomai: POSIX skin or CONFIG_XENO_O=
PT_PERVASIVE disabled<br>
&gt;<br>
&gt; Zafar,<br>
&gt;<br>
&gt; Rebuild the kernel after selecting support for pervasive:<br>
&gt;<br>
&gt; Real-time subsystem ---&gt;<br>
&gt; =A0 =A0 =A0[*]Pervasive real-time support in user space<br>
&gt;<br>
&gt; Regards,<br>
&gt;<br>
&gt; Ed<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Tue, 2010-09-14 at 16:45 +0530, Zafar Iqbal wrote:<br>
&gt;<br>
&gt;&gt; Dear Sir,<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; I Installed the Xenomai Successfully in MY System with Ubuntu 10.0=
4.<br>
&gt;&gt; Operationg System: Ubuntu 10.4<br>
&gt;&gt; Xenomai Version: 2.5.4.<br>
&gt;&gt; refrence for the installation: <a href=3D"http://www.xenomai.org/i=
ndex.php/Building_Debian_packages" target=3D"_blank">http://www.xenomai.org=
/index.php/Building_Debian_packages</a><br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; later I compiled the example code provided in the xenomai folder a=
nd i got compiled sucessfully but while running the executable I am getting=
 the following different error:<br>
&gt;&gt;<br>
&gt;&gt; for POSIX Code:<br>
&gt;&gt; root@domain.hid# ./satch<br>
&gt;&gt; Xenomai: POSIX skin or CONFIG_XENO_OPT_PERVASIVE disabled.<br>
&gt;&gt; (modprobe xeno_posix?)<br>
&gt;&gt;<br>
&gt;&gt; for native code<br>
&gt;&gt;<br>
&gt;&gt; root@domain.hid# ./rtprint<br>
&gt;&gt; Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.<br>
&gt;&gt; (modprobe xeno_native?)<br>
&gt;&gt; root@domain.hid#<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Please Suggest Me whats wrong here in the above code.<br>
&gt;&gt;<br>
&gt;&gt; Thanks and Regards<br>
&gt;&gt; Zafar<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; Xenomai-help mailing list<br>
&gt;&gt; <a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><b=
r>
&gt;&gt; <a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_=
blank">https://mail.gna.org/listinfo/xenomai-help</a><br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Xenomai-help mailing list<br>
&gt; <a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
&gt; <a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blan=
k">https://mail.gna.org/listinfo/xenomai-help</a><br>
&gt;<br>
<br>
<br>
<br>
_______________________________________________<br>
Xenomai-help mailing list<br>
<a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-help</a><br>
</div></div></blockquote></div><br>

--0016e6da7daa94160304904a42df--

