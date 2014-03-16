Message-ID: <1394996997.10478.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Date: Sun, 16 Mar 2014 19:09:57 +0000 (GMT)
From: Matthias Schneider <ma30002000@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Issue suspending threads on mercury
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

Hi all,=0A=0AI am experiencing a problem with xenomai-forge (recent "next" =
checkout) on=A0=0AMercury (on top of a 3.12.9+CONFIG_PREEMPT_RT on x86) whe=
n suspending=A0=0Atasks/threads.=0A=0AAs far =A0as I understand, the mercur=
y implementation sends a signal to the thread=A0=0Ato be suspended, with th=
at threads signal handler setting the suspended state,=A0=0Ai.e. the settin=
g of __THREAD_S_SUSPENDED happens in notifier_callback, which=A0=0Aseems to=
 be different from the cobalt implementation.=0A=0AThe problem I am experie=
ncing is that sometimes the signal handler never seems=A0=0Ato get called i=
n a thread that should be suspended, =A0i.e. that thread suspension=A0=0Aso=
metimes simply does not work.=0AThe following example code (for the vxworks=
 skin) reproduces the issue (it gets=A0=0Astuck in the loop waiting for the=
 WIND_SUSPEND flag):=A0=0A=0Ahttp://www.pastebin.ca/2667435=0A=0AAny hints =
on how I can continue investigating this issue?=0A=0AThanks in advance for =
the help=0Aregards,=0AMatthias=0A

