MIME-Version: 1.0
Date: Sat, 10 May 2008 20:47:22 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
Message-ID: <4e888e043f64dd610bf15a02a955a84b@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] =?utf-8?q?VxWorks_skin_problem_concerning_WIND=5FT?=
	=?utf-8?q?CB_structure?=
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
To: xenomai@xenomai.org

I=E2=80=99m currently porting a VxWorks Application in SuSE Linux patched=
 with
Xenomai. I encounter some problems with the taskLib.h emulation. Indeed,
I=E2=80=99ve got an error concerning WIND_TCB structure. I think that not=
 the
whole structure is implemented or maybe it=E2=80=99s implemented by Xenom=
ai
Native API and not VxWorks skin.

Here are extracts of Code.c:
 #include <vxworks/vxworks.h>
 WIND_TCB * pTcb;
 pTcb->entry
 pTcb->lockCnt
 pTcb->pSignalInfo->sigt_blocked
 pTcb->pStackBase=20
 =E2=80=A6=20

Here are the errors:
 Code.c:270: warning: implicit declaration of function =E2=80=98taskTcb=E2=
=80=99=20
 Code.c:270: warning: assignment makes pointer from integer without a cas=
t=20
 Code.c:286: error: =E2=80=98WIND_TCB=E2=80=99 has no member named =E2=80=
=98entry=E2=80=99=20
 Code.c:292: error: =E2=80=98WIND_TCB=E2=80=99 has no member named =E2=80=
=98entry=E2=80=99=20
 Code.c:315: error: =E2=80=98WIND_TCB=E2=80=99 has no member named =E2=80=
=98lockCnt=E2=80=99=20
 Code.c:324: error: =E2=80=98WIND_TCB=E2=80=99 has no member named =E2=80=
=98pSignalInfo=E2=80=99=20
 Code.c:339: error: =E2=80=98WIND_TCB=E2=80=99 has no member named =E2=80=
=98pStackBase=E2=80=99=20
 Code.c:474: warning: assignment makes pointer from integer without a cas=
t=20
 Code.c:492: error: =E2=80=98WIND_TCB=E2=80=99 has no member named =E2=80=
=98safeCnt=E2=80=99=20
 Code.c:493: warning: implicit declaration of function =E2=80=98TASK_UNSA=
FE=E2=80=99=20
 Code.c:511: warning: implicit declaration of function =E2=80=98intLock=E2=
=80=99=20
 Code.c:512: error: =E2=80=98WIND_TCB=E2=80=99 has no member named =E2=80=
=98safeCnt=E2=80=99=20
 Code.c:513: error: =E2=80=98WIND_TCB=E2=80=99 has no member named =E2=80=
=98status=E2=80=99=20
 Code.c:513: error: =E2=80=98WIND_READY=E2=80=99 undeclared (first use in=
 this
function)=20
 Code.c:513: error: (Each undeclared identifier is reported only once=20
 Code.c:513: error: for each function it appears in.)=20
 Code.c:513: error: =E2=80=98WIND_TCB=E2=80=99 has no member named =E2=80=
=98lockCnt=E2=80=99
 Code.c:517: warning: implicit declaration of function =E2=80=98intUnlock=
=E2=80=99
 Code.c:519: error: =E2=80=98taskIdCurrent=E2=80=99 undeclared (first use=
 in this
function)
 Code.c:522: error: =E2=80=98WIND_TCB=E2=80=99 has no member named =E2=80=
=98safeCnt=E2=80=99
 Code.c:523: error: =E2=80=98WIND_TCB=E2=80=99 has no member named =E2=80=
=98lockCnt=E2=80=99
 Code.c:525: warning: implicit declaration of function =E2=80=98Q_FIRST=E2=
=80=99
 Code.c:525: error: =E2=80=98WIND_TCB=E2=80=99 has no member named =E2=80=
=98safetyQHead=E2=80=99
 Code.c:525: warning: comparison between pointer and integer
 Code.c:526: warning: implicit declaration of function =E2=80=98windPendQ=
