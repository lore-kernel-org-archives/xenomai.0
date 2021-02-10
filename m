From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: RE: several questions about porting latmus
Date: Wed, 10 Feb 2021 06:57:10 +0000
Message-ID: <MWHPR11MB171017296BC54BF95BBCC9F9F28D9@MWHPR11MB1710.namprd11.prod.outlook.com>
References: <MWHPR11MB1710FDC8D365CE3FCFADA88DF2B69@MWHPR11MB1710.namprd11.prod.outlook.com>
 <87o8h4uobn.fsf@xenomai.org>
 <MWHPR11MB1710A620A26BF775C60336B4F2B29@MWHPR11MB1710.namprd11.prod.outlook.com>
 <87r1lrq27f.fsf@xenomai.org>
 <MWHPR11MB1710B903D91D79F1B7737A56F28F9@MWHPR11MB1710.namprd11.prod.outlook.com>
 <87lfbznfc5.fsf@xenomai.org>
 <MWHPR11MB1710FADEAFBE0892DEEF39EBF28F9@MWHPR11MB1710.namprd11.prod.outlook.com>
 <87blcuo149.fsf@xenomai.org>
 <MWHPR11MB1710F548750FCD30C325AEF6F28E9@MWHPR11MB1710.namprd11.prod.outlook.com>
 <878s7wmncw.fsf@xenomai.org>
In-Reply-To: <878s7wmncw.fsf@xenomai.org>
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


>>>> Chen, Hongzhan <hongzhan.chen@intel.com> writes:
>>>>>
>>>>>> -----Original Message-----
>>>>>>>From: Philippe Gerum <rpm@xenomai.org>=20
>>>>>>>Sent: Monday, February 8, 2021 12:21 AM
>>>>>>>To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>>>>>>Cc: xenomai@xenomai.org
>>>>>>>Subject: Re: several questions about porting latmus
>>>>>>>
>>>>>>>
>>>>>>>Chen, Hongzhan <hongzhan.chen@intel.com> writes:
>>>>>>>
>>>>>>>>>-----Original Message-----
>>>>>>>>>From: Philippe Gerum <rpm@xenomai.org>=20
>>>>>>>>>Sent: Monday, February 1, 2021 5:31 PM
>>>>>>>>>To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>>>>>>>>Cc: xenomai@xenomai.org
>>>>>>>>>Subject: Re: several questions about porting latmus
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>Hi Hongzhan,
>>>>>>>>>
>>>>>>>>>Chen, Hongzhan <hongzhan.chen@intel.com> writes:
>>>>>>>>>
>>>>>>>>>> Hi Philippe
>>>>>>>>>>
>>>>>>>>>> When I was trying to port latmus from evl to xenomai 3.2,  I met=
 several issues that block porting
>>>>>>>>>> and need your suggestions.
>>>>>>>>>>
>>>>>>>>>> 1. When I tried to replace function evl_run_kthread_on_cpu of la=
tmus.c driver ,  I found that only rtdm_task_init =20
>>>>>>>>>>     can meet our requirements mostly  but we still cannot pass c=
pu affinity through it to pin task to required
>>>>>>>>>>     cpu. Do we need to implement new API so that we can  pass cp=
u affinity to pin task to required cpu but
>>>>>>>>>>     finish all functions  of rtdm_task_init?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>>We should probably introduce rtdm_task_init_on_cpu() in 3.2, since=
 this
>>>>>>>>>is a desirable feature which should be part of the CXP. Other ways=
 to
