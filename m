References: <1320433713.81220.YahooMailNeo@domain.hid>
	<4EB43B3E.806@domain.hid>
Message-ID: <1320440601.64091.YahooMailNeo@domain.hid>
Date: Fri, 4 Nov 2011 14:03:21 -0700 (PDT)
From: Tom Z <tomz30@domain.hid>
In-Reply-To: <4EB43B3E.806@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="-1180850466-2057196594-1320440601=:64091"
Subject: Re: [Xenomai-help] 0 CPU time problem
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

---1180850466-2057196594-1320440601=:64091
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

"We do not know what skin you use, we will assume that you use Xenomaiposix=
 skin, so, compile with the right flags."=0AHere is how I build my program,=
 say, fooTest:=0Agcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wal=
l -pipe -D__XENO__ -lnative -L/usr/xenomai/lib -lxenomai -lpthread -lnative=
 -lrtdk fooTest.c -o fooTest=0A=0A=0A"CLOCK_PROCESS_CPUTIME_ID is not imple=
mented for xenomai posix skin, so,=0Aclock_gettime probably returns an erro=
r, and the struct timespec is=0Aunchanged.=0AIf somehow the glibc clock_get=
time is used, and this call does not cause=0Aa system call, then all bets a=
re off, and even a lockup could happen."=0AThanks for explaining this. So c=
an I trust the CPU time I obtained with my method when the function is runn=
ing in the primary mode? It seems you explanation implies that the results =
I obtained are not reliable, if so, are there other reliable ways to obtain=
 the CPU time?=0A=0A=0AWith many thanks,=0ATom=0A=0A=0A____________________=
____________=0AFrom: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org=
>=0ATo: Tom Z <tomz30@domain.hid>=0ACc: "xenomai@xenomai.org" <xenomai-help=
@gna.org>=0ASent: Friday, 4 November 2011 2:21 PM=0ASubject: Re: [Xenomai-h=
elp] 0 CPU time problem=0A=0AOn 11/04/2011 08:08 PM, Tom Z wrote:=0A> Hi Al=
l,=0A> =0A> I am trying to measure the CPU time consumed by a function foo(=
), and=0A> here is how I do it:=0A> =0A> void foo(){ struct timespec tp1, t=
p2; =0A> clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &tp);=0A> =0A> //Computati=
on goes here=0A> =0A> =0A> clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &tp2); /=
/The CPU time is=0A> given between the difference between tp2 and tp 1=0A> =
=0A> }=0A> =0A> =0A> The program is running on Ubuntu 10.10, and the kernel=
 is 2.6.37=0A> patched with Xenomai 2.5.6=0A> =0A> =0A> Here is what I obse=
rved:=0A> =0A> 1) If foo() is running in the Linux domain (i.e., called by =
a regular=0A> Linux process), the CPU time obtained by the above method loo=
ks=0A> normal, and the mean CPU time of 25000 invocations of foo() is 10=0A=
> ms.=0A> =0A> 2) If foo() is running in the primary domain (i.e., called b=
y a=0A> Xenomai task spawned by rt_task_create() and rt_task_start()), then=
=0A> *most of the time*, the CPU time also looks as normal as the result=0A=
> in 1), and the mean CPU time is also about 10 ms. However, I also=0A> not=
iced that sometimes the CPU time obtained by the above method is=0A> 0. Thi=
s zero value did not appear often, and out of 25000 invocations=0A> of foo(=
), I noticed that there is only 1 invocation of foo() where=0A> the CPU tim=
e is 0. BTW, the Xenomai task's priority is 99.=0A> =0A> What causes this 0=
 CPU time in the primary domain? Is there something=0A> wrong with my metho=
d to measure the CPU time?=0A=0AWe do not know what skin you use, we will a=
ssume that you use Xenomai=0Aposix skin, so, compile with the right flags.=
=0A=0ACLOCK_PROCESS_CPUTIME_ID is not implemented for xenomai posix skin, s=
o,=0Aclock_gettime probably returns an error, and the struct timespec is=0A=
unchanged.=0A=0AIf somehow the glibc clock_gettime is used, and this call d=
oes not cause=0Aa system call, then all bets are off, and even a lockup cou=
ld happen.=0A=0A-- =0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 Gilles.
---1180850466-2057196594-1320440601=:64091
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt"><div style=3D"margin-=
left: 40px;"><span class=3D"tab">"</span>We do not know what skin you use, =
we will assume that you use Xenomai posix skin, so, compile with the right =
flags."</div><div><span>Here is how I build my program, say, fooTest:</span=
></div><div><span>gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wa=
ll -pipe -D__XENO__ -lnative -L/usr/xenomai/lib -lxenomai -lpthread -lnativ=
e -lrtdk fooTest.c -o fooTest<br></span></div><div><br></div><div style=3D"=
margin-left: 40px;">"CLOCK_PROCESS_CPUTIME_ID is not implemented for xenoma=
i posix skin, so,<br>clock_gettime probably returns an error, and the struc=
t timespec is<br>unchanged.<br>If somehow the glibc clock_gettime is used, =
and this call does not cause<br>a system call, then all bets are off, and e=
ven a lockup could happen."</div><div>Thanks for explaining this. So can I
 trust the CPU time I obtained with my method when the function is running =
