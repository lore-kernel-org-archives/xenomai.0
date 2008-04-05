Message-ID: <47F700C2.60509@domain.hid>
Date: Sat, 05 Apr 2008 00:32:02 -0400
From: Tomas Kalibera <kalibera@domain.hid>
MIME-Version: 1.0
References: <47ED5DE3.60202@domain.hid>	<47F17B32.7070505@domain.hid>	<18417.52630.8850.939898@domain.hid>	<47F23E9E.7060801@domain.hid>	<2ff1a98a0804010703v7090d7dbhbbff114a51badd6d@domain.hid>	<47F258AD.3000103@domain.hid>	<2ff1a98a0804010858kb009b37y764667cf1fa56c6@domain.hid>	<47F2A7CC.4050301@domain.hid>	<2ff1a98a0804020142r55bab884x8896c8191f8580d5@domain.hid>	<47F3A00E.1020700@domain.hid>	<2ff1a98a0804020807t4d2cc718x493ae3c48e9a042f@domain.hid>	<47F3E0B3.2030805@domain.hid>	<18419.57862.758026.458669@domain.hid>	<47F3FE7E.6020302@domain.hid>	<18420.2520.32895.319766@domain.hid>	<18420.3711.295442.250105@domain.hid>
	<47F5148E.4030909@domain.hid>
In-Reply-To: <47F5148E.4030909@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Kernel crash with Xenomai (caused by fork?)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>


Hi,

I've tried a more defensive kernel setup & your patch (no.6). The lockup 
is still there. It  happens after a realtime task is started, though I 
was unable to track exactly when -  it does not crash in a debugger, 
does not crash with strace, breaks SysRq, and printing log messages 
seems to be delayed (despite flushing). I tried changing the application 
code (like using more default flags when creating a task, etc). But I 
did not find a workaround.

I've put the kernel on the web again, including the config (the one that 
contains "xenomaidp6"). Maybe it might help to track down the bug... 
Maybe not.

Do you have any ideas how to work it around ?

Thanks
Tomas





Tomas Kalibera wrote:
> Gilles Chanteperdrix wrote:
>   
>>  > Of course, we are looking for all bugs. But please tell me: do you get
>>  > the lock-up even before fork is called ? If not, could you verify that
>>  > at least some Xenomai programs run correctly, for instance latency ?
>>  > Looking at the code, I think I found a bug, but I doubt it could cause a
>>  > lockup. The definition of VM_PINNED in include/linux/mm.h collides with
>>  > another bit used by Linux, so this defintion should be changed from:
>>  > #define VM_PINNED 0x08000000
>>  > to:
>>  > #define VM_PINNED 0x10000000
>>
>> Here comes a 6th patch for this bug, (patch 6 includes patch 5).
>>
>>   
>>     
> I've tested the 6th patch, the lockup is still there.
> As far as I can observe, it behaves exactly like with the 5th patch.
>
> Tomas
>
>
>
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>   


