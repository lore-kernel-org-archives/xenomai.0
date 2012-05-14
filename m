Message-ID: <4FB0BF2F.1060108@domain.hid>
Date: Mon, 14 May 2012 10:15:43 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4FB0BA7C.6070704@domain.hid>
In-Reply-To: <4FB0BA7C.6070704@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] rt_task_create and rt_task delete re-scheduling
 calling task
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roberto Bielli <roberto.bielli@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/14/2012 09:55 AM, Roberto Bielli wrote:
> Hi,
>
> i saw in the documentation that rt_task_create and rt_task_delete should
> re-scheduling the calling task.
> So i lost the priority if in a task try to call rt_task_create or
> rt_task create. Do i understand correctly ?
> Is there a way to avoid this behaviour ? Or which are all the case of
> re-scheduling whne calling rt_task_create/rt_task_delete ?

There is no way to avoid rescheduling (assuming you are currently using 
the user-space API). Creating and deleting tasks involves switching to 
secondary mode to get/release linux resources it's impossible to access 
from a primary context.

>
> Thanks of all
>
> P.S. the imx25 now it's perfect. Was only the reentrant interrupt.
>


-- 
Philippe.

