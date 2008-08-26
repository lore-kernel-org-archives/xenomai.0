Message-ID: <48B3FACB.3050609@domain.hid>
Date: Tue, 26 Aug 2008 14:44:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <f5413a21c1a563b4f7eeac16c004811f@domain.hid>
In-Reply-To: <f5413a21c1a563b4f7eeac16c004811f@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with tcb.handle and taskDesc.td_tid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: matthieu.connaulte_xenomai@domain.hid
Cc: xenomai@xenomai.org

Matthieu wrote:
> Hi
> 
> I would like to understand the coherence between the task identifier of the
> task control block and the task id given by taskDesk (function
> taskInfoGet()). In fact, I init a task with taskInit, I get the tid using
> tid=tcb.handle. The use of taskInfoGet(tid, taskDesc) gives me a
> taskDesk.td_tid different from the tid.
> 
> I want to test if the task is suspended using taskIsSuspended(tid) or
> taskIsSuspended(taskDesc.td_tid), but both get me  a 3d0001 errno (code
> error of WIND_OBJ_ERR_BASE S_objLib_OBJ_ID_ERROR). The PID given by
> /proc/xenomai/stat also has no connection. Idem with a ps -AfL
> 
> Thank you in advance for your explanations

You are not supposed to use the internal fields of the structures. A
valid id is one returned by the taskIdSelf(), taskNameToId(),
taskIdDefault(). I can not find a service which returns the task Id for
a given TCB. Is it what you are looking for ?

-- 
                                                 Gilles.

