Message-ID: <4FB0BE4A.4060006@domain.hid>
Date: Mon, 14 May 2012 10:11:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4FB0BA7C.6070704@domain.hid>
In-Reply-To: <4FB0BA7C.6070704@domain.hid>
Content-Type: text/plain; charset=UTF-8
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

rt_task_create may reschedule the calling task, only "may", not
"should". And it happens in the obvious case: when creating a task with
a higher priority than the current task.

The reason why rt_task_delete may reschedule is documented:
"Native tasks implement a mechanism by which they are immune from
deletion by other tasks while they run into a deemed safe section of
code. This feature is used internally by the native skin in order to
prevent tasks from being deleted in the middle of a critical section,
without resorting to interrupt masking when the latter is not an option.
For this reason, the caller of rt_task_delete() might be blocked and a
rescheduling take place, waiting for the target task to exit such
critical section."

Xenomai online documentation may be found here:
http://www.xenomai.org/documentation/xenomai-2.6/html/api/index.html

And a local copy is installed when you run xenomai package "make install".


-- 
                                                                Gilles.

