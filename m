Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C86ABC.275B2E3C"
Date: Fri, 8 Feb 2008 18:36:12 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D376AB6@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: [Xenomai-help] fpu issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


This is a multi-part message in MIME format.

------_=_NextPart_001_01C86ABC.275B2E3C
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I found the source of my fpu issue. A single kernel module with two
tasks was also active. I noticed the failure occurred whenever sound
would play. (This is one of the tasks.) It seems the problem is that the
sound task doesn't use the FPU, so I didn't turn on T_FPU. The tone task
(not in use at that time) does, so it has T_FPU. When I turned on T_FPU
for the sound task, I never saw the problem again. With it off, if I
played sound while running the program, I'd regularly see the
corruption.

=20

Here is the task code:

=20

static void sound_func(void *data)

{      =20

    for (;;) //go until suspended or thread deletion

    {=20

        if (play=3D=3Dstop) //time to stop if this happens

        {

            unsigned long evt =3D 0;

           =20

            play=3Dstop=3D0; // just in case

            rt_event_clear(&sound_event, SOUND, 0);

            rt_task_set_periodic(&sound_task, TM_NOW, TM_INFINITE); /*
disable periodic mode */

            rt_event_wait(&sound_event, SOUND, &evt, EV_ALL,
TM_INFINITE);

            rt_task_set_periodic(&sound_task, TM_NOW,
rt_timer_ns2ticks(ST_AUDIO_PERIOD));

        }

       =20

#if BUFSIZE !=3D 65536

        if (play=3D=3DBUFSIZE) play=3D0;

#endif

       =20

        if(rt_task_wait_period(0)) rt_task_wait_period(0); //wait for
next tick and ignore overruns (do the best we can)

        // Since the index is incrementd subtract 2 from the size before
comparing the index

       =20

        outb(buf[play++], DAC_ADDRESS); //send the next byte to the dac

    }

}

=20

The buffer is filled with a linux userland process and an appropriate
wait queue. This same code worked fine in RTAI without the FPU flag.

=20

I've tested this for several minutes.

=20

Any idea?

=20

Steven

=20


