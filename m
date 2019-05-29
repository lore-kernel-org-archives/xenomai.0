Subject: Re: [PATCH] lib/cobalt: init: do not call pthread_atfork() from
 atfork() handlers
References: <20190503150939.3594-1-rpm@xenomai.org>
 <VI1PR05MB591765785A35FB3685463256F6300@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <6ef3a9cf-cb30-59c4-1983-4475fdc7cd6e@xenomai.org>
 <c0230398-8da5-a0b4-d30c-17e91e2f0cb7@xenomai.org>
 <DB8PR05MB5915F745C3CA952C04179E2EF6080@DB8PR05MB5915.eurprd05.prod.outlook.com>
 <69740012-4273-4647-00a2-55fd7ad9468d@xenomai.org>
 <DB8PR05MB5915BB62DD6315DB14C4CF04F6080@DB8PR05MB5915.eurprd05.prod.outlook.com>
 <bda67d42-c84b-9951-6202-7385381191be@xenomai.org>
 <e0969597-c9f2-77d6-90ad-50dffde6aede@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <ae41fa53-9126-0d2c-7089-2870c6276cb4@xenomai.org>
Date: Wed, 29 May 2019 10:22:55 +0200
MIME-Version: 1.0
In-Reply-To: <e0969597-c9f2-77d6-90ad-50dffde6aede@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 5/27/19 9:19 AM, Jan Kiszka wrote:
> On 14.05.19 15:58, Philippe Gerum via Xenomai wrote:
>> On 5/14/19 12:24 PM, Lange Norbert wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Philippe Gerum <rpm@xenomai.org>
>>>> Sent: Dienstag, 14. Mai 2019 12:05
>>>> To: Lange Norbert <norbert.lange@andritz.com>; Xenomai
>>>> (xenomai@xenomai.org) <xenomai@xenomai.org>
>>>> Subject: Re: [PATCH] lib/cobalt: init: do not call pthread_atfork()
>>>> from
>>>> atfork() handlers
>>>>
>>>> E-MAIL FROM A NON-ANDRITZ SOURCE: AS A SECURITY MEASURE, PLEASE
>>>> EXERCISE CAUTION WITH E-MAIL CONTENT AND ANY LINKS OR
>>>> ATTACHMENTS.
>>>>
>>>>
>>>> On 5/14/19 11:53 AM, Lange Norbert wrote:
>>>>> (readding ML)
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Philippe Gerum <rpm@xenomai.org>
>>>>>> Sent: Dienstag, 14. Mai 2019 10:38
>>>>>> To: Lange Norbert <norbert.lange@andritz.com>
>>>>>> Subject: Re: [PATCH] lib/cobalt: init: do not call pthread_atfork()
>>>>>> from
>>>>>> atfork() handlers
>>>>>>
>>>>>> E-MAIL FROM A NON-ANDRITZ SOURCE: AS A SECURITY MEASURE,
>>>> PLEASE
>>>>>> EXERCISE CAUTION WITH E-MAIL CONTENT AND ANY LINKS OR
>>>> ATTACHMENTS.
>>>>>>
>>>>>>
>>>>>> On 5/14/19 10:35 AM, Philippe Gerum wrote:
>>>>>>> On 5/6/19 9:56 AM, Lange Norbert wrote:
>>>>>>>> Hello Philippe,
>>>>>>>>
>>>>>>>> using this patch, smokey's "fork test" alone finishes, but..
>>>>>>>> the smokey suite will hang when running that test after the mutex
>>>>>>>> or cvars test. Eg.
>>>>>>>>
>>>>>>>> smokey --run=10,11
>>>>>>>> smokey --run=12,11
>>>>>>>
>>>>>>> I cannot reproduce this with glibc 2.28, and the tip of my
>>>>>>> for-upstream tree which includes that fix. Which glibc are you
>>>>>>> running?
>>>>>
>>>>> Glibc 2.28, Xenomai userspace is based on current master branch with
>>>>> fix added (tested both with and without our company stuff on top)
>>>>>
>>>>>>
>>>>>> Is this the sequence which hangs on your end?
>>>>>>
>>>>>> ~ # smokey --run=13-14
>>>>>> posix_cond OK
>>>>>> posix_fork OK
>>>>>> ~ # smokey --run=15-14
>>>>>> posix_mutex OK
>>>>>> posix_fork OK
>>>>>>
>>>>>
>>>>> Yes:
>>>>>
>>>>> root@buildroot:~# /usr/xenomai/bin/smokey --run=10 posix_mutex OK
>>>>> root@buildroot:~# /usr/xenomai/bin/smokey --run=11 posix_fork OK
>>>>> root@buildroot:~# /usr/xenomai/bin/smokey --run=10,11 posix_mutex OK
>>>>>
>>>>> When it hangs, this is the stacktrace:
>>>>> (switched to crosstool-NG for the toolchain, did not check to enable
>>>> debuginfo for glibc).
>>>>>
>>>>> (gdb) bt
>>>>> #0  0x00007f45b4d86feb in ?? () from /lib64/libc.so.6
>>>>> #1  0x00007f45b4de8b95 in malloc () from /lib64/libc.so.6
>>>>> #2  0x00007f45b4f81a53 in ?? () from /lib64/ld-linux-x86-64.so.2
>>>>> #3  0x00007f45b4f83149 in ?? () from /lib64/ld-linux-x86-64.so.2
>>>>> #4  0x00007f45b4f8d4cc in ?? () from /lib64/ld-linux-x86-64.so.2
>>>>> #5  0x00007f45b4ea7bcf in _dl_catch_exception () from /lib64/libc.so.6
>>>>
>>>> That is a different issue, possibly not directly related.
>>>> backtrace() is used over
>>>> a signal context in the default SIGSHADOW handler libcobalt
>>>> installs, which is
>>>> unsafe since backtrace() calls malloc(). This run ends up with a
>>>> recursive call
>>>> to malloc() which deadlocks on the internal arena lock. Disabling
>>>> CONFIG_XENO_OPT_DEBUG_TRACE_RELAX may paper over the issue.
>>>
>>> So smokeys fork will cause some relaxation log entries if I
>>> understood this correctly,
>>> and a "clean" application should leave realtime before calling fork.
>>> (Unrelated to the issue that a deadlock should not happen)
>>>
>>
>> Aside of calling uninit backtrace() from a sighandler which is wrong,
>> it looks like this issue pops up because two other conditions are met:
>>
>> - some test which precedes smokey-fork switched the scheduling class
>> of the main() smokey thread to a real-time policy (e.g. posix-mutex.c
>> does so when entering run_posix_mutex()). When smokey-fork re-execs,
>> the child inherits the scheduler settings for the main thread, so
>> eventually runs copperplate inits as a SCHED_FIFO thread, which is
>> eligible for relax detection (SCHED_OTHER/WEAK would not be).
>> - xnthread_relax() from the core always asks for a backtrace via a
>> SIGSHADOW signal upon detection, including when the current thread
>> does not want to be warned about mode switches, which seems wrong. If
>> the warn-on-switch bit was considered as it should be, the request for
>> backtrace via SIGSHADOW would not be sent in the first place.
>>
>> Clearing either of these conditions like the couple of patches below
>> does should tame down the issue. I would recommend to merge both
>> actually.
>>
>> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
>> index fa7a65569..6caf9ef37 100644
>> --- a/kernel/cobalt/thread.c
>> +++ b/kernel/cobalt/thread.c
>> @@ -2131,11 +2131,11 @@ void xnthread_relax(int notify, int reason)
>>        * information.
>>        */
>>       xnthread_propagate_schedparam(thread);
>> -   
>> +
>>       if (xnthread_test_state(thread, XNUSER) && notify) {
>> -        xndebug_notify_relax(thread, reason);
>>           if (xnthread_test_state(thread, XNWARN)) {
>>               /* Help debugging spurious relaxes. */
>> +            xndebug_notify_relax(thread, reason);
>>               memset(&si, 0, sizeof(si));
>>               si.si_signo = SIGDEBUG;
>>               si.si_code = SI_QUEUE;
>> diff --git a/testsuite/smokey/main.c b/testsuite/smokey/main.c
>> index 12321dfc5..5702e825a 100644
>> --- a/testsuite/smokey/main.c
>> +++ b/testsuite/smokey/main.c
>> @@ -22,6 +22,7 @@
>>     int main(int argc, char *const argv[])
>>   {
>> +    struct sched_param param = { .sched_priority = 0 };
>>       struct smokey_test *t;
>>       int ret, fails = 0;
>>   @@ -29,6 +30,7 @@ int main(int argc, char *const argv[])
>>           return 0;
>>         for_each_smokey_test(t) {
>> +        pthread_setschedparam(pthread_self(), SCHED_OTHER, &param);
>>           ret = t->run(t, argc, argv);
>>           if (ret) {
>>               if (ret == -ENOSYS) {
>>
> 
> Can you provide those hunks as patches?
>

Those are pending in my queue with other patches. I'll submit them later
today.

> And how about the backtrace() issue?
> 
The most practical way is to warmup backtrace() by a dummy call during
inits as Norbert suggested. I'll add a patch doing so to the queue.

-- 
Philippe.

