References: <MWHPR11MB1710FDC8D365CE3FCFADA88DF2B69@MWHPR11MB1710.namprd11.prod.outlook.com>
 <87o8h4uobn.fsf@xenomai.org>
 <MWHPR11MB1710A620A26BF775C60336B4F2B29@MWHPR11MB1710.namprd11.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: several questions about porting latmus
In-reply-to: <MWHPR11MB1710A620A26BF775C60336B4F2B29@MWHPR11MB1710.namprd11.prod.outlook.com>
Date: Sun, 07 Feb 2021 17:20:36 +0100
Message-ID: <87r1lrq27f.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


Chen, Hongzhan <hongzhan.chen@intel.com> writes:

>>-----Original Message-----
>>From: Philippe Gerum <rpm@xenomai.org> 
>>Sent: Monday, February 1, 2021 5:31 PM
>>To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>Cc: xenomai@xenomai.org
>>Subject: Re: several questions about porting latmus
>>
>>
>>Hi Hongzhan,
>>
>>Chen, Hongzhan <hongzhan.chen@intel.com> writes:
>>
>>> Hi Philippe
>>>
>>> When I was trying to port latmus from evl to xenomai 3.2,  I met several issues that block porting
>>> and need your suggestions.
>>>
>>> 1. When I tried to replace function evl_run_kthread_on_cpu of latmus.c driver ,  I found that only rtdm_task_init  
>>>     can meet our requirements mostly  but we still cannot pass cpu affinity through it to pin task to required
>>>     cpu. Do we need to implement new API so that we can  pass cpu affinity to pin task to required cpu but
>>>     finish all functions  of rtdm_task_init?
>>>
>>
>>We should probably introduce rtdm_task_init_on_cpu() in 3.2, since this
>>is a desirable feature which should be part of the CXP. Other ways to
>>pin the new kthread are fairly ugly ATM, ranging from pinning the parent
>>to the destination CPU before creating the child thread, or open coding
>>the spawning sequence based on the internal interface (xnthread_init,
>>xnthread_start). Please submit a patch for review of that change
>>specifically, prior to submitting any latmus-related bits.
>>
>
> OK.  I have finished latmus driver porting so far and built it successfully with linux.
> In the following , I would  start to port latmus application. After latmus application is done,
> I would validate all of them and then will try to submit patches to review after validation 
> is successful. 
>

With respect to the timer responder test, the latmus application is
based on EVL's built-in timerfd [1] feature, which is very close to the
Cobalt/POSIX equivalent, so the port should be straightforward.

Things may be a little trickier with the GPIO responder test, as Cobalt
needs a specific RTDM driver to operate the GPIO lines (EVL reuses the
common GPIOLIB for this [2], so do not look for any specific driver
here). It depends on the GPIO controller you will test on. You will
certainly need to add support for it to kernel/drivers/gpio.

Which hardware do you plan to use?

[1] https://evlproject.org/core/user-api/timer/
[2] http://evlproject.org/core/oob-drivers/gpio/

-- 
Philippe.

