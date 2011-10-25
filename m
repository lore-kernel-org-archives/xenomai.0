References: <1319494779.40265.YahooMailNeo@domain.hid>
	<4EA67872.30609@domain.hid>
Message-ID: <1319552289.52870.YahooMailNeo@domain.hid>
Date: Tue, 25 Oct 2011 07:18:09 -0700 (PDT)
From: makarand pradhan <makarand_u_pradhan@domain.hid>
In-Reply-To: <4EA67872.30609@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="-965286322-45318363-1319552289=:52870"
Subject: Re: [Xenomai-core] CPU utilization question
Reply-To: makarand pradhan <makarand_u_pradhan@domain.hid>
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

---965286322-45318363-1319552289=:52870
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Gilles,=0A=0AAppreciate your response.=0A=0APl find comments inline.=0A=
=0A=0A________________________________=0AFrom: Gilles Chanteperdrix <gilles=
.chanteperdrix@domain.hid>=0ATo: makarand pradhan <makarand_u_pradhan@domain.hid=
o.com>=0ACc: "xenomai@xenomai.org" <xenomai@xenomai.org>=0ASent: Tuesday,=
 October 25, 2011 4:50 AM=0ASubject: Re: [Xenomai-core] CPU utilization que=
stion=0A=0AOn 10/25/2011 12:19 AM, makarand pradhan wrote:=0A> (...) I'm=0A=
> assuming that the ROOT thread captures the %CPU spent in=0A> Linux/secnod=
ary and each xenomai thread listed, captures the %CPU in=0A> primary domain=
. If a thread transitions to the secondary, then I'm=0A> assuming that the =
%util in secondary domain will get accounted=0A> against ROOT and the actua=
l % usage in primary will get accounted=0A> against the thread.=0A=0AYou ar=
e assuming wrong, the CPU utilization measures the activity of the=0Alinux =
kernel as a whole, including its idle task. So, the sum of all the=0Aprimar=
y mode tasks and of the ROOT task is always 100%.=0A=0A[MP]: Yes. I've noti=
ced that the sum of all tasks is always 100. My question was specifically a=
bout a xenomai task that transitions in secondary.=0A=0Ae.g. Assume a xenom=
ai task that uses a total of 20% CPU. Of this assume that 10% is spent exec=
uting system calls in secondary domain and 10% is spent in the primary doma=
in. I believe that from an accounting perspective, 10% would get accounted =
against ROOT and the xenomai task will show a CPU util of 10%. Is this accu=
rate?=0A=0A> Question:=0A> =0A> If the linux process is sleeping, why do I =
see a CPU util against the=0A> process? Why is the CPU % util vary based on=
 the activity I do in the=0A> primary domain?=0A=0Art_printf is a primary m=
ode service which causes activity in secondary=0Amode: the actual printf is=
 done by a plain linux task.=0A=0A[MP]: Tx. It helped. I've taken the rt_pr=
intfs out and now my Linux process that started the xenomai task shows 0% a=
s expected.=0A=0A=A0 PID USER =A0 =A0 =A0PR =A0NI =A0VIRT =A0RES =A0SHR S %=
CPU %MEM =A0 =A0TIME+ =A0COMMAND =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=
=0A=A05136 root =A0 =A0 =A020 =A0 0 =A04936 4372 3688 S =A00.0 =A00.8 =A0 0=
:00.04 a.out =A0 =A0 =A0 =A0 =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=0ARgds,=0AMakarand.=0A=
=0A-- =0A=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0 Gilles.
---965286322-45318363-1319552289=:52870
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt"><div style=3D"font-fa=
mily: 'times new roman', 'new york', times, serif; font-size: 12pt; "><span=
>Hi Gilles,</span></div><div style=3D"font-family: 'times new roman', 'new =
york', times, serif; font-size: 12pt; "><span><br></span></div><div style=
=3D"font-family: 'times new roman', 'new york', times, serif; font-size: 12=
pt; "><span>Appreciate your response.</span></div><div style=3D"font-family=
: 'times new roman', 'new york', times, serif; font-size: 12pt; "><span><br=
></span></div><div style=3D"font-family: 'times new roman', 'new york', tim=
es, serif; font-size: 12pt; "><span>Pl find comments inline.</span></div><d=
iv style=3D"font-family: 'times new roman', 'new york', times, serif; font-=
size: 12pt; "><br></div><div style=3D"font-family: 'times new roman', 'new =
york', times, serif; "><div style=3D"font-size: 12pt; font-family: 'times n=
ew roman',
 'new york', times, serif; "><font size=3D"2" face=3D"Arial"><hr size=3D"1"=
