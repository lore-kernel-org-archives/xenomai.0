Message-ID: <7289437c0706062254v2a386894oeb498459877d5086@domain.hid>
Date: Thu, 7 Jun 2007 07:54:07 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <1181143109.17978.101.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_26040_3518735.1181195647687"
References: <7289437c0706060801i299d6881w31cc5ffee3444ace@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01FAF561@domain.hid>
	<1181143109.17978.101.camel@domain.hid>
Subject: Re: [Xenomai-help] Cyclictest
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

------=_Part_26040_3518735.1181195647687
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>Did you double-check that you were not testing Xenomai with the
>"vanilla" cyclictest, ie. the one without libpthread_rt dependencies...?
>See "ldd cyclictest" when in doubt.

Yes, I did. I wanted to know performances of cyclictest without Xenomai to
compare.
And I thought that even with Xenomai in the kernel, I would have the same
result.

On 6/6/07, Philippe Gerum <rpm@xenomai.org> wrote:
>
> On Wed, 2007-06-06 at 15:04 +0000, Daniel Schnell wrote:
> > Try adding -p99 to use realtime.
> >
> >
> > ________________________________
> >
> > From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid=
]
> On Behalf Of Perrine Martignoni
> > Sent: 6. j=FAn=ED 2007 15:02
> > To: xenomai-help
> > Subject: [Xenomai-help] Cyclictest
> >
> >
> > Hello,
> >
> > I launched the same application Cyclictest on a kernel Linux without
> Xenomai and a kernel Linux with Xenomai and I noticed that the result is
> different.
> >
> > Here is the result with a kernel Linux without xenomai :
> >
> > > cyclictest -t 10 -c 1 -i 10500
> >
> >
> > T: 0 (  732) P:99 I:   10500 C:    2291 Min:      41 Act:    2281
> Avg:    5075 Max:   10224
> >
> > T: 1 (  733) P:98 I:   11000 C:    2187 Min:      66 Act:    1312
> Avg:    5085 Max:   10236
> >
> > T: 2 (  734) P:97 I:   11500 C:    2092 Min:      91 Act:     842
> Avg:    5113 Max:   10311
> >
> > T: 3 (  735) P:96 I:   12000 C:    2004 Min:     106 Act:    1384
> Avg:    5134 Max:   10140
> >
> > T: 4 (  736) P:95 I:   12500 C:    1924 Min:     116 Act:    9873
> Avg:    5152 Max:   10306
> >
> > T: 5 (  737) P:94 I:   13000 C:    1850 Min:     136 Act:     415
> Avg:    5172 Max:   10376
> >
> > T: 6 (  738) P:93 I:   13500 C:    1782 Min:     136 Act:    3873
> Avg:    5180 Max:   10411
> >
> > T: 7 (  751) P:92 I:   14000 C:    1722 Min:     156 Act:    3559
> Avg:    5184 Max:   10190
> >
> > T: 8 (  752) P:91 I:   14500 C:    1663 Min:     140 Act:    8454
> Avg:    5216 Max:   10310
> >
> > T: 9 (  753) P:90 I:   15000 C:    1608 Min:     184 Act:    2485
> Avg:    5214 Max:   10490
> >
> >
> >
> > And here is the result with a kernel Linux with xenomai :
> > > cyclictest -t 10 -c 1 -i 10000
> >
> >
> > T: 0 (  893) P:99 I:   10000 C:     1756 Min:   13407 Act:   13536
> Avg:   13452 Max:   13693
> >
> > T: 1 (  894) P:98 I:   10500 C:     1673 Min:    4955 Act:    7595
> Avg:    9767 Max:   14727
> >
> > T: 2 (  895) P:97 I:   11000 C:     1597 Min:    5461 Act:    7628
> Avg:   10047 Max:   14793
> >
> > T: 3 (  908) P:96 I:   11500 C:     1333 Min:    4987 Act:    5641
> Avg:    9808 Max:   14779
> >
> > T: 4 (  909) P:95 I:   12000 C:     1277 Min:    5478 Act:   11665
> Avg:    9588 Max:   13864
> >
> > T: 5 (  910) P:94 I:   12500 C:     1226 Min:    6016 Act:   11191
> Avg:    9859 Max:   14135
> >
> > T: 6 (  911) P:93 I:   13000 C:     1179 Min:    5526 Act:    9711
> Avg:   10130 Max:   14901
> >
> > T: 7 (  912) P:92 I:   13500 C:     1135 Min:    5061 Act:   14740
> Avg:    9896 Max:   14852
> >
> > T: 8 (  913) P:91 I:   14000 C:     1095 Min:    5549 Act:    7766
> Avg:    9669 Max:   14198
> >
> > T: 9 (  914) P:90 I:   14500 C:     1057 Min:    5107 Act:   11820
> Avg:    9940 Max:   14984
> >
> >
> >
> > We can see that with Xenomai, the results are less good.
> > Is there an explication to this?
>
> Actually, you don't have any information from this test output unless
> you did put some load on your box. Real-time is about predictability,
> what Xenomai brings is exactly that. Raw performances have no meaning in
> a real-time context unless they can be sustained regardless of the
> runtime conditions.
>
> If your box is not some flashy big iron, try putting some load with this
> command while the test is running, on both boxen:
>
> while :; do dd if=3D/dev/zero of=3Dhog.out count=3D500 bs=3D1M; rm -f hog=
.out &&
> sync; done
>
> If you do have a recent, multi-core and multi-Ghz box, try compiling a
> kernel over all the CPUs when testing. E.g. for a 2 CPU box, try
> running:
>
> while :; do make clean && make -j3; done
>
> >
> > Thanks
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> --
> Philippe.
>
>
>

