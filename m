References: <1320433713.81220.YahooMailNeo@domain.hid>
	<4EB43B3E.806@domain.hid>
	<1320440601.64091.YahooMailNeo@domain.hid>
	<4EB45AF6.60304@domain.hid>
Message-ID: <1320460319.56312.YahooMailNeo@domain.hid>
Date: Fri, 4 Nov 2011 19:31:59 -0700 (PDT)
From: Tom Z <tomz30@domain.hid>
In-Reply-To: <4EB45AF6.60304@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="573995543-253283875-1320460319=:56312"
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

--573995543-253283875-1320460319=:56312
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Gilles,=0A=0A"No, CLOCK_PROCESS_CPUTIME is a clock implemented by the Li=
nux kernel,=0Aso, it does not see the time spent in primary mode. If the fo=
o function=0Adoes not suspend, you can use rt_timer_tsc(), but the answer i=
s no,=0Athere is currently no way to get the cpu time used when in primary =
mode."=0AThanks a lot for the explanation. It seems my understanding on how=
 Xenomai works was incorrect. I thought that if a task, say, myRTTask() is =
spawned by rt_task_create() and rt_task_start(), then=A0myRTTask() will alw=
ays run in the primary mode, so if myRTTask() calls foo(), then foo() will =
be running in the primary mode all the time. The correct fact is, myRTTask(=
) could be running in either the primary mode or the secondary mode, right?=
 This arises my another question, if foo() uses some third party libraries =
(with source code available), how can I tell what parts of foo() will be ru=
nning in the primary mode, and what parts will be in the secondary mode? Ar=
e there principles for deciding whether the code is in the primary mode or =
the secondary mode?=0A=0A=0AThanks again for your patient help.=0A=0ATom=0A=
=0A=0A________________________________=0AFrom: Gilles Chanteperdrix <gilles=
.chanteperdrix@domain.hid>=0ATo: Tom Z <tomz30@domain.hid>=0ACc: "xenomai-h=
elp@domain.hid" <xenomai@xenomai.org>=0ASent: Friday, 4 November 2011 4:36 PM=
=0ASubject: Re: [Xenomai-help] 0 CPU time problem=0A=0AOn 11/04/2011 10:03 =
PM, Tom Z wrote:=0A> > We do not know what skin you use, we will assume tha=
t you use=0A> > Xenomai posix skin, so, compile with the right flags.=0A>=
=0A> Here is how I=0A> build my program, say, fooTest: gcc -I/usr/xenomai/i=
nclude=0A> -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__ -lnative=0A> -=
L/usr/xenomai/lib -lxenomai -lpthread -lnative -lrtdk fooTest.c -o=0A> fooT=
est=0A=0AYou are using the native skin then.=0A=0A> > CLOCK_PROCESS_CPUTIME=
_ID is not implemented for xenomai posix skin,=0A> > so, clock_gettime prob=
ably returns an error, and the struct timespec=0A> > is unchanged. If someh=
ow the glibc clock_gettime is used, and this=0A> > call does not cause a sy=
stem call, then all bets are off, and even a=0A> > lockup could happen.=0A>=
=0A> Thanks for explaining this. So can I trust the=0A> CPU time I obtained=
 with my method when the function is running in=0A> the primary mode? It se=
ems you explanation implies that the results I=0A> obtained are not reliabl=
e, if so, are there other reliable ways to=0A> obtain the CPU time?=0A=0ANo=
, CLOCK_PROCESS_CPUTIME is a clock implemented by the Linux kernel,=0Aso, i=
t does not see the time spent in primary mode. If the foo function=0Adoes n=
ot suspend, you can use rt_timer_tsc(), but the answer is no,=0Athere is cu=
rrently no way to get the cpu time used when in primary mode.=0A=0A-- =0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Gilles.
--573995543-253283875-1320460319=:56312
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt"><div>Hi Gilles,<br></=
div><div style=3D"margin-left: 40px;">"No, CLOCK_PROCESS_CPUTIME is a clock=
 implemented by the Linux kernel,<br>so, it does not see the time spent in =