><b><span style=3D"font-weight:bold;">From:</span></b> Gilles Chanteperdrix=
 &lt;gilles.chanteperdrix@xenomai.org&gt;<br><b><span style=3D"font-weight:=
 bold;">To:</span></b> makarand pradhan &lt;makarand_u_pradhan@domain.hid&gt=
;<br><b><span style=3D"font-weight: bold;">Cc:</span></b> "xenomai@xenomai.org=
.org" &lt;xenomai@xenomai.org&gt;<br><b><span style=3D"font-weight: bold;"=
>Sent:</span></b> Tuesday, October 25, 2011 4:50 AM<br><b><span style=3D"fo=
nt-weight: bold;">Subject:</span></b> Re: [Xenomai-core] CPU utilization qu=
estion<br></font><br>=0AOn 10/25/2011 12:19 AM, makarand pradhan wrote:<br>=
&gt; (...) I'm<br>&gt; assuming that the ROOT thread captures the %CPU spen=
t in<br>&gt; Linux/secnodary and each xenomai thread listed, captures the %=
CPU in<br>&gt; primary domain. If a thread transitions to the secondary, th=
en I'm<br>&gt; assuming that the %util in secondary domain will get account=
ed<br>&gt; against ROOT and the actual % usage in primary will get accounte=
d<br>&gt; against the thread.<br><br>You are assuming wrong, the CPU utiliz=
ation measures the activity of the<br>linux kernel as a whole, including it=
s idle task. So, the sum of all the<br>primary mode tasks and of the ROOT t=
ask is always 100%.</div><div style=3D"font-family: 'times new roman', 'new=
 york', times, serif; font-size: 12pt; " class=3D"yui_3_2_0_16_131949494011=
357"><br></div><div style=3D"font-family: 'times new roman', 'new york', ti=
mes, serif; font-size: 12pt; " class=3D"yui_3_2_0_16_131949494011357">[MP]:=
 Yes. I've noticed that
 the sum of all tasks is always 100. My question was specifically about a x=
enomai task that transitions in secondary.</div><div style=3D"font-family: =
'times new roman', 'new york', times, serif; font-size: 12pt; " class=3D"yu=
i_3_2_0_16_131949494011357"><br></div><div style=3D"font-family: 'times new=
 roman', 'new york', times, serif; font-size: 12pt; " class=3D"yui_3_2_0_16=
_131949494011357">e.g. Assume a xenomai task that uses a total of 20% CPU. =
Of this assume that 10% is spent executing system calls in secondary domain=
 and 10% is spent in the primary domain. I believe that from an accounting =
perspective, 10% would get accounted against ROOT and the xenomai task will=
 show a CPU util of 10%. Is this accurate?<br><br>&gt; Question:<br>&gt; <b=
r>&gt; If the linux process is sleeping, why do I see a CPU util against th=
e<br>&gt; process? Why is the CPU % util vary based on the activity I do in=
 the<br>&gt; primary domain?<br><br>rt_printf is a primary mode service
 which causes activity in secondary<br>mode: the actual printf is done by a=
 plain linux task.</div><div style=3D"font-family: 'times new roman', 'new =
york', times, serif; font-size: 12pt; " class=3D"yui_3_2_0_16_1319494940113=
57"><br></div><div style=3D"font-family: 'times new roman', 'new york', tim=
es, serif; font-size: 12pt; " class=3D"yui_3_2_0_16_131949494011357">[MP]: =
Tx. It helped. I've taken the rt_printfs out and now my Linux process that =
started the xenomai task shows 0% as expected.</div><div style=3D"font-fami=
ly: 'times new roman', 'new york', times, serif; font-size: 12pt; " class=
=3D"yui_3_2_0_16_131949494011357"><br></div><div class=3D"yui_3_2_0_16_1319=
49494011357"><div class=3D"yui_3_2_0_16_131949494011357">&nbsp; PID USER &n=
bsp; &nbsp; &nbsp;PR &nbsp;NI &nbsp;VIRT &nbsp;RES &nbsp;SHR S %CPU %MEM &n=
bsp; &nbsp;TIME+ &nbsp;COMMAND &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp=
;</div><div class=3D"yui_3_2_0_16_131949494011357">&nbsp;5136 root &nbsp; &=
nbsp; &nbsp;20 &nbsp; 0 &nbsp;4936 4372 3688 S &nbsp;<b>0.0</b> &nbsp;0.8 &=
nbsp; 0:00.04 a.out &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</div=
><div style=3D"font-family: 'times new roman', 'new york', times, serif; fo=
nt-size: 12pt; "><br></div>Rgds,</div><div class=3D"yui_3_2_0_16_1319494940=
11357">Makarand.<br><br><font size=3D"3">-- </font><br><font size=3D"3">&nb=
sp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; &nbsp; &nbsp; Gilles.</font><br><br><br></div></div></div>=
</body></html>
---965286322-45318363-1319552289=:52870--