Flush=E2=80=99
 Code.c:526: error: =E2=80=98WIND_TCB=E2=80=99 has no member named =E2=80=
=98safetyQHead=E2=80=99
 Code.c:532: warning: implicit declaration of function =E2=80=98windPendQ=
Put=E2=80=99
 Code.c:532: error: =E2=80=98WIND_TCB=E2=80=99 has no member named =E2=80=
=98safetyQHead=E2=80=99
 Code.c:553: warning: implicit declaration of function =E2=80=98TASK_ID_V=
ERIFY=E2=80=99
 Code.c:566: warning: implicit declaration of function =E2=80=98TASK_SAFE=
=E2=80=99
 Code.c:578: error: =E2=80=98WIND_TCB=E2=80=99 has no member named =E2=80=
=98pTaskVar=E2=80=99
 Code.c:579: error: =E2=80=98WIND_TCB=E2=80=99 has no member named =E2=80=
=98pTaskVar=E2=80=99
 Code.c:583: error: =E2=80=98WIND_TCB=E2=80=99 has no member named =E2=80=
=98pSignalInfo=E2=80=99
 Code.c:620: error: =E2=80=98WIND_TCB=E2=80=99 has no member named =E2=80=
=98pStackBase=E2=80=99
 Code.c:638: error: =E2=80=98WIND_TCB=E2=80=99 has no member named =E2=80=
=98options=E2=80=99
 Code.c:644: warning: implicit declaration of function =E2=80=98taskResta=
rt=E2=80=99
 Code.c:654: error: =E2=80=98WIND_TCB=E2=80=99 has no member named =E2=80=
=98pTaskVar=E2=80=99
 Code.c:658: error: invalid application of =E2=80=98sizeof=E2=80=99 to in=
complete type
=E2=80=98struct sigtcb=E2=80=99
 Code.c:659: error: =E2=80=98_NSIGS=E2=80=99 undeclared (first use in thi=
s function)
 Code.c:660: error: dereferencing pointer to incomplete type
 Code.c:660: error: dereferencing pointer to incomplete type
 Code.c:660: error: dereferencing pointer to incomplete type
 Code.c:667: error: =E2=80=98WIND_TCB=E2=80=99 has no member named =E2=80=
=98pSignalInfo=E2=80=99
 Code.c:876: warning: suggest explicit braces to avoid ambiguous =E2=80=98=
else=E2=80=99
 Code.c: In function =E2=80=98sigTcbPut=E2=80=99:
 Code.c:994: warning: implicit declaration of function =E2=80=98INT_RESTR=
ICT=E2=80=99
 Code.c:997: error: =E2=80=98WIND_TCB=E2=80=99 has no member named =E2=80=
=98pSignalInfo=E2=80=99
 Code.c:998: error: =E2=80=98WIND_TCB=E2=80=99 has no member named =E2=80=
=98pSignalInfo=E2=80=99
 Code.c:1000: warning: implicit declaration of function
=E2=80=98taskStackAllot=E2=80=99
 Code.c:1001: error: invalid application of =E2=80=98sizeof=E2=80=99 to i=
ncomplete type
=E2=80=98struct sigtcb=E2=80=99
 Code.c:1008: error: =E2=80=98WIND_TCB=E2=80=99 has no member named =E2=80=
=98pSignalInfo=E2=80=99
 Code.c:1009: error: invalid application of =E2=80=98sizeof=E2=80=99 to i=
ncomplete type
=E2=80=98struct sigtcb=E2=80=99
 Code.c:1011: error: =E2=80=98_NSIGS=E2=80=99 undeclared (first use in th=
is function)
 Code.c:1012: error: dereferencing pointer to incomplete type
 Code.c:1012: error: dereferencing pointer to incomplete type=20
 Code.c:1013: error: dereferencing pointer to incomplete type What are my
issues?

Thanks in advance=20