primary mode. If the foo function<br>does not suspend, you can use rt_timer=
_tsc(), but the answer is no,<br>there is currently no way to get the cpu t=
ime used when in primary mode."</div><div>Thanks a lot for the explanation.=
 It seems my understanding on how Xenomai works was incorrect. I thought th=
at if a task, say, myRTTask() is spawned by rt_task_create() and rt_task_st=
art(), then&nbsp;myRTTask() will always run in the primary mode, so if myRT=
Task() calls foo(), then foo() will be running in the primary mode all the =
time. The correct fact is, myRTTask() could be running in either the primar=
y mode or the secondary mode, right? This arises my another question, if
 foo() uses some third party libraries (with source code available), how ca=
n I tell what parts of foo() will be running in the primary mode, and what =
parts will be in the secondary mode? Are there principles for deciding whet=
her the code is in the primary mode or the secondary mode?<br></div><div><b=
r></div><div>Thanks again for your patient help.<br></div><div>Tom<br></div=
><div style=3D"font-family: times new roman, new york, times, serif; font-s=
ize: 12pt;"><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt;"><font face=3D"Arial" size=3D"2"><hr size=3D"1"><b><s=
pan style=3D"font-weight:bold;">From:</span></b> Gilles Chanteperdrix &lt;g=
illes.chanteperdrix@domain.hid&gt;<br><b><span style=3D"font-weight: bold;=
">To:</span></b> Tom Z &lt;tomz30@domain.hid&gt;<br><b><span style=3D"font-w=
eight: bold;">Cc:</span></b> "xenomai@xenomai.org" &lt;xenomai@xenomai.org=
g&gt;<br><b><span style=3D"font-weight: bold;">Sent:</span></b> Friday, 4 N=
ovember
 2011 4:36 PM<br><b><span style=3D"font-weight: bold;">Subject:</span></b> =
Re: [Xenomai-help] 0 CPU time problem<br></font><br>On 11/04/2011 10:03 PM,=
 Tom Z wrote:<br>&gt; &gt; We do not know what skin you use, we will assume=
 that you use<br>&gt; &gt; Xenomai posix skin, so, compile with the right f=
lags.<br>&gt;<br>&gt; Here is how I<br>&gt; build my program, say, fooTest:=
 gcc -I/usr/xenomai/include<br>&gt; -D_GNU_SOURCE -D_REENTRANT -Wall -pipe =
-D__XENO__ -lnative<br>&gt; -L/usr/xenomai/lib -lxenomai -lpthread -lnative=
 -lrtdk fooTest.c -o<br>&gt; fooTest<br><br>You are using the native skin t=
hen.<br><br>&gt; &gt; CLOCK_PROCESS_CPUTIME_ID is not implemented for xenom=
ai posix skin,<br>&gt; &gt; so, clock_gettime probably returns an error, an=
d the struct timespec<br>&gt; &gt; is unchanged. If somehow the glibc clock=
_gettime is used, and this<br>&gt; &gt; call does not cause a system call, =
then all bets are off, and even a<br>&gt; &gt; lockup could
 happen.<br>&gt;<br>&gt; Thanks for explaining this. So can I trust the<br>=
&gt; CPU time I obtained with my method when the function is running in<br>=
&gt; the primary mode? It seems you explanation implies that the results I<=
br>&gt; obtained are not reliable, if so, are there other reliable ways to<=
br>&gt; obtain the CPU time?<br><br>No, CLOCK_PROCESS_CPUTIME is a clock im=
plemented by the Linux kernel,<br>so, it does not see the time spent in pri=
mary mode. If the foo function<br>does not suspend, you can use rt_timer_ts=
c(), but the answer is no,<br>there is currently no way to get the cpu time=
 used when in primary mode.<br><br>-- <br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Gilles.<br><br><br></div></div></d=
iv></body></html>
--573995543-253283875-1320460319=:56312--