------_=_NextPart_001_01C86ABC.275B2E3C
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
@font-face
	{font-family:"\@MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
@font-face
	{font-family:Monaco;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I found the source of my fpu issue. A single kernel =
module
with two tasks was also active. I noticed the failure occurred whenever =
sound
would play. (This is one of the tasks.) It seems the problem is that the =
sound
task doesn&#8217;t use the FPU, so I didn&#8217;t turn on T_FPU. The =
tone task
(not in use at that time) does, so it has T_FPU. When I turned on T_FPU =
for the
sound task, I never saw the problem again. With it off, if I played =
sound while
running the program, I&#8217;d regularly see the =
corruption.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Here is the task code:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3D"#760f50"
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:#760F50'>static</span>=
</font><font
size=3D2 color=3Dblack face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;
color:black'> </span></font><font size=3D2 color=3D"#760f50" =
face=3DMonaco><span
style=3D'font-size:10.0pt;font-family:Monaco;color:#760F50'>void</span></=
font><font
size=3D2 color=3Dblack face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;
color:black'> sound_func(</span></font><font size=3D2 color=3D"#760f50"
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:#760F50'>void</span></=
font><font
size=3D2 color=3Dblack face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;
color:black'> *data)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblack
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>{&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblack
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>&nbsp;&nbsp;&nb=
sp;
</span></font><font size=3D2 color=3D"#760f50" face=3DMonaco><span =
style=3D'font-size:
10.0pt;font-family:Monaco;color:#760F50'>for</span></font><font size=3D2
color=3Dblack face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;
color:black'> (;;) </span></font><font size=3D2 color=3D"#236e25" =
face=3DMonaco><span
style=3D'font-size:10.0pt;font-family:Monaco;color:#236E25'>//go until =
suspended
or thread deletion</span></font><font size=3D2 color=3Dblack =
face=3DMonaco><span
style=3D'font-size:10.0pt;font-family:Monaco;color:black'><o:p></o:p></sp=
an></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblack
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>&nbsp;&nbsp;&nb=
sp;
{ <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblack
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><font size=3D2 color=3D"#760f50" face=3DMonaco><span =
style=3D'font-size:
10.0pt;font-family:Monaco;color:#760F50'>if</span></font><font size=3D2
color=3Dblack face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;
color:black'> (play=3D=3Dstop) </span></font><font size=3D2 =
color=3D"#236e25"
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:#236E25'>//time
to stop if this happens</span></font><font size=3D2 color=3Dblack =
face=3DMonaco><span
style=3D'font-size:10.0pt;font-family:Monaco;color:black'><o:p></o:p></sp=
an></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblack
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
{<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblack
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><font size=3D2 color=3D"#760f50" face=3DMonaco><span =
style=3D'font-size:
10.0pt;font-family:Monaco;color:#760F50'>unsigned</span></font><font =
size=3D2
color=3Dblack face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;
color:black'> </span></font><font size=3D2 color=3D"#760f50" =
face=3DMonaco><span
style=3D'font-size:10.0pt;font-family:Monaco;color:#760F50'>long</span></=
font><font
size=3D2 color=3Dblack face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;
color:black'> evt =3D </span></font><font size=3D2 color=3Dblue =
face=3DMonaco><span
style=3D'font-size:10.0pt;font-family:Monaco;color:blue'>0</span></font><=
font
size=3D2 color=3Dblack face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;
color:black'>;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblack
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblack
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
play=3Dstop=3D</span></font><font size=3D2 color=3Dblue =
face=3DMonaco><span
style=3D'font-size:10.0pt;font-family:Monaco;color:blue'>0</span></font><=
font
size=3D2 color=3Dblack face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;
color:black'>; </span></font><font size=3D2 color=3D"#236e25" =
face=3DMonaco><span
style=3D'font-size:10.0pt;font-family:Monaco;color:#236E25'>// just in =
case</span></font><font
size=3D2 color=3Dblack face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;
color:black'><o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblack
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
rt_event_clear(&amp;sound_event, SOUND, </span></font><font size=3D2 =
color=3Dblue
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:blue'>0</span></font><=
font
size=3D2 color=3Dblack face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;
color:black'>);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblack
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
rt_task_set_periodic(&amp;sound_task, TM_NOW, TM_INFINITE); =
</span></font><font
size=3D2 color=3D"#236e25" face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:
Monaco;color:#236E25'>/* disable periodic mode */</span></font><font =
size=3D2
color=3Dblack face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;
color:black'><o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblack
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
rt_event_wait(&amp;sound_event, SOUND, &amp;evt, EV_ALL, =
TM_INFINITE);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblack
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
rt_task_set_periodic(&amp;sound_task, TM_NOW,
rt_timer_ns2ticks(ST_AUDIO_PERIOD));<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblack
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
}<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblack
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3D"#683821"
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:#683821'>#if
BUFSIZE !=3D </span></font><font size=3D2 color=3Dblue =
face=3DMonaco><span
style=3D'font-size:10.0pt;font-family:Monaco;color:blue'>65536</span></fo=
nt><font
size=3D2 color=3D"#683821" face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:
Monaco;color:#683821'><o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblack
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><font size=3D2 color=3D"#760f50" face=3DMonaco><span =
style=3D'font-size:
10.0pt;font-family:Monaco;color:#760F50'>if</span></font><font size=3D2
color=3Dblack face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;
color:black'> (play=3D=3DBUFSIZE) play=3D</span></font><font size=3D2 =
color=3Dblue
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:blue'>0</span></font><=
font
size=3D2 color=3Dblack face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;
color:black'>;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3D"#683821"
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:#683821'>#endif<o:p></=
o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblack
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblack
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><font size=3D2 color=3D"#760f50" face=3DMonaco><span =
style=3D'font-size:
10.0pt;font-family:Monaco;color:#760F50'>if</span></font><font size=3D2
color=3Dblack face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;
color:black'>(rt_task_wait_period(</span></font><font size=3D2 =
color=3Dblue
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:blue'>0</span></font><=
font
size=3D2 color=3Dblack face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;
color:black'>)) rt_task_wait_period(</span></font><font size=3D2 =
color=3Dblue
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:blue'>0</span></font><=
font
size=3D2 color=3Dblack face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;
color:black'>); </span></font><font size=3D2 color=3D"#236e25" =
face=3DMonaco><span
style=3D'font-size:10.0pt;font-family:Monaco;color:#236E25'>//wait for =
next tick
and ignore overruns (do the best we can)</span></font><font size=3D2 =
color=3Dblack
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'><o:p></o:p></sp=
an></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblack
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><font size=3D2 color=3D"#236e25" face=3DMonaco><span =
style=3D'font-size:
10.0pt;font-family:Monaco;color:#236E25'>// Since the index is =
incrementd
subtract 2 from the size before comparing the index</span></font><font =
size=3D2
color=3Dblack face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;
color:black'><o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblack
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblack
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
outb(buf[play++], DAC_ADDRESS); </span></font><font size=3D2 =
color=3D"#236e25"
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:#236E25'>//send
the next byte to the dac</span></font><font size=3D2 color=3Dblack =
face=3DMonaco><span
style=3D'font-size:10.0pt;font-family:Monaco;color:black'><o:p></o:p></sp=
an></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblack
face=3DMonaco><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>&nbsp;&nbsp;&nb=
sp;
}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DMonaco><span =
style=3D'font-size:
10.0pt;font-family:Monaco;color:black'>}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DMonaco><span =
style=3D'font-size:
10.0pt;font-family:Monaco;color:black'><o:p>&nbsp;</o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DMonaco><span =
style=3D'font-size:
10.0pt;font-family:Monaco;color:black'>The buffer is filled with a linux
userland process and an appropriate wait queue. This same code worked =
fine in
RTAI without the FPU flag.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DMonaco><span =
style=3D'font-size:
10.0pt;font-family:Monaco;color:black'><o:p>&nbsp;</o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DMonaco><span =
style=3D'font-size:
10.0pt;font-family:Monaco;color:black'>I&#8217;ve tested this for =
several
minutes.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DMonaco><span =
style=3D'font-size:
10.0pt;font-family:Monaco;color:black'><o:p>&nbsp;</o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DMonaco><span =
style=3D'font-size:
10.0pt;font-family:Monaco;color:black'>Any =
idea?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DMonaco><span =
style=3D'font-size:
10.0pt;font-family:Monaco;color:black'><o:p>&nbsp;</o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DMonaco><span =
style=3D'font-size:
10.0pt;font-family:Monaco;color:black'>Steven<o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C86ABC.275B2E3C--

