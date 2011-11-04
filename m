From: "Lyons, Brendon N" <lyonsb@domain.hid>
Date: Fri, 4 Nov 2011 18:15:40 +0000
Message-ID: <768BACF5E8359A48BAF0059F2E3E1A430A86C3C7@domain.hid>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_768BACF5E8359A48BAF0059F2E3E1A430A86C3C7SN2PRD0202MB152_"
MIME-Version: 1.0
Subject: [Xenomai-help] Xenomai, Beagleboard and RTAI
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

--_000_768BACF5E8359A48BAF0059F2E3E1A430A86C3C7SN2PRD0202MB152_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I am sorry for the previous message with no subject. I am resending this so=
 that it can be properly tagged.

______________________________________

Hello,

I am currently working on a project which requires realtime use of a beagle=
board. I know that Xenomai is a realtime kernel however, our setup calls fo=
r the use of Mathworks' Simulink support for RTAI. I have been doing some r=
esearch and have found that Xenomai incorporates RTAI as a skin? I am not e=
ntirely sure what that means but it sounds like I can simply copy and paste=
 RTAI headers in the designated ../rtai folder within Xenomai and have my r=
tai programs compile and run on Xenomai.

Here is an outline of the goals I would like to achieve:


  *   Have Xenomai running on a beagleboard with an RTAI skin
  *   Generate realtime programs with the Simulink support for RTAI
  *   Upload the program and run it on the beagleboard

I have a few questions regarding this approach:

First of all is this even feasible?
Secondly if it is, what would be the consequences of running an RTAI execut=
able built on say <ubuntu 9.04 kernel 2.6.28.7 with gcc 4.3.3> on <Xenomai =
2.5.2 Kernel 2.6.28.10 (adeos-ipipe-2.6.28.10-arm-1.12-07) patch  with gcc =
4.3.3> (this is the closest kernel match I could find)

Or if I wanted to run a later Xenomai such as <Xenomai 2.5.6 Kernel 2.6.33 =
(adeos-ipipe-2.6.33-arm-1.18-02) patch with gcc 4.3.3>

Which leads me to my next question, what is the earliest kernel + Xenomai c=
ombination supported on the beagleboard?

I hope my questions were clear and made sense, I am new to Xenomai.


Regards,
--
Brendon Lyons
B.Sc Aerospace Engineering
Graduate Research Assistant
Eagle Flight Research Center
Embry-Riddle Aeronautical University

--_000_768BACF5E8359A48BAF0059F2E3E1A430A86C3C7SN2PRD0202MB152_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" id=3D"owaParaStyle"></style>
</head>
<body fpstyle=3D"1" ocsi=3D"0">
<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;">
<div style=3D"font-family: Times New Roman; color: #000000; font-size: 16px=
">
<div id=3D"divRpF134309" style=3D"direction: ltr; "><font face=3D"Tahoma" s=
ize=3D"2" color=3D"#000000">I am sorry for the previous message with no sub=
ject. I am resending this so that it can be properly tagged.</font></div>
<div id=3D"divRpF134309" style=3D"direction: ltr; "><font face=3D"Tahoma" s=
ize=3D"2" color=3D"#000000"><br>
</font></div>
<div id=3D"divRpF134309" style=3D"direction: ltr; "><font face=3D"Tahoma" s=
ize=3D"2" color=3D"#000000">______________________________________<br>
</font><br>
</div>
<div></div>
<div>
<div style=3D"direction:ltr; font-family:Tahoma; color:#000000; font-size:1=
0pt"><span class=3D"Apple-style-span" style=3D"font-family:arial,sans-serif=
; background-color:rgb(255,255,255)">Hello,</span>
<div style=3D"font-family:arial,sans-serif; background-color:rgb(255,255,25=
5)"><br>
</div>
<div style=3D"font-family:arial,sans-serif; background-color:rgb(255,255,25=
5)">I am currently working on a project which requires realtime use of a be=
agleboard. I know that Xenomai is a realtime kernel however, our setup call=
s for the use of Mathworks' Simulink
 support for RTAI. I have been doing some research and have found that Xeno=
mai incorporates RTAI as a skin? I am not entirely sure what that means but=
 it sounds like I can simply copy and paste RTAI headers in the designated =
../rtai folder within Xenomai and
 have my rtai programs compile and run on Xenomai.</div>
<div style=3D"font-family:arial,sans-serif; background-color:rgb(255,255,25=
5)"><br>
</div>
<div style=3D"font-family:arial,sans-serif; background-color:rgb(255,255,25=
5)">Here is an outline of the goals I would like to achieve:</div>
<div style=3D"font-family:arial,sans-serif; background-color:rgb(255,255,25=
5)"><br>
</div>
<div style=3D"font-family:arial,sans-serif; background-color:rgb(255,255,25=
5)">
<ul>
<li style=3D"margin-left:15px">Have Xenomai running on a beagleboard with a=
n RTAI skin</li><li style=3D"margin-left:15px">Generate realtime programs w=
ith the Simulink support for RTAI</li><li style=3D"margin-left:15px">Upload=
 the program and run it on the beagleboard</li></ul>
<div>
<div>I have a few questions regarding this approach:</div>
<div><br>
</div>
<div>First of all is this even feasible?</div>
<div>Secondly if it is, what would be the consequences of running an RTAI e=
xecutable built on say &lt;ubuntu 9.04&nbsp;kernel 2.6.28.7 with gcc 4.3.3&=
gt;&nbsp;on &lt;Xenomai 2.5.2 Kernel 2.6.28.10&nbsp;(adeos-ipipe-2.6.28.<wb=
r>10-arm-1.12-07) patch&nbsp;&nbsp;with gcc 4.3.3&gt; (this is the closest
 kernel match I could find)</div>
<div><br>
</div>
<div>Or if I wanted to run a later Xenomai such as &lt;Xenomai 2.5.6 Kernel=
 2.6.33 (adeos-ipipe-2.6.33-arm-1.18-<wbr>02) patch with&nbsp;gcc 4.3.3&gt;=
</div>
<div><br>
</div>
<div>Which leads me to my next question, what is the earliest kernel &#43; =
Xenomai combination supported on the beagleboard?</div>
<div><br>
</div>
<div>I hope my questions were clear and made sense, I am new to Xenomai.</d=
iv>
<div><br>
</div>
<div><br>
</div>
<div>Regards,</div>
--&nbsp;<br>
<font color=3D"#888888">
<div>Brendon Lyons</div>
<div>B.Sc Aerospace Engineering</div>
<div>Graduate Research Assistant</div>
<div>Eagle Flight Research Center</div>
<div>Embry-Riddle Aeronautical University</div>
</font></div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_768BACF5E8359A48BAF0059F2E3E1A430A86C3C7SN2PRD0202MB152_--

