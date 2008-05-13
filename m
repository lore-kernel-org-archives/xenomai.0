MIME-Version: 1.0
Date: Tue, 13 May 2008 11:16:56 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
In-Reply-To: <18470.9287.958484.497706@domain.hid>
References: <18470.9287.958484.497706@domain.hid>
Message-ID: <2ded5d53ed3cbdff58cf25d2523b701f@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] =?utf-8?q?_Re=3A__VxWorks_skin_problem_concerning_?=
 =?utf-8?q?WIND=5FTCBstructure?=
Reply-To: matthieu.connaulte_xenomai@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Sun, 11 May 2008 00:40:07 +0200, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Philippe Gerum wrote:
>  > Matthieu wrote:
>  > > Im currently porting a VxWorks Application in SuSE Linux patched
with
>  > > Xenomai. I encounter some problems with the taskLib.h emulation.
> Indeed,
>  > > Ive got an error concerning WIND_TCB structure. I think that not t=
he
>  > > whole structure is implemented or maybe its implemented by Xenomai
>  > > Native API and not VxWorks skin.
>  > >
>  >
>  > Implementing the whole WIND_TCB structure is out of scope. Most of t=
he
> fields
>  > you attempt to access in your app are dependent on the VxWorks
innards,
> which is
>  > meaningless in an emulation environment. You can emulate the others
(or
> their
>  > meaning) fairly easily (e.g. pStackBase and status).
>  >
>  > > Here are extracts of Code.c:
>  > >  #include <vxworks/vxworks.h>
>  > >  WIND_TCB * pTcb;
>  > >  pTcb->entry
>  > >  pTcb->lockCnt
>  > >  pTcb->pSignalInfo->sigt_blocked
>=20
> ... And you may access signal mask with the posix pthread_sigmask
> service (if the first sigset_t pointer is NULL, the "how" argument is
> ignored, and the only effect of the service is to copy the current
> signal mask).
>=20
> --
>=20
>=20
> 					    Gilles.

Thank you for your answers.
First, in my investigation, I found out that in vxworks/vxworks.h there a=
re
different definitions of WIND_TCB while the compilation occur in kernel
mode and xeno_sim or not. What does it mean ?
I think I've understood what you say. The problem is how can I emulate th=
e
fields I need since I don't know if they can be treated as standard threa=
ds
with pthread.h and signal.h ? Do I need to use Xenomai specific
implementation of such information to get the field value ?
The field are
 entry         (entry point of task)
 lockCnt       (preemtion lock count)
 pSignalInfo   (ptr to signal info for task)
 pStackBase    (points to bottom of stack)
 SafeCnt       (safe_from_delete count)
 status        (status of task)
 safetyQHead   (safe_from_delete q head)
 ptaskVar      (ptr to task variable list)
 options       (task option bits)
=20
Matthieu



