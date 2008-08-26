MIME-Version: 1.0
Date: Tue, 26 Aug 2008 11:45:29 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
Message-ID: <f5413a21c1a563b4f7eeac16c004811f@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] =?utf-8?q?Problem_with_tcb=2Ehandle_and_taskDesc?=
	=?utf-8?q?=2Etd=5Ftid?=
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

Hi

I would like to understand the coherence between the task identifier of t=
he
task control block and the task id given by taskDesk (function
taskInfoGet()). In fact, I init a task with taskInit, I get the tid using
tid=3Dtcb.handle. The use of taskInfoGet(tid, taskDesc) gives me a
taskDesk.td_tid different from the tid.

I want to test if the task is suspended using taskIsSuspended(tid) or
taskIsSuspended(taskDesc.td_tid), but both get me  a 3d0001 errno (code
error of WIND_OBJ_ERR_BASE S_objLib_OBJ_ID_ERROR). The PID given by
/proc/xenomai/stat also has no connection. Idem with a ps -AfL

Thank you in advance for your explanations

Matthieu



