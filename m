MIME-Version: 1.0
Date: Tue, 26 Aug 2008 16:15:58 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
In-Reply-To: <48B3FD37.4060701@domain.hid>
References: <48B3FD37.4060701@domain.hid>
Message-ID: <dcca602eeac0de54e5e7095d60c77710@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] =?utf-8?q?_Re=3A__Problem_with_tcb=2Ehandle_and_ta?=
 =?utf-8?q?skDesc=2Etd=5Ftid?=
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



On Tue, 26 Aug 2008 14:55:19 +0200, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Gilles Chanteperdrix wrote:
>> Matthieu wrote:
>>> Hi
>>>
>>> I would like to understand the coherence between the task identifier =
of
> the
>>> task control block and the task id given by taskDesk (function
>>> taskInfoGet()). In fact, I init a task with taskInit, I get the tid
> using
>>> tid=3Dtcb.handle. The use of taskInfoGet(tid, taskDesc) gives me a
>>> taskDesk.td_tid different from the tid.
>>>
>>> I want to test if the task is suspended using taskIsSuspended(tid) or
>>> taskIsSuspended(taskDesc.td_tid), but both get me  a 3d0001 errno (co=
de
>>> error of WIND_OBJ_ERR_BASE S_objLib_OBJ_ID_ERROR). The PID given by
>>> /proc/xenomai/stat also has no connection. Idem with a ps -AfL
>>>
>>> Thank you in advance for your explanations
>>
>> You are not supposed to use the internal fields of the structures. A
>> valid id is one returned by the taskIdSelf(), taskNameToId(),
>> taskIdDefault(). I can not find a service which returns the task Id fo=
r
>> a given TCB. Is it what you are looking for ?
>=20
> By the way, if you could call taskInfoGet, you already have a valid tas=
k
> id...
>=20

But using taskNameToId, taskSuspend(tid) makes the same error and so is
taskInfoGet(). In the sources, I saw that taskInfoGet seems to be a
reentrant routine (see ksrc/skins/vxworks/syscall.c where a taskInfoGet i=
s
call in the taskInfoGet routine)=20

Matthieu

> --
>                                                  Gilles.



