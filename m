Message-ID: <213583.55278.qm@domain.hid>
References: <737283.11182.qm@domain.hid>
	<4DEF2D3D.9090409@domain.hid> 
Date: Tue, 21 Jun 2011 05:02:24 -0700 (PDT)
From: sanjay anvekar <sanjayanvekar@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-520288917-1308657744=:55278"
Subject: Re: [Xenomai-help] Xenomai-Driver
Reply-To: sanjay anvekar <sanjayanvekar@domain.hid>
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

--0-520288917-1308657744=:55278
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Gilles,=0A=A0=A0=A0=A0 Thanks for your reply. I am using 'rt_task_sleep(=
100us)' at the end of every task to let Linux task run.=0AWith this I am ab=
le to run my application program , but I am not able to debug using 'GDB'. =
Also is there any=0Abetter way to allow Linux task run instead of using 'rt=
_task_sleep' ? My application has got 5 different task of =0A=0Aequal prior=
ity and I want to run these in Round Robin fashion , I used 'rt_task_set_mo=
de(0,XNRRB ,NULL)'=0Ato enable Round Robin scheduling mode, but task are no=
t getting executed in Round Robin fashion. =0A=0AAm I missing something ? P=
lease help me.=0A=0AThanks & Best Regards,=0ASanjay=0A=0A=0A=0A____________=
____________________=0AFrom: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org=
omai.org>=0ATo: sanjay anvekar <sanjayanvekar@domain.hid>=0ACc: "xenomai-hel=
p@domain.hid" <xenomai@xenomai.org>=0ASent: Wednesday, 8 June 2011 1:35 PM=0A=
Subject: Re: [Xenomai-help] Xenomai-Driver=0A=0AOn 06/08/2011 04:22 AM, san=
jay anvekar wrote:=0A>=A0 =A0 =A0 rt_task_yield() - To allow=0A execution o=
f other tasks.=0A=0AIt is a bit hard to answer without seeing any code, but=
 there is a=0Asimple remark we can make: rt_task_yield does not "allow exec=
ution of=0Aother tasks", rt_task_yield only allows execution of tasks with =
same=0Apriority as the current task. Your real-time tasks have to let Linux=
 run=0Afrom time to time if you want the serial port and graphic display to=
 run=0Acorrectly, and in order to do this they have to get suspended,=0Art_=
task_yield will definitely not do that.=0A=0A-- =0A=A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Gilles.
--0-520288917-1308657744=:55278
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt"><div><span></span><sp=
an>Hi Gilles,</span></div><div style=3D"font-family: times new roman,new yo=
rk,times,serif; font-size: 12pt;"><div style=3D"font-family: times new roma=
n,new york,times,serif; font-size: 12pt;"><div id=3D"yiv143611138"><div sty=
le=3D"color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); font-famil=
y: times new roman,new york,times,serif; font-size: 12pt;"><div><span>&nbsp=
;&nbsp;&nbsp;&nbsp; Thanks for your reply. I am using 'rt_task_sleep(</span=
><span> 100us</span><span>)' at the end of every task to let Linux task run=
.</span></div><div><span>With this I am able to run my application program =
, but I am not able to debug using 'GDB'. Also is there any</span></div><di=
v><span>better way to allow Linux task run instead of using 'rt_task_sleep'=
 ? My application has got 5 different task of
 <br></span></div><div><span>equal priority and I want to run these in Roun=
d Robin fashion , I used 'rt_task_set_mode(0,XNRRB ,NULL)'</span></div><div=
><span>to enable Round Robin scheduling mode, but task are not getting exec=
uted in Round Robin fashion. <br></span></div><div><span>Am I missing somet=
hing ? Please help=0A me.</span></div><div><br><span></span></div><div><spa=
n>Thanks &amp; Best Regards,</span></div><div><span>Sanjay<br></span></div>=
<div><br></div><div style=3D"font-family: times new roman,new york,times,se=
rif; font-size: 12pt;"><div style=3D"font-family: times new roman,new york,=
times,serif; font-size: 12pt;"><font face=3D"Arial" size=3D"2"><hr size=3D"=
1"><b><span style=3D"font-weight: bold;">From:</span></b> Gilles Chanteperd=
rix &lt;gilles.chanteperdrix@xenomai.org&gt;<br><b><span style=3D"font-weig=
ht: bold;">To:</span></b> sanjay anvekar &lt;sanjayanvekar@domain.hid&gt;<br=
><b><span style=3D"font-weight: bold;">Cc:</span></b> "xenomai@xenomai.org=
" &lt;xenomai@xenomai.org&gt;<br><b><span style=3D"font-weight: bold;">Sen=
t:</span></b> Wednesday, 8 June 2011 1:35 PM<br><b><span style=3D"font-weig=
ht: bold;">Subject:</span></b> Re: [Xenomai-help] Xenomai-Driver<br></font>=
<br>On 06/08/2011 04:22 AM, sanjay anvekar wrote:<br>&gt;&nbsp; &nbsp; &nbs=
p; rt_task_yield() - To allow=0A execution of other tasks.<br><br>It is a b=
it hard to answer without seeing any code, but there is a<br>simple remark =
we can make: rt_task_yield does not "allow execution of<br>other tasks", rt=
_task_yield only allows execution of tasks with same<br>priority as the cur=
rent task. Your real-time tasks have to let Linux run<br>from time to time =
if you want the serial port and graphic display to run<br>correctly, and in=
 order to do this they have to get suspended,<br>rt_task_yield will definit=
ely not do that.<br><br>-- <br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; Gilles.<br><br><br></div></div></div></div><b=
r><br></div></div></div></body></html>
--0-520288917-1308657744=:55278--

