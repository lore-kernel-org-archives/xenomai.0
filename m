From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: RE: several questions about porting latmus
Date: Tue, 9 Feb 2021 08:42:26 +0000
Message-ID: <MWHPR11MB1710F548750FCD30C325AEF6F28E9@MWHPR11MB1710.namprd11.prod.outlook.com>
References: <MWHPR11MB1710FDC8D365CE3FCFADA88DF2B69@MWHPR11MB1710.namprd11.prod.outlook.com>
 <87o8h4uobn.fsf@xenomai.org>
 <MWHPR11MB1710A620A26BF775C60336B4F2B29@MWHPR11MB1710.namprd11.prod.outlook.com>
 <87r1lrq27f.fsf@xenomai.org>
 <MWHPR11MB1710B903D91D79F1B7737A56F28F9@MWHPR11MB1710.namprd11.prod.outlook.com>
 <87lfbznfc5.fsf@xenomai.org>
 <MWHPR11MB1710FADEAFBE0892DEEF39EBF28F9@MWHPR11MB1710.namprd11.prod.outlook.com>
 <87blcuo149.fsf@xenomai.org>
In-Reply-To: <87blcuo149.fsf@xenomai.org>
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

>> Chen, Hongzhan <hongzhan.chen@intel.com> writes:
>>>
>>>> -----Original Message-----
>>>>>From: Philippe Gerum <rpm@xenomai.org>=20
>>>>>Sent: Monday, February 8, 2021 12:21 AM
>>>>>To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>>>>Cc: xenomai@xenomai.org
>>>>>Subject: Re: several questions about porting latmus
>>>>>
>>>>>
>>>>>Chen, Hongzhan <hongzhan.chen@intel.com> writes:
>>>>>
>>>>>>>-----Original Message-----
>>>>>>>From: Philippe Gerum <rpm@xenomai.org>=20
>>>>>>>Sent: Monday, February 1, 2021 5:31 PM
>>>>>>>To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>>>>>>Cc: xenomai@xenomai.org
>>>>>>>Subject: Re: several questions about porting latmus
>>>>>>>
>>>>>>>
>>>>>>>Hi Hongzhan,
>>>>>>>
>>>>>>>Chen, Hongzhan <hongzhan.chen@intel.com> writes:
>>>>>>>
>>>>>>>> Hi Philippe
>>>>>>>>
>>>>>>>> When I was trying to port latmus from evl to xenomai 3.2,  I met s=
everal issues that block porting
>>>>>>>> and need your suggestions.
>>>>>>>>
>>>>>>>> 1. When I tried to replace function evl_run_kthread_on_cpu of latm=
us.c driver ,  I found that only rtdm_task_init =20
>>>>>>>>     can meet our requirements mostly  but we still cannot pass cpu=
 affinity through it to pin task to required
>>>>>>>>     cpu. Do we need to implement new API so that we can  pass cpu =
affinity to pin task to required cpu but
>>>>>>>>     finish all functions  of rtdm_task_init?
>>>>>>>>
>>>>>>>
>>>>>>>We should probably introduce rtdm_task_init_on_cpu() in 3.2, since t=
his
>>>>>>>is a desirable feature which should be part of the CXP. Other ways t=
o
>>>>>>>pin the new kthread are fairly ugly ATM, ranging from pinning the pa=
rent
>>>>>>>to the destination CPU before creating the child thread, or open cod=
ing
>>>>>>>the spawning sequence based on the internal interface (xnthread_init=
,
>>>>>>>xnthread_start). Please submit a patch for review of that change
>>>>>>>specifically, prior to submitting any latmus-related bits.
>>>>>>>
>>>>>>
>>>>>> OK.  I have finished latmus driver porting so far and built it succe=
ssfully with linux.
>>>>>> In the following , I would  start to port latmus application. After =
latmus application is done,
>>>>>> I would validate all of them and then will try to submit patches to =
review after validation=20
>>>>>> is successful.=20
>>>>>>
>>>>>
>>>>>With respect to the timer responder test, the latmus application is
>>>>>based on EVL's built-in timerfd [1] feature, which is very close to th=
e
>>>>>Cobalt/POSIX equivalent, so the port should be straightforward.
>>>>>
>>>>>Things may be a little trickier with the GPIO responder test, as Cobal=
t
>>>>>needs a specific RTDM driver to operate the GPIO lines (EVL reuses the
>>>>>common GPIOLIB for this [2], so do not look for any specific driver
>>>>>here). It depends on the GPIO controller you will test on. You will
>>>>>certainly need to add support for it to kernel/drivers/gpio.
>>>>>
>>>>>Which hardware do you plan to use?
>>>>
>>>> Currently , I am working on up xtream Lite board which is based on
>>>> Intel Whiskey Lake.  Yes,  I need to add new GPIO controller rtdm driv=
er
>>>> under kernel/drivers/gpio for my board after further investigated, tha=
nks=20
>>>> for your soft reminder.=20
>>>>
>>>> I have almost finished latmus application porting and validated that l=
atmus driver is=20
>>>> working but I still have not got Freedom-K64F so far.  So the gpio tes=
t
>>>> environment can not be setup in short time because of lack of hardware=
 on my side.
>>>>
>>>
>>>There is also the option of making benchmarks/zephyr/latmon a Xenomai
>>>application, which would act as the latency monitor running on a
>>>separate Linux board. Xenomai would then help testing Xenomai which
>>>might not be optimal at first glance, however this should be ok
>>>nevertheless provided that such monitoring board runs a known to be
>>>stable I-pipe configuration.
>>>
>>
>> One more question,  I saw that rtdm gpio driver can call rtdm_gpiochip_s=
can_of
>> to do init currently but actually rtdm_gpiochip_scan_of do call of_find_=
compatible_node
>> to find device node, It is workable for those devices registered through=
 ACPI table?
>> If not , does that means we need to add new API to implement analogous f=
unction for those
>> gpio pinctrl devices registered by ACPI?
>>
>
>gpiochip_find() is available to non-OF systems as well; what gets
>enumerated by the platform code ends up being registered in the gpiolib
>device list.
>
>The idea is to match by name the type of controller which is expected on
>your platform with the gpio chips enumerated by gpiochip_find(). You may
>want to add some generic helper to gpio-core.c doing that for non-OF
>platforms, which you would call from additional controller-specific RTDM
>modules (those which would define more GPIO device subclasses,
>i.e. RTDM_SUBCLASS_xx).
>
>--=20
>Philippe.

Thanks  for your suggestions. I have finished implementing generic helper i=
n gpio-core.c and
also developed new gpio rtdm driver for my board. After build successfully =
and run xenomai=20
on my board, bother latmus and gpio chip device file can be found under /de=
v/rtdm folder.
But when I try to run /usr/bin/latmus , it returned with error "measurement=
 setup failed: Resource
Temporarily unavailable". After further debug, I found that actually it wro=
ngly call ioctl_rt handler of
Latmus driver. I saw that libevl have explicit oob_ioctl for calling such r=
ealtime handler but how=20
cobalt differentiate nrt and rt when call same ioctl?

Regards

Hongzhan Chen

