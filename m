References: <1394996997.10478.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <5326AE7E.3050201@xenomai.org> 
Message-ID: <1395076680.34261.YahooMailNeo@web171604.mail.ir2.yahoo.com>
Date: Mon, 17 Mar 2014 17:18:00 +0000 (GMT)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <5326AE7E.3050201@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Issue suspending threads on mercury
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

> On Monday, March 17, 2014 9:12 AM, Philippe Gerum <rpm@xenomai.org> wrote=
:=0A=0A> > On 03/16/2014 08:09 PM, Matthias Schneider wrote:=0A>>=A0 Hi all=
,=0A>> =0A>>=A0 I am experiencing a problem with xenomai-forge (recent "nex=
t" checkout) on=0A>>=A0 Mercury (on top of a 3.12.9+CONFIG_PREEMPT_RT on x8=
6) when suspending=0A>>=A0 tasks/threads.=0A>> =0A>>=A0 As far=A0 as I unde=
rstand, the mercury implementation sends a signal to the thread=0A>>=A0 to =
be suspended, with that threads signal handler setting the suspended state,=
=0A>>=A0 i.e. the setting of __THREAD_S_SUSPENDED happens in notifier_callb=
ack, which=0A>>=A0 seems to be different from the cobalt implementation.=0A=
>> =0A>>=A0 The problem I am experiencing is that sometimes the signal hand=
ler never seems=0A>>=A0 to get called in a thread that should be suspended,=
=A0 i.e. that thread suspension=0A>>=A0 sometimes simply does not work.=0A>=
>=A0 The following example code (for the vxworks skin) reproduces the issue=
 (it gets=0A>>=A0 stuck in the loop waiting for the WIND_SUSPEND flag):=0A>=
> =0A>>=A0 http://www.pastebin.ca/2667435=0A> =0A> Could you check this URL=
? I can't seem to find anything pasted there.=0A> =0A> =0A>> =0A>>=A0 Any h=
ints on how I can continue investigating this issue?=0A>> =0A> =0A> Running=
 the test suite in lib/vxworks/testsuite may give us more =0A> information.=
 sem-1, sem-2, task-2 and wd-1 are all using the =0A> suspend/resume mechan=
ism.=0A> =0A> -- =0A> Philippe.=0A>=0A=0AHi all,=0A=0Aplease find another c=
opy of the example code at:=0A=0Ahttp://pastebin.com/rNGDfR2b=0A=0A=0AThe s=
cenario described by Kim when using gdb may coincide with ocurrence=A0=0Aof=
 the issue all the time when using gdb on my system. However,=A0=0Aalso wit=
hout gdb it happens from time to time (several 10000s cycles=A0=0Aof the co=
de above).=0A=0AThe enclosed test code from vxworks/testsuite seems to work=
 when executing it once,=A0=0Abut note that the issue only happens from tim=
e to time (thats why I added the sample=A0=0Acode).=0A=0AMatthias

