Message-ID: <1320433713.81220.YahooMailNeo@domain.hid>
Date: Fri, 4 Nov 2011 12:08:33 -0700 (PDT)
From: Tom Z <tomz30@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="943903729-1584326518-1320433713=:81220"
Subject: [Xenomai-help] 0 CPU time problem
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
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

--943903729-1584326518-1320433713=:81220
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi All,=0A=0AI am trying to measure the CPU time consumed by a function foo=
(), and here is how I do it:=0A=0Avoid foo(){=0A=A0=A0=A0=A0=A0=A0=A0 struc=
t timespec tp1, tp2;=0A=A0=A0=A0=A0=A0=A0=A0 clock_gettime(CLOCK_PROCESS_CP=
UTIME_ID, &tp);=0A=0A=A0=A0=A0 =A0=A0=A0 //Computation goes here=0A=0A=0A=
=A0=A0=A0 =A0=A0=A0 clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &tp2);=0A=A0=A0=
=A0 =A0=A0=A0 //The CPU time is given between the difference between tp2 an=
d tp 1=0A=0A}=0A=0A=0AThe program is running on Ubuntu 10.10, and the kerne=
l is 2.6.37 patched with Xenomai 2.5.6=0A=0A=0AHere is what I observed:=0A=
=0A1) If foo() is running in the Linux domain (i.e., called by a regular Li=
nux process), the CPU time obtained by the above method looks normal, and t=
he mean CPU time of 25000 invocations of foo() is 10 ms.=0A=0A2) If foo() i=
s running in the primary domain (i.e., called by a Xenomai task spawned by =
rt_task_create() and rt_task_start()), then *most of the time*, the CPU tim=
e also looks as normal as the result in 1), and the mean CPU time is also a=
bout 10 ms. However, I also noticed that sometimes the CPU time obtained by=
 the above method is 0. This zero value did not appear often, and out of 25=
000 invocations of foo(), I noticed that there is only 1 invocation of foo(=
) where the CPU time is 0. BTW, the Xenomai task's priority is 99.=0A=0AWha=
t causes this 0 CPU time in the primary domain? Is there something wrong wi=
th my method to measure the CPU time?=0A=0AThanks,=0ATom=0A
--943903729-1584326518-1320433713=:81220
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt"><div>Hi All,</div><di=
v><br></div><div>I am trying to measure the CPU time consumed by a function=
 foo(), and here is how I do it:</div><div><br></div><div>void foo(){</div>=
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct timespec tp1, tp2;</=
div><div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock_gettime(CLOCK_PRO=
CESS_CPUTIME_ID, &amp;tp);</div><div><br></div><div><span class=3D"tab">&nb=
sp;&nbsp;&nbsp; </span><span class=3D"tab">&nbsp;&nbsp;&nbsp; //Computation=
 goes here<br></span></div><div><br><span class=3D"tab"></span></div><div><=
span class=3D"tab">&nbsp;&nbsp;&nbsp; </span><span class=3D"tab">&nbsp;&nbs=
p;&nbsp; </span>clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &amp;tp2);</div><di=
v><span class=3D"tab">&nbsp;&nbsp;&nbsp; </span><span class=3D"tab">&nbsp;&=
nbsp;&nbsp; //The CPU time is given between the difference between tp2 and =
tp
 1<br></span></div><div>}</div><div><br></div><div><br></div><div>The progr=
am is running on Ubuntu 10.10, and the kernel is 2.6.37 patched with Xenoma=
i 2.5.6</div><div><br></div><div><br></div><div>Here is what I observed:<br=
></div><div>1) If foo() is running in the Linux domain (i.e., called by a r=
egular Linux process), the CPU time obtained by the above method looks norm=
al, and the mean CPU time of 25000 invocations of foo() is 10 ms.<br></div>=
<div>2) If foo() is running in the primary domain (i.e., called by a Xenoma=
i task spawned by rt_task_create() and rt_task_start()), then *most of the =
time*, the CPU time also looks as normal as the result in 1), and the mean =
CPU time is also about 10 ms. However, I also noticed that sometimes the CP=
U time obtained by the above method is 0. This zero value did not appear of=
ten, and out of 25000 invocations of foo(), I noticed that there is only 1 =
invocation of foo() where the CPU time is 0. BTW, the Xenomai task's
 priority is 99.</div><div><br></div><div>What causes this 0 CPU time in th=
e primary domain? Is there something wrong with my method to measure the CP=
U time?</div><div><br></div><div>Thanks,</div><div>Tom<br></div></div></bod=
y></html>
--943903729-1584326518-1320433713=:81220--

