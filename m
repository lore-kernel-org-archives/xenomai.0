Message-ID: <4443D1E0.5020708@domain.hid>
Date: Mon, 17 Apr 2006 19:35:28 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] General question on Native Skin tasks
References: <6ee4c8380604161110y3c937a74t9186bad2d9af2058@domain.hid>	<4443992C.5000808@domain.hid>
	<4443AB1F.2060405@domain.hid>
In-Reply-To: <4443AB1F.2060405@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, "Brian L." <bluczkie@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>

Philippe Gerum wrote:
> Jan Kiszka wrote:
> 
>> Brian L. wrote:
>>
>>> If I create a native-skin RT_TASK from userspace with no flags, i.e.
>>>
>>> void task(void*)
>>> {
>>>    for (;;) ;
>>> }
>>> int main()
>>> {
>>>   RT_TASK t;
>>>   rt_task_create(&t, 0, 3, 0);
>>>   rt_task_start(&t,task,0);
>>>   (do something which blocks)
>>> }
>>
>>
>>
>> mlockall left out for simplicity? Or is it also missing on your real
>> test? In the latter case, occasional application crashes are "normal"
>> (as described below).
>>
>> Philippe, you suggested some code for detecting this. We should really,
>> really add this soon (maybe to the exception path)!
>>
> 
> The submitted patch works pretty well detecting unlocked memory, I'm 
> using it right now, but I'd like something a bit more self-explanatory 
> than just receiving SIGXCPU. I don't think the execption path is the 
> right place to put this, since the mlockall issue causes random bugs, 
> and you likely want to detect them early and unconditionally.
> 

Commit #941 should provide a reliable guard against lack of process 
memory locking.

-- 

Philippe.

