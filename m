Message-ID: <47837E28.5040406@domain.hid>
Date: Tue, 08 Jan 2008 14:44:08 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2ff1a98a0801080223l4c975df8qbc64c164b9697454@domain.hid>	<14854214.1199776626079.JavaMail.ngmail@domain.hid>	<24653876.1199792394399.JavaMail.ngmail@domain.hid>	<478370D6.8080605@domain.hid>
	<2ff1a98a0801080518k8970391kc2f0a4166adfe393@domain.hid>
In-Reply-To: <2ff1a98a0801080518k8970391kc2f0a4166adfe393@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] posix functions for real time and non real time
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, "M. Koehrer" <mathias_koehrer@domain.hid>, xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> On Jan 8, 2008 1:47 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> M. Koehrer wrote:
>>> Hi Gilles,
>>>
>>> thank you very much for the response.
>>> I tried this out and found one strange thing:
>>> When I run the following simple example (that uses the __real_pthread_ functions)
>>> the executable appears in the /proc/xenomai/stat list.
>>> As I am calling __real_pthread_create() I expected that my program does not appear
>>> in xenomai at all.
>>> Build is done using xeno-config --posix-cflags plus -O2 -Wall. For linking xeno-config --posix-ldflags
>>> is used.
>> POSIX-skin applications automatically map the main thread to a (prio-0)
>> Xenomai thread, therefore you see at least one thread in /proc/xenomai.
>> Technically, this happens in the init function of the pthread_rt lib you
>> link against, and it helps your main thread to interact with Xenomai
>> resources without explicit (non-standard) thread wrapping.
>>
>>> Another question:
>>> Is there a special header file available that has some defines to map the pthread_xxx
>>> function to __real_pthread_xxx.
>>> By including this header I do not have to modify the C code of that files that should
>>> use the non real-time functions.
>> You are tackling an important issue: How to build large-scale POSIX
>> applications over Xenomai when they have both RT and non-RT parts?
>> Possible strategies:
>>
>> [RT part dominates]
>>  - Wrap the non-RT calls with "__real_"-prefixes
>>
>> [Non-RT part dominates]
>>  - Invoke RT-services explicitly via "__wrap_"-prefixes
>>
>> [Both cases]
>>  - Separate RT- and non-RT-only components into separate program
>>    modules, link them in two steps: first RT with Xenomai args and
>>    non-RT as usual, then link both intermediate parts together
>>
>> For this wrapping, I think that renaming macros for pthread services
>> could indeed be useful (e.g. something that translates
>> rt_pthread_mutex_lock in the source code into __warp_pthread_mutex_lock
>> for the linker).
> 
> When you try to mix up real-time and non real-time threads, it all
> becomes very complicated. You do not need your complication: just make
> all your tasks real-time tasks (using priority 0 for low priority
> tasks) and forget about __real_* calls.

That can be inefficient in large applications: You don't need the
(average-case) overhead of Xenomai IPC for pure non-RT interaction. And
IPC object creation is precisely the critical point, because their type
cannot be told apart by the wrapping layer based on generic parameters.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

