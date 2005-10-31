Date: Mon, 31 Oct 2005 15:59:11 +0100
From: andreas.spieker@domain.hid
Message-id: <OF8F0700EC.A1D80BF4-ONC12570AB.004AE3CB-C12570AB.005254F3@domain.hid>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: quoted-printable
Subject: [Xenomai-help] General Xenomai / RTAI Skin Usage Questions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


Hello,

I have an existing user-space Application,
programmed as a multithreaded C Program,
until now relying on RTAI3.2, mostly on time + task services,
basically to let all the threads run periodically,
for IPC Stuff  I use SystemV-IPC (!).

After the Split between RTAI and Xenomai I'm looking
for an alternative to RTAI, because since Kernel 2.6.10,
I was not longer able to get RTAI running (Kernel freezes)
and the Mailing List Members were not really willing to give me
some hints or a "functioning" kernel config file.

So my questions are:
1.)  Do you think Xenomai (with RTAI Skin ?) is the right way for me to=
 go?
2.)  Is there a simple (LXRT-like) demo with makefile for RTAI-Skin usa=
ge?
3.)  Actually, AFTER having created my threads, I use rt_task_init() +
 rt_task_make_periodic() + rt_task_wait_period() in these threads to
get them running periodically. So I turn an existing thread into someth=
ing
with soft-realtime capabilities, the API calls refer to the already run=
ning
thread. .
When using Xenomai, do I have to change to rt_task_create() +
rt_task_start(),
therefore creating my threads from the xenomai api?
I fear this would bring a lot of changes to my existing program, is thi=
s
right and is this
unavoidable?
4.) Is there a documentation which options must be set or unset in the
linux kernel .config to get
xenomai running? I had some problems, but was able to get them solved u=
sing
an old
"functioning" kernel config file (in contrast to RTAI).

Thanks for any hints and comments,
Andreas Spieker

PS: *** I will be in holidays the next weeks, so will notbe able to rep=
ly
immediately to postings ***


-----------------------------------------------------
Dr.-Ing. Andreas Spieker
Research Information and Communication
Assisting Systems (REI/AA)

DaimlerChrysler AG
HPC 050-G023
D-71059 Sindelfingen
Telefon: +49 7031 4389 774
Telefax:  +49 7031 4389 264
Mobil:     (+49) (0)179 -10 84 718
email: andreas.spieker@domain.hid

Besucheradresse:
DaimlerChrysler AG
REI/AA, Zimmer 1.103
Hanns-Klemm-Stra=DFe 45
71034 B=F6blingen,
-----------------------------------------------------=



