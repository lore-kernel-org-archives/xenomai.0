Message-ID: <4EAFDD8E.9020909@domain.hid>
Date: Tue, 01 Nov 2011 12:52:46 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAMJ=MEeOYUsNXMOUwLyxTo5kDcTTER90bXUpPiwao0YGZMpTeQ@mail.gmail.com>	
	<1316782850.2050.8.camel@domain.hid>	
	<CAMJ=MEfe-EKe9V7N3c=udfq=YGz23HhFec9UqvfZ6LtT2R3bjw@domain.hid>	
	<1316809390.2050.11.camel@domain.hid> <1317034005.2174.6.camel@domain.hid>	
	<CAMJ=MEf+bdds8Cv7vENTJLeVpYpR+ZGq1yP6TEFnFvTLy6iB3Q@mail.gmail.com>
	<1317071493.11112.14.camel@domain.hid>
In-Reply-To: <1317071493.11112.14.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai-forge: SEGFAULT is pSOS skin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ronny Meeus <ronny.meeus@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On 09/26/2011 11:11 PM, Philippe Gerum wrote:
> On Mon, 2011-09-26 at 22:01 +0200, Ronny Meeus wrote:
>> On Mon, Sep 26, 2011 at 12:46 PM, Philippe Gerum<rpm@xenomai.org>  wrote:
>>> On Fri, 2011-09-23 at 22:23 +0200, Philippe Gerum wrote:
>>>> On Fri, 2011-09-23 at 22:21 +0200, Ronny Meeus wrote:
>>>>> On Fri, Sep 23, 2011 at 3:00 PM, Philippe Gerum<rpm@xenomai.org>  wrote:
>>>>>> On Thu, 2011-09-22 at 22:15 +0200, Ronny Meeus wrote:
>>>>>>> Hello
>>>>>>>
>>>>>>> I have created some time ago a test application for the PSOS interface
>>>>>>> of Xenomai.
>>>>>>> This is a extensive test that stresses most of the PSOS services we
>>>>>>> use in our application. You can find it as an attachment.
>>>>>>> It is running fine on Xenomai 2-5-6.
>>>>>>> Note that in the test application there is also a benchmarking part.
>>>>>>> This is currently disabled, I will fix that later.
>>>>>>>
>>>>>>> Now I'm investigating a switch to xenomai-forge so I tried to run the
>>>>>>> same test on this platform.
>>>>>>
>>>>>> This is a double cleanup call, due to the incorrect propagation of an
>>>>>> internal error detected in the task trampoline within the psos emulator.
>>>>>> In fact, this reveals a more general shortcoming with handling this
>>>>>> situation for tasks, and this may also reveal an issue with t_delete()
>>>>>> over the Mercury core.
>>>>>>
>>>>>> I can't reproduce the issue here with your test program, but I'm sure
>>>>>> something is wrong in the emulator anyway, I'm just lucky with the
>>>>>> timings. Since you are running over the vanilla kernel and maybe x86,
>>>>>> you could run valgrind to check whether some memory corruption is
>>>>>> detected.
>>>>>>
>>>>>> I'm working on this bug which will bite any emulator based on the
>>>>>> copperplate interface the same way. I don't see any show stopper to fix
>>>>>> it, but this needs some thoughts to do this properly.
>>>>>>
>>>>>> Btw,
>>>>>>
>>>>>> - what is your architecture?
>>>>>> - what is your glibc version?
>>>>>
>>>>> Running on a PC (virtual BOX).
>>>>>
>>>>> This is the information about the lib I use:
>>>>> meeusr@domain.hid$ ./libc.so.6
>>>>> GNU C Library (Ubuntu EGLIBC 2.11.1-0ubuntu7.6) stable release version
>>>>> 2.11.1, by Roland McGrath et al.
>>>>> Copyright (C) 2009 Free Software Foundation, Inc.
>>>>> This is free software; see the source for copying conditions.
>>>>> There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
>>>>> PARTICULAR PURPOSE.
>>>>> Compiled by GNU CC version 4.4.3.
>>>>> Compiled on a Linux>>2.6.24-27-server<<  system on 2010-11-17.
>>>>> Available extensions:
>>>>>      crypt add-on version 2.1 by Michael Glad and others
>>>>>      GNU Libidn by Simon Josefsson
>>>>>      Native POSIX Threads Library by Ulrich Drepper et al
>>>>>      BIND-8.2.3-T5B
>>>>> For bug reporting instructions, please see:
>>>>> <http://www.debian.org/Bugs/>.
>>>>>
>>>>>
>>>>> The valgrind stuff I will do later.
>>>>
>>>> I can reproduce now. This is highly timing dependent.
>>>>
>>>
>>> git://git.xenomai.org/xenomai-forge.git has a general fix for this
>>> issue. Your test code will need the following patch to work. The basic
>>> fix is that you can't create multiple objects with the same name with
>>> Xenomai, because we need unique names for the registry to be meaningful.
>>
>> Thanks for looking into this issue.
>> The problem that we have is that we have a huge application and we
>> cannot guarantee that all tasknames are unique.
>> That is why I have implemented a mechanism to make a taskname unique
>> (I already had this in the Xenomai-2.5.6). In the force version this
>> could be something like:
>>
>>          if (name == NULL || *name == '\0')
>>                  sprintf(task->name, "t%lu", ++anon_tids);
>>          else {
>>                  struct clusterobj *cobj =
>> cluster_findobj(&psos_task_table, name);
>>                  if (cobj != NULL) {
>>                          snprintf(task->name,sizeof(task->name),
>> "%s@domain.hid", name, ++anon_tids);
>>                  }
>>                  else
>>                          strncpy(task->name, name, sizeof(task->name));
>>                  task->name[sizeof(task->name) - 1] = '\0';
>>          }
>>
>> This is an example for tasks. The same could be done for
>> regions,semaphores and message queues. I tried it on my repo and the
>> task application (rtprint) runs unmodified.
>> The only issue I see with this approach is that when 2 tasks with an
>> identical name, for example TEST, are created, the second one will be
>> mapped to TEST@1. If a t_ident call is executed, the TID of the first
>> instance will be returned, which is fine. If now the first task is
>> deleted, the t_ident call will fail.
>>
>

I have committed a general fix for this issue in the -forge repo. 
Specifically, the psos emulator now accepts duplicates the way the 
original API does. *_ident() will return duplicate matches by order of 
registration.

If this code works as expected, then you should not have to prevent 
duplicates anymore.

-- 
Philippe.