in the primary mode? It seems you explanation implies that the results I ob=
tained are not reliable, if so, are there other reliable ways to obtain the=
 CPU time?<br></div><div><br></div><div>With many thanks,</div><div>Tom<br>=
</div><div style=3D"font-family: times new roman, new york, times, serif; f=
ont-size: 12pt;"><div style=3D"font-family: times new roman, new york, time=
s, serif; font-size: 12pt;"><font face=3D"Arial" size=3D"2"><hr size=3D"1">=
<b><span style=3D"font-weight:bold;">From:</span></b> Gilles Chanteperdrix =
&lt;gilles.chanteperdrix@xenomai.org&gt;<br><b><span style=3D"font-weight: =
bold;">To:</span></b> Tom Z &lt;tomz30@domain.hid&gt;<br><b><span style=3D"f=
ont-weight: bold;">Cc:</span></b> "xenomai@xenomai.org" &lt;xenomai@xenomai.org=
na.org&gt;<br><b><span style=3D"font-weight: bold;">Sent:</span></b> Friday=
, 4 November 2011 2:21 PM<br><b><span style=3D"font-weight: bold;">Subject:=
</span></b>
 Re: [Xenomai-help] 0 CPU time problem<br></font><br>On 11/04/2011 08:08 PM=
, Tom Z wrote:<br>&gt; Hi All,<br>&gt; <br>&gt; I am trying to measure the =
CPU time consumed by a function foo(), and<br>&gt; here is how I do it:<br>=
&gt; <br>&gt; void foo(){ struct timespec tp1, tp2; <br>&gt; clock_gettime(=
CLOCK_PROCESS_CPUTIME_ID, &amp;tp);<br>&gt; <br>&gt; //Computation goes her=
e<br>&gt; <br>&gt; <br>&gt; clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &amp;tp=
2); //The CPU time is<br>&gt; given between the difference between tp2 and =
tp 1<br>&gt; <br>&gt; }<br>&gt; <br>&gt; <br>&gt; The program is running on=
 Ubuntu 10.10, and the kernel is 2.6.37<br>&gt; patched with Xenomai 2.5.6<=
br>&gt; <br>&gt; <br>&gt; Here is what I observed:<br>&gt; <br>&gt; 1) If f=
oo() is running in the Linux domain (i.e., called by a regular<br>&gt; Linu=
x process), the CPU time obtained by the above method looks<br>&gt; normal,=
 and the mean CPU time of 25000 invocations of foo() is 10<br>&gt;
 ms.<br>&gt; <br>&gt; 2) If foo() is running in the primary domain (i.e., c=
alled by a<br>&gt; Xenomai task spawned by rt_task_create() and rt_task_sta=
rt()), then<br>&gt; *most of the time*, the CPU time also looks as normal a=
s the result<br>&gt; in 1), and the mean CPU time is also about 10 ms. Howe=
ver, I also<br>&gt; noticed that sometimes the CPU time obtained by the abo=
ve method is<br>&gt; 0. This zero value did not appear often, and out of 25=
000 invocations<br>&gt; of foo(), I noticed that there is only 1 invocation=
 of foo() where<br>&gt; the CPU time is 0. BTW, the Xenomai task's priority=
 is 99.<br>&gt; <br>&gt; What causes this 0 CPU time in the primary domain?=
 Is there something<br>&gt; wrong with my method to measure the CPU time?<b=
r><br>We do not know what skin you use, we will assume that you use Xenomai=
<br>posix skin, so, compile with the right flags.<br><br>CLOCK_PROCESS_CPUT=
IME_ID is not implemented for xenomai posix skin,
 so,<br>clock_gettime probably returns an error, and the struct timespec is=
<br>unchanged.<br><br>If somehow the glibc clock_gettime is used, and this =
call does not cause<br>a system call, then all bets are off, and even a loc=
kup could happen.<br><br>-- <br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; Gilles.<br><br><br></div></div></div></body>=
</html>
---1180850466-2057196594-1320440601=:64091--