>>>>>>>>>pin the new kthread are fairly ugly ATM, ranging from pinning the =
parent
>>>>>>>>>to the destination CPU before creating the child thread, or open c=
oding
>>>>>>>>>the spawning sequence based on the internal interface (xnthread_in=
it,
>>>>>>>>>xnthread_start). Please submit a patch for review of that change
>>>>>>>>>specifically, prior to submitting any latmus-related bits.
>>>>>>>>>
>>>>>>>>
>>>>>>>> OK.  I have finished latmus driver porting so far and built it suc=
cessfully with linux.
>>>>>>>> In the following , I would  start to port latmus application. Afte=
r latmus application is done,
>>>>>>>> I would validate all of them and then will try to submit patches t=
o review after validation=20
>>>>>>>> is successful.=20
>>>>>>>>
>>>>>>>
>>>>>>>With respect to the timer responder test, the latmus application is
>>>>>>>based on EVL's built-in timerfd [1] feature, which is very close to =
the
>>>>>>>Cobalt/POSIX equivalent, so the port should be straightforward.
>>>>>>>
>>>>>>>Things may be a little trickier with the GPIO responder test, as Cob=
alt
>>>>>>>needs a specific RTDM driver to operate the GPIO lines (EVL reuses t=
he
>>>>>>>common GPIOLIB for this [2], so do not look for any specific driver
>>>>>>>here). It depends on the GPIO controller you will test on. You will
>>>>>>>certainly need to add support for it to kernel/drivers/gpio.
>>>>>>>
>>>>>>>Which hardware do you plan to use?
>>>>>>
>>>>>> Currently , I am working on up xtream Lite board which is based on
>>>>>> Intel Whiskey Lake.  Yes,  I need to add new GPIO controller rtdm dr=
iver
>>>>>> under kernel/drivers/gpio for my board after further investigated, t=
hanks=20
>>>>>> for your soft reminder.=20
>>>>>>
>>>>>> I have almost finished latmus application porting and validated that=
 latmus driver is=20
>>>>>> working but I still have not got Freedom-K64F so far.  So the gpio t=
est
>>>>>> environment can not be setup in short time because of lack of hardwa=
re on my side.
>>>>>>
>>>>>
>>>>>There is also the option of making benchmarks/zephyr/latmon a Xenomai
>>>>>application, which would act as the latency monitor running on a
>>>>>separate Linux board. Xenomai would then help testing Xenomai which
>>>>>might not be optimal at first glance, however this should be ok
>>>>>nevertheless provided that such monitoring board runs a known to be
>>>>>stable I-pipe configuration.
>>>>>
>>>>
>>>> One more question,  I saw that rtdm gpio driver can call rtdm_gpiochip=
_scan_of
>>>> to do init currently but actually rtdm_gpiochip_scan_of do call of_fin=
d_compatible_node
>>>> to find device node, It is workable for those devices registered throu=
gh ACPI table?
>>>> If not , does that means we need to add new API to implement analogous=
 function for those
>>>> gpio pinctrl devices registered by ACPI?
>>>>
>>>
>>>gpiochip_find() is available to non-OF systems as well; what gets
>>>enumerated by the platform code ends up being registered in the gpiolib
>>>device list.
>>>
>>>The idea is to match by name the type of controller which is expected on
>>>your platform with the gpio chips enumerated by gpiochip_find(). You may
>>>want to add some generic helper to gpio-core.c doing that for non-OF
>>>platforms, which you would call from additional controller-specific RTDM
>>>modules (those which would define more GPIO device subclasses,
>>>i.e. RTDM_SUBCLASS_xx).
>>>
>>>--=20
>>>Philippe.
>>
>> Thanks  for your suggestions. I have finished implementing generic helpe=
r in gpio-core.c and
>> also developed new gpio rtdm driver for my board. After build successful=
ly and run xenomai=20
>> on my board, bother latmus and gpio chip device file can be found under =
/dev/rtdm folder.
>> But when I try to run /usr/bin/latmus , it returned with error "measurem=
ent setup failed: Resource
>> Temporarily unavailable". After further debug, I found that actually it =
wrongly call ioctl_rt handler of
>> Latmus driver. I saw that libevl have explicit oob_ioctl for calling suc=
h realtime handler but how=20
>> cobalt differentiate nrt and rt when call same ioctl?
>>
>
>The driver itself differentiates this, not Cobalt per se. For Xenomai
>tasks, ioctl requests from libcobalt are always passed to the ioctl_rt
>handler first.
>
>When this handler detects that such request should be processed by the
>converse ioctl_nrt handler instead, it should simply return with -ENOSYS
>to the caller.
>
>As a result, Cobalt would switch the current task to secondary mode,
>then call the ioctl_nrt handler with the same request code and arg.
>

Thanks , I already found that there as reply in history email by Jan to ans=
wer similar question=20
 https://xenomai.org/pipermail/xenomai/2019-September/041664.html
I  was trying the fixing. There is something wrong with my latmus driver af=
ter porting from evl and need
to be adjusted accordingly.

>--=20
>Philippe.

