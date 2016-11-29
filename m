References: <304110a1193e48e8304b.1480401144@devws148.be.alcatel-lucent.com>
 <0e747fe3-ff40-5cd7-e24b-9bb68bcd7eee@xenomai.org>
 <CAMJ=MEfLWvPwi5PPP0Q-fd=Q4DgSz7gDabTX5eObWxz+cF=wWw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <100ded04-e551-d9b9-90c6-83db370fee4d@xenomai.org>
Date: Tue, 29 Nov 2016 17:18:43 +0100
MIME-Version: 1.0
In-Reply-To: <CAMJ=MEfLWvPwi5PPP0Q-fd=Q4DgSz7gDabTX5eObWxz+cF=wWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] psos.h: remove dependency on tunables.h
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>
Cc: xenomai@xenomai.org

On 11/29/2016 01:59 PM, Ronny Meeus wrote:
> On Tue, Nov 29, 2016 at 9:55 AM, Philippe Gerum <rpm@xenomai.org> wrote:
>> On 11/29/2016 07:32 AM, Ronny Meeus wrote:
>>> The psos.h file pollutes the application's namespace with defines
>>> of the boilerplate code because the tunables.h is included. In our
>>> application we already have a definition of the list_entry macro,
>>> resulting in a redefinition. The psos.h should be kept clean.
>>>
>>> Following small test program clearly shows the issue:
>>>
>>> #include <psos/psos.h>
>>> #define list_entry
>>> int main(int argc, char * const argv[])
>>> {
>>>   return 0;
>>> }
>>>
>>> When compiling the code above a warning is generated:
>>>
>>> simple_test.c:3:1: warning: "list_entry" redefined
>>> In file included from boilerplate/list.h:24,
>>>                  from boilerplate/setup.h:21,
>>>                  from boilerplate/tunables.h:22,
>>>                  from psos/psos.h:28,
>>>                  from simple_test.c:1:
>>> boilerplate/shared-list.h:233:1: warning: this is the location of the previous definition
>>>
>>> This patch resolves the issue by just removing the dependency
>>> and all related functions. If the functions are actually needed, better to
>>> move them in a separate header file since they are not part of the 'official'
>>> psos interface.
>>>
>>> diff --git a/include/psos/psos.h b/include/psos/psos.h
>>> --- a/include/psos/psos.h
>>> +++ b/include/psos/psos.h
>>> @@ -25,7 +25,6 @@
>>>  #define _XENOMAI_PSOS_PSOS_H
>>>
>>
>> Ack. But then we'd also need to introduce psos/tunables.h for defining
>> the bits your patch removes from psos/psos.h.
>>
> 
> Philippe
> 
> I just removed the functions because I did not see a need for them.
> 
> People can just access the
> extern int psos_long_names
> defined in the psos.h to manipulate the behavior of the psos interface
> with respect
> to the long names behavior.
> 
> After studying the usage of the tunables I understand the mechanism and how
> it can be used to allow certain configurations to be done up to a
> certain point (init done).
> If values are changed after that point, an assert is raised.
> 
> I have created a new patch (which I will send in a separate mail) that
> just moves the
> functionality into a separate file. But this the issue remains that
> the user can access
> (even write) the psos_long_names flag (after init) without any assert
> being triggered.
> 

This is all about interfaces. If user decides to bypass the interfaces
doing silly things, other things will invariably end up hitting the fan;
and this is true for virtually any interface exposed by the system.

Having an interface in this case is merely a way to guarantee proper
behavior, regardless of psos_long_names being dropped, renamed or having
a different type in the future.

-- 
Philippe.

