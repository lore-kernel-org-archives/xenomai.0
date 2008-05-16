Message-ID: <2ff1a98a0805160149w3478755bqa4ffa44dfc7107b0@domain.hid>
Date: Fri, 16 May 2008 10:49:44 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <baae236367f2f79b010b505e6c7178e5@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <482C6382.5010604@domain.hid>
	<baae236367f2f79b010b505e6c7178e5@domain.hid>
Subject: Re: [Xenomai-help] VxWorks skin problem concerning WIND_TCBstructure
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

On Fri, May 16, 2008 at 8:30 AM, Matthieu
<matthieu.connaulte_xenomai@domain.hid> wrote:
> On Thu, 15 May 2008 18:23:30 +0200, Philippe Gerum <rpm@xenomai.org> wrote:
>> Gilles Chanteperdrix wrote:
>>> On Thu, May 15, 2008 at 5:56 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> On Thu, May 15, 2008 at 4:14 PM, Philippe Gerum <rpm@xenomai.org>
>> wrote:
>>>>>> Matthieu wrote:
>>>>>>> On Thu, 15 May 2008 15:12:32 +0200, "Gilles Chanteperdrix"
>>>>>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>>>>>> On Thu, May 15, 2008 at 11:28 AM, Gilles Chanteperdrix
>>>>>>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>>>>>>> On Thu, May 15, 2008 at 8:10 AM, Matthieu
>>>>>>>>> <matthieu.connaulte_xenomai@domain.hid> wrote:
>>>>>>>>>  I think
>>>>>>>>>> that VxWorks Task Control Block ,implemeted by  WIND RIVER, is
>> keeping
>>>>>>>> the
>>>>>>>>>> context in hard real-time. That's why I would like to know if
>> there are
>>>>>>>>>> other possibilities ?
>>>>>>>>> Yes, there are possibilities: fix your code not to use such
>> internal
>>>>>>>>> data as the WIND_TCB members.
>>>>>>>> Even VxWorks documentation considers accessing WIND_TCB directly as
>> a
>>>>>>>> bad practice. See the doc of taskInfoGet at:
>>>>>>>>
>>>>>>>>
>>>>>>>
>>
> http://spacegrant.colorado.edu/~dixonc/vxworks/docs/vxworks/ref/taskShow.html
>>>>>>>> So, what I would agree we can do is implement taskInfoGet.
>>>>>>>>
>>>>>>>> --
>>>>>>>>  Gilles
>>>>>>> Well, what a great issue for me...
>>>>>>>
>>>>>> The attached patch provides taskInfoGet(). Whether it does provide
>> everything
>>>>>> you need from the task information block is another issue, but at
>> least, you
>>>>>> would have the proper infrastructure to add the missing bits to.
>>>>> You have been fast.
>>>> I cheated: this code has been floating around on my disk for some time
>> now.
>>>>
>>>>  One minor concern. The definition of TASK_DESC in
>>>>> vxworks headers seems to be:
>>>>>
>>>>> typedef struct                        /* TASK_DESC - information
>> structure */
>>>>>     {
>>>>>     int                       td_id;          /* task id */
>>>>>     char *            td_name;        /* name of task */
>>>>>     int                       td_priority;    /* task priority */
>>>>>     int                       td_status;      /* task status */
>>>>>     int                       td_options;     /* task option bits (see
>> below) */
>>>>>     FUNCPTR           td_entry;       /* original entry point of task
>> */
>>>>>     char *            td_sp;          /* saved stack pointer */
>>>>>     char *            td_pStackBase;  /* the bottom of the stack */
>>>>>     char *            td_pStackLimit; /* the effective end of the
>> stack */
>>>>>     char *            td_pStackEnd;   /* the actual end of the stack
>> */
>>>>>     int                       td_stackSize;   /* size of stack in
>> bytes */
>>>>>     int                       td_stackCurrent;/* current stack usage
>> in bytes */
>>>>>     int                       td_stackHigh;   /* maximum stack usage
>> in bytes */
>>>>>     int                       td_stackMargin; /* current stack margin
>> in bytes */
>>>>>     int                       td_errorStatus; /* most recent task
>> error status */
>>>>>     int                       td_delay;       /* delay/timeout ticks
>> */
>>>>>     } TASK_DESC;
>>>>>
>>>>>
>>>> My concern is that this layout and naming might be arch-dependent
>> and/or even
>>>> WIND version dependent.
>>>>
>>>> Could any ppc and arm people with access to Tornado headers
>> confirm/refute this
>>>> assumption? TIA,
>>>
>>> Found it here:
>>>
>>
> http://rts-lab.eas.asu.edu/NSF_EI/courses/cse591_RTES/document/reference_document/vxworks_taskLib.h
>>>
>>
>> The arch-dependent part of this "generic kernel interface header" (eh...)
>> does
>> not look like including the TASK_DESC stuff and moreover, this seems to
> be
>> based
>> on VxWorks 5.4 which is our reference version too, so I agree, we should
>> probably comply with their naming as well.
>>
>> --
>> Philippe.
>
> It's a great pleasure to work with people having such a reactivity and
> efficiency.
>
> Do I patch my kernel now or would you operate for some modifications before
> ?

I suggest you patch your kernel with the patch Philippe sent, adapt it
to suit your needs, maybe changing TASK_DESC as in vxworks taskLib.h,
test and debug it, then send us a patch which we will be happy to
merge.

-- 
 Gilles

