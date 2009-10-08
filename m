Message-ID: <4ACDE8AF.9080204@domain.hid>
Date: Thu, 08 Oct 2009 15:27:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0000ACDD.4ACE037F@192.168.2.103>
In-Reply-To: <0000ACDD.4ACE037F@192.168.2.103>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Re : rt_printf with daemonized task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "oliver.schlenker@domain.hid" <oliver.schlenker@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

oliver.schlenker@domain.hid wrote:
> 
> 
> 
> 
> -------- Original Message --------
> Subject: Re: Re : rt_printf with daemonized task (08-Okt-2009 14:19)
> From:    Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> To:      oliver.schlenker@domain.hid
> 
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> oliver.schlenker@domain.hid wrote:
>>>>>>>>> int main( int arc, char *argv[] ) { int i;
>>>>>>>>>
>>>>>>>>> rt_print_auto_init(1);
>>>>>>>>>
>>>>>>>>> rt_printf("--------------- TEST RT-PRINTF  1 ------------\n");
>>>>>>>>>
>>>>>>>>> sleep(1);
>>>>>>>>>
>>>>>>>>> daemon(0,0);
>>>>>>>>>
>>>>>>>>> rt_print_auto_init(1);
>>>>>>> Ok, understood, at least for the scenario where the rt_print feature
>>>>>>> is initialised befor the fork/daemon call. What I don't understand
>>>>>>> is, why it does not work if the rt_print feature is initialised after
>>>>>>> the fork / daemon.
>>>>>> From the way I understand your code, you never tried to initialize the
>>>>>> rt_print feature only after the fork, your code initializes it both
>>>>>> before and after.
>>>>>>
>>>>> There are two initializations: The base init done via __rt_print_init 
>> on
>>>>> library loading and the one to be done per-thread via rt_print_init (or
>>>>> on first rt_printf). That printer thread is initialized via the former
>>>>> one. On fork, we do not need to re-run the full __rt_print_init
>>>>> (variables and resources are cloned on fork), we just need to spawn
>>>>> another printer thread.
>>>> Unless I am wrong, rtdk also maintains a list of the thread buffers
>>>> which need to be polled. After the fork, this list will be intact, but
>>>> the threads to which belong the buffers will no longer exist. So, IMO,
>>>> the fork handler should also free all these buffers and reset the list
>>>> to the empty state.
>>> Famous last words: That should work without tweaking. A print_buffer
>>> only contains data references, nothing that points to some uncloned thread.
>> Ok. But you walk the list of print_buffers every time, and these
>> print_buffers remain allocated in the child process. So, that is a kind
>> of memory leak.
>>
>>> Jan
>>>
>>
>> -- 
>>                                           Gilles
>>
> 
> Did change my test code in the meantime to :
> 
> 
> #include <stdlib.h>
> #include <stdio.h>
> 
> #include <native/task.h>
> #include <native/timer.h>
> #include <rtdk.h>
> 
> 
> int main( int arc, char *argv[] )
> {
> int i;
> 
> daemon(0,1);
> 
> __rt_print_init();
> 
> rt_print_auto_init(1);
> 
> rt_printf("--------------- TEST RT-PRINTF ------------\n");
> 
> sleep(10);
> 
> return(0);
> }
> 
> 
> and everything works fine at first glance.
> 
> There is at least an output to syslog of the rt_printf message. I have
> no idea if this creates an internal memory leak. For my application
> it might be not a real problem, because the fork is done only once.
> For application with several fork calls or a recursional fork calls it might be
> not ok.

This case will not leak as there were no buffers registered before the
fork. But it's not a generic solution, using a non-public service,
__rt_print_init, which I don't want to make public.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

