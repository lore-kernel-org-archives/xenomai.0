From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: RE: [PATCH V2 1/2] cobalt/rtdm: introduce new interfaces to init task
Date: Thu, 11 Mar 2021 07:08:40 +0000
Message-ID: <MWHPR11MB1710AA2988D7054EC577A076F2909@MWHPR11MB1710.namprd11.prod.outlook.com>
References: <20210310005732.13439-1-hongzhan.chen@intel.com>
 <6ab75124-acb3-4276-c8c0-0e39f63a946a@siemens.com>
 <87im5zidmg.fsf@xenomai.org>
In-Reply-To: <87im5zidmg.fsf@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

                                                                           =
 =20
>Jan Kiszka via Xenomai <xenomai@xenomai.org> writes:                      =
              =20
>                                                                          =
              =20
>> On 10.03.21 01:57, hongzha1 via Xenomai wrote:                          =
              =20
>>> Initialise and start a real-time task on specified cpu or current      =
              =20
>>> cpu.                                                                   =
              =20
>>>                                                                        =
              =20
>>> Signed-off-by: hongzha1 <hongzhan.chen@intel.com>                      =
              =20
>>>                                                                        =
              =20
>>> diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kerne=
l/rtdm/driver.h
>>> index 733c49df8..42daaa5b2 100644                                      =
              =20
>>> --- a/include/cobalt/kernel/rtdm/driver.h                              =
              =20
>>> +++ b/include/cobalt/kernel/rtdm/driver.h                              =
              =20
>>> @@ -1024,6 +1024,20 @@ typedef void (*rtdm_task_proc_t)(void *arg);    =
              =20
>>>  int rtdm_task_init(rtdm_task_t *task, const char *name,               =
              =20
>>>  		   rtdm_task_proc_t task_proc, void *arg,                           =
            =20
>>>  		   int priority, nanosecs_rel_t period);                            =
            =20
>>> +int rtdm_task_init_on_cpu(rtdm_task_t *task, int cpu, const char *name=
,             =20
>>> +		rtdm_task_proc_t task_proc, void *arg,                              =
            =20
>>> +		int priority, nanosecs_rel_t period);                               =
            =20
>>> +                                                                      =
              =20
>>> +static inline int rtdm_task_init_cpu(rtdm_task_t *task, const char *na=
me,           =20
>>> +		rtdm_task_proc_t task_proc, void *arg,                              =
            =20
>>> +		int priority, nanosecs_rel_t period)                                =
            =20
>>                                                                         =
              =20
>> I think this was a typo of Philippe:                                    =
              =20
>>                                                                         =
              =20
>> rtdm_task_init should be implemented as a wrapper around                =
              =20
> rtdm_task_init_on_cpu. We don't need another call. =20

I misunderstood something. Thanks for helping clarify it.                  =
                =20
>                                                                          =
             =20
>                                                                          =
              =20
>Correct.                =20

New patches updated. Please review.
                                                               =20
>                                                                          =
              =20
>--                                                                        =
              =20
>Philippe.                                                                 =
              =20

