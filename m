Message-ID: <482C5D49.9070909@domain.hid>
Date: Thu, 15 May 2008 17:56:57 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <2ff1a98a0805150612x62f8a1a9te843a27911244e72@domain.hid>	
	<955c7c82b3624040fbf69ee97e7177dc@domain.hid>	
	<482C4560.3070200@domain.hid>
	<2ff1a98a0805150745q1c0be6bdp91705669f941dc7@domain.hid>
In-Reply-To: <2ff1a98a0805150745q1c0be6bdp91705669f941dc7@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] VxWorks skin problem concerning WIND_TCBstructure
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> On Thu, May 15, 2008 at 4:14 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>> Matthieu wrote:
>>> On Thu, 15 May 2008 15:12:32 +0200, "Gilles Chanteperdrix"
>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>> On Thu, May 15, 2008 at 11:28 AM, Gilles Chanteperdrix
>>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>>> On Thu, May 15, 2008 at 8:10 AM, Matthieu
>>>>> <matthieu.connaulte_xenomai@domain.hid> wrote:
>>>>>  I think
>>>>>> that VxWorks Task Control Block ,implemeted by  WIND RIVER, is keeping
>>>> the
>>>>>> context in hard real-time. That's why I would like to know if there are
>>>>>> other possibilities ?
>>>>> Yes, there are possibilities: fix your code not to use such internal
>>>>> data as the WIND_TCB members.
>>>> Even VxWorks documentation considers accessing WIND_TCB directly as a
>>>> bad practice. See the doc of taskInfoGet at:
>>>>
>>>>
>>> http://spacegrant.colorado.edu/~dixonc/vxworks/docs/vxworks/ref/taskShow.html
>>>> So, what I would agree we can do is implement taskInfoGet.
>>>>
>>>> --
>>>>  Gilles
>>> Well, what a great issue for me...
>>>
>> The attached patch provides taskInfoGet(). Whether it does provide everything
>> you need from the task information block is another issue, but at least, you
>> would have the proper infrastructure to add the missing bits to.
> 
> You have been fast.

I cheated: this code has been floating around on my disk for some time now.

 One minor concern. The definition of TASK_DESC in
> vxworks headers seems to be:
> 
> typedef struct 			/* TASK_DESC - information structure */
>     {
>     int			td_id;		/* task id */
>     char *		td_name;	/* name of task */
>     int			td_priority;	/* task priority */
>     int			td_status;	/* task status */
>     int			td_options;	/* task option bits (see below) */
>     FUNCPTR		td_entry;	/* original entry point of task */
>     char *		td_sp;		/* saved stack pointer */
>     char *		td_pStackBase;	/* the bottom of the stack */
>     char *		td_pStackLimit;	/* the effective end of the stack */
>     char *		td_pStackEnd;	/* the actual end of the stack */
>     int			td_stackSize;	/* size of stack in bytes */
>     int			td_stackCurrent;/* current stack usage in bytes */
>     int			td_stackHigh;	/* maximum stack usage in bytes */
>     int			td_stackMargin;	/* current stack margin in bytes */
>     int			td_errorStatus;	/* most recent task error status */
>     int			td_delay;	/* delay/timeout ticks */
>     } TASK_DESC;
> 
> 

My concern is that this layout and naming might be arch-dependent and/or even
WIND version dependent.

Could any ppc and arm people with access to Tornado headers confirm/refute this
assumption? TIA,

-- 
Philippe.

