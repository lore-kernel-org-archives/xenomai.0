References: <CAMQ-e4-eJ+Ahb2c4BaZQWfey8WFbEevRzOxTJNgSXNj6RYj=eg@mail.gmail.com>
 <57164144.2010400@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <57189FD4.10505@xenomai.org>
Date: Thu, 21 Apr 2016 11:39:32 +0200
MIME-Version: 1.0
In-Reply-To: <57164144.2010400@xenomai.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] trying to shadow a pthread fails with -EINVAL error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andrea <andrea.schiappacasse@camelotbio.com>, Xenomai@xenomai.org

On 04/19/2016 04:31 PM, Philippe Gerum wrote:
> On 04/19/2016 04:08 PM, Andrea wrote:
>> Hello,
>>
>> I'm currently trying to integrate Xenomai 3.0.2 using Cobalt with alchemy
>> skin in a C++  project, under kernel 4.1.8  with i-pipe patch.
>>
>> In my application I'm creating some threads using boost library, and I
>> would like to shadow one of them to a rt_task in order to use some
>> xenomai
>> function in there.
>>
>> If I call rt_task_shadow(NULL, NULL, 0,0) from the running thread,
>> -EINVAL
>> is returned.
>>
>> While the API docs says that this can be due to an invalid prio, tracking
>> down the source of the error, it appears that in my case it is
>> generated in
>> the function syncobj_lock (copperplate/syncobj.c), where a call to
>> monitor_enter (which internally calls cobalt_monitor_enter) fails and
>> returns -1.
>>
>> The same happens with threads created both using standard
>> pthread_create or
>> via the boost library.
>>
>> Trying to shadow the main thread (or creating rt_task from there) works
>> correctly. instead.
>>
>> A reproducible example in my system:
>>
>> #include "pthread.h"
>> #include "alchemy/task.h"
>> #include <iostream>
>> #include <unistd.h>
>>
>> void* shadow(void*)
>> {
>>      std::cerr<<"Shadow returned "<< rt_task_shadow(NULL, NULL, 0,0);
>> }
>>
>> int main(int argc, char* argv[])
>> {
>>      pthread_t test_thread;
>>     // new boost::thread(shadow);
>>      pthread_create(&test_thread, NULL, shadow, NULL);
>>      sleep(10);
>>
>>      return 0;
>> }
>>
>> with output: Shadow returned -22
>>
>> Do you have any insight on where the problem could be? Am I missing
>> something basic?
>>
>
> I suspect some chicken and egg situation in the rt_task_shadow()
> implementation. I'll have a look as soon as I can.
>
>> If possible, I would like to stick to alchemy skin.
>
> Unfortunately, the only way to work around this issue at the moment
> would be to call libcobalt's pthread_setschedparam() for pthread_self(),
> until this issue is fixed in libalchemy. You could do this for a
> particular statement without wrapping the POSIX API by calling:
>
> struct sched_param parm = { .sched_priority = 0 };
> __RT(pthread_setschedparam(phread_self(), SCHED_OTHER, &parm);
>
> instead of rt_task_shadow(). libcobalt is underlying all Xenomai 3
> applications, so you would not need to fixup the build rules or
> dependencies. It's already there.
>

Ok, so my suspicion turned out to be true, rt_task_shadow() used to call 
Cobalt services for creating ... a Cobalt context, which is not exactly 
a bright idea. This is fixed in the stable- and next- branches.

However, rt_task_create() is still not usable from a plain regular POSIX 
thread; this could be done, but at the expense of significant changes 
that do not seem worth it, given that calling __STD(pthread_create()) 
followed by running rt_task_shadow() from the created regular pthread 
would lead to the same result than creating a real-time thread directly 
from a regular pthread context.

The rationale is that a main thread is automatically turned into a 
Cobalt thread during early init, prior to entering the main() routine 
(unless automatic Xenomai bootstrap was disabled though). Therefore an 
application may fully instantiate the system, calling any Xenomai 
service over the main() context to do so.

rt_task_shadow() (as fixed) should be used to turn a plain pthread 
context into a Xenomai thread, before the latter invokes other calls 
from the Alchemy API.

-- 
Philippe.