------=_Part_26040_3518735.1181195647687
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

&gt;Did you double-check that you were not testing Xenomai with the<br>&gt;=
&quot;vanilla&quot; cyclictest, ie. the one without libpthread_rt dependenc=
ies...?<br>&gt;See &quot;ldd cyclictest&quot; when in doubt.<br><br>Yes, I =
did. I wanted to know performances of cyclictest without Xenomai to compare=
.
<br>And I thought that even with Xenomai in the kernel, I would have the sa=
me result.<br><br><div><span class=3D"gmail_quote">On 6/6/07, <b class=3D"g=
mail_sendername">Philippe Gerum</b> &lt;<a href=3D"mailto:rpm@xenomai.org">=
rpm@xenomai.org
</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-lef=
t: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1=
ex;">On Wed, 2007-06-06 at 15:04 +0000, Daniel Schnell wrote:<br>&gt; Try a=
dding -p99 to use realtime.
<br>&gt;<br>&gt;<br>&gt; ________________________________<br>&gt;<br>&gt; F=
rom: <a href=3D"mailto:xenomai-help-bounces@domain.hid">xenomai-help-bounces@domain.hid=
na.org</a> [mailto:<a href=3D"mailto:xenomai-help-bounces@domain.hid">xenomai-=
help-bounces@domain.hid
</a>] On Behalf Of Perrine Martignoni<br>&gt; Sent: 6. j=FAn=ED 2007 15:02<=
br>&gt; To: xenomai-help<br>&gt; Subject: [Xenomai-help] Cyclictest<br>&gt;=
<br>&gt;<br>&gt; Hello,<br>&gt;<br>&gt; I launched the same application Cyc=
lictest on a kernel Linux without Xenomai and a kernel Linux with Xenomai a=
nd I noticed that the result is different.
<br>&gt;<br>&gt; Here is the result with a kernel Linux without xenomai :<b=
r>&gt;<br>&gt; &gt; cyclictest -t 10 -c 1 -i 10500<br>&gt;<br>&gt;<br>&gt; =
T: 0 (&nbsp;&nbsp;732) P:99 I:&nbsp;&nbsp; 10500 C:&nbsp;&nbsp;&nbsp;&nbsp;=
2291 Min:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;41 Act:&nbsp;&nbsp;&nbsp;&nbsp=
;2281 Avg:&nbsp;&nbsp;&nbsp;&nbsp;5075 Max:&nbsp;&nbsp; 10224
<br>&gt;<br>&gt; T: 1 (&nbsp;&nbsp;733) P:98 I:&nbsp;&nbsp; 11000 C:&nbsp;&=
nbsp;&nbsp;&nbsp;2187 Min:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;66 Act:&nbsp;=
&nbsp;&nbsp;&nbsp;1312 Avg:&nbsp;&nbsp;&nbsp;&nbsp;5085 Max:&nbsp;&nbsp; 10=
236<br>&gt;<br>&gt; T: 2 (&nbsp;&nbsp;734) P:97 I:&nbsp;&nbsp; 11500 C:&nbs=
p;&nbsp;&nbsp;&nbsp;2092 Min:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;91 Act:&nb=
sp;&nbsp;&nbsp;&nbsp; 842 Avg:&nbsp;&nbsp;&nbsp;&nbsp;5113 Max:&nbsp;&nbsp;=
 10311<br>&gt;
