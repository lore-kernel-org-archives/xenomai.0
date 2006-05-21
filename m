Message-ID: <447042ED.5090806@domain.hid>
Date: Sun, 21 May 2006 12:37:33 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_task_delete behavior
References: <6ee4c8380605172215i34e83797i709de4a314412618@domain.hid>	
	<446C29A9.3030508@domain.hid>	
	<6ee4c8380605190702l323f5d57v234d055b1cfeff5a@domain.hid>	
	<446DDA56.3050209@domain.hid>
	<6ee4c8380605202203w74a3c04j912d5e4e543f8433@domain.hid>
In-Reply-To: <6ee4c8380605202203w74a3c04j912d5e4e543f8433@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Brian L." <bluczkie@domain.hid>
Cc: xenomai@xenomai.org

Brian L. wrote:
> No...
> 
> hold on--self-destruction should never return. The calling task
> destroys itself then ceases to continue executing, right?
> 

Yes.

> I suspect that late at night, three days ago, I confused 'not
> returning since the calling context is gone' with 'hanging'.
> 
> If a thread's function (the one passed to rt_task_start) returns, is
> it cleaned up, or is it still neccesary to call rt_task_delete on it?
> 

It's cleanup up automatically. This explains the output of 
/proc/xenomai/sched below; the task has indeed gone away, and the only 
remaining thread which keeps the process from exiting is likely the main 
- non-Xenomai - one which is somehow paused or blocked.

> On 5/19/06, Philippe Gerum <rpm@xenomai.org> wrote:
> 
>> Brian L. wrote:
>> > CPU   PID   PRI   TIMEOUT   STAT   NAME
>> > 0     0        0     0      R      ROOT
>> >
>>
>> Is this snapshot obtained while the application is still hanging?
>>
>> >
>> > On 5/18/06, Philippe Gerum <rpm@xenomai.org> wrote:
>> >
>> >> Brian L. wrote:
>> >> > I'm calling what amounts to rt_task_delete(rt_task_self()) and the
>> >> > task simply hangs, with this call never returning.
>> >> > rt_task_delete(NULL) behaves identically.
>> >> >
>> >> > What could cause this behavior? The problem is embedded within a
>> >> > nontrivial application, but it seems that it's not behaving 
>> according
>> >> > to spec which says that the caller will only block when:
>> >> >
>> >> > 1. The target is in a "safe section"
>> >> >
>> >> > and
>> >> >
>> >> > 2. The caller is not the target
>> >> >
>> >> > Any ideas?
>> >> >
>> >>
>> >> Could you post the output of
>> >>
>> >> $ cat /proc/xenomai/sched
>> >>
>> >> TIA,
>> >>
>> >> > _______________________________________________
>> >> > Xenomai-help mailing list
>> >> > Xenomai-help@domain.hid
>> >> > https://mail.gna.org/listinfo/xenomai-help
>> >> >
>> >>
>> >>
>> >> --
>> >>
>> >> Philippe.
>> >>
>> >
>>
>>
>> -- 
>>
>> Philippe.
>>
> 


-- 

Philippe.

