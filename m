MIME-Version: 1.0
Date: Thu, 22 May 2008 16:02:49 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
Message-ID: <166743d9cab3b1b1bc8f3d29d9079afa@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] vxworks emulation
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

Hi,

I encounter a problem with the emulation of vxworks over Xenomai. I need =
to
use FUNCPTR but this function is't implemented the same in Xenomai as in
Wind River.

Here is part of wind-river code : (types/vxTypesOld.h)

#ifdef __cplusplus
typedef int             (*FUNCPTR) (...);     /* ptr to function returnin=
g
int */
typedef void            (*VOIDFUNCPTR) (...); /* ptr to function returnin=
g
void */
typedef double          (*DBLFUNCPTR) (...);  /* ptr to function returnin=
g
double*/
typedef float           (*FLTFUNCPTR) (...);  /* ptr to function returnin=
g
float */
#else
typedef int             (*FUNCPTR) ();     /* ptr to function returning i=
nt
*/
typedef void            (*VOIDFUNCPTR) (); /* ptr to function returning
void */
typedef double          (*DBLFUNCPTR) ();  /* ptr to function returning
double*/
typedef float           (*FLTFUNCPTR) ();  /* ptr to function returning
float */
#endif                  /* _cplusplus */

Here is part of vxworks/vxworks.h :

typedef void (*FUNCPTR)(long, long, long, long, long, long, long, long,
long, long);


So there is a restriction in the arguments allowed to pass. In fact when =
I
try to compil the following line there are errors (number of arguments an=
d
conversion types errors)

char TheCompMes[55];
...
extern FUNCPTR errPtr;
...
errPtr (ERR_ACT_TASK, 0 , PER, 0 , NULL, "cmde_tache", "FastMsgCollector"=
,
TheCompMes);

What can I do ?=20

Thanks in advance

Matthieu



