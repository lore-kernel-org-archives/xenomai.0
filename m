Message-ID: <858255.34222.qm@domain.hid>
References: <737283.11182.qm@domain.hid>
	<4DEF2D3D.9090409@domain.hid>
	<213583.55278.qm@domain.hid>
	<4E01050D.8000800@domain.hid>
Date: Tue, 21 Jun 2011 20:29:04 -0700 (PDT)
From: sanjay anvekar <sanjayanvekar@domain.hid>
In-Reply-To: <4E01050D.8000800@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-661161965-1308713344=:34222"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

--0-661161965-1308713344=:34222
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Gilles,=0A=A0=A0=A0=A0 Thanks for your reply. With GDB I am able to run =
the application but it never hits configured breakpoints=0Aand it takes lit=
tle longer time to start application. I tried changing priority of tasks, b=
ut it didn't help.=0AIn my application program I have not configured any in=
terrupts and completely dependent on Linux drivers.=0AIf I do not use rt_ta=
sk_sleep() my program does not work correctly. I tried to suspend each task=
 instead of =0A=0Ausing rt_task_sleep and resume them in shadow task but so=
me how it did not work .=0A=0A'rt_task_set_mode(0,XNRRB ,NULL)' didn't retu=
rn any error , but when I tried with T_RRB parameter=0Ainstead of XNRRB it =
failed.=0A=0ABest Regards,=0ASanjay=0A=0A=0A=0A=0A_________________________=
_______=0AFrom: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>=0AT=
o: sanjay anvekar <sanjayanvekar@domain.hid>=0ACc: "xenomai@xenomai.org" <x=
enomai-help@domain.hid>=0ASent: Wednesday, 22 June 2011 2:24 AM=0ASubject: Re:=
 [Xenomai-help] Xenomai-Driver=0A=0AOn 06/21/2011 02:02 PM, sanjay anvekar =
wrote:=0A> Hi Gilles, Thanks for your reply. I am using 'rt_task_sleep(100u=
s)'=0A> at the end of every task to let Linux task run. With this I am able=
=0A> to run my application program , but I am not able to debug using=0A> '=
GDB'.=0A=0AWhat happens when you try and debug with gdb?=0A=0A> Also is the=
re any better way to allow Linux task run instead=0A> of using 'rt_task_sle=
ep' ? My application has got 5 different task of=0A=0AFirst, the applicatio=
n should wait interrupts and react upon them, not=0Ado any polling, this sh=
ould normally leave some time for Linux to run if=0Athe system is well dime=
nsioned.=0A=0A> =0A> =0A> equal priority and I want to run these in Round R=
obin fashion , I=0A> used 'rt_task_set_mode(0,XNRRB ,NULL)' to enable Round=
 Robin=0A> scheduling mode, but task are not getting executed in Round Robi=
n=0A> fashion.=0A=0AI do not think round-robin is what you want: it will no=
t let linux run.=0Art_task_set_mode probably returns an error when you use =
XNRRB, because=0Ait does not expect this bit to be set.=0A=0A-- =0A=A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Gilles.
--0-661161965-1308713344=:34222
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt"><div><span>Hi Gilles,=
</span></div><div><span>&nbsp;&nbsp;&nbsp;&nbsp; Thanks for your reply. Wit=
h GDB I am able to run the application but it never hits configured breakpo=
ints</span></div><div><span>and it takes little longer time to start applic=
ation. I tried changing priority of tasks, but it didn't help.</span></div>=
<div><span>In my application program I have not configured any interrupts a=
nd completely dependent on Linux drivers.</span></div><div><span>If I do no=
t use rt_task_sleep() my program does not work correctly. I tried to suspen=
d each task instead of <br></span></div><div><span>using rt_task_sleep and =
resume them in shadow task but some how it did not work .<br></span></div><=
div><span>'</span>rt_task_set_mode(0,XNRRB ,NULL)' didn't return any error =
, but when I tried with T_RRB parameter</div><div>instead of XNRRB it
 failed.</div><div><br></div><div>Best Regards,</div><div>Sanjay<br></div><=
pre style=3D"margin-left: 24pt;"><a href=3D"http://www.xenomai.org/document=
ation/xenomai-2.4/html/api/group__task.html#g915e7edfb0aaddb643794d7abc7093=
bf"><span class=3D"SpellE"></span></a><span class=3D"keywordtype"><span sty=
le=3D"font-family: &quot;Courier New&quot;;"><br></span></span></pre><div><=
br></div><div style=3D"font-family: times new roman,new york,times,serif; f=
ont-size: 12pt;"><div style=3D"font-family: times new roman,new york,times,=
serif; font-size: 12pt;"><font face=3D"Arial" size=3D"2"><hr size=3D"1"><b>=
<span style=3D"font-weight: bold;">From:</span></b> Gilles Chanteperdrix &l=
t;gilles.chanteperdrix@xenomai.org&gt;<br><b><span style=3D"font-weight: bo=
ld;">To:</span></b> sanjay anvekar &lt;sanjayanvekar@domain.hid&gt;<br><b><s=
pan style=3D"font-weight: bold;">Cc:</span></b> "xenomai@xenomai.org" &lt;=
xenomai@xenomai.org&gt;<br><b><span style=3D"font-weight: bold;">Sent:</sp=
an></b> Wednesday, 22
 June 2011 2:24 AM<br><b><span style=3D"font-weight: bold;">Subject:</span>=
</b> Re: [Xenomai-help] Xenomai-Driver<br></font><br>On 06/21/2011 02:02 PM=
, sanjay anvekar wrote:<br>&gt; Hi Gilles, Thanks for your reply. I am usin=
g 'rt_task_sleep(100us)'<br>&gt; at the end of every task to let Linux task=
 run. With this I am able<br>&gt; to run my application program , but I am =
not able to debug using<br>&gt; 'GDB'.<br><br>What happens when you try and=
 debug with gdb?<br><br>&gt; Also is there any better way to allow Linux ta=
sk run instead<br>&gt; of using 'rt_task_sleep' ? My application has got 5 =
different task of<br><br>First, the application should wait interrupts and =
react upon them, not<br>do any polling, this should normally leave some tim=
e for Linux to run if<br>the system is well dimensioned.<br><br>&gt; <br>&g=
t; <br>&gt; equal priority and I want to run these in Round Robin fashion ,=
 I<br>&gt; used 'rt_task_set_mode(0,XNRRB ,NULL)' to enable Round
 Robin<br>&gt; scheduling mode, but task are not getting executed in Round =
Robin<br>&gt; fashion.<br><br>I do not think round-robin is what you want: =
it will not let linux run.<br>rt_task_set_mode probably returns an error wh=
en you use XNRRB, because<br>it does not expect this bit to be set.<br><br>=
-- <br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; Gilles.<br><br><br></div></div></div></body></html>
--0-661161965-1308713344=:34222--

