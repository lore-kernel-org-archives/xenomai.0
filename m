References: <1319490255.1417.YahooMailNeo@domain.hid>
	<4EA69486.4030106@domain.hid>
Message-ID: <1319638430.4857.YahooMailNeo@domain.hid>
Date: Wed, 26 Oct 2011 07:13:50 -0700 (PDT)
From: Tom Z <tomz30@domain.hid>
In-Reply-To: <4EA69486.4030106@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="1735753853-1879321393-1319638430=:4857"
Subject: Re: [Xenomai-help] address spaces of real-time task and standard
	linux process
Reply-To: Tom Z <tomz30@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

--1735753853-1879321393-1319638430=:4857
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

=0A=0AThanks. I increased the stack size and the problem was gone. This pro=
blem was hard to find for me, as when I step into the functions in gdb, the=
 locations where the problem occurs are different.=0A=0A=0ABTW, in your pre=
vious reply you mentioned debugging techniques such as examining the regist=
ers and disassembling, can you suggesting some readings that elaborate such=
 techniques. I have a few questions regarding such techniques, e.g., how do=
 I interpret the meaning of each register? By disassembling, do you mean lo=
oking at the assembly codes?=0A=0A=0AThanks,=0ATom=0A=0A=0A=0A_____________=
___________________=0AFrom: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org=
mai.org>=0ATo: Tom Z <tomz30@domain.hid>=0ACc: Thomas Lockhart <Thomas.Lockh=
art@domain.hid>; "xenomai@xenomai.org" <xenomai@xenomai.org>=0ASent: Tu=
esday, 25 October 2011 5:50 AM=0ASubject: Re: [Xenomai-help] address spaces=
 of real-time task and standard linux process=0A=0AOn 10/24/2011 11:04 PM, =
Tom Z wrote:=0A>=A0 8)=A0 =A0  rt_task_create(&task_desc, "RealTimeImagePro=
cessing", 4096, 99, T_FPU|T_CPU(0));=0A=0A4096 bytes is a really small stac=
k size, are you sure that the=0Asegmentation fault is simply not a stack ov=
erflow?=0A=0A-- =0A=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =
=A0 Gilles.
--1735753853-1879321393-1319638430=:4857
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt"><div><span><br></span=
></div><div>Thanks. I increased the stack size and the problem was gone. Th=
is problem was hard to find for me, as when I step into the functions in gd=
b, the locations where the problem occurs are different.<br></div><div><br>=
</div><div>BTW, in your previous reply you mentioned debugging techniques s=
uch as examining the registers and disassembling, can you suggesting some r=
eadings that elaborate such techniques. I have a few questions regarding su=
ch techniques, e.g., how do I interpret the meaning of each register? By di=
sassembling, do you mean looking at the assembly codes?<br></div><div><br><=
/div><div>Thanks,</div><div>Tom<br></div><div><br></div><div style=3D"font-=
family: times new roman, new york, times, serif; font-size: 12pt;"><div sty=
le=3D"font-family: times new roman, new york, times, serif; font-size:
 12pt;"><font face=3D"Arial" size=3D"2"><hr size=3D"1"><b><span style=3D"fo=
nt-weight:bold;">From:</span></b> Gilles Chanteperdrix &lt;gilles.chanteper=
drix@domain.hid&gt;<br><b><span style=3D"font-weight: bold;">To:</span></b=
> Tom Z &lt;tomz30@domain.hid&gt;<br><b><span style=3D"font-weight: bold;">C=
c:</span></b> Thomas Lockhart &lt;Thomas.Lockhart@domain.hid&gt;; "xenoma=
i-help@domain.hid" &lt;xenomai@xenomai.org&gt;<br><b><span style=3D"font-weig=
ht: bold;">Sent:</span></b> Tuesday, 25 October 2011 5:50 AM<br><b><span st=
yle=3D"font-weight: bold;">Subject:</span></b> Re: [Xenomai-help] address s=
paces of real-time task and standard linux process<br></font><br>On 10/24/2=
011 11:04 PM, Tom Z wrote:<br>&gt;&nbsp; 8)&nbsp; &nbsp;  rt_task_create(&a=
mp;task_desc, "RealTimeImageProcessing", 4096, 99, T_FPU|T_CPU(0));<br><br>=
4096 bytes is a really small stack size, are you sure that the<br>segmentat=
ion fault is simply not a stack overflow?<br><br>-- <br>&nbsp;&nbsp;&nbsp;
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; &nbsp; &nbsp; Gilles.<br><br><br></div></div></div></body></html>
--1735753853-1879321393-1319638430=:4857--