<br>&gt; T: 3 (&nbsp;&nbsp;735) P:96 I:&nbsp;&nbsp; 12000 C:&nbsp;&nbsp;&nb=
sp;&nbsp;2004 Min:&nbsp;&nbsp;&nbsp;&nbsp; 106 Act:&nbsp;&nbsp;&nbsp;&nbsp;=
1384 Avg:&nbsp;&nbsp;&nbsp;&nbsp;5134 Max:&nbsp;&nbsp; 10140<br>&gt;<br>&gt=
; T: 4 (&nbsp;&nbsp;736) P:95 I:&nbsp;&nbsp; 12500 C:&nbsp;&nbsp;&nbsp;&nbs=
p;1924 Min:&nbsp;&nbsp;&nbsp;&nbsp; 116 Act:&nbsp;&nbsp;&nbsp;&nbsp;9873 Av=
g:&nbsp;&nbsp;&nbsp;&nbsp;5152 Max:&nbsp;&nbsp; 10306<br>&gt;<br>&gt; T: 5 =
(&nbsp;&nbsp;737) P:94 I:&nbsp;&nbsp; 13000 C:&nbsp;&nbsp;&nbsp;&nbsp;1850 =
Min:&nbsp;&nbsp;&nbsp;&nbsp; 136 Act:&nbsp;&nbsp;&nbsp;&nbsp; 415 Avg:&nbsp=
;&nbsp;&nbsp;&nbsp;5172 Max:&nbsp;&nbsp; 10376
<br>&gt;<br>&gt; T: 6 (&nbsp;&nbsp;738) P:93 I:&nbsp;&nbsp; 13500 C:&nbsp;&=
nbsp;&nbsp;&nbsp;1782 Min:&nbsp;&nbsp;&nbsp;&nbsp; 136 Act:&nbsp;&nbsp;&nbs=
p;&nbsp;3873 Avg:&nbsp;&nbsp;&nbsp;&nbsp;5180 Max:&nbsp;&nbsp; 10411<br>&gt=
;<br>&gt; T: 7 (&nbsp;&nbsp;751) P:92 I:&nbsp;&nbsp; 14000 C:&nbsp;&nbsp;&n=
bsp;&nbsp;1722 Min:&nbsp;&nbsp;&nbsp;&nbsp; 156 Act:&nbsp;&nbsp;&nbsp;&nbsp=
;3559 Avg:&nbsp;&nbsp;&nbsp;&nbsp;5184 Max:&nbsp;&nbsp; 10190<br>&gt;
<br>&gt; T: 8 (&nbsp;&nbsp;752) P:91 I:&nbsp;&nbsp; 14500 C:&nbsp;&nbsp;&nb=
sp;&nbsp;1663 Min:&nbsp;&nbsp;&nbsp;&nbsp; 140 Act:&nbsp;&nbsp;&nbsp;&nbsp;=
8454 Avg:&nbsp;&nbsp;&nbsp;&nbsp;5216 Max:&nbsp;&nbsp; 10310<br>&gt;<br>&gt=
; T: 9 (&nbsp;&nbsp;753) P:90 I:&nbsp;&nbsp; 15000 C:&nbsp;&nbsp;&nbsp;&nbs=
p;1608 Min:&nbsp;&nbsp;&nbsp;&nbsp; 184 Act:&nbsp;&nbsp;&nbsp;&nbsp;2485 Av=
g:&nbsp;&nbsp;&nbsp;&nbsp;5214 Max:&nbsp;&nbsp; 10490<br>&gt;<br>&gt;
<br>&gt;<br>&gt; And here is the result with a kernel Linux with xenomai :<=
br>&gt; &gt; cyclictest -t 10 -c 1 -i 10000<br>&gt;<br>&gt;<br>&gt; T: 0 (&=
nbsp;&nbsp;893) P:99 I:&nbsp;&nbsp; 10000 C:&nbsp;&nbsp;&nbsp;&nbsp; 1756 M=
in:&nbsp;&nbsp; 13407 Act:&nbsp;&nbsp; 13536 Avg:&nbsp;&nbsp; 13452 Max:&nb=
sp;&nbsp; 13693
<br>&gt;<br>&gt; T: 1 (&nbsp;&nbsp;894) P:98 I:&nbsp;&nbsp; 10500 C:&nbsp;&=
nbsp;&nbsp;&nbsp; 1673 Min:&nbsp;&nbsp;&nbsp;&nbsp;4955 Act:&nbsp;&nbsp;&nb=
sp;&nbsp;7595 Avg:&nbsp;&nbsp;&nbsp;&nbsp;9767 Max:&nbsp;&nbsp; 14727<br>&g=
t;<br>&gt; T: 2 (&nbsp;&nbsp;895) P:97 I:&nbsp;&nbsp; 11000 C:&nbsp;&nbsp;&=
nbsp;&nbsp; 1597 Min:&nbsp;&nbsp;&nbsp;&nbsp;5461 Act:&nbsp;&nbsp;&nbsp;&nb=
sp;7628 Avg:&nbsp;&nbsp; 10047 Max:&nbsp;&nbsp; 14793<br>
&gt;<br>&gt; T: 3 (&nbsp;&nbsp;908) P:96 I:&nbsp;&nbsp; 11500 C:&nbsp;&nbsp=
;&nbsp;&nbsp; 1333 Min:&nbsp;&nbsp;&nbsp;&nbsp;4987 Act:&nbsp;&nbsp;&nbsp;&=
nbsp;5641 Avg:&nbsp;&nbsp;&nbsp;&nbsp;9808 Max:&nbsp;&nbsp; 14779<br>&gt;<b=
r>&gt; T: 4 (&nbsp;&nbsp;909) P:95 I:&nbsp;&nbsp; 12000 C:&nbsp;&nbsp;&nbsp=
;&nbsp; 1277 Min:&nbsp;&nbsp;&nbsp;&nbsp;5478 Act:&nbsp;&nbsp; 11665 Avg:&n=
bsp;&nbsp;&nbsp;&nbsp;9588 Max:&nbsp;&nbsp; 13864<br>&gt;
<br>&gt; T: 5 (&nbsp;&nbsp;910) P:94 I:&nbsp;&nbsp; 12500 C:&nbsp;&nbsp;&nb=
sp;&nbsp; 1226 Min:&nbsp;&nbsp;&nbsp;&nbsp;6016 Act:&nbsp;&nbsp; 11191 Avg:=
&nbsp;&nbsp;&nbsp;&nbsp;9859 Max:&nbsp;&nbsp; 14135<br>&gt;<br>&gt; T: 6 (&=
nbsp;&nbsp;911) P:93 I:&nbsp;&nbsp; 13000 C:&nbsp;&nbsp;&nbsp;&nbsp; 1179 M=
in:&nbsp;&nbsp;&nbsp;&nbsp;5526 Act:&nbsp;&nbsp;&nbsp;&nbsp;9711 Avg:&nbsp;=
&nbsp; 10130 Max:&nbsp;&nbsp; 14901<br>&gt;<br>
&gt; T: 7 (&nbsp;&nbsp;912) P:92 I:&nbsp;&nbsp; 13500 C:&nbsp;&nbsp;&nbsp;&=
nbsp; 1135 Min:&nbsp;&nbsp;&nbsp;&nbsp;5061 Act:&nbsp;&nbsp; 14740 Avg:&nbs=
p;&nbsp;&nbsp;&nbsp;9896 Max:&nbsp;&nbsp; 14852<br>&gt;<br>&gt; T: 8 (&nbsp=
;&nbsp;913) P:91 I:&nbsp;&nbsp; 14000 C:&nbsp;&nbsp;&nbsp;&nbsp; 1095 Min:&=
nbsp;&nbsp;&nbsp;&nbsp;5549 Act:&nbsp;&nbsp;&nbsp;&nbsp;7766 Avg:&nbsp;&nbs=
p;&nbsp;&nbsp;9669 Max:&nbsp;&nbsp; 14198<br>&gt;<br>&gt; T: 9 (&nbsp;&nbsp=
;914) P:90 I:&nbsp;&nbsp; 14500 C:&nbsp;&nbsp;&nbsp;&nbsp; 1057 Min:&nbsp;&=
nbsp;&nbsp;&nbsp;5107 Act:&nbsp;&nbsp; 11820 Avg:&nbsp;&nbsp;&nbsp;&nbsp;99=
40 Max:&nbsp;&nbsp; 14984
<br>&gt;<br>&gt;<br>&gt;<br>&gt; We can see that with Xenomai, the results =
are less good.<br>&gt; Is there an explication to this?<br><br>Actually, yo=
u don&#39;t have any information from this test output unless<br>you did pu=
t some load on your box. Real-time is about predictability,
<br>what Xenomai brings is exactly that. Raw performances have no meaning i=
n<br>a real-time context unless they can be sustained regardless of the<br>=
runtime conditions.<br><br>If your box is not some flashy big iron, try put=
ting some load with this
<br>command while the test is running, on both boxen:<br><br>while :; do dd=
 if=3D/dev/zero of=3Dhog.out count=3D500 bs=3D1M; rm -f hog.out &amp;&amp;<=
br>sync; done<br><br>If you do have a recent, multi-core and multi-Ghz box,=
 try compiling a
<br>kernel over all the CPUs when testing. E.g. for a 2 CPU box, try<br>run=
ning:<br><br>while :; do make clean &amp;&amp; make -j3; done<br><br>&gt;<b=
r>&gt; Thanks<br>&gt;<br>&gt; _____________________________________________=
__
<br>&gt; Xenomai-help mailing list<br>&gt; <a href=3D"mailto:Xenomai-help@domain.hid=
na.org">Xenomai-help@domain.hid</a><br>&gt; <a href=3D"https://mail.gna.org/li=
stinfo/xenomai-help">https://mail.gna.org/listinfo/xenomai-help</a><br>--<b=
r>
Philippe.<br><br><br></blockquote></div><br>

------=_Part_26040_3518735.1181195647687--

