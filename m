From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: RE: several questions about porting latmus
Date: Mon, 8 Feb 2021 06:36:02 +0000
Message-ID: <MWHPR11MB1710B903D91D79F1B7737A56F28F9@MWHPR11MB1710.namprd11.prod.outlook.com>
References: <MWHPR11MB1710FDC8D365CE3FCFADA88DF2B69@MWHPR11MB1710.namprd11.prod.outlook.com>
 <87o8h4uobn.fsf@xenomai.org>
 <MWHPR11MB1710A620A26BF775C60336B4F2B29@MWHPR11MB1710.namprd11.prod.outlook.com>
 <87r1lrq27f.fsf@xenomai.org>
In-Reply-To: <87r1lrq27f.fsf@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

-----Original Message-----
>From: Philippe Gerum <rpm@xenomai.org>=20
>Sent: Monday, February 8, 2021 12:21 AM
>To: Chen, Hongzhan <hongzhan.chen@intel.com>
>Cc: xenomai@xenomai.org
>Subject: Re: several questions about porting latmus
>
>
>Chen, Hongzhan <hongzhan.chen@intel.com> writes:
>
>>>-----Original Message-----
>>>From: Philippe Gerum <rpm@xenomai.org>=20
>>>Sent: Monday, February 1, 2021 5:31 PM
>>>To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>>Cc: xenomai@xenomai.org
>>>Subject: Re: several questions about porting latmus
>>>
>>>
>>>Hi Hongzhan,
>>>
>>>Chen, Hongzhan <hongzhan.chen@intel.com> writes:
>>>
>>>> Hi Philippe
>>>>
>>>> When I was trying to port latmus from evl to xenomai 3.2,  I met sever=
al issues that block porting
>>>> and need your suggestions.
>>>>
>>>> 1. When I tried to replace function evl_run_kthread_on_cpu of latmus.c=
 driver ,  I found that only rtdm_task_init =20
>>>>     can meet our requirements mostly  but we still cannot pass cpu aff=
inity through it to pin task to required
>>>>     cpu. Do we need to implement new API so that we can  pass cpu affi=
nity to pin task to required cpu but
>>>>     finish all functions  of rtdm_task_init?
>>>>
>>>
>>>We should probably introduce rtdm_task_init_on_cpu() in 3.2, since this
>>>is a desirable feature which should be part of the CXP. Other ways to
>>>pin the new kthread are fairly ugly ATM, ranging from pinning the parent
>>>to the destination CPU before creating the child thread, or open coding
>>>the spawning sequence based on the internal interface (xnthread_init,
>>>xnthread_start). Please submit a patch for review of that change
>>>specifically, prior to submitting any latmus-related bits.
>>>
>>
>> OK.  I have finished latmus driver porting so far and built it successfu=
lly with linux.
>> In the following , I would  start to port latmus application. After latm=
us application is done,
>> I would validate all of them and then will try to submit patches to revi=
ew after validation=20
>> is successful.=20
>>
>
>With respect to the timer responder test, the latmus application is
>based on EVL's built-in timerfd [1] feature, which is very close to the
>Cobalt/POSIX equivalent, so the port should be straightforward.
>
>Things may be a little trickier with the GPIO responder test, as Cobalt
>needs a specific RTDM driver to operate the GPIO lines (EVL reuses the
>common GPIOLIB for this [2], so do not look for any specific driver
>here). It depends on the GPIO controller you will test on. You will
>certainly need to add support for it to kernel/drivers/gpio.
>
>Which hardware do you plan to use?

Currently , I am working on up xtream Lite board which is based on
Intel Whiskey Lake.  Yes,  I need to add new GPIO controller rtdm driver
under kernel/drivers/gpio for my board after further investigated, thanks=20
for your soft reminder.=20

I have almost finished latmus application porting and validated that latmus=
 driver is=20
working but I still have not got Freedom-K64F so far.  So the gpio test
environment can not be setup in short time because of lack of hardware on m=
y side.

>
>[1] https://evlproject.org/core/user-api/timer/
>[2] http://evlproject.org/core/oob-drivers/gpio/
>
>--=20
>Philippe.

